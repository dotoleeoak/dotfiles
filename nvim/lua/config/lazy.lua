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
                local lsp = require("lspconfig")
                local capabilities = require("cmp_nvim_lsp").default_capabilities()

                lsp.pyright.setup({ capabilities = capabilities })
                lsp.starpls.setup({ capabilities = capabilities })
                lsp.terraformls.setup({ capabilities = capabilities })
                lsp.jsonls.setup({ capabiliities = capabilities })
                lsp.jsonnet_ls.setup({ capabilities = capabilities })
                lsp.rust_analyzer.setup({ capabilities = capabilities })
                lsp.bazelrc_lsp.setup({ capabilities = capabilities })
                lsp.gopls.setup({ capabilities = capabilities })
            end,
        },
        {
            "nvim-treesitter/nvim-treesitter",
            config = function()
                ensure_installed = { "bash", "c", "lua", "markdown", "python", "yaml", "jsonnet" }
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
                    go = { "gofmt" },
                    python = { "yapf" },
                    rust = { "rustfmt" },
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
                            "--lint=fix",
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
        {
            -- code search
            "MagicDuck/grug-far.nvim",
            config = function()
                require("grug-far").setup({
                    -- options, see Configuration section below
                    -- there are no required options atm
                    -- engine = 'ripgrep' is default, but 'astgrep' can be specified
                })
            end,
            keys = {
                { "<leader>gf", "<cmd>GrugFar<cr>" },
            },
        },
        {
            -- folding
            "kevinhwang91/nvim-ufo",
            dependencies = { "kevinhwang91/promise-async" },
            opts = {
                provider_selector = function(bufnr, filetype, buftype)
                    return { "treesitter", "indent" }
                end,
            },
        },
        -- {
        --     -- indent highlight
        --     "lukas-reineke/indent-blankline.nvim",
        --     main = "ibl",
        --     config = function()
        --         local highlight = {
        --             "RainbowRed",
        --             "RainbowYellow",
        --             "RainbowBlue",
        --             "RainbowOrange",
        --             "RainbowGreen",
        --             "RainbowViolet",
        --             "RainbowCyan",
        --         }
        --
        --         local hooks = require("ibl.hooks")
        --         -- create the highlight groups in the highlight setup hook, so they are reset
        --         -- every time the colorscheme changes
        --         hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
        --             vim.api.nvim_set_hl(0, "RainbowRed", { fg = "#7e616b" })
        --             vim.api.nvim_set_hl(0, "RainbowYellow", { fg = "#807d6d" })
        --             vim.api.nvim_set_hl(0, "RainbowBlue", { fg = "#547894" })
        --             vim.api.nvim_set_hl(0, "RainbowOrange", { fg = "#797166" })
        --             vim.api.nvim_set_hl(0, "RainbowGreen", { fg = "#5c716a" })
        --             vim.api.nvim_set_hl(0, "RainbowViolet", { fg = "#65627e" })
        --             vim.api.nvim_set_hl(0, "RainbowCyan", { fg = "#4f6e78" })
        --         end)
        --
        --         require("ibl").setup({ indent = { highlight = highlight } })
        --     end,
        -- },
    },

    -- Configure any other settings here. See the documentation for more details.
    -- colorscheme that will be used when installing plugins.
    -- install = { colorscheme = { "habamax" } },
    -- automatically check for plugin updates
    checker = { enabled = true },
})
