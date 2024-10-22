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
                require("lspconfig").terraformls.setup({
                    capabilities = capabilities,
                    filetypes = { "terraform", "terraform-vars", "tf" },
                })
                require("lspconfig").jsonls.setup({ capabiliities = capabilities })
                require("lspconfig").jsonnet_ls.setup({ capabilities = capabilities })
                require("lspconfig").bazelrc_lsp.setup({ capabilities = capabilities })
            end,
        },
        {
            "nvim-treesitter/nvim-treesitter",
            config = function()
                ensure_installed = { "bash", "c", "lua", "markdown", "python", "yaml" }
            end,
        },
        {
            "nvim-lualine/lualine.nvim",
            opts = {
                options = {
                    icons_enabled = false,
                    theme = "auto",
                },
                sections = {
                    lualine_a = { "mode" },
                    lualine_b = { "branch" },
                    lualine_c = { { "filename", path = 1 } },
                    -- lualine_c = {
                    --     {
                    --         "buffers",
                    --         show_filename_only = false,
                    --         show_modified_status = true,
                    --     },
                    -- },
                },
            },
        },
        {
            -- terminal
            "akinsho/toggleterm.nvim",
            version = "*",
            config = true,
            keys = {
                { "<leader>tt", "<cmd>ToggleTerm<cr>" },
            },
        },
        { "numToStr/Comment.nvim" },
        { "jiangmiao/auto-pairs" },
        { "preservim/nerdtree" },
        { "google/vim-jsonnet" },
        {
            "folke/todo-comments.nvim",
            opts = {
                signs = false,
                highlight = {
                    multiline = true,
                },
            },
        },
        {
            -- fuzzy finder
            "nvim-telescope/telescope.nvim",
            tag = "0.1.8",
            dependencies = {
                "nvim-lua/plenary.nvim",
                "nvim-telescope/telescope-live-grep-args.nvim",
                {
                    "nvim-telescope/telescope-fzf-native.nvim",
                    build = "make",
                },
            },
            opts = function(_, opts)
                -- Enable searching hidden files in live_grep
                local telescopeConfig = require("telescope.config")
                local vimgrep_arguments = { unpack(telescopeConfig.values.vimgrep_arguments) }
                table.insert(vimgrep_arguments, "--hidden")
                table.insert(vimgrep_arguments, "--glob")
                table.insert(vimgrep_arguments, "!**/.git/*")
                opts.defaults = {
                    vimgrep_arguments = vimgrep_arguments,
                }

                -- Enable searching hidden files in find_files
                opts.pickers = {
                    find_files = {
                        hidden = true,
                        find_command = { "rg", "--files", "--hidden", "--glob", "!**/.git/*" },
                    },
                    -- live_grep = {
                    --     mappings = {
                    --         i = {
                    --             ["<c-f>"] = custom_pickers.actions.set_extension,
                    --             ["<c-l>"] = custom_pickers.actions.set_folders,
                    --         },
                    --     },
                    -- },
                }
            end,
            keys = {
                { "<leader>ff", "<cmd>Telescope find_files<cr>" },
                -- { "<leader>ff", "<cmd>Telescope live_grep<cr>" },
                { "<leader>fg", ":lua require('telescope').extensions.live_grep_args.live_grep_args()<cr>" },
                { "<leader>fb", "<cmd>Telescope buffers<cr>" },
                { "<leader>fh", "<cmd>Telescope help_tags<cr>" },
            },
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
                    yaml = { "prettier" },
                    ["*"] = { "trim_newlines", "trim_whitespace" },
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
                    prettier = {},
                },
            },
        },
        {
            -- autocompletion
            "hrsh7th/nvim-cmp",
            dependencies = {
                "hrsh7th/cmp-nvim-lsp",
                "hrsh7th/cmp-nvim-lsp-signature-help",
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
        {
            "nvim-tree/nvim-tree.lua",
            opts = {
                renderer = {
                    indent_markers = {
                        icons = {
                            corner = ">",
                            edge = "|",
                            item = "|",
                            bottom = "-",
                        },
                    },
                    icons = {
                        glyphs = {
                            folder = {
                                arrow_closed = "▸",
                                arrow_open = "▾",
                                default = "",
                                open = "",
                                empty = "",
                                empty_open = "",
                                symlink = "",
                                symlink_open = "",
                            },
                        },
                        show = {
                            file = false,
                            folder = false,
                            folder_arrow = true,
                            git = true,
                        },
                    },
                },
            },
            keys = {
                { "<leader>s", "<cmd>NvimTreeToggle<cr>" },
            },
        },
        {
            "kdheepak/lazygit.nvim",
            cmd = {
                "LazyGit",
                "LazyGitConfig",
                "LazyGitCurrentFile",
                "LazyGitFilter",
                "LazyGitFilterCurrentFile",
            },
            dependencies = {
                "nvim-lua/plenary.nvim",
            },
            keys = {
                { "<leader>lg", "<cmd>LazyGit<cr>", desc = "LazyGit" },
            },
        },
    },

    -- Configure any other settings here. See the documentation for more details.
    -- colorscheme that will be used when installing plugins.
    -- install = { colorscheme = { "habamax" } },
    -- automatically check for plugin updates
    checker = { enabled = true },
})
