#!/bin/zsh
# Tool configurations

# Zoxide initialization
eval "$(zoxide init zsh)"

# Direnv initialization
eval "$(direnv hook zsh)"

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
  exit 1
fi

# Configure language management tool (asdf or mise)
if [[ "$LANGUAGE_EXECUTABLE" == "asdf" ]]; then
  # Asdf configurations
  . "$HOME/.asdf/asdf.sh"
  fpath=(${ASDF_DIR}/completions $fpath) # append completions to fpath
elif [[ "$LANGUAGE_EXECUTABLE" == "mise" ]]; then
  # Mise activate
  eval "$($HOME/.local/bin/mise activate zsh)"
else
  echo "Invalid value for LANGUAGE_EXECUTABLE. Please set it to either 'asdf' or 'mise'."
  exit 1
fi
