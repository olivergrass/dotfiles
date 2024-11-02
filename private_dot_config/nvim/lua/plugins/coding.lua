return {
    {
        "Wansmer/treesj",
        dependencies = { "nvim-treesitter/nvim-treesitter" },
        keys = {
            { "<S-j>", "<cmd>TSJToggle<cr>", desc = "Join Toggle" },
        },
        opts = { use_default_keymaps = false, max_join_length = 150 },
    },
    {
        "andrewferrier/debugprint.nvim",
        opts = {},
        keys = {
            { "g?", mode = "n" },
            { "g?", mode = "x" },
        },
        cmd = {
            "ToggleCommentDebugPrints",
            "DeleteDebugPrints",
        },
    },
    {
        "stevearc/conform.nvim",
        event = { "BufWritePre" },
        cmd = { "ConformInfo" },
        keys = {
            {
                "<leader>bf",
                function()
                    require("conform").format({ async = true })
                end,
                mode = "",
                desc = "Format buffer",
            },
        },
        -- type hinting with LuaLS
        ---@module "conform"
        opts = {
            formatters_by_ft = {
                lua = { "stylua" },
                -- Conform will run multiple formatters sequentially
                python = { "isort", "black" },
                -- You can customize some of the format options for the filetype (:help conform.format)
                rust = { "rustfmt", lsp_format = "fallback" },
                -- Conform will run the first available formatter
                javascript = { "prettierd", "prettier", stop_after_first = true },
            },
            default_format_opts = {
                lsp_format = "fallback",
            },
        },
    },
    {
        "zapling/mason-conform.nvim",
        event = { "BufReadPost", "BufNewFile" },
        dependencies = {
            "williamboman/mason.nvim",
            "stevearc/conform.nvim",
        },
        opts = {},
    },
}
