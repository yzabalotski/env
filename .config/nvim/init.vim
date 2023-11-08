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

call plug#begin()
" telescope
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.4' }
" solarized
Plug 'altercation/vim-colors-solarized'
call plug#end()

" find files using Telescope command-line sugar
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>

" solarized
syntax enable
set background=dark
colorscheme solarized
