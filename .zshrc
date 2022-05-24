# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
# if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  # source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
# fi
typeset -g POWERLEVEL10K_INSTANT_PROMPT=off

# Path to your oh-my-zsh installation
export ZSH="/home/lelouvincx/.oh-my-zsh"

# Set name of the theme to load
ZSH_THEME="powerlevel10k/powerlevel10k"

# Which plugins would you like to load?
source $ZSH/oh-my-zsh.sh
source /home/lelouvincx/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /home/lelouvincx/.oh-my-zsh/custom/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source /home/lelouvincx/.oh-my-zsh/plugins/command-not-found/command-not-found.plugin.zsh

# Load plugins
plugins=(zsh-autosuggestions zsh-syntax-highlighting thefuck git command-not-found virtualenv tmux)

# User configuration
export PATH="/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/home/lelouvincx/.local/bin/"
# export MANPATH="/usr/local/man:$MANPATH"

# Config plugins
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=60'
eval $(thefuck --alias)

# Alias
fpath+=${ZDOTDIR:-~}/.zsh_functions

## Add shortcut "Shift + Enter"
bindkey '`' autosuggest-accept

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/home/lelouvincx/anaconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/home/lelouvincx/anaconda3/etc/profile.d/conda.sh" ]; then
        . "/home/lelouvincx/anaconda3/etc/profile.d/conda.sh"
    else
        export PATH="/home/lelouvincx/anaconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

export PATH=/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/home/lelouvincx/.local/bin/:/home/lelouvincx/anaconda3/bin

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
