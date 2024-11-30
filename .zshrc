# Bind auto suggest key
bindkey '`' autosuggest-accept

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Clear screen
alias cls="clear"

# Zoxide
eval "$(zoxide init zsh)"

# Use lsd instead of ls
alias ls="lsd"
alias la="lsd -a"
alias ll="lsd -lAhg --group-dirs first"
alias lah="lsd -lah"

# Use bat instead for cat
alias cat="bat --theme Catppuccin-mocha"

# Alias tmux
alias ta="TERM=screen-256color tmux attach"
alias td="TERM=screen-256color tmux detach"
alias tmux="TERM=screen-256color tmux -2"

# Alias docker compose to dkc
alias dkc="docker compose"
alias ld="lazydocker"

# Alias lazygit, commitizen
alias lz="lazygit"
alias c="uvx --from commitizen cz c"

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

# Asdf configurations
. "$HOME/.asdf/asdf.sh"
fpath=(${ASDF_DIR}/completions $fpath) # append completions to fpath

# Set JAVA_HOME
. ~/.asdf/plugins/java/set-java-home.zsh

# Alacritty auto suggest
fpath+=${ZDOTDIR:-~}/.zsh_functions
fpath+=${ZDOTDIR:-~}/.zsh_functions

# Mojo path
export MODULAR_HOME="/home/lelouvincx/.modular"
export PATH="/home/lelouvincx/.modular/pkg/packages.modular.com_mojo/bin:$PATH"

# Set cowsay
cowsay -f tux "Hello lelouvincx"
