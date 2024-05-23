return {
    { "kyazdani42/nvim-web-devicons" },
    { "stevearc/dressing.nvim" },
    { "xiyaowong/nvim-transparent" },
    {
        "folke/noice.nvim",
        config = function()
            require("noice").setup({
                lsp = {
                    -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
                    override = {
                        ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
                        ["vim.lsp.util.stylize_markdown"] = true,
                        ["cmp.entry.get_documentation"] = true,
                    },
                },
                -- you can enable a preset for easier configuration
                presets = {
                    bottom_search = true, -- use a classic bottom cmdline for search
                    command_palette = true, -- position the cmdline and popupmenu together
                    long_message_to_split = true, -- long messages will be sent to a split
                    inc_rename = false, -- enables an input dialog for inc-rename.nvim
                    lsp_doc_border = false, -- add a border to hover docs and signature help
                },
            })
        end,
        dependencies = {
            "muniftanjim/nui.nvim",
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
