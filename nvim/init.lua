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
vim.opt.tabstop = 4
vim.opt.expandtab = true
vim.opt.showmode = false
vim.opt.termguicolors = true
vim.opt.winborder = "rounded"

-- Open all folds by default
vim.opt.foldlevelstart = 99

vim.g.mapleader = " "
vim.g.maplocalleader = ","
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

vim.opt.langmap =
    "ㅁa,ㅠb,ㅊc,ㅇd,ㄷe,ㄹf,ㅎg,ㅗh,ㅑi,ㅓj,ㅏk,ㅣl,ㅡm,ㅜn,ㅐo,ㅔp,ㅂq,ㄱr,ㄴs,ㅅt,ㅕu,ㅍv,ㅈw,ㅌx,ㅛy,ㅋz"

vim.keymap.set("n", "<space>ec", ":e $MYVIMRC<cr>")
vim.keymap.set("n", "<space>sc", ":source $MYVIMRC<cr>")
vim.keymap.set("n", "<space>bn", ":bnext<cr>")
vim.keymap.set("n", "<space>bp", ":bprev<cr>")
vim.keymap.set("n", "<space>o", ":lua vim.diagnostic.open_float(nil, { scope = 'line' })<cr>", { silent = true })

require("config.lazy")
