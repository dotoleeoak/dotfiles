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
                local capabilities = require("cmp_nvim_lsp").default_capabilities()
                require("lspconfig").pyright.setup({ capabilities = capabilities })
                require("lspconfig").starpls.setup({ capabilities = capabilities })
                -- require("lspconfig").bzl.setup({ capabilities = capabilities })
                require("lspconfig").terraformls.setup({
                    capabilities = capabilities,
                    filetypes = { "terraform", "terraform-vars", "tf" },
                })
                require("lspconfig").jsonls.setup({ capabilities = capabilities })
                require("lspconfig").jsonnet_ls.setup({ capabilities = capabilities })
            end,
        },
        { "nvim-treesitter/nvim-treesitter" },
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
        { "preservim/nerdtree" },
        -- { "junegunn/fzf" },
        -- { "junegunn/fzf.vim" },
        { "google/vim-jsonnet" },
        {
            -- fuzzy finder
            "nvim-telescope/telescope.nvim",
            tag = "0.1.8",
            dependencies = { "nvim-lua/plenary.nvim" },
            keys = {
                { "<leader>ff", "<cmd>Telescope find_files hidden=true<cr>" },
                { "<leader>fg", "<cmd>Telescope live_grep<cr>" },
                { "<leader>fb", "<cmd>Telescope buffers<cr>" },
                { "<leader>fh", "<cmd>Telescope help_tags<cr>" },
            },
        },
        {
            "nvim-telescope/telescope-fzf-native.nvim",
            build = "make",
        },
        {
            -- Git integration
            "tpope/vim-fugitive",
        },
        {
            -- git blame
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
                    jsonnet = { "jsonnetfmt" },
                    sh = { "shfmt" },
                    tf = { "terraform_fmt" },
                    terraform = { "terraform_fmt" },
                    yaml = { "yamlfmt" },
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
                    buildifier = {
                        args = {
                            "-path",
                            "$FILENAME",
                        },
                    },
                },
            },
        },
        {
            -- autocompletion
            "hrsh7th/nvim-cmp",
            dependencies = {
                "hrsh7th/cmp-nvim-lsp",
                "hrsh7th/cmp-path",
                "hrsh7th/cmp-buffer",
            },
            config = function()
                require("plugin.nvim-cmp")
            end,
        },
        {
            -- linter
            "mfussenegger/nvim-lint",
            config = function()
                require("lint").linters_by_ft = {
                    bzl = { "buildifier" },
                    sh = { "shellcheck" },
                }
            end,
        },
    },

    -- Configure any other settings here. See the documentation for more details.
    -- colorscheme that will be used when installing plugins.
    -- install = { colorscheme = { "habamax" } },
    -- automatically check for plugin updates
    checker = { enabled = true },
})
