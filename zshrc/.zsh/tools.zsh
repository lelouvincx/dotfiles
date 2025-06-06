#!/bin/zsh
# Tool configurations

# Configure language management tool (asdf or mise)
# WARN: asdf or mise must be intalled first, to be able to use other tools
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

# Install fzf-dbt
FZF_DBT_PATH=~/.fzf-dbt/fzf-dbt.sh
if [[ ! -f $FZF_DBT_PATH ]]; then
    FZF_DBT_DIR=$(dirname $FZF_DBT_PATH)
    print -P "%F{green}Installing fzf-dbt into $FZF_DBT_DIR%f"
    mkdir -p $FZF_DBT_DIR
    command curl -L https://raw.githubusercontent.com/Infused-Insight/fzf-dbt/main/src/fzf_dbt.sh > $FZF_DBT_PATH && \
        print -P "%F{green}Installation successful.%f" || \
        print -P "%F{red}The download has failed.%f"
fi

export FZF_DBT_PREVIEW_CMD="cat {}"
export FZF_DBT_HEIGHT=80%
source $FZF_DBT_PATH
