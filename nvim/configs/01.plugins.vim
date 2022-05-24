call plug#begin('~/.config/nvim/bundle')
" --------------------------------------------------------
"
" Manage nvim plugins
Plug 'gmarik/Vundle.vim'

" Color scheme
Plug 'overcache/NeoSolarized'
Plug 'morhetz/gruvbox'

" Dev icons
Plug 'kyazdani42/nvim-web-devicons'

" Navigate smoothly b/w nvim and tmux
Plug 'christoomey/vim-tmux-navigator'

" Airline status line
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" Code highlighting
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

" Git for neovim
Plug 'tpope/vim-fugitive'

" LSP config
Plug 'neovim/nvim-lspconfig'

" Coc-nvim code suggestions
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" Commenter
Plug 'tpope/vim-commentary'

" Tabline
Plug 'mkitt/tabline.vim'

" Tagbar
Plug 'preservim/tagbar'

" Autocomplete parentheses, brackets, quotes, ...
Plug 'jiangmiao/auto-pairs'

" A file explorer showing as tree
Plug 'kyazdani42/nvim-tree.lua'

" File explorer inside nvim
Plug 'francoiscabrol/ranger.vim'
Plug 'rbgrouleff/bclose.vim'

" FZF
"
Plug 'junegunn/fzf', {'dir': '~/.fzf','do': './install --all'}
Plug 'junegunn/fzf.vim' " needed for previews
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'antoinemadec/coc-fzf', {'branch': 'release'}

" Startify
"
Plug 'mhinz/vim-startify'

" Folder for vim
"
Plug 'tmhedberg/simpylfold'

" --------------------------------------------------------
"
call plug#end()

