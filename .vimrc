" turn off VI-compatible mode
set nocompatible

syntax enable

" enable recursive file search from current dir
set path+=**

" line number settings
set number
set relativenumber

" =============================================================================
" key mappings
" =============================================================================
let mapleader = " "

" fast vimrc editting
nnoremap <leader>ev :vsplit $MYVIMRC<cr>
nnoremap <leader>sv :source $MYVIMRC<cr>

" clean up highlighting after search
nnoremap <silent> <F3> :let @/ = ""<CR>

" handy movements between buffers
noremap <C-l> <C-w>l
noremap <C-h> <C-w>h
noremap <C-j> <C-w>j
noremap <C-k> <C-w>k

" simplify using tabs (alt(meta) + h/j)
nnoremap <M-h> gT
nnoremap <M-l> gt
nnoremap <M-t> :tabnew<cr>
nnoremap <M-q> :tabclose<cr>

" show invisible symbols
set listchars=eol:$,tab:>-,trail:~,extends:-,precedes:<
set list

" configure indent
set smartindent

" init pathgen
execute pathogen#infect()

" open Tagbar
nmap <F8> :TagbarToggle<CR>

nnoremap <F4> :grep -R <cword> * <CR>:cw <CR>

" solarized theme
set background=dark
colorscheme solarized

" highlight cursor line
set cursorline
highlight CursorLine ctermbg=0

" highlight 80 column
set colorcolumn=80
highlight ColorColumn ctermbg=0

set exrc

au FileType xml setlocal equalprg=xmllint\ --format\ --recover\ -\ 2>/dev/null
au FileType json setlocal equalprg=python\ -m\ json.tool

hi SpecialKey ctermbg=8
hi SpecialKey ctermfg=0
