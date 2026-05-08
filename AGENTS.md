# AGENTS.md

## Commands

- Install: `./install.sh` or `./install.sh [module1] [module2]...`
- Uninstall: `./uninstall.sh <module>`
- Modules: `zshrc tmux alacritty nvim local mise spaceship bat`
- Lua lint: `stylua` (config: `nvim/nvim/stylua.toml`)
- Update submodules: `git submodule update --remote --merge`

## Architecture

GNU Stow-based modular dotfiles. Each directory is a Stow package:

- **Home targets** (`$HOME`): `zshrc`, `tmux`, `local`, `spaceship`
- **Config targets** (`$HOME/.config`): `alacritty`, `nvim`, `mise`, `bat`
- **nvim**: Git submodule (github.com/lelouvincx/nvim) with LazyVim base

## Code Style

- **Lua**: 4 spaces, 120 char limit, snake_case
- **Shell**: Bash with `set -e`, POSIX preferred
- **Commits**: Conventional format (feat:, fix:, chore:)
- **Stow**: Maintain proper directory hierarchy for symlink targets
- **Security**: Use `secrets.zsh` (git-ignored) for sensitive vars

## Directory Structure

```
alacritty/
  alacritty/
    alacritty.toml
bat/
  bat/
    config
local/
  .local/
    bin/
      sqlfix-gum.sh
      sqlfix.sh
mise/
  mise/
    config.toml
nvim/
  nvim/
    after/
      ftplugin/
        dbml.lua
        lua.lua
    lua/
      config/
        autocmds.lua
        keymaps.lua
        lazy.lua
        options.lua
      plugins/
        lang/
          dbt.lua
          lua.lua
          python.lua
        amp.lua
        blink.lua
        bufferline.lua
        claudecode.lua
        codesnap.lua
        colorscheme.lua
        copilot-lualine.lua
        fidget.lua
        gitsigns.lua
        lazydocker.lua
        lsp-signature.lua
        lspconfig.lua
        lualine.lua
        neo-tree.lua
        neogen.lua
        noice.lua
        none-ls.lua
        notification.lua
        project.lua
        rainbow.lua
        remote.lua
        telescope.lua
        tmux.lua
        treesitter.lua
        zenmode.lua
    .git
    .repomixignore
    init.lua
    lazy-lock.json
    lazyvim.json
spaceship/
  spaceship.zsh
tmux/
  .tmux.conf
zshrc/
  .zsh/
    aliases.zsh
    config.zsh
    env.zsh
    tools.zsh
  .zimrc
  .zshenv
  .zshrc
.repomixignore
.stow-local-ignore
AGENTS.md
Brewfile
CLAUDE.md
default-iterm-profile.json
install.sh
LICENSE
README.md
repomix.config.json
touchegg.conf
uninstall.sh
```
