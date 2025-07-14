# lelouvincx's dotfiles 🚀

[![Auto Update Submodules](https://github.com/lelouvincx/dotfiles/actions/workflows/update-submodule.yaml/badge.svg?branch=main)](https://github.com/lelouvincx/dotfiles/actions/workflows/update-submodule.yaml)

Welcome to my **dotfiles** repository! This project serves as a central hub for managing, sharing, and maintaining my development environment configurations. From Vim tweaks to terminal optimizations, these configurations aim to enhance productivity and streamline workflows.

---

## 🎯 **Features**

### **Terminal Stack**
- **[Alacritty](https://alacritty.org/)** - GPU-accelerated terminal emulator
  - JetBrainsMono Nerd Font at 17pt for excellent readability
  - Catppuccin Latte theme with 90% opacity and blur effects
  - Optimized for macOS with proper Option key handling

- **[Tmux](https://github.com/tmux/tmux)** - Terminal multiplexer
  - Catppuccin Latte theme for visual consistency
  - Vim-style navigation with smart pane switching
  - Session persistence via tmux-resurrect and tmux-continuum
  - Battery status, automatic restore, and yank support

- **[Zsh](https://www.zsh.org/) + [Spaceship Prompt](https://spaceship-prompt.sh/)**
  - Modular configuration split into logical components (env, config, tools, aliases, secrets)
  - [Zim](https://zimfw.sh/) framework for fast startup and plugin management
  - Auto-suggestions, syntax highlighting, and substring history search
  - Comprehensive prompt showing git status, language versions, execution time, and more

### **Neovim Configuration**
- LazyVim-based setup with 30+ carefully selected plugins
- Multiple AI integrations: GitHub Copilot, Supermaven, and Avante
- Extensive LSP support for 15+ languages
- Maintained as a [separate repository](https://github.com/lelouvincx/nvim) via git submodule

### **Development Tools**
- **[Mise](https://mise.jdx.dev/)** - Polyglot tool version manager
  - Manages 17 development tools including Python, Node.js, Rust, Java, and more
  - Replaces asdf with better performance and features

- **Modern CLI Replacements**
  - `lsd` → `ls` (with icons and git integration)
  - `bat` → `cat` (with syntax highlighting)
  - `zoxide` → `cd` (smart directory jumping)
  - `lazygit` & `lazydocker` for TUI git/docker management

### **GNU Stow Integration**
- Organized, modular configuration management
- Easy installation with selective module support
- Clean separation between home and config directory targets

## 📋 **To Do**

- [ ] Create bootstrap script to install prerequisites (Homebrew, Stow, Zsh, Zimfw, Mise, Alacritty)
- [ ] Add automatic Zim framework installation if not present
- [ ] Ensure all CLI tools are available via Mise or package managers
- [ ] Add health check script to verify all dependencies

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

---

## 🔧 **Getting Started**

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

- `zshrc` - Zsh configuration with modular setup (env, config, tools, aliases)
- `tmux` - Tmux configuration with Catppuccin theme and plugins
- `alacritty` - Alacritty terminal configuration with Catppuccin Latte theme
- `nvim` - Neovim configuration (LazyVim-based, maintained as submodule)
- `local` - Scripts and utilities in `.local/bin`
- `mise` - Mise tool version manager configuration
- `spaceship` - Spaceship prompt configuration for Zsh

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

---

## Important Notes

### Environment Configuration

- **Secrets Management**: The `.zsh/secrets.zsh` file is git-ignored for storing sensitive environment variables (API keys, tokens, etc.)
- **Tool Selection**: Configure your preferred tools via environment variables in `.zsh/env.zsh`:
  - `LS_EXECUTABLE`: Choose between `lsd` or `exa`
  - `LANGUAGE_EXECUTABLE`: Choose between `mise` or `asdf`
- **Color Scheme**: Unified Catppuccin Latte theme across Alacritty, Tmux, and Neovim for visual consistency

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

## 🌟 **Acknowledgments**

- Plugins and integrations from the vibrant open-source community.
- Inspired by [LazyVim](https://github.com/LazyVim/LazyVim).
- [GNU Stow](https://www.gnu.org/software/stow/) for excellent dotfiles management.

---

## 🐞 **Support**

Found a bug? Want to request a feature? Open an issue in the [issue tracker](https://github.com/lelouvincx/dotfiles/issues).
