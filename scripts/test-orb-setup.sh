#!/usr/bin/env bash
set -euo pipefail

root="$(git rev-parse --show-toplevel)"
scratch="$(mktemp -d)"
trap 'rm -rf "$scratch"' EXIT
export HOME="$scratch/home" GIT_CONFIG_NOSYSTEM=1 GIT_CONFIG_GLOBAL=/dev/null
mkdir -p "$HOME" "$scratch/upstream/.agents"
export MARKER="$scratch/marker"
printf '#!/usr/bin/env bash\necho stale >> "$MARKER"\n' > "$scratch/upstream/.agents/setup"
chmod +x "$scratch/upstream/.agents/setup"
git -C "$scratch/upstream" init -q -b main
git -C "$scratch/upstream" add .
git -C "$scratch/upstream" -c user.name=Fixture -c user.email=fixture@example.invalid -c commit.gpgsign=false commit -qm initial
git clone -q "$scratch/upstream" "$scratch/checkout"
cat > "$scratch/upstream/.agents/setup" <<'HOOK'
#!/usr/bin/env bash
set -euo pipefail
test "$AGENT_SKILLS_REPO" = "$EXPECTED_REPO"
test "$AGENT_SKILLS_DIR" = "$EXPECTED_DIR"
test "$1" = 'argument with spaces'
echo current >> "$MARKER"
HOOK
git -C "$scratch/upstream" add .
git -C "$scratch/upstream" -c user.name=Fixture -c user.email=fixture@example.invalid -c commit.gpgsign=false commit -qm updated
export AGENT_SKILLS_REPO="$scratch/upstream" EXPECTED_REPO="$scratch/upstream"
export AGENT_SKILLS_DIR="$scratch/checkout" EXPECTED_DIR="$scratch/checkout"
bash "$root/.agents/setup" 'argument with spaces'
test "$(cat "$MARKER")" = current
rm "$MARKER"
bash "$root/.agents/setup" 'argument with spaces'
test "$(cat "$MARKER")" = current
echo 'PASS: stale first invocation and warm invocation dispatch current hook'

printf '\n# retained local edit\n' >> "$AGENT_SKILLS_DIR/.agents/setup"
cp "$AGENT_SKILLS_DIR/.agents/setup" "$scratch/expected"
for state in unstaged staged; do
	if [ "$state" = staged ]; then git -C "$AGENT_SKILLS_DIR" add .agents/setup; fi
	bash "$root/.agents/setup" 'argument with spaces' > "$scratch/output"
	grep -q 'local changes detected; skipping pull' "$scratch/output"
	cmp "$scratch/expected" "$AGENT_SKILLS_DIR/.agents/setup"
done
echo 'PASS: staged and unstaged edits preserved'
git -C "$AGENT_SKILLS_DIR" reset -q --hard HEAD
git -C "$AGENT_SKILLS_DIR" remote set-url origin "$scratch/absent-remote"
rm "$MARKER"
if bash "$root/.agents/setup" 'argument with spaces'; then
	echo 'FAIL: failed refresh must stop dispatch' >&2
	exit 1
fi
test ! -e "$MARKER"
echo 'PASS: failed pull never dispatches stale hook'

export AGENT_SKILLS_DIR="$scratch/new-checkout" EXPECTED_DIR="$scratch/new-checkout"
bash "$root/.agents/setup" 'argument with spaces'
test "$(cat "$MARKER")" = current
export AGENT_SKILLS_DIR="$scratch/existing"
mkdir -p "$AGENT_SKILLS_DIR"
touch "$AGENT_SKILLS_DIR/sentinel"
if bash "$root/.agents/setup"; then exit 1; fi
test -f "$AGENT_SKILLS_DIR/sentinel"
echo 'PASS: clone missing checkout and preserve existing non-checkout'
