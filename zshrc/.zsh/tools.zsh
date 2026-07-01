#!/bin/zsh
# Tool configurations

# Configure language management tool (asdf or mise)
# WARN: asdf or mise must be installed first, to be able to use other tools
if [[ "$LANGUAGE_EXECUTABLE" == "asdf" ]]; then
  # Asdf configurations
  . "$HOME/.asdf/asdf.sh"
  fpath=(${ASDF_DIR}/completions $fpath) # append completions to fpath
elif [[ "$LANGUAGE_EXECUTABLE" == "mise" ]]; then
  # Mise activate
  eval "$($HOME/.local/bin/mise activate zsh)"
else
  echo "Invalid value for LANGUAGE_EXECUTABLE. Please set it to either 'asdf' or 'mise'."
  return 1
fi

# Zoxide initialization
eval "$(zoxide init zsh)"

# Direnv initialization
eval "$(direnv hook zsh)"

# Auto update clean main branches when entering a git repo.
autoload -Uz add-zsh-hook
typeset -gA _auto_git_pulled_repos

auto_git_pull_main_on_cd() {
  command -v git >/dev/null 2>&1 || return

  local repo_root branch
  repo_root=$(git rev-parse --show-toplevel 2>/dev/null) || return

  # Pull each repo at most once per shell session.
  [[ -n "${_auto_git_pulled_repos[$repo_root]}" ]] && return

  branch=$(git -C "$repo_root" branch --show-current 2>/dev/null) || return
  [[ "$branch" == "main" ]] || return

  # Avoid auto-pulling over local edits, staged changes, or untracked files.
  [[ -z "$(git -C "$repo_root" status --porcelain)" ]] || return

  echo "git: updating $repo_root main..."
  git -C "$repo_root" fetch origin main --quiet || return
  git -C "$repo_root" pull --ff-only origin main

  _auto_git_pulled_repos[$repo_root]=1
}

add-zsh-hook chpwd auto_git_pull_main_on_cd
auto_git_pull_main_on_cd

# Configure ls alternative (lsd or exa)
if [[ "$LS_EXECUTABLE" == "lsd" ]]; then
  alias ls="lsd"
  alias la="lsd -a"
  alias ll="lsd -lAhg --group-dirs first"
  alias lah="lsd -lah"
  alias lt="lsd --tree --depth 2"
elif [[ "$LS_EXECUTABLE" == "exa" ]]; then
  alias ls="exa"
  alias la="exa -a"
  alias ll="exa -l"
  alias lah="exa -lah"
  alias l="exa -lahg --icons --color=always --group-directories-first --git"
  alias lt="exa -T -L 2"
else
  echo "Invalid value for LS_EXECUTABLE. Please set it to either 'lsd' or 'exa'."
  return 1
fi
