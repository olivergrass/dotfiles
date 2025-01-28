return {
    {
        "saghen/blink.cmp",
        event = { "InsertEnter", "CmdlineEnter" },
        dependencies = "rafamadriz/friendly-snippets",

        -- use a release tag to download pre-built binaries
        version = "v0.*",

        opts = {
            appearance = {
                use_nvim_cmp_as_default = false,
                nerd_font_variant = "mono",
            },

            completion = {
                accept = { auto_brackets = { enabled = true } },
                documentation = {
                    auto_show = true,
                    auto_show_delay_ms = 250,
                    treesitter_highlighting = true,
                },
                ghost_text = { enabled = false },
                menu = {
                    cmdline_position = function()
                        if vim.g.ui_cmdline_pos ~= nil then
                            local pos = vim.g.ui_cmdline_pos -- (1, 0)-indexed
                            return { pos[1] - 1, pos[2] }
                        end
                        local height = (vim.o.cmdheight == 0) and 1 or vim.o.cmdheight
                        return { vim.o.lines - height, 0 }
                    end,
                },
            },

            signature = { enabled = true },

            keymap = {
                ["<C-space>"] = { "show", "show_documentation", "hide_documentation" },
                ["<C-e>"] = { "hide", "fallback" },

                ["<Tab>"] = { "snippet_forward", "accept", "fallback" },
                ["<S-Tab>"] = { "snippet_backward", "fallback" },

                ["<Up>"] = { "select_prev", "fallback" },
                ["<Down>"] = { "select_next", "fallback" },
                ["<C-p>"] = { "select_prev", "fallback" },
                ["<C-n>"] = { "select_next", "fallback" },

                ["<C-b>"] = { "scroll_documentation_up", "fallback" },
                ["<C-f>"] = { "scroll_documentation_down", "fallback" },
            },
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
            require("lspconfig.ui.windows").default_options = { border = "rounded" }

            local hover = vim.lsp.buf.hover
            vim.lsp.buf.hover = function()
                return hover({
                    border = "rounded",
                    max_height = math.floor(vim.o.lines * 0.5),
                    max_width = math.floor(vim.o.columns * 0.4),
                })
            end

            local signature = vim.lsp.buf.signature_help
            vim.lsp.buf.signature_help = function()
                return signature({
                    border = "rounded",
                    max_height = math.floor(vim.o.lines * 0.5),
                    max_width = math.floor(vim.o.columns * 0.4),
                })
            end

            require("mason-lspconfig").setup_handlers({
                function(server_name)
                    require("lspconfig")[server_name].setup({})
                end,
                ["lua_ls"] = function()
                    require("lspconfig").lua_ls.setup({
                        settings = {
                            Lua = {
                                diagnostics = {
                                    globals = { "vim", "bit" },
                                },
                            },
                        },
                    })
                end,
            })

            vim.api.nvim_create_autocmd("LspAttach", {
                callback = function(args)
                    local bufnr = args.buf
                    local client = vim.lsp.get_client_by_id(args.data.client_id)
                    if client.config.name == "ruff" then
                        -- client.handlers["textDocument/publishDiagnostics"] = function(...)
                        --     local result = select(2, ...)
                        --     result.diagnostics = {}
                        -- end
                        client.server_capabilities.hoverProvider = false
                        client.server_capabilities.completionProvider = false
                    end
                    if client.config.name == "basedpyright" then
                        -- client.handlers["textDocument/publishDiagnostics"] = function(...)
                        --     local result = select(2, ...)
                        --     result.diagnostics = {}
                        -- end
                        client.server_capabilities.hoverProvider = false
                    end
                    if client.config.name == "jedi_language_server" then
                        client.handlers["textDocument/publishDiagnostics"] = function(...)
                            local result = select(2, ...)
                            result.diagnostics = {}
                        end
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
            "stevearc/dressing.nvim",
            "olivergrass/mini.pick",
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
