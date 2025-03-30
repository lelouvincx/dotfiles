# lelouvincx's dotfiles 🚀

[![Auto Update Submodules](https://github.com/lelouvincx/dotfiles/actions/workflows/update-submodule.yaml/badge.svg?branch=main)](https://github.com/lelouvincx/dotfiles/actions/workflows/update-submodule.yaml)

Welcome to my **dotfiles** repository! This project serves as a central hub for managing, sharing, and maintaining my development environment configurations. From Vim tweaks to terminal optimizations, these configurations aim to enhance productivity and streamline workflows.

---

## 🎯 **Features**

- **Neovim Configuration**:
  - Modular structure with plugins managed via `lazy.nvim`.
  - Advanced LSP integration (`pyright`, `lua_ls`, etc.).
  - AI-powered suggestions using `copilot.nvim`.
  - Preconfigured plugins for coding, UI enhancements, and more.
- **Shell Customizations**:

  - Zsh setup using the `spaceship.zsh` prompt.
  - Optimized `.zshrc` for aliases, environment variables, and plugins.

- **Terminal Configurations**:

  - Themes and key bindings for `alacritty` and `tmux`.

- **Git Submodules**:

  - Automatically updated via GitHub Actions.
  - Seamless integration of external repositories.

- **GNU Stow Integration**:
  - Organized, modular configuration management
  - Easy installation with selective module support
  - Simplified dotfiles updates and maintenance

---

## 📂 **Repository Structure**

```plaintext
├── .github/
│   ├── ISSUE_TEMPLATE/           # Templates for bug reports and feature requests
│   ├── workflows/                # GitHub Actions for CI/CD automation
├── alacritty/                    # Alacritty terminal configuration
│   └── .config/
│       └── alacritty/
│           └── alacritty.toml
├── nvim/                         # Neovim-specific configurations
│   └── .config/
│       └── nvim/                 # Neovim configuration files
├── tmux/                         # tmux configuration
│   └── .tmux.conf
├── zsh/                          # Zsh configurations
│   ├── .zimrc
│   ├── .zsh/                     # Zsh modules (aliases, env, etc.)
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

---

## 🔧 **Getting Started**

### Prerequisites

- **Git**: For managing and cloning the repository.
- **GNU Stow**: For managing symlinks to dotfiles.
- **Neovim**: Latest version is recommended.
- **Zsh**: Preferred shell environment.
- **Tmux**: For terminal multiplexing.
- **Alacritty**: Terminal emulator.

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

- `alacritty` - Alacritty terminal configuration
- `nvim` - Neovim configuration
- `tmux` - Tmux configuration
- `zsh` - ZSH configuration
- `local` - Scripts and utilities in `.local/bin`

### Updating

To pull the latest changes and update submodules:

```bash
git pull --recurse-submodules
git submodule update --remote --merge
```

After updating, rerun the installation script:

```bash
./install.sh
```

---

## 🤝 **Contributing**

Contributions are welcome! Here's how you can help:

1. Fork this repository.
2. Create a feature branch:
   ```bash
   git checkout -b feature/your-feature
   ```
3. Commit your changes:
   ```bash
   git commit -m "feat: add your feature"
   ```
4. Push to the branch:
   ```bash
   git push origin feature/your-feature
   ```
5. Open a pull request.

Please read the [CONTRIBUTING.md](CONTRIBUTING.md) for detailed guidelines.

---

## 🛠️ **Automation**

### GitHub Actions

- **Submodule Updates**: Automatically keeps submodules in sync with their latest commits.
- **Release Management**: Uses `release-please` for version tagging and changelogs.

---

## 📝 **License**

This repository is licensed under the [MIT License](LICENSE). Feel free to use and adapt these configurations.

---

## 🌟 **Acknowledgments**

- Plugins and integrations from the vibrant open-source community.
- Inspired by [LazyVim](https://github.com/LazyVim/LazyVim).
- [GNU Stow](https://www.gnu.org/software/stow/) for excellent dotfiles management.

---

## 🐞 **Support**

Found a bug? Want to request a feature? Open an issue in the [issue tracker](https://github.com/lelouvincx/dotfiles/issues).
