return {
    { "stevearc/dressing.nvim" },
    { "xiyaowong/nvim-transparent" },
    {
        "folke/noice.nvim",
        enabled = true,
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
            },
            -- you can disable the plugin for some filetypes
            routes = {
                { filter = { find = "E162" }, view = "mini" },
                { filter = { event = "msg_show", kind = "", find = "written" }, view = "mini" },
                { filter = { event = "msg_show", find = "search hit BOTTOM" }, skip = true },
                { filter = { event = "msg_show", find = "search hit TOP" }, skip = true },
                { filter = { event = "emsg", find = "E23" }, skip = true },
                { filter = { event = "emsg", find = "E20" }, skip = true },
                { filter = { find = "No signature help" }, skip = true },
                { filter = { find = "E37" }, skip = true },
            },
            views = {
                mini = { win_options = { winblend = 100 } },
            },
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
            "echasnovski/mini.notify",
            "rcarriga/nvim-notify",
        },
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
        enabled = true,
        config = function()
            vim.notify = require("notify")
        end,
    },
    {
        "akinsho/bufferline.nvim",
        config = function()
            require("user.config.bufferline")
        end,
    },
    {
        "nvim-lualine/lualine.nvim",
        config = function()
            require("user.config.lualine")
        end,
        dependencies = {
            "folke/noice.nvim",
        },
    },
    {
        "goolord/alpha-nvim",
        config = function()
            require("user.config.alpha")
        end,
    },
}
