return {
    {
        "neovim/nvim-lspconfig",
        event = { "BufReadPre", "BufNewFile" },
        dependencies = {
            "hrsh7th/nvim-cmp",
            "hrsh7th/cmp-nvim-lsp",
            "williamboman/mason.nvim",
            "williamboman/mason-lspconfig.nvim",
        },
        config = function()
            local capabilities = require("cmp_nvim_lsp").default_capabilities()

            require("mason-lspconfig").setup_handlers {
                function(server_name)
                    require("lspconfig")[server_name].setup {
                        capabilities = capabilities,
                    }
                end,
            }

            require("lspconfig")["lua_ls"].setup({
                capabilities = capabilities,
                settings = {
                    Lua = {
                        diagnostics = {
                            globals = { "vim" },
                        }
                    }
                }
            })

            require("lspconfig")["hls"].setup({
                capabilities = capabilities,
                settings = {
                    haskell = {
                        plugin = {
                            rename = {
                                config = {
                                    crossModule = true
                                }
                            }
                        }
                    }
                }
            })
        end,
    },

    {
        "williamboman/mason.nvim",
        build = function()
            pcall(vim.cmd, "MasonUpdate")
        end,
        config = function()
            require("mason").setup()
        end,
    },

    {
        "williamboman/mason-lspconfig.nvim",
        dependencies = { "nvim-lspconfig" },
        config = function()
            require("mason-lspconfig").setup()
        end,
    },

    {
        "https://git.sr.ht/~whynothugo/lsp_lines.nvim",
        enabled = false,
        config = function()
            require("lsp_lines").setup()
        end,
        dependencies = { "nvim-lspconfig" },
    },

    {
        "https://github.com/github/copilot.vim",
        config = function()
            vim.g.copilot_assume_mapped = true
        end,
    },
}
