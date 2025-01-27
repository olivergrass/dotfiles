return {
    {
        "stevearc/dressing.nvim",
        lazy = true,
        opts = {},
    },
    {
        "folke/noice.nvim",
        enabled = false,
        event = "VeryLazy",
        opts = {
            lsp = {
                -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
                override = {
                    ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
                    ["vim.lsp.util.stylize_markdown"] = true,
                    ["cmp.entry.get_documentation"] = true,
                },
                hover = { enabled = true },
                progress = { enabled = false },
                signature = {
                    auto_open = {
                        enabled = false,
                    },
                },
            },
            -- you can disable the plugin for some filetypes
            -- routes = {
            --     { filter = { find = "E162" }, view = "mini" },
            --     { filter = { event = "msg_show", kind = "", find = "written" }, view = "mini" },
            --     { filter = { event = "msg_show", find = "search hit BOTTOM" }, skip = true },
            --     { filter = { event = "msg_show", find = "search hit TOP" }, skip = true },
            --     { filter = { event = "notify", find = "Config Change Detected" }, skip = true },
            --     { filter = { event = "emsg", find = "E23" }, skip = true },
            --     { filter = { event = "emsg", find = "E20" }, skip = true },
            --     { filter = { find = "No signature help" }, skip = true },
            --     { filter = { find = "E37" }, skip = true },
            -- },
            -- views = {
            --     mini = { win_options = { winblend = 0 } },
            -- },
            -- you can enable a preset for easier configuration
            presets = {
                bottom_search = true, -- use a classic bottom cmdline for search
                command_palette = true, -- position the cmdline and popupmenu together
                long_message_to_split = true, -- long messages will be sent to a split
                inc_rename = false, -- enables an input dialog for inc-rename.nvim
                lsp_doc_border = true, -- add a border to hover docs and signature help
            },
        },
        config = function(_, opts)
            if vim.o.filetype == "lazy" then
                vim.cmd([[messages clear]])
            end
            require("noice").setup(opts)
        end,
        dependencies = {
            "muniftanjim/nui.nvim",
            -- "echasnovski/mini.notify",
            -- "rcarriga/nvim-notify",
        },
    },
    {
        "muniftanjim/nui.nvim",
        lazy = true,
    },
    {
        "norcalli/nvim-colorizer.lua",
        cmd = "ColorizerToggle",
        config = function()
            require("colorizer").setup()
        end,
    },
    {
        "rcarriga/nvim-notify",
        enabled = false,
        config = function()
            vim.notify = require("notify")
        end,
    },
    {
        "akinsho/bufferline.nvim",
        enabled = false,
        config = function()
            require("user.config.bufferline")
        end,
    },
    {
        "nvim-lualine/lualine.nvim",
        enabled = true,
        event = { "VeryLazy" },
        config = function()
            require("user.config.lualine")
        end,
        dependencies = {
            {
                "linrongbin16/lsp-progress.nvim",
                opts = {
                    client_format = function(client_name, spinner, series_messages)
                        return #series_messages > 0
                                and (spinner .. " " .. client_name .. " " .. table.concat(series_messages, ", "))
                            or nil
                    end,
                    format = function(client_messages)
                        if #client_messages > 0 then
                            return table.concat(client_messages, " ")
                        end
                        return ""
                    end,
                },
            },
            -- "folke/noice.nvim",
        },
    },
    {
        "christopher-francisco/tmux-status.nvim",
        lazy = true,
        opts = {},
    },
    {
        "goolord/alpha-nvim",
        enabled = true,
        event = { "VimEnter" },
        config = function()
            require("user.config.alpha")
        end,
    },
}
