return {
    {
        "karb94/neoscroll.nvim",
        keys = { "<C-u>", "<C-d>", "<C-b>", "<C-f>", "<C-y>", "<C-e>", "z" },
        config = function()
            require("user.config.neoscroll")
        end,
    },
    {
        "otavioschwanck/arrow.nvim",
        keys = { ";", "m" },
        dependencies = {
            { "echasnovski/mini.icons" },
        },
        opts = {
            show_icons = true,
            leader_key = ";",
            buffer_leader_key = "m",
        },
    },
    ---@class snacks.Config
    {
        "folke/snacks.nvim",
        priority = 1000,
        lazy = false,
        ---@type snacks.Config
        opts = {
            bigfile = { enabled = true },
            input = { enabled = true },
            notifier = { enabled = true },
            quickfile = { enabled = true },
            statuscolumn = { enabled = false },
            words = { enabled = true },
            dashboard = { enabled = false },
        },
        keys = {
            -- stylua: ignore start
            { "<leader>.", function() Snacks.scratch() end, desc = "Scratch" },
            { "<leader>un", function() Snacks.notifier.hide() end, desc = "Dismiss All Notifications" },
            { "<leader>bd", function() Snacks.bufdelete() end, desc = "Delete Buffer" },
            { "<leader>gg", function() Snacks.lazygit() end, desc = "Lazygit" },
            { "<leader>gb", function() Snacks.git.blame_line() end, desc = "Git Blame Line" },
            { "<leader>gB", function() Snacks.gitbrowse() end, desc = "Git Browse" },
            { "<c-/>", function() Snacks.terminal(nil, {}) end, desc = "Toggle Terminal", mode = { "n", "t" } },
            { "<c-_>", function() Snacks.terminal(nil, {}) end, desc = "which_key_ignore", mode = { "n", "t" } },
            { "]]", function() Snacks.words.jump(vim.v.count1) end, desc = "Next Reference" },
            { "[[", function() Snacks.words.jump(-vim.v.count1) end, desc = "Prev Reference" },
            -- stylua: ignore end
        },
        init = function()
            vim.api.nvim_create_autocmd("User", {
                pattern = "MiniFilesActionRename",
                callback = function(event)
                    Snacks.rename.on_rename_file(event.data.from, event.data.to)
                end,
            })
            vim.api.nvim_create_autocmd("User", {
                pattern = "VeryLazy",
                callback = function()
                    -- Setup some globals for debugging (lazy-loaded)
                    _G.dd = function(...)
                        Snacks.debug.inspect(...)
                    end
                    _G.bt = function()
                        Snacks.debug.backtrace()
                    end
                    vim.print = _G.dd -- Override print to use snacks for `:=` command

                    -- Create some toggle mappings
                    Snacks.toggle.option("spell", { name = "Spelling" }):map("<leader>us")
                    Snacks.toggle.option("wrap", { name = "Wrap" }):map("<leader>uw")
                    Snacks.toggle.option("relativenumber", { name = "Relative Number" }):map("<leader>uL")
                    Snacks.toggle.diagnostics():map("<leader>ud")
                    Snacks.toggle.line_number():map("<leader>ul")
                    Snacks.toggle
                        .option("conceallevel", { off = 0, on = vim.o.conceallevel > 0 and vim.o.conceallevel or 2 })
                        :map("<leader>uc")
                    Snacks.toggle.treesitter():map("<leader>uT")
                    Snacks.toggle
                        .option("background", { off = "light", on = "dark", name = "Dark Background" })
                        :map("<leader>ub")
                    Snacks.toggle.inlay_hints():map("<leader>uh")
                end,
            })
        end,
    },
    {
        "folke/flash.nvim",
        opts = {
            jump = {
                autojump = false,
            },
        },
        keys = {
            -- stylua: ignore start
            { "<CR>", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
            { "S", mode = { "n", "x", "o" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
            { "r", mode = "o", function() require("flash").remote() end, desc = "Remote Flash" },
            { "R", mode = { "o", "x" }, function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
            { "<c-s>", mode = { "c" }, function() require("flash").toggle() end, desc = "Toggle Flash Search" },
            -- stylua: ignore end
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
        "rmagatti/goto-preview",
        -- event = "BufEnter",
        opts = {
            focus_on_open = false,
        },
        keys = {
            {
                "gpd",
                "<cmd>lua require('goto-preview').goto_preview_definition()<CR>",
                noremap = true,
                desc = "goto preview definition",
            },
            {
                "gpD",
                "<cmd>lua require('goto-preview').goto_preview_declaration()<CR>",
                noremap = true,
                desc = "goto preview declaration",
            },
            {
                "gpi",
                "<cmd>lua require('goto-preview').goto_preview_implementation()<CR>",
                noremap = true,
                desc = "goto preview implementation",
            },
            {
                "gpy",
                "<cmd>lua require('goto-preview').goto_preview_type_definition()<CR>",
                noremap = true,
                desc = "goto preview type definition",
            },
            {
                "gpr",
                "<cmd>lua require('goto-preview').goto_preview_references()<CR>",
                noremap = true,
                desc = "goto preview references",
            },
            {
                "gP",
                "<cmd>lua require('goto-preview').close_all_win()<CR>",
                noremap = true,
                desc = "close all preview windows",
            },
        },
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
        "github/copilot.vim",
        cmd = "Copilot",
        lazy = true,
        build = "Copilot auth",
        config = function()
            vim.g.copilot_filetypes = {
                ["*"] = false,
            }
        end,
    },
    {
        "olimorris/codecompanion.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-treesitter/nvim-treesitter",
            "github/copilot.vim",
        },
        cmd = { "CodeCompanion", "CodeCompanionChat", "CodeCompanionActions", "CodeCompanionCmd" },
        opts = {
            strategies = {
                chat = {
                    ["file"] = {
                        callback = "strategies.chat.slash_commands.file",
                        description = "Select a file using Telescope",
                        opts = {
                            provider = "telescope", -- Other options include 'default', 'mini_pick', 'fzf_lua', snacks
                            contains_code = true,
                        },
                    },
                    adapter = "copilot",
                },
                inline = {
                    adapter = "copilot",
                },
                agent = {
                    adapter = "copilot",
                },
            },
        },
        config = function(opts)
            -- Expand 'cc' into 'CodeCompanion' in the command line
            vim.cmd([[cab cc CodeCompanion]])

            require("codecompanion").setup(opts)
        end,
    },
    {
        "OXY2DEV/markview.nvim",
        ft = { "markdown", "codecompanion" },
        opts = {
            preview = {
                filetypes = { "markdown", "codecompanion" },
                ignore_buftypes = {},
            },
        },
    },
    {
        "akinsho/toggleterm.nvim",
        enabled = false,
        cmd = "ToggleTerm",
        keys = { "C-\\" },
        config = function()
            require("user.config.toggleterm")
        end,
    },

    -- Language Specific
    {
        "simrat39/rust-tools.nvim",
        ft = "rust",
    },
}
