return {
    {
        "echasnovski/mini.indentscope",
        version = "*",
        event = { "BufReadPre", "BufNewFile" },
        opts = {
            symbol = "│",
            options = { try_as_border = true },
        },
        init = function()
            vim.api.nvim_create_autocmd("FileType", {
                pattern = { "help", "alpha", "dashboard", "neo-tree", "nvim-tree", "Trouble", "lazy", "mason" },
                callback = function()
                    vim.b.miniindentscope_disable = true
                end,
            })
        end,
        config = function(_, opts)
            require("mini.indentscope").setup(opts)
        end,
    },
    {
        "echasnovski/mini.files",
        version = "*",
        event = "VeryLazy",
        config = function(_, opts)
            require("mini.files").setup(opts)
        end,
        keys = {
            { "<leader>e", function() MiniFiles.open(vim.api.nvim_buf_get_name(0)) end, desc = "File tree" },
        }
    },
    {
        "echasnovski/mini.icons",
        opts = {},
        lazy = true,
        specs = {
            { "nvim-tree/nvim-web-devicons", enabled = false, optional = true },
        },
        init = function()
            package.preload["nvim-web-devicons"] = function()
                require("mini.icons").mock_nvim_web_devicons()
                return package.loaded["nvim-web-devicons"]
            end
        end,
    },
    {
        "echasnovski/mini.comment",
        event = "VeryLazy",
        version = "*",
        opts = {
            mappings = {
                comment = "gc", -- takes a motion
                comment_line = "gcc",
                comment_visual = "gc",
                textobject = "gc", -- allow comment to work as textobject
            },
        },
        config = function(_, opts)
            require("mini.comment").setup(opts)
        end,
    },
    {
        "echasnovski/mini.surround",
        event = "VeryLazy",
        version = "*",
        config = function(_, opts)
            require("mini.surround").setup(opts)
        end,
    },
    {
        "echasnovski/mini.pairs",
        event = "VeryLazy",
        version = "*",
        config = function(_, opts)
            require("mini.pairs").setup(opts)
        end,
    },
}
