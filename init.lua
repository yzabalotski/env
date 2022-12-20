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
Plug 'nvim-lua/plenary.nvim'
Plug 'BurntSushi/ripgrep'
Plug 'sharkdp/fd'
Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.0' }

" nvim-cmp
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/nvim-cmp'
" For vsnip users.
Plug 'hrsh7th/cmp-vsnip'
Plug 'hrsh7th/vim-vsnip'
" lug 'hrsh7th/cmp-nvim-lsp-signature-help'
Plug 'ray-x/lsp_signature.nvim'

set completeopt=menu,menuone,noselect

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
  --vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
  --vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
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
  vim.keymap.set('n', '<space>F', function() vim.lsp.buf.format { async = true } end, bufopts)
end
require'lspconfig'.pyright.setup{
    on_attach = on_attach
}
require'lspconfig'.clangd.setup{
    on_attach = on_attach
}
require "lsp_signature".setup({
  bind = true, -- This is mandatory, otherwise border config won't get registered.
  handler_opts = {
    border = "rounded"
  }
})
-- telescope
local g = vim.g
g.mapleader = ' '
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})
-- nvim-cmp
local cmp = require'cmp'

cmp.setup({
snippet = {
  -- REQUIRED - you must specify a snippet engine
  expand = function(args)
    vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
    -- require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
    -- require('snippy').expand_snippet(args.body) -- For `snippy` users.
    -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
  end,
},
window = {
  completion = cmp.config.window.bordered(),
  documentation = cmp.config.window.bordered(),
},
mapping = cmp.mapping.preset.insert({
  ['<C-b>'] = cmp.mapping.scroll_docs(-4),
  ['<C-f>'] = cmp.mapping.scroll_docs(4),
  ['<C-Space>'] = cmp.mapping.complete(),
  ['<C-e>'] = cmp.mapping.abort(),
  ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
}),
sources = cmp.config.sources({
  { name = 'nvim_lsp' },
  { name = 'vsnip' }, -- For vsnip users.
  -- { name = 'luasnip' }, -- For luasnip users.
  -- { name = 'ultisnips' }, -- For ultisnips users.
  -- { name = 'snippy' }, -- For snippy users.
}, {
  { name = 'buffer' },
  -- { name = 'nvim_lsp_signature_help' }, -- for signature_help
})
})

-- Set configuration for specific filetype.
cmp.setup.filetype('gitcommit', {
sources = cmp.config.sources({
  { name = 'cmp_git' }, -- You can specify the `cmp_git` source if you were installed it.
}, {
  { name = 'buffer' },
})
})

-- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline({ '/', '?' }, {
mapping = cmp.mapping.preset.cmdline(),
sources = {
  { name = 'buffer' }
}
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(':', {
mapping = cmp.mapping.preset.cmdline(),
sources = cmp.config.sources({
  { name = 'path' }
}, {
  { name = 'cmdline' }
})
})

-- Set up lspconfig.
local capabilities = require('cmp_nvim_lsp').default_capabilities()
-- Replace <YOUR_LSP_SERVER> with each lsp server you've enabled.
require('lspconfig')['clangd'].setup {
capabilities = capabilities
}
require('lspconfig')['pyright'].setup {
capabilities = capabilities
}
--------------------------------------------------------------------------------
-- keymaps
--------------------------------------------------------------------------------
local map = vim.api.nvim_set_keymap
local default_opts = {noremap = true, silent = true}

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

map('n', 'gr', ':lua vim.lsp.buf.references()<cr>', default_opts)
map('n', 'gd', ':lua vim.lsp.buf.definition()<cr>', default_opts)
