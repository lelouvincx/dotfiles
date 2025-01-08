# lelouvincx's dotfiles 🚀

[![Auto Update Submodules](https://github.com/lelouvincx/dotfiles/actions/workflows/update-submodule.yml/badge.svg)](https://github.com/lelouvincx/dotfiles/actions/workflows/update-submodule.yml)

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

---

## 📂 **Repository Structure**

```plaintext
├── .github/
│   ├── ISSUE_TEMPLATE/           # Templates for bug reports and feature requests
│   ├── workflows/                # GitHub Actions for CI/CD automation
│       ├── update-submodule.yml  # Automated submodule updates
├── nvim/                         # Neovim-specific configurations
│   ├── after/                    # File-specific settings
│   ├── ftdetect/                 # File type detection
│   ├── lua/                      # Lua modules for plugins and settings
│   ├── .github/                  # Submodules-specific workflows
├── .gitignore                    # Ignored files
├── .tmux.conf                    # tmux configuration
├── .zshrc                        # Zsh configuration
├── LICENSE                       # Licensing information
├── README.md                     # Project documentation (this file)
├── alacritty.toml                # Alacritty terminal configuration
├── default-iterm-profile.json    # iTerm2 configuration
```

---

## 🔧 **Getting Started**

### Prerequisites

- **Git**: For managing and cloning the repository.
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
3. Run the setup script (if available) or manually link the files:
   ```bash
   ./install.sh
   ```
   _or manually symlink configurations:_
   ```bash
   ln -s ~/.dotfiles/.zshrc ~/.zshrc
   ln -s ~/.dotfiles/.tmux.conf ~/.tmux.conf
   ```

### Updating

To pull the latest changes and update submodules:

```bash
git pull --recurse-submodules
git submodule update --remote --merge
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

---

## 🐞 **Support**

Found a bug? Want to request a feature? Open an issue in the [issue tracker](https://github.com/lelouvincx/dotfiles/issues).
