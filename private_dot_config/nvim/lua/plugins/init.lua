return {
    {
        "karb94/neoscroll.nvim",
        config = function()
            require("user.config.neoscroll")
        end,
    },
    {
        "otavioschwanck/arrow.nvim",
        keys = { ";" },
        opts = {
            show_icons = true,
            leader_key = ';' -- Recommended to be a single key
        }
    },
    {
      "folke/flash.nvim",
      event = "VeryLazy",
      opts = {
          jump = {
              autojump = false,
          },
      },
      keys = {
        { "<CR>", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
        { "S", mode = { "n", "x", "o" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
        { "r", mode = "o", function() require("flash").remote() end, desc = "Remote Flash" },
        { "R", mode = { "o", "x" }, function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
        { "<c-s>", mode = { "c" }, function() require("flash").toggle() end, desc = "Toggle Flash Search" },
      },
    },

    -- Tools
    {
        "lewis6991/gitsigns.nvim",
        enabled = false,
        config = function()
            require("user.config.gitsigns")
        end,
    },
    {
        "famiu/bufdelete.nvim",
    },
    {
        "folke/which-key.nvim",
        event = "VeryLazy",
        enabled = false,
        opts_extend = { "spec" },
        opts = {
            default = {},
            spec = {
                {
                    mode = { "n", "v" },
                    { "<leader>g", "Git" },
                    { "<leader>l", "LSP" },
                    { "<leader>s", "Search" },
                    { "<leader>t", "Terminal" },
                },
            },
        },
        config = function(_, opts)
            local wk = require("which-key")
            wk.setup(opts)
        end,
    },
    {
        "akinsho/toggleterm.nvim",
        config = function()
            require("user.config.toggleterm")
        end,
    },

    -- Language Specific
    { "simrat39/rust-tools.nvim" },
}
