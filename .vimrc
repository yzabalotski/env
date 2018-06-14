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
