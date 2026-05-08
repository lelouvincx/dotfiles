# dotfiles

[![Auto Update Submodules](https://github.com/lelouvincx/dotfiles/actions/workflows/update-submodule.yaml/badge.svg?branch=main)](https://github.com/lelouvincx/dotfiles/actions/workflows/update-submodule.yaml)

## Stack

- **Alacritty**: terminal
- **Tmux**: multiplexer
- **Zsh + Zim + Spaceship**: shell, framework, prompt
- **Neovim**: [lelouvincx/nvim](https://github.com/lelouvincx/nvim)
- **Mise**: tool version mgr

## Install

```bash
git clone --recursive https://github.com/lelouvincx/dotfiles.git ~/.dotfiles
cd ~/.dotfiles
brew install stow    # macOS; apt/dnf for Linux
./install.sh         # all modules
./install.sh zsh tmux nvim  # or pick modules
```

## Modules

`local` `zshrc` `tmux` `alacritty` `nvim` `mise` `spaceship`

## Update

```bash
git pull --recurse-submodules && git submodule update --remote --merge
./install.sh
```

## Uninstall

```bash
./uninstall.sh <module>
```
