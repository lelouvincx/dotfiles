# dotfiles

[![Auto Update Submodules](https://github.com/lelouvincx/dotfiles/actions/workflows/update-submodule.yaml/badge.svg?branch=main)](https://github.com/lelouvincx/dotfiles/actions/workflows/update-submodule.yaml)

## Stack

- **Alacritty**: terminal
- **Tmux**: multiplexer
- **Zsh + Zim + Spaceship**: shell, framework, prompt
- **Neovim**: [lelouvincx/nvim](https://github.com/lelouvincx/nvim)
- **Mise**: tool version mgr
- **Bat + Herdr**: pager theme and terminal workspace config
- **Local CLIs**: `yt-transcript` for YouTube captions, `youtube-transcribe` for OpenRouter STT

## Layout

```diagram
╭──────────────╮       ╭──────────────────────╮
│ install.sh   │──────▶│ scripts/stow-modules │
│ uninstall.sh │       │ module → target map   │
╰──────┬───────╯       ╰──────────┬───────────╯
       │                          │
       ▼                          ▼
╭──────────────╮       ╭──────────────────────╮
│ $HOME        │       │ $HOME/.config        │
│ zshrc tmux   │       │ alacritty nvim mise  │
│ local prompt │       │ bat herdr            │
╰──────────────╯       ╰──────────────────────╯
```

## Install

```bash
git clone --recursive https://github.com/lelouvincx/dotfiles.git ~/.dotfiles
cd ~/.dotfiles
brew install stow    # macOS; apt/dnf for Linux
./install.sh         # all modules
./install.sh zshrc tmux nvim  # or pick modules
```

## Modules

`zshrc` `tmux` `alacritty` `nvim` `local` `mise` `spaceship` `bat` `herdr`

## Update

```bash
git pull --recurse-submodules && git submodule update --remote --merge
./install.sh
```

## Test

```bash
./scripts/test-youtube-transcribe.sh
uvx pre-commit run --all-files
```

## Uninstall

```bash
./uninstall.sh <module>
```
