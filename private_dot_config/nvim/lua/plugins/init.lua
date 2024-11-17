return {
    {
        "stevearc/profile.nvim"
    },
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
            bigfile = {
                ---@class snacks.bigfile.Config
                {
                    notify = true, -- show notification when big file detected
                    size = 1.5 * 1024 * 1024, -- 1.5MB
                    -- Enable or disable features when big file detected
                    ---@param ctx {buf: number, ft:string}
                    setup = function(ctx)
                        vim.b.minianimate_disable = true
                        vim.b.miniindentscope_disable = true
                        vim.opt.foldmethod = "manual"
                        vim.schedule(function()
                            vim.bo[ctx.buf].syntax = ctx.ft
                            vim.opt.foldmethod = "expr"
                        end)
                    end,
                },
            },
            notifier = { enabled = true },
            quickfile = { enabled = true },
            statuscolumn = { enabled = false },
            words = { enabled = true },
        },
        keys = {
            -- stylua: ignore start
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
