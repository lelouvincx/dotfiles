#!/bin/zsh
# Aliases configuration

# System aliases
alias cls="clear"
alias zshrc="EDITOR=$EDITOR ~/.zshrc"

# File operations
alias cat="bat"

# Tmux
alias ta="TERM=screen-256color tmux attach"
alias td="TERM=screen-256color tmux detach"
alias tmux="TERM=screen-256color tmux -2"

# Docker and container tools
alias dkc="docker compose"
alias ld="lazydocker"
alias dive="docker run -ti --rm -v /var/run/docker.sock:/var/run/docker.sock wagoodman/dive"
alias stirling-pdf='docker run --rm -d --name stirling-pdf -p 8080:8080 \
  -v "./StirlingPDF/trainingData:/usr/share/tessdata" \
  -v "./StirlingPDF/extraConfigs:/configs" \
  -v "./StirlingPDF/customFiles:/customFiles/" \
  -v "./StirlingPDF/logs:/logs/" \
  -v "./StirlingPDF/pipeline:/pipeline/" \
  -e DOCKER_ENABLE_SECURITY=false -e LANGS=en_GB stirlingtools/stirling-pdf:latest'
alias speedtest="docker run -ti --rm --init --net host --name speedtest huss4in7/speedtest-cli --accept-license"

# Git tools
alias lz="lazygit"
alias c="uvx --from commitizen cz c"
alias gs="git status"

# Neovim
alias n="nvim ."
alias nv="nvim"

# Development tools
alias pre-commit="uvx pre-commit"
alias sqlfluff="uvx sqlfluff"

# System info
alias f="fastfetch -c examples/12.jsonc"

# Configure sqlfix executable
if ! $(which gum) &>/dev/null; then
  alias sqlfix="${HOME}/.local/bin/sqlfix-gum.sh"
else
  alias sqlfix="${HOME}/.local/bin/sqlfix.sh"
fi
