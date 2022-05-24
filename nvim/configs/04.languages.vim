" Specific settings for specific filetypes:    {{{
" usual policy: if there is a Makefile present, :mak calls make, otherwise we define a command to compile the filetype

" C/C++:
function! CSET()
    set makeprg=if\ \[\ -f\ \"Makefile\"\ \];then\ make\ $*;else\ if\ \[\ -f\ \"makefile\"\ \];then\ make\ $*;else\ gcc\ -O2\ -g\ -Wall\ -Wextra\ -o%.bin\ %\ -lm;fi;fi
    set cindent
    set nowrap
endfunction

function! CPPSET()
    set makeprg=if\ \[\ -f\ \"Makefile\"\ \];then\ make\ $*;else\ if\ \[\ -f\ \"makefile\"\ \];then\ make\ $*;else\ g++\ -std=gnu++0x\ -O2\ -g\ -Wall\ -Wextra\ -o\ %<\ %;fi;fi
    set cindent
    set nowrap
    nnoremap <buffer> <F7> :w<cr>:!g++ -Wall -Wextra -Wshadow -O2 % -o %< -std=c++11 -I ./<cr>
    nnoremap <buffer> <F8> :w<cr>:!g++ -O2 % -o %< -std=c++14 -I ./<cr>:!./%< < in<cr>
    nnoremap <buffer> <F9> :w<cr>:!g++ % -o %<<cr>:!./%< < in<cr>
    nnoremap <buffer> <F10> :w<cr>:!g++ % -o %<<cr>:!./%< <cr>:!cat %<.out<cr>
endfunction

" Java
function! JAVASET()
    set makeprg=if\ \[\ -f\ \"Makefile\"\ \];then\ make\ $*;else\ if\ \[\ -f\ \"makefile\"\ \];then\ make\ $*;else\ javac\ -g\ %;fi;fi
    set cindent
    set nowrap
    nnoremap <buffer> <F8> :w<cr>:!javac %<cr>
    nnoremap <buffer> <F9> :w<cr>:!javac %<cr>:!java %< %<cr>
endfunction

" vim scripts
function! VIMSET()
    set nowrap
    set tabstop=2
    set softtabstop=2
    set shiftwidth=2
endfunction

" Python
function! PYSET()
    if exists('g:no_pyset')
        return
    endif
    set nowrap

    set autoindent
    set expandtab
    set shiftwidth=4
    set tabstop=4
    " nnoremap <buffer> <F9> :w<cr>:exec '!clear && python3' shellescape(@%, 1)<cr>
    nnoremap <buffer> <F9> :w !python3<cr>
endfunction

" Autocommands for all languages:
autocmd BufNewFile,BufReadPost *.py2 set filetype=python
autocmd FileType vim        call VIMSET()
autocmd FileType c          call CSET()
autocmd FileType C          call CPPSET()
autocmd FileType cc         call CPPSET()
autocmd FileType cpp        call CPPSET()
autocmd FileType java       call JAVASET()
autocmd FileType python     call PYSET()

" }}}

" Disable ~ when inside tmux, as Ctrl + PageUp/Down are translated to 5~
if &term =~ '^screen'
	map ~ <Nop>
endif

" Show filename in tmux panel
autocmd BufEnter,BufReadPost,FileReadPost,BufNewFile * call system("tmux rename-window " . expand('%'))
autocmd VimLeave * call system("tmux rename-window bash")

