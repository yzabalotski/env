" turn off VI-compatible mode
set nocompatible

" enable recursive file search from current dir
set path+=**

" line number settings
set number
set relativenumber

inoremap jk <esc>
let mapleader = " "

" fast vimrc editting
nnoremap <leader>ev :vsplit $MYVIMRC<cr>
nnoremap <leader>sv :source $MYVIMRC<cr>

" highlight cursor line
set cursorline
highlight CursorLine ctermbg=16

" highlight 80 column
set colorcolumn=80
highlight ColorColumn ctermbg=10

" clean up highlighting after search
nnoremap <F3> :let @/ = ""<CR>

" handy movements between buffers
noremap <C-l> <C-w>l
noremap <C-h> <C-w>h
noremap <C-j> <C-w>j
noremap <C-k> <C-w>k

" show invisible symbols
set listchars=eol:$,tab:>>,trail:~,extends:-,precedes:<
set list

" configure indent
set smartindent

" init pathgen
execute pathogen#infect()

" open Tagbar
nmap <F8> :TagbarToggle<CR>
