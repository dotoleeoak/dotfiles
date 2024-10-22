vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.incsearch = true
vim.opt.hlsearch = true
vim.opt.clipboard = "unnamedplus"
vim.opt.scrolloff = 3
vim.opt.expandtab = true
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.showmode = false

vim.g.mapleader = "<Space>"
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

vim.keymap.set("n", "<leader>n", "<cmd>bnext<cr>")
vim.keymap.set("n", "<leader>p", "<cmd>bprevious<cr>")
vim.keymap.set("n", "<leader>d", "<cmd>bdelete<cr>")

require("config.lazy")
