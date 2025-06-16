#!/bin/zsh
# Main .zshrc file - loads modular configs

# Load environment variables
source ~/.zsh/env.zsh

# Load secret variables if the file exists
[ -f ~/.zsh/secrets.zsh ] && source ~/.zsh/secrets.zsh

# Load main configurations
source ~/.zsh/config.zsh

# Load tool configurations
source ~/.zsh/tools.zsh

# Load aliases
source ~/.zsh/aliases.zsh

# Display greeting
cowsay -f tux "Hello lelouvincx!"

# Added by dbt installer
export PATH="$PATH:/Users/lelouvincx/.local/bin"

# dbt aliases
alias dbtf=/Users/lelouvincx/.local/bin/dbt
