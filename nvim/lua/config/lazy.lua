-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.uv.fs_stat(lazypath) then
    local lazyrepo = "https://github.com/folke/lazy.nvim.git"
    local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
end
vim.opt.rtp:prepend(lazypath)

-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Setup lazy.nvim
require("lazy").setup({
    spec = {
        {
            -- colorscheme
            "projekt0n/github-nvim-theme",
            lazy = false,
            config = function()
                vim.cmd("colorscheme github_dark")
            end,
        },
        {
            -- LSP
            "neovim/nvim-lspconfig",
            config = function()
                require("lspconfig").pyright.setup({})
                require("lspconfig").starpls.setup({})
                require("lspconfig").bzl.setup({})
                require("lspconfig").terraformls.setup({})
            end,
        },
        {
            -- status bar
            "itchyny/lightline.vim",
            config = function()
                vim.g.lightline = { colorscheme = "wombat" }
                vim.opt.laststatus = 2
                vim.opt.showmode = false
            end,
        },
        {
            -- terminal
            "akinsho/toggleterm.nvim",
            version = "*",
            config = true,
        },
        { "numToStr/Comment.nvim" },
        { "jiangmiao/auto-pairs" },
        { "junegunn/fzf" },
        { "junegunn/fzf.vim" },
        {
            -- git integration
            "lewis6991/gitsigns.nvim",
            opts = {
                current_line_blame = true,
            },
        },
        {
            -- formatter
            "stevearc/conform.nvim",
            opts = {
                formatters_by_ft = {
                    lua = { "stylua" },
                    bzl = { "buildifier" },
                    python = { "yapf" },
                },
                format_on_save = {
                    lsp_format = "fallback",
                },
                formatters = {
                    stylua = {
                        args = {
                            "--search-parent-directories",
                            "--indent-type",
                            "Spaces",
                            "--stdin-filepath",
                            "$FILENAME",
                            "-",
                        },
                    },
                },
            },
        },
    },
    -- Configure any other settings here. See the documentation for more details.
    -- colorscheme that will be used when installing plugins.
    -- install = { colorscheme = { "habamax" } },
    -- automatically check for plugin updates
    checker = { enabled = true },
})
