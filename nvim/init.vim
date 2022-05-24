for f in split(glob('~/.config/nvim/configs/*.vim'), '\n')
	exe 'source' f
endfor

" let g:loaded_python_provider = 1

lua require('init')
