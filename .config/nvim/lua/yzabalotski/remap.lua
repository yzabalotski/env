vim.g.mapleader = " "
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex) -- TODO: is it needed?

vim.keymap.set("n", "<M-t>", vim.cmd.tabnew)
vim.keymap.set("n", "<M-q>", vim.cmd.tabclose)
vim.keymap.set("n", "<M-h>", vim.cmd.tabp)
vim.keymap.set("n", "<M-l>", vim.cmd.tabn)

vim.keymap.set("n", "<C-l>", "<C-w>l")
vim.keymap.set("n", "<C-h>", "<C-w>h")
vim.keymap.set("n", "<C-j>", "<C-w>j")
vim.keymap.set("n", "<C-k>", "<C-w>k")

vim.keymap.set("n", "<leader>/", vim.cmd.nohlsearch)

-- moving lines around
vim.keymap.set("v", "<M-j>", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "<M-k>", ":m '<-2<CR>gv=gv")
vim.keymap.set("n", "<M-j>", ":m .+1<CR>==")
vim.keymap.set("n", "<M-k>", ":m .-2<CR>==")

-- delete to black hole register
vim.keymap.set("x", "<leader>d", "\"_d")

-- copy to system clipboard
vim.keymap.set("n", "<leader>y", "\"+y")
vim.keymap.set("v", "<leader>y", "\"+y")
