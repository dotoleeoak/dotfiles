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
            version = "*",
            config = function()
                vim.cmd("colorscheme github_dark")
            end,
        },
        {
            -- LSP
            "neovim/nvim-lspconfig",
            version = "*",
            config = function()
                local lsp = require("lspconfig")
                local capabilities = require("cmp_nvim_lsp").default_capabilities()

                lsp.bashls.setup({ capabilities = capabilities })
                lsp.bazelrc_lsp.setup({ capabilities = capabilities })
                lsp.gopls.setup({ capabilities = capabilities })
                lsp.jsonls.setup({ capabilities = capabilities })
                lsp.jsonnet_ls.setup({ capabilities = capabilities })
                lsp.pyright.setup({ capabilities = capabilities })
                lsp.rust_analyzer.setup({ capabilities = capabilities })
                lsp.starpls.setup({ capabilities = capabilities })
                lsp.terraformls.setup({ capabilities = capabilities })
                lsp.ccls.setup({
                    capabilities = capabilities,
                    init_options = {
                        cache = {
                            directory = "/tmp/ccls-cache",
                        },
                    },
                })
            end,
            -- keys = {
            --     { "<leader>e", "<cmd>lua vim.diagnostic.open_float(0, {scope='line'})<cr>" },
            -- },
        },
        {
            "nvim-treesitter/nvim-treesitter",
            version = "*",
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
                    lualine_b = { { "filename", path = 1 } },
                    lualine_c = {},
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
            version = "*",
            dependencies = {
                "nvim-lua/plenary.nvim",
                "nvim-telescope/telescope-live-grep-args.nvim",
                {
                    "nvim-telescope/telescope-fzf-native.nvim",
                    build = "make",
                    version = "*",
                    config = function()
                        require("telescope").load_extension("fzf")
                    end,
                },
                {
                    "nvim-telescope/telescope-frecency.nvim",
                    version = "*",
                    config = function()
                        require("telescope").load_extension("frecency")
                    end,
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
                    path_display = { "truncate" },
                }

                -- Enable searching hidden files in find_files
                opts.pickers = {
                    find_files = {
                        hidden = true,
                        find_command = { "rg", "--files", "--hidden", "--glob", "!**/.git/*" },
                    },
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
            version = "*",
            opts = {
                formatters_by_ft = {
                    lua = { "stylua" },
                    bzl = { "buildifier" },
                    go = { "gofmt" },
                    python = { "yapf" },
                    cpp = { "clang-format" },
                    rust = { "rustfmt" },
                    jsonnet = { "jsonnetfmt" },
                    -- sh = { "shfmt" },
                    tf = { "terraform_fmt" },
                    terraform = { "terraform_fmt" },
                    -- yaml = { "prettier" },
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
            "stevearc/oil.nvim",
            version = "*",
            opts = {
                view_options = {
                    show_hidden = true,
                },
            },
            keys = {
                { "-", "<cmd>Oil<cr>" },
            },
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
            opts = {
                openTargetWindow = {
                    preferredLocation = "right",
                },
            },
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
        {
            "ErichDonGubler/lsp_lines.nvim",
        },
        {
            "wakatime/vim-wakatime",
        },
        {
            -- surrounding pairs
            "kylechui/nvim-surround",
            version = "*",
            event = "VeryLazy",
            opts = {},
        },
        {
            -- easy navigation
            "smoka7/hop.nvim",
            version = "*",
            opts = {},
            keys = {
                { "<leader>hw", "<cmd>HopWord<cr>" },
                { "<leader>hc", "<cmd>HopChar1<cr>" },
            },
        },
        {
            "yetone/avante.nvim",
            event = "VeryLazy",
            lazy = false,
            version = "*",
            build = "make BUILD_FROM_SOURCE=true",
            opts = {
                provider = "claude",
                -- auto_suggestions_provider = "claude",
                behaviour = {
                    -- auto_suggestions = true,
                    -- support_paste_from_clipboard = true,
                },
            },
            dependencies = {
                "stevearc/dressing.nvim",
                "nvim-lua/plenary.nvim",
                "MunifTanjim/nui.nvim",
            },
        },
        { "github/copilot.vim" },
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
