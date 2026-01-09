# lelouvincx's dotfiles 🚀

[![Auto Update Submodules](https://github.com/lelouvincx/dotfiles/actions/workflows/update-submodule.yaml/badge.svg?branch=main)](https://github.com/lelouvincx/dotfiles/actions/workflows/update-submodule.yaml)

Welcome to my **dotfiles** repository!

## Features

### Terminal Stack

- **[Alacritty](https://alacritty.org/)** - GPU-accelerated terminal emulator
- **[Tmux](https://github.com/tmux/tmux)** - Terminal multiplexer
- **[Zsh](https://www.zsh.org/) + [Spaceship Prompt](https://spaceship-prompt.sh/)**
  - [Zim](https://zimfw.sh/) framework for fast startup and plugin management

### Neovim Configuration

https://github.com/lelouvincx/nvim

### Development Tools

- **[Mise](https://mise.jdx.dev/)** - Tool version manager

## To Do

- [ ] Create bootstrap script to install prerequisites (Homebrew, Stow, Zsh, Zimfw, Mise, Alacritty)
- [ ] Add automatic Zim framework installation if not present
- [ ] Ensure all CLI tools are available via Mise or package managers
- [ ] Add health check script to verify all dependencies

## Repository Structure

```plaintext
├── .github/
│   ├── ISSUE_TEMPLATE/           # Templates for bug reports and feature requests
│   ├── workflows/                # GitHub Actions for CI/CD automation
├── alacritty/                    # Alacritty terminal configuration
│   └── .config/
│       └── alacritty/
│           └── alacritty.toml
├── mise/                         # Mise configuration
│   └── mise/
│       └── config.toml/
├── spaceship/                    # Spaceship configuration
│   └── spaceship.zsh
├── nvim/                         # Neovim-specific submodule
│   └── nvim/                     # Neovim configuration files
├── tmux/                         # tmux configuration
│   └── .tmux.conf
├── zshrc/                        # Zsh configurations
│   ├── .zimrc                    # Zim framework packages
│   ├── .zsh/                     # Modular Zsh configs
│   │   ├── aliases.zsh           # Command aliases
│   │   ├── config.zsh            # Main Zsh settings
│   │   ├── env.zsh               # Environment variables
│   │   ├── tools.zsh             # Tool integrations
│   │   └── secrets.zsh           # Git-ignored secrets
│   ├── .zshenv
│   └── .zshrc
├── local/                        # Local scripts and utilities
│   └── .local/
│       └── bin/                  # User scripts
├── .stow-local-ignore            # Patterns for files Stow should ignore
├── Brewfile                      # Homebrew packages list
├── install.sh                    # Installation script using GNU Stow
├── LICENSE                       # Licensing information
└── README.md                     # Project documentation (this file)
```

## Getting Started

### Prerequisites

- **Git**: For managing and cloning the repository
- **GNU Stow**: For managing symlinks to dotfiles
- **Zsh**: Shell environment with Zim framework
- **Alacritty**: GPU-accelerated terminal emulator
- **Tmux**: Terminal multiplexer
- **Mise**: Tool version manager (will install other tools)

### Installation

1. Clone this repository:

   ```bash
   git clone --recursive https://github.com/lelouvincx/dotfiles.git ~/.dotfiles
   ```

2. Navigate to the repository:

   ```bash
   cd ~/.dotfiles
   ```

3. Install GNU Stow if not already installed:

   ```bash
   # macOS
   brew install stow

   # Ubuntu/Debian
   sudo apt install stow

   # Fedora/RHEL
   sudo dnf install stow
   ```

4. Run the installation script to install all configurations:

   ```bash
   ./install.sh
   ```

   Or install specific modules:

   ```bash
   ./install.sh zsh tmux nvim
   ```

### Available Modules

- `local` - scripts and utilities in `.local/bin`
- `zshrc`
- `tmux`
- `alacritty`
- `nvim`
- `mise`
- `spaceship`

### Updating

To pull the latest changes and update submodules:

```bash
git pull --recurse-submodules
git submodule update --remote --merge
```

After updating, rerun the installation script:

```bash
./install.sh <module>
```

To uninstall a module, run the uninstall script:

```bash
./uninstall.sh <module>
```
