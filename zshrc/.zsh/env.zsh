#!/bin/zsh
# Environment variables configuration

# Default editor
export EDITOR=nvim

# GitHub token (consider using a secure method to store this)
export GITHUB_TOKEN=

# Tool selection variables
export LS_EXECUTABLE=lsd # either lsd or exa
export LANGUAGE_EXECUTABLE=mise # either asdf or mise

# Spaceship prompt config
export SPACESHIP_CONFIG="${HOME}/spaceship.zsh"

# Added by dbt installer
export PATH="$PATH:/Users/lelouvincx/.local/bin"

# dbt aliases
alias dbtf=/Users/lelouvincx/.local/bin/dbt

# Amp CLI
export PATH="/Users/lelouvincx/.amp/bin:$PATH"
