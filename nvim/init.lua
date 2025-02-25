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

-- Open all folds by default
vim.opt.foldlevelstart = 99

vim.g.mapleader = "<Space>"
vim.g.maplocalleader = ","
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

vim.keymap.set("n", "<leader>ec", ":e $MYVIMRC<cr>")
vim.keymap.set("n", "<leader>sc", ":source $MYVIMRC<cr>")
vim.keymap.set("n", "<leader>bn", ":bnext")
vim.keymap.set("n", "<leader>bp", ":bprev")
vim.keymap.set("n", "<leader>i", ":lua vim.diagnostic.open_float(nil, { focus = false, scope = 'cursor' })")

require("config.lazy")
