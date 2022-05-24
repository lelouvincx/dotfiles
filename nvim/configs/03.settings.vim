" -----------------------------------------------------------------------

" Commenter
filetype plugin on
filetype plugin indent on

" Map ctrl / to comment and uncomment
nmap <C-_>   :Commentary<cr>
vmap <C-_>   :Commentary<cr>
" -----------------------------------------------------------------------

"Airline
let g:airline_theme = 'base16_solarized_light'
let g:airline_powerline_fonts = 1
let g:airline_left_sep = ''
let g:airline_right_sep = ''
let g:airline_detect_paste = 1

" Extensions
"
" Tabline - showing the top buffers bar
"
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#formatter = 'unique_tail' " file-name.js
" let g:airline#extensions#tabline#formatter = 'default' " file-name.js
let g:airline#extensions#tabline#show_splits = 1
let g:airline#extensions#tabline#alt_sep = 1
let g:airline#extensions#tabline#exclude_preview = 1
let g:airline#extensions#tabline#show_close_button = 1
let g:airline#extensions#tabline#close_symbol = 'X'
" fixes unnecessary redraw, when e.g. opening Gundo window
let airline#extensions#tabline#ignore_bufadd_pat =
    \ '\c\vgundo|undotree|vimfiler|tagbar|nerd_tree'

let g:airline#extensions#branch#enabled = 1
 
let g:airline#extensions#fzf#enabled = 1

let g:airline#extensions#virtualenv#enabled = 1

let g:airline_section_c = '%t'
let g:airline_section_z = '%3p%% %3l/%L:%3v'

" Symbols
if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif

" Powerline symbols
let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''
let g:airline_symbols.branch = ''
let g:airline_symbols.readonly = ''
let g:airline_symbols.linenr = '☰'
let g:airline_symbols.maxlinenr = ''
let g:airline_symbols.dirty='⚡'

" -----------------------------------------------------------------------

" Tmux navigation

nnoremap <silent> {c-h} :TmuxNavigateLeft<cr>
nnoremap <silent> {c-j} :TmuxNavigateDown<cr>
nnoremap <silent> {c-k} :TmuxNavigateUp<cr>
nnoremap <silent> {c-l} :TmuxNavigateRight<cr>
nnoremap <silent> {c-z} :TmuxNavigatePrevious<cr>

" Disable tmux navigator when zooming the Vim pane
let g:tmux_navigator_disable_when_zoomed = 1

" -----------------------------------------------------------------------
"
"  Coc-nvim

" Coc-highlight
" Config suggestion box's color
hi Pmenu ctermbg=White ctermfg=White guibg=Black
hi PmenuSel guibg=#b7c7b7 gui=NONE
hi PmenuSbar guibg=#bcbcbc
hi PmenuThumb guibg=#585858
" Cursor hold
autocmd CursorHold * silent call CocActionAsync('highlight')

" Coc-snippets
"
" Make Tab used for autocompletion, snippet expand and jump
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()

" Bind shift tab for vice versa
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
" Use ctrl-shift-space for trigger completion
inoremap <silent><expr> <c-s-space> coc#refresh()

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

let g:coc_snippet_next = '<tab>'
" -----------------------------------------------------------------------
"
"  Tabline cofig

hi TabLine      ctermfg=Black  ctermbg=Green     cterm=NONE
hi TabLineFill  ctermfg=Black  ctermbg=Green     cterm=NONE
hi TabLineSel   ctermfg=White  ctermbg=DarkBlue  cterm=NONE
let g:tablineclosebutton=1

" -----------------------------------------------------------------------
"
"  nvim-tree

let g:nvim_tree_git_hl = 1 "0 by default, will enable file highlight for git attributes (can be used without the icons).
let g:nvim_tree_highlight_opened_files = 1 "0 by default, will enable folder and file icon highlight for opened files/directories.
let g:nvim_tree_root_folder_modifier = ':~' "This is the default. See :help filename-modifiers for more options
let g:nvim_tree_add_trailing = 1 "0 by default, append a trailing slash to folder names
let g:nvim_tree_group_empty = 1 " 0 by default, compact folders that only contain a single folder into one node in the file tree
let g:nvim_tree_icon_padding = ' ' "one space by default, used for rendering the space between the icon and the filename. Use with caution, it could break rendering if you set an empty string depending on your font.
let g:nvim_tree_symlink_arrow = ' >> ' " defaults to ' ➛ '. used as a separator between symlinks' source and target.
let g:nvim_tree_respect_buf_cwd = 1 "0 by default, will change cwd of nvim-tree to that of new buffer's when opening nvim-tree.
let g:nvim_tree_create_in_closed_folder = 1 "0 by default, When creating files, sets the path of a file when cursor is on a closed folder to the parent folder when 0, and inside the folder when 1.
let g:nvim_tree_special_files = { 'README.md': 1, 'Makefile': 1, 'MAKEFILE': 1 } " List of filenames that gets highlighted with NvimTreeSpecialFile
let g:nvim_tree_show_icons = {
    \ 'git': 1,
    \ 'folders': 1,
    \ 'files': 1,
    \ 'folder_arrows': 1,
    \ }
"If 0, do not show the icons for one of 'git' 'folder' and 'files'
"1 by default, notice that if 'files' is 1, it will only display
"if nvim-web-devicons is installed and on your runtimepath.
"if folder is 1, you can also tell folder_arrows 1 to show small arrows next to the folder icons.
"but this will not work when you set renderer.indent_markers.enable (because of UI conflict)

" default will show icon by default if no icon is provided
" default shows no icon by default
let g:nvim_tree_icons = {
    \ 'default': "",
    \ 'symlink': "",
    \ 'git': {
    \   'unstaged': "✗",
    \   'staged': "✓",
    \   'unmerged': "",
    \   'renamed': "➜",
    \   'untracked': "★",
    \   'deleted': "",
    \   'ignored': "◌"
    \   },
    \ 'folder': {
    \   'arrow_open': "",
    \   'arrow_closed': "",
    \   'default': "",
    \   'open': "",
    \   'empty': "",
    \   'empty_open': "",
    \   'symlink': "",
    \   'symlink_open': "",
    \   }
    \ }

nnoremap <F2> :NvimTreeToggle<CR>
nnoremap <leader>r :NvimTreeRefresh<CR>
nnoremap <leader>n :NvimTreeFindFile<CR>
" More available functions:
" NvimTreeOpen
" NvimTreeClose
" NvimTreeFocus
" NvimTreeFindFileToggle
" NvimTreeResize
" NvimTreeCollapse
" NvimTreeCollapseKeepBuffers

set termguicolors " this variable must be enabled for colors to be applied properly

" a list of groups can be found at `:help nvim_tree_highlight`
" highlight NvimTreeFolderIcon guibg=DarkCyan
"
" -----------------------------------------------------------------------
"
"  Ranger

let g:ranger_map_keys=1
let g:ranger_open_new_tab=1
" vnoremap <C-f> :Ranger<CR>

" -----------------------------------------------------------------------
"
"  Tagbar

nmap <F12> :TagbarToggle<CR>
let g:Tlist_Ctags_Cmd='/usr/bin/ctags'

" -----------------------------------------------------------------------
"
"  Fold setup
