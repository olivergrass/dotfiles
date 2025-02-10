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
                ---@diagnostic disable-next-line: redundant-parameter
                return hover({
                    border = "rounded",
                    max_height = math.floor(vim.o.lines * 0.5),
                    max_width = math.floor(vim.o.columns * 0.4),
                })
            end

            local signature = vim.lsp.buf.signature_help
            vim.lsp.buf.signature_help = function()
                ---@diagnostic disable-next-line: redundant-parameter
                return signature({
                    border = "rounded",
                    max_height = math.floor(vim.o.lines * 0.5),
                    max_width = math.floor(vim.o.columns * 0.4),
                })
            end

            -- vim.diagnostic.config({ virtual_lines = { current_line = true } })

            -- Show diagnostic info on cursor hover
            vim.cmd([[ autocmd CursorMoved * lua vim.diagnostic.open_float(nil, {focusable = false}) ]])

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

            vim.api.nvim_create_user_command("LspCapabilities", function()
                local curBuf = vim.api.nvim_get_current_buf()
                local clients = vim.lsp.get_clients({ bufnr = curBuf })

                for _, client in pairs(clients) do
                    if client.name ~= "null-ls" then
                        local capAsList = {}
                        for key, value in pairs(client.server_capabilities) do
                            if value and key:find("Provider") then
                                local capability = key
                                table.insert(capAsList, "- " .. capability)
                            end
                        end
                        table.sort(capAsList) -- sorts alphabetically
                        local msg = "# " .. client.name .. "\n" .. table.concat(capAsList, "\n")
                        vim.notify(msg, "trace", {
                            on_open = function(win)
                                local buf = vim.api.nvim_win_get_buf(win)
                                vim.api.nvim_buf_set_option(buf, "filetype", "markdown")
                            end,
                            timeout = 14000,
                        })
                        vim.fn.setreg("+", "Capabilities = " .. vim.inspect(client.server_capabilities))
                    end
                end
            end, {})

            vim.api.nvim_create_autocmd("LspAttach", {
                callback = function(args)
                    local bufnr = args.buf
                    local client = vim.lsp.get_client_by_id(args.data.client_id)
                    if client.config.name == "ruff" then
                        client.handlers["textDocument/publishDiagnostics"] = function(...)
                            local result = select(2, ...)
                            result.diagnostics = {}
                        end
                        client.server_capabilities.hoverProvider = false
                        client.server_capabilities.completionProvider = false
                        client.server_capabilities.definitionProvider = false
                        client.server_capabilities.renameProvider = false
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
                        client.server_capabilities.definitionProvider = false
                        client.server_capabilities.declarationProvider = false
                        client.server_capabilities.referencesProvider = false
                        client.server_capabilities.renameProvider = false
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
