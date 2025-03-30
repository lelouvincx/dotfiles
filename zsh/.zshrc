#!/bin/zsh
# Main .zshrc file - loads modular configs

# Load environment variables
source ~/.zsh/env.zsh

# Load main configurations
source ~/.zsh/config.zsh

# Load tool configurations
source ~/.zsh/tools.zsh

# Load aliases
source ~/.zsh/aliases.zsh

# Display greeting
cowsay -f tux "Hello lelouvincx!"
