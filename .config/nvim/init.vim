syntax enable
set nu
set rnu

let mapleader = " "
nnoremap <leader>ev :vsplit $MYVIMRC<cr>
nnoremap <leader>sv :source $MYVIMRC<cr>

" clean up highlighting after search
nnoremap <silent> <F3> :let @/ = ""<CR>

noremap <C-l> <C-w>l
noremap <C-h> <C-w>h
noremap <C-j> <C-w>j
noremap <C-k> <C-w>k

nnoremap <M-h> gT
nnoremap <M-l> gt

" show invisible symbols
set listchars=eol:$,tab:>-,trail:~,extends:-,precedes:<
set list
