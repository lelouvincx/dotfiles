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

# Path extension
export PATH="${HOME}/.local/bin:${HOME}/.amp/bin:${HOME}/.opencode/bin:${HOME}/.holistics/bin:$PATH"

# Amp plugin env
export PLUGINS=all
export AGENTS_REGISTRY_ENV=local
