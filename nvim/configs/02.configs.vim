let mapleader = "|"

" Stuffs that should be set by default: {{{
syntax on
syntax enable

set softtabstop=4
set tabstop=4
set expandtab
set shiftwidth=4
set nocompatible            " use new features whenever they are available
set bs=2                    " backspace should work as we expect
set autoindent
set history=50              " remember last 50 commands
set ruler                   " show cursor position in bottom line
set number relativenumber                     " show line number
set hlsearch                " highlight search result
" y and d put stuff into system clipboard (so that other apps can see it)
set clipboard=unnamed,unnamedplus
set textwidth=0
" Open new split to right / bottom
set splitbelow
set splitright
" Automatically update changed files (but need to focus on the file)
" set autoread
autocmd FocusGained * checktime
set foldmethod=manual
set foldlevel=20
" Disable Ex mode.
nnoremap Q <Nop>
" Copy multiple times: gv to reselect and y to copy again.
xnoremap p pgvy
" }}}

" Misc {{{
set autoread                " auto re-read changes outside vim
set autowrite               " auto save before make/execute
set showcmd
set timeout                 " adjust timeout for mapped commands
set timeoutlen=1200

set visualbell
set noerrorbells
" }}}

" Display related: {{{
set display+=lastline       " Show everything you can in the last line (intead of stupid @@@)
set display+=uhex           " Show chars that cannot be displayed as <13> instead of ^M
" }}}

" Searching {{{
set incsearch               " show first match when start typing
set ignorecase              " default should ignore case
set smartcase               " use case sensitive if I use uppercase
" }}}

" Syntax theme "{{{
" ---------------------------------------------------------------------

" Do not need anymore because I have treesitter
syntax enable
set termguicolors

" if exists("&termguicolors") && exists("&winblend")
  " syntax enable
  " set termguicolors
  " set winblend=0
  " set wildoptions=pum
  " highlight Normal ctermbg=None
  " set pumblend=5
  " set background=dark
  " let no_buffers_menu=1
  " let g:neosolarized_termtrans=1
  " let g:neosolarized_vertSplitBgTrans=0
  " runtime /home/lelouvincx/.config/nvim/bundle/NeoSolarized/colors/NeoSolarized.vim
  " colorscheme NeoSolarized
" endif

" }}}

" Extras "{{{
" ------------------------------------------------------------
set exrc
"}}}

" -------------------------------------------------------------
" Navigating between buffers
map <A-t> :bn<CR>
map <A-S-t> :bp<CR>
map <A-d> :bd<CR>
