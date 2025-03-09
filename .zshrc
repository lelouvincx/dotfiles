export EDITOR=nvim
export GITHUB_TOKEN=

# Bind auto suggest key
bindkey '`' autosuggest-accept

# Clear screen
alias cls="clear"

# Zoxide
eval "$(zoxide init zsh)"

# For ls alternative, use exa or lsd
# Use lsd instead of ls
alias ls="lsd"
alias la="lsd -a"
alias ll="lsd -lAhg --group-dirs first"
alias lah="lsd -lah"
# Use exa instead of ls
alias ls="exa"
alias la="exa -a"
alias ll="exa -l"
alias lah="exa -lah"
alias l="exa -lahg --icons --color=always --group-directories-first --git"
alias lt="exa -T -L 2"

# Use bat instead for cat
alias cat="bat"

# Alias tmux
alias ta="TERM=screen-256color tmux attach"
alias td="TERM=screen-256color tmux detach"
alias tmux="TERM=screen-256color tmux -2"

# Alias docker compose to dkc
alias dkc="docker compose"
alias ld="lazydocker"
alias dive="docker run -ti --rm  -v /var/run/docker.sock:/var/run/docker.sock wagoodman/dive"

# Alias lazygit, commitizen
alias lz="lazygit"
alias c="uvx --from commitizen cz c"
alias gits="git status"

# Alias zshrc
alias zshrc="nvim ~/.zshrc"

# Alias neovim
alias n="nvim ."
alias nv="nvim"

# Config spaceship prompt
SPACESHIP_CHAR_SYMBOL='↓'
export SPACESHIP_CONFIG="$HOME/Repos/dotfiles/spaceship.zsh"
source "${HOME}/.zim/modules/spaceship/spaceship.zsh"

# Alias speedtest
alias speedtest="docker run -ti --rm --init --net host --name speedtest huss4in7/speedtest-cli --accept-license"

# Direnv
eval "$(direnv hook zsh)"

# For language mangement, use either asdf or mise
# Asdf configurations
. "$HOME/.asdf/asdf.sh"
fpath=(${ASDF_DIR}/completions $fpath) # append completions to fpath
# Mise activate
eval "$($HOME/.local/bin/mise activate zsh)"

# Alacritty auto suggest
fpath+=${ZDOTDIR:-~}/.zsh_functions
fpath+=${ZDOTDIR:-~}/.zsh_functions

# Alias stirling-pdf - a local many-in-one pdf tool
alias stirling-pdf='docker run --rm -d --name stirling-pdf -p 8080:8080 -v "./StirlingPDF/trainingData:/usr/share/tessdata" -v "./StirlingPDF/extraConfigs:/configs" -v "./StirlingPDF/customFiles:/customFiles/" -v "./StirlingPDF/logs:/logs/" -v "./StirlingPDF/pipeline:/pipeline/" -e DOCKER_ENABLE_SECURITY=false -e LANGS=en_GB stirlingtools/stirling-pdf:latest'

# Alias fastfetch
alias f="fastfetch -c examples/12.jsonc"

# Alias pre-commit
alias pre-commit="uvx pre-commit"

# Alias sqlfluff
alias sqlfluff="uvx sqlfluff"

# Set cowsay
cowsay -f tux "Hello lelouvincx"
