#!/bin/zsh
# Environment variables configuration

# Default editor
export EDITOR=nvim

# Tool selection variables
export LS_EXECUTABLE=lsd # either lsd or exa
export LANGUAGE_EXECUTABLE=mise # either asdf or mise

# 1Password CLI
export OP_BIOMETRIC_UNLOCK_ENABLED=true

# Spaceship prompt config
export SPACESHIP_CONFIG="${HOME}/spaceship.zsh"

# Path extension
export PATH="${HOME}/.local/bin:${HOME}/.amp/bin:${HOME}/.opencode/bin:${HOME}/.holistics/bin:$PATH"

# Amp plugin env
export PLUGINS=all
export AGENTS_REGISTRY_ENV=local
export AMP_CONFIG_DIR="${HOME}/.config/amp"
