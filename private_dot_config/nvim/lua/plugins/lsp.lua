return {
    {
        "saghen/blink.cmp",
        lazy = false, -- lazy loading handled internally
        dependencies = "rafamadriz/friendly-snippets",

        -- use a release tag to download pre-built binaries
        version = "v0.*",

        opts = {
            keymap = {
                ["<C-space>"] = { "show", "show_documentation", "hide_documentation" },
                ["<C-e>"] = { "hide" },

                ["<Tab>"] = {
                    function(cmp)
                        if cmp.is_in_snippet() then
                            return cmp.accept()
                        else
                            return cmp.select_and_accept()
                        end
                    end,
                    "snippet_forward",
                    "fallback",
                },
                ["<S-Tab>"] = { "snippet_backward", "fallback" },

                ["<Up>"] = { "select_prev", "fallback" },
                ["<Down>"] = { "select_next", "fallback" },
                ["<C-p>"] = { "select_prev", "fallback" },
                ["<C-n>"] = { "select_next", "fallback" },

                ["<C-b>"] = { "scroll_documentation_up", "fallback" },
                ["<C-f>"] = { "scroll_documentation_down", "fallback" },
            },
            highlight = {
                use_nvim_cmp_as_default = true,
            },
            -- set to 'mono' for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
            nerd_font_variant = "normal",

            -- experimental auto-brackets support
            -- accept = { auto_brackets = { enabled = true } },

            -- experimental signature help support
            -- trigger = { signature_help = { enabled = true } }
        },
    },
    {
        "neovim/nvim-lspconfig",
        event = { "BufReadPost", "BufWritePost", "BufNewFile" },
        dependencies = {
            "williamboman/mason.nvim",
            "williamboman/mason-lspconfig.nvim",
        },
        config = function()
            require("mason-lspconfig").setup_handlers({
                function(server_name)
                    require("lspconfig")[server_name].setup({})
                end,
            })

            require("lspconfig")["lua_ls"].setup({
                settings = {
                    Lua = {
                        diagnostics = {
                            globals = {
                                "vim",
                                "bit",
                            },
                        },
                    },
                },
            })

            vim.api.nvim_create_autocmd("LspAttach", {
                callback = function(args)
                    local bufnr = args.buf
                    local client = vim.lsp.get_client_by_id(args.data.client_id)
                    if client.config.name == "ruff" then
                        client.handlers["textDocument/publishDiagnostics"] = false
                        client.server_capabilities.hoverProvider = false
                    end
                    if client.config.name == "basedpyright" then
                        client.server_capabilities.hoverProvider = false
                    end
                    if client.config.name == "jedi_language_server" then
                        client.server_capabilities.completionProvider = false
                    end
                end,
            })

        end,
    },
    {
        "williamboman/mason.nvim",
        cmd = "Mason",
        build = function()
            pcall(vim.cmd, "MasonUpdate")
        end,
        opts = {},
        dependencies = {
            "stevearc/dressing.nvim"
        },
        config = function(_, opts)
            require("mason").setup(opts)
        end,
    },

    {
        "williamboman/mason-lspconfig.nvim",
        event = { "BufReadPost", "BufNewFile" },
        dependencies = {
            "nvim-lspconfig",
            "williamboman/mason.nvim",
        },
        config = function()
            require("mason-lspconfig").setup()
        end,
    },
}
