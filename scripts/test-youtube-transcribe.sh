#!/usr/bin/env bash
set -euo pipefail

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
BIN="$REPO_DIR/local/.local/bin/youtube-transcribe"
TMP_DIR="$(mktemp -d "${TMPDIR:-/tmp}/youtube-transcribe-test.XXXXXX")"

cleanup() { rm -rf "$TMP_DIR"; }
trap cleanup EXIT

fail() {
  printf 'not ok - %s\n' "$*" >&2
  exit 1
}

pass() { printf 'ok - %s\n' "$*"; }

assert_contains() {
  local haystack="$1"
  local needle="$2"
  local label="$3"

  if [[ "$haystack" != *"$needle"* ]]; then
    printf 'Expected output to contain: %s\n' "$needle" >&2
    printf 'Actual output:\n%s\n' "$haystack" >&2
    fail "$label"
  fi
}

assert_fails_with() {
  local expected="$1"
  shift
  local output
  local status

  set +e
  output="$("$@" 2>&1)"
  status=$?
  set -e

  if [[ "$status" -eq 0 ]]; then
    printf 'Expected command to fail, but it exited 0: %s\n' "$*" >&2
    fail "command should fail"
  fi

  assert_contains "$output" "$expected" "failure output includes $expected"
}

make_fake_deps() {
  local fake_bin="$1"
  mkdir -p "$fake_bin"

  cat >"$fake_bin/yt-dlp" <<'SH'
#!/usr/bin/env bash
set -euo pipefail

output_pattern=""
uses_web_client=false
while [[ $# -gt 0 ]]; do
  case "$1" in
  -o)
    output_pattern="$2"
    shift 2
    ;;
  --extractor-args)
    [[ "$2" == *'youtube:player_client=web'* ]] && uses_web_client=true
    shift 2
    ;;
  *)
    shift
    ;;
  esac
done

if [[ -n "${YOUTUBE_TRANSCRIBE_TEST_YTDLP_RETRY_DIR:-}" ]]; then
  mkdir -p "$YOUTUBE_TRANSCRIBE_TEST_YTDLP_RETRY_DIR"
  count_file="$YOUTUBE_TRANSCRIBE_TEST_YTDLP_RETRY_DIR/yt-dlp-count"
  count=0
  [[ -f "$count_file" ]] && count="$(cat "$count_file")"
  printf '%s' "$((count + 1))" >"$count_file"

  if [[ "$count" -eq 0 ]]; then
    printf 'simulated yt-dlp failure\n' >&2
    exit 1
  fi

  if [[ "$uses_web_client" != true ]]; then
    printf 'expected youtube web player client retry\n' >&2
    exit 2
  fi
fi

[[ -n "$output_pattern" ]] || { echo 'missing -o' >&2; exit 2; }
output_file="${output_pattern//%(ext)s/mp3}"
mkdir -p "$(dirname "$output_file")"
printf 'fake mp3 audio' >"$output_file"
SH

  cat >"$fake_bin/ffmpeg" <<'SH'
#!/usr/bin/env bash
set -euo pipefail

output_pattern="${@: -1}"
mkdir -p "$(dirname "$output_pattern")"
printf 'chunk zero' >"${output_pattern//%04d/0000}"
printf 'chunk one' >"${output_pattern//%04d/0001}"
SH

  cat >"$fake_bin/curl" <<'SH'
#!/usr/bin/env bash
set -euo pipefail

output_file=""
payload_file=""

while [[ $# -gt 0 ]]; do
  case "$1" in
  -o)
    output_file="$2"
    shift 2
    ;;
  --data-binary)
    payload_file="${2#@}"
    shift 2
    ;;
  -w | -H)
    shift 2
    ;;
  *)
    shift
    ;;
  esac
done

[[ -n "$output_file" ]] || { echo 'missing -o' >&2; exit 2; }
[[ -n "$payload_file" ]] || { echo 'missing payload' >&2; exit 2; }

idx="0"
if [[ "$(basename "$output_file")" =~ response_([0-9]+)\.json ]]; then
  idx="${BASH_REMATCH[1]}"
fi

if [[ -n "${YOUTUBE_TRANSCRIBE_TEST_PAYLOAD_DIR:-}" ]]; then
  mkdir -p "$YOUTUBE_TRANSCRIBE_TEST_PAYLOAD_DIR"
  cp "$payload_file" "$YOUTUBE_TRANSCRIBE_TEST_PAYLOAD_DIR/payload_${idx}.json"
fi

printf '{"text":"Transcript chunk %s"}' "$idx" >"$output_file"
printf '200'
SH

  chmod +x "$fake_bin/yt-dlp" "$fake_bin/ffmpeg" "$fake_bin/curl"
}

