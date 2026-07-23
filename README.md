# dotfiles

[![Auto Update Submodules](https://github.com/lelouvincx/dotfiles/actions/workflows/update-submodule.yaml/badge.svg?branch=main)](https://github.com/lelouvincx/dotfiles/actions/workflows/update-submodule.yaml)

## Stack

- **Alacritty**: terminal
- **Tmux**: multiplexer
- **Zsh + Zim + Spaceship**: shell, framework, prompt
- **Neovim**: [lelouvincx/nvim](https://github.com/lelouvincx/nvim)
- **Mise**: tool version mgr
- **Bat + Herdr**: pager theme and terminal workspace config
- **Local CLIs**: `yt-transcript` for YouTube captions, `youtube-transcribe` for OpenRouter STT, `holistics-init` for AMQL repository setup

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

## Holistics project setup

`holistics-init` creates a local Git repository and downloads its Holistics AMQL code. It requires the
[Holistics CLI](https://docs.holistics.io/docs/cli) and Git.

Install the `local` dotfiles module to expose the command on `PATH`:

```bash
./install.sh local
```

Usage:

```bash
holistics-init <domain> <directory-amql> <remote-url> <branch>
```

Example:

```bash
holistics-init \
  eu \
  prusa-amql \
  https://gitlab.com/prusa3d-platform/ai-playground/holistics-bi \
  feature/migration-audit-parity-prep
```

The command authenticates with the selected Holistics domain, creates the directory, initializes Git with
the specified remote and branch, creates an empty commit, then runs `holistics sync-code .`. The directory
name must end with `-amql` and must not already exist.

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
