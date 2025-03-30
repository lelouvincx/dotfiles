#!/bin/zsh
# Main ZSH configurations

# Set editor default keymap to emacs (`-e`) or vi (`-v`)
bindkey -e

# Bind auto suggest key
bindkey '`' autosuggest-accept

# Remove path separator from WORDCHARS.
WORDCHARS=${WORDCHARS//[\/]}

# Remove older command from the history if a duplicate is to be added.
setopt HIST_IGNORE_ALL_DUPS

# Configure spaceship prompt
SPACESHIP_CHAR_SYMBOL='↓'
source "${HOME}/.zim/modules/spaceship/spaceship.zsh"

# Alacritty auto suggest paths
fpath+=${ZDOTDIR:-~}/.zsh_functions