test_help_and_syntax() {
  bash -n "$BIN"

  local output
  output="$($BIN --help)"
  assert_contains "$output" 'Usage: youtube-transcribe' 'help includes command name'
  assert_contains "$output" 'openai/gpt-4o-transcribe' 'help includes default model'
  assert_contains "$output" 'OPENROUTER_API_KEY' 'help includes credential requirement'

  pass 'help and syntax'
}

test_argument_validation() {
  assert_fails_with 'Usage: youtube-transcribe' "$BIN"
  assert_fails_with '--output requires a value' "$BIN" --output
  assert_fails_with 'Unsupported format: xml' "$BIN" --format xml dQw4w9WgXcQ
  assert_fails_with '--chunk-seconds must be a positive integer' "$BIN" --chunk-seconds 0 dQw4w9WgXcQ

  pass 'argument validation'
}

test_missing_key_before_network() {
  local fake_bin="$TMP_DIR/fake-bin-missing-key"
  make_fake_deps "$fake_bin"

  assert_fails_with \
    'OPENROUTER_API_KEY is not set' \
    env -u OPENROUTER_API_KEY PATH="$fake_bin:$PATH" "$BIN" --credentials-file "$TMP_DIR/missing.env" dQw4w9WgXcQ

  pass 'missing key validation'
}

test_mocked_json_transcription_flow() {
  local fake_bin="$TMP_DIR/fake-bin-e2e"
  local payload_dir="$TMP_DIR/payloads"
  local output_file="$TMP_DIR/transcript.json"
  make_fake_deps "$fake_bin"

  env \
    PATH="$fake_bin:$PATH" \
    OPENROUTER_API_KEY='test-key' \
    YOUTUBE_TRANSCRIBE_TEST_PAYLOAD_DIR="$payload_dir" \
    "$BIN" \
      --format json \
      --language en \
      --chunk-seconds 123 \
      --model test/model \
      --output "$output_file" \
      dQw4w9WgXcQ >/dev/null

  jq -e \
    '.source == "https://www.youtube.com/watch?v=dQw4w9WgXcQ"
      and .model == "test/model"
      and .language == "en"
      and (.chunks | length == 2)
      and .chunks[0].start_seconds == 0
      and .chunks[0].start == "00:00:00"
      and .chunks[0].text == "Transcript chunk 0"
      and .chunks[1].start_seconds == 123
      and .chunks[1].start == "00:02:03"
      and .chunks[1].text == "Transcript chunk 1"' \
    "$output_file" >/dev/null

  jq -e \
    '.model == "test/model"
      and .language == "en"
      and .input_audio.format == "mp3"
      and (.input_audio.data | type == "string")
      and (.input_audio.data | length > 0)' \
    "$payload_dir/payload_0.json" >/dev/null

  pass 'mocked json transcription flow'
}

test_markdown_stdout_flow() {
  local fake_bin="$TMP_DIR/fake-bin-md"
  make_fake_deps "$fake_bin"

  local output
  output="$(
    env \
      PATH="$fake_bin:$PATH" \
      OPENROUTER_API_KEY='test-key' \
      "$BIN" \
        --language en \
        --chunk-seconds 60 \
        youtu.be/dQw4w9WgXcQ
  )"

  assert_contains "$output" '# YouTube transcript' 'markdown has title'
  assert_contains "$output" 'source:: https://youtu.be/dQw4w9WgXcQ' 'markdown preserves URL source'
  assert_contains "$output" 'model:: openai/gpt-4o-transcribe' 'markdown includes default model'
  assert_contains "$output" '## 00:00:00' 'markdown has first timestamp'
  assert_contains "$output" '## 00:01:00' 'markdown has second timestamp'
  assert_contains "$output" 'Transcript chunk 1' 'markdown includes second chunk'

  pass 'markdown stdout flow'
}

test_yt_dlp_web_client_retry() {
  local fake_bin="$TMP_DIR/fake-bin-retry"
  local retry_dir="$TMP_DIR/retry"
  local output_file="$TMP_DIR/retry-transcript.json"
  make_fake_deps "$fake_bin"

  env \
    PATH="$fake_bin:$PATH" \
    OPENROUTER_API_KEY='test-key' \
    YOUTUBE_TRANSCRIBE_TEST_YTDLP_RETRY_DIR="$retry_dir" \
    "$BIN" \
      --format json \
      --language en \
      --chunk-seconds 60 \
      --output "$output_file" \
      dQw4w9WgXcQ >/dev/null

  [[ "$(cat "$retry_dir/yt-dlp-count")" == 2 ]] || fail 'yt-dlp should be called twice when first download fails'
  jq -e '.chunks | length == 2' "$output_file" >/dev/null

  pass 'yt-dlp web client retry'
}

test_help_and_syntax
test_argument_validation
test_missing_key_before_network
test_mocked_json_transcription_flow
test_markdown_stdout_flow
test_yt_dlp_web_client_retry

printf 'All youtube-transcribe tests passed.\n'
