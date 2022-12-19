local opt = vim.opt
local cmd = vim.cmd
--------------------------------------------------------------------------------
-- general settings
--------------------------------------------------------------------------------
-- set nocompatible ?
cmd'syntax enable'
-- set path+=** ?
opt.number = true
opt.relativenumber = true
opt.listchars = 'eol:$,tab:>-,trail:~,extends:-,precedes:<'
opt.list = true
opt.smartindent = true
opt.cursorline = true
opt.colorcolumn = '80'
cmd'au FileType xml setlocal equalprg=xmllint\\ --format\\ --recover\\ -\\ 2>/dev/null'
cmd'au FileType json setlocal equalprg=python\\ -m\\ json.tool'
opt.exrc = true -- ?
opt.expandtab = true
opt.tabstop = 4
opt.shiftwidth = 4
--------------------------------------------------------------------------------
-- plugins
--------------------------------------------------------------------------------
vim.cmd([[
call plug#begin()
Plug 'altercation/vim-colors-solarized'
Plug 'neovim/nvim-lspconfig'
call plug#end()
]])
-- solarized
opt.background = 'dark'
cmd'colorscheme solarized'
-- lsp
-- `on_attach` function example from git repo
local on_attach = function(client, bufnr)
  -- Enable completion triggered by <c-x><c-o>
  -- vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  local bufopts = { noremap=true, silent=true, buffer=bufnr }
  vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
  vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
  vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
  vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, bufopts)
  vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
  vim.keymap.set('n', '<space>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, bufopts)
  vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, bufopts)
  vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, bufopts)
  vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, bufopts)
  vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
  vim.keymap.set('n', '<space>f', function() vim.lsp.buf.format { async = true } end, bufopts)
end
require'lspconfig'.pyright.setup{
    on_attach = on_attach
}
require'lspconfig'.clangd.setup{
    on_attach = on_attach
}
--------------------------------------------------------------------------------
-- keymaps
--------------------------------------------------------------------------------
local g = vim.g
local map = vim.api.nvim_set_keymap
local default_opts = {noremap = true, silent = true}

g.mapleader = ' '
map('n', '<leader>ev', ':vsplit $MYVIMRC<cr>', default_opts)
map('n', '<leader>sv', ':source $MYVIMRC<cr>', default_opts)
-- clean up highlighting after search
map('n', '<F2>', ':let @/ = ""<cr>', default_opts)
-- handy movements between buffers
map('', '<C-l>', '<C-w>l', default_opts)
map('', '<C-h>', '<C-w>h', default_opts)
map('', '<C-j>', '<C-w>j', default_opts)
map('', '<C-k>', '<C-w>k', default_opts)
-- handy movements between tabs (alt(meta) + h/j)
map('', '<M-h>', 'gT', default_opts)
map('', '<M-l>', 'gt', default_opts)
map('', '<M-t>', ':tabnew<cr>', default_opts)
map('', '<M-q>', ':tabclose<cr>', default_opts)
