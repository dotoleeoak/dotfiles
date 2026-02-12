-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.uv.fs_stat(lazypath) then
    local lazyrepo = "https://github.com/folke/lazy.nvim.git"
    local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
end
vim.opt.rtp:prepend(lazypath)

-- Setup lazy.nvim
require("lazy").setup({
    defaults = {
        version = "*",
    },
    ui = {
        border = "rounded",
    },
    spec = {
        {
            -- colorscheme
            "projekt0n/github-nvim-theme",
            lazy = false,
            config = function()
                require("github-theme").setup({
                    options = {
                        transparent = true,
                    },
                })
                vim.cmd("colorscheme github_dark_default")
            end,
        },
        {
            -- LSP
            "neovim/nvim-lspconfig",
            config = function()
                vim.lsp.config("*", {
                    capabilities = require("cmp_nvim_lsp").default_capabilities(),
                })

                vim.lsp.config("ccls", {
                    init_options = {
                        cache = {
                            directory = "/tmp/ccls-cache",
                        },
                        clang = {
                            extraArgs = {
                                "-isystem/Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/c++/v1",
                            },
                        },
                    },
                })

                vim.lsp.enable("bashls")
                vim.lsp.enable("bazelrc_lsp")
                vim.lsp.enable("ccls")
                vim.lsp.enable("cmake")
                vim.lsp.enable("eslint")
                vim.lsp.enable("gopls")
                vim.lsp.enable("graphql")
                vim.lsp.enable("jsonls")
                vim.lsp.enable("jsonnet_ls")
                vim.lsp.enable("nixd")
                vim.lsp.enable("prismals")
                vim.lsp.enable("pyright")
                vim.lsp.enable("rust_analyzer")
                vim.lsp.enable("starpls")
                vim.lsp.enable("terraformls")
                vim.lsp.enable("ts_ls")
                vim.lsp.enable("yamlls")
            end,
        },
        {
            -- Prisma LSP
            "prisma/vim-prisma",
        },
        {
            "nvim-treesitter/nvim-treesitter",
            build = ":TSUpdate",
            event = { "BufReadPost", "BufNewFile" },
            config = function()
                require("nvim-treesitter.configs").setup({
                    ensure_installed = {
                        "bash",
                        "c",
                        "java",
                        "jsonc",
                        "jsonnet",
                        "lua",
                        "markdown",
                        "python",
                        "terraform",
                        "tsx",
                        "typescript",
                        "yaml",
                    },
                    highlight = {
                        enable = true,
                    },
                    indent = {
                        enable = true,
                    },
                })
            end,
        },
        {
            -- statusline
            "nvim-lualine/lualine.nvim",
            opts = {
                options = {
                    icons_enabled = false,
                    theme = "auto",
                },
                sections = {
                    lualine_a = { "mode" },
                    lualine_b = { { "filename", path = 1 } },
                    lualine_c = { "diagnostics" },
                },
            },
        },
        {
            -- highlight TODO comments
            "folke/todo-comments.nvim",
            dependencies = { "nvim-lua/plenary.nvim" },
            opts = {
                signs = false,
                highlight = {
                    multiline = true,
                },
            },
        },
        {
            -- fuzzy finder
            "ibhagwan/fzf-lua",
            opts = {},
            keys = {
                { "<leader>ff", "<cmd>FzfLua files<cr>", desc = "Find files" },
                { "<leader>fg", "<cmd>FzfLua live_grep<cr>", desc = "Live Grep" },
                { "<leader>fb", "<cmd>FzfLua buffers<cr>", desc = "Find buffers" },
                { "<leader>fr", "<cmd>FzfLua resume<cr>", desc = "Resume previous fzf" },
            },
        },
        {
            -- Git integration
            "tpope/vim-fugitive",
            dependencies = {
                "tpope/vim-rhubarb",
            },
            config = function()
                -- Netrw is disabled for oil.nvim, so define a custom Browse command
                vim.api.nvim_create_user_command("Browse", function(opts)
                    vim.fn.system({ "open", opts.args })
                end, { nargs = 1 })
            end,
        },
        {
            -- git blame
            "lewis6991/gitsigns.nvim",
            event = { "BufReadPre", "BufNewFile" },
            opts = {
                current_line_blame = true,
            },
            keys = {
                { "<leader>hs", "<cmd>Gitsigns stage_hunk<cr>" },
                { "<leader>hr", "<cmd>Gitsigns reset_hunk<cr>" },
                { "<leader>hp", "<cmd>Gitsigns preview_hunk<cr>" },
                { "<leader>hS", "<cmd>Gitsigns stage_buffer<cr>" },
                { "<leader>hR", "<cmd>Gitsigns reset_buffer<cr>" },
                { "<leader>hb", "<cmd>Gitsigns blame_line<cr>" },
            },
        },
        {
            -- formatter
            "stevearc/conform.nvim",
            opts = function()
                return {
                    formatters_by_ft = {
                        bzl = { "buildifier" },
                        cmake = { "cmake_format" },
                        cpp = { "clang-format" },
                        go = { "gofmt" },
                        javascript = { "prettier" },
                        javascriptreact = { "prettier" },
                        jsonnet = { "jsonnetfmt" },
                        lua = { "stylua" },
                        nix = { "nixfmt" },
                        python = { "yapf" },
                        rust = { "rustfmt" },
                        sh = { "shfmt" },
                        terraform = { "terraform_fmt" },
                        tf = { "terraform_fmt" },
                        typescript = { "prettier" },
                        typescriptreact = { "prettier" },
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
                        prisma = {
                            command = "pnpm",
                            args = {
                                "prisma",
                                "format",
                            },
                        },
                        prettier = {
                            cwd = require("conform.util").root_file({
                                ".editorconfig",
                                ".prettierrc",
                                ".prettierrc.json",
                                ".prettierrc.js",
                                "prettier.config.js",
                                "package.json",
                            }),
                        },
                    },
                }
            end,
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
            -- file explorer
            "stevearc/oil.nvim",
            opts = {
                default_file_explorer = true,
                view_options = {
                    show_hidden = true,
                },
            },
            keys = {
                { "-", "<cmd>Oil<cr>" },
            },
            dependencies = {
                "benomahony/oil-git.nvim",
            }
        },
        {
            -- lazygit integration
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
            -- autopairs
            "windwp/nvim-autopairs",
            opts = {},
        },
        {
            -- surrounding pairs
            "kylechui/nvim-surround",
            event = "VeryLazy",
            opts = {},
        },
        {
            -- easy navigation
            "smoka7/hop.nvim",
            opts = {},
            keys = {
                { "<leader>hw", "<cmd>HopWord<cr>" },
                { "<leader>hc", "<cmd>HopChar1<cr>" },
            },
        },
        -- {
        --     "yetone/avante.nvim",
        --     event = "VeryLazy",
        --     lazy = false,
        --     build = "make BUILD_FROM_SOURCE=true",
        --     opts = {
        --         provider = "claude",
        --         -- auto_suggestions_provider = "claude",
        --         behaviour = {
        --             -- auto_suggestions = true,
        --             -- support_paste_from_clipboard = true,
        --         },
        --     },
        --     dependencies = {
        --         "stevearc/dressing.nvim",
        --         "nvim-lua/plenary.nvim",
        --         "MunifTanjim/nui.nvim",
        --     },
        -- },
        { "github/copilot.vim" },
        {
            -- color highlighter
            "norcalli/nvim-colorizer.lua",
            opts = {
                "*", -- Highlight all files
            },
        },
        {
            -- git diff viewer
            "sindrets/diffview.nvim",
        },
        {
            "folke/which-key.nvim",
            event = "VeryLazy",
            opts = {
                -- your configuration comes here
                -- or leave it empty to use the default settings
                -- refer to the configuration section below
            },
            keys = {
                {
                    "<leader>?",
                    function()
                        require("which-key").show({ global = false })
                    end,
                    desc = "Buffer Local Keymaps (which-key)",
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
