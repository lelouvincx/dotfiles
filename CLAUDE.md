# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Build/Lint/Test Commands
- Install dotfiles: `./install.sh` or `./install.sh [module1] [module2]...`
- Check available modules: See modules list in `install.sh`
- Lua linting/formatting: Use `stylua` with config in `nvim/nvim/stylua.toml`
- Verbose installation: `./install.sh -v` or `./install.sh --verbose`

## Code Style Guidelines
- **Lua**: 4 spaces indentation, 120 character line limit
- **Shell**: Use bash for scripts, follow POSIX compatibility when possible
- **Naming**: Use descriptive variable names with snake_case for Lua
- **LazyVim**: Follow LazyVim plugin conventions for Neovim configuration
- **Error Handling**: Use appropriate error handling for bash scripts (set -e)
- **Git Commits**: Use conventional commits format (feat:, fix:, chore:, etc.)
- **Comments**: Keep comments minimal and focused on "why" not "what"
- **Imports**: In Lua, organize imports logically with LazyVim imports first
- **Modules**: Keep dotfiles organized in stow-compatible module structure

This repository is a collection of dotfiles managed with GNU Stow. Respect the existing organizational structure and configuration patterns when making changes.