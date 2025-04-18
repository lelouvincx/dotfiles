# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Build/Lint/Test Commands

- Install dotfiles: `./install.sh` or `./install.sh [module1] [module2]...`
- Install only Neovim: `./install.sh nvim`
- Check available modules: `zshrc`, `tmux`, `alacritty`, `nvim`, `local`, `mise`, `spaceship`
- Lua formatting: `stylua filename.lua` (config in `nvim/nvim/stylua.toml`)
- Verbose installation: `./install.sh -v` or `./install.sh --verbose`
- Neovim plugin commands: Use `:Lazy` or `<space> + L` to manage plugins

## Code Style Guidelines

- **Lua**: 4 spaces indentation, 120 character line limit
- **Shell**: Use bash for scripts with `set -e` for error handling
- **Naming**: Use descriptive snake_case variables for Lua
- **Plugins**: Follow LazyVim plugin spec format with consistent structure
- **Git Commits**: Use conventional commits format (feat:, fix:, chore:, etc.)
- **Comments**: Keep minimal and focused on explaining "why" not "what"
- **Imports**: Organize Lua imports with LazyVim imports first
- **Structure**: Keep proper LazyVim directory organization (/lua/config/, /lua/plugins/)
- **Modules**: Maintain stow-compatible module structure for all dotfiles

This repository is a collection of dotfiles managed with GNU Stow. Each module is designed to be stowed independently to its target location.
