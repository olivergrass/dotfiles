return {
    {
        "echasnovski/mini.indentscope",
        version = "*",
        event = { "CursorMoved" },
        opts = {
            draw = {
                delay = 50,
            },
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
    },
    {
        "echasnovski/mini.files",
        version = "*",
        lazy = false,
        opts = {},
        keys = {
            {
                "<leader>e",
                function()
                    require("mini.files").open(vim.api.nvim_buf_get_name(0))
                end,
                desc = "File tree",
            },
        },
    },
    {
        "echasnovski/mini.icons",
        lazy = true,
        opts = {},
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
        version = "*",
        event = { "BufReadPre", "BufNewFile" },
        enabled = false, -- Since this is now built-in
        opts = {
            mappings = {
                comment = "gc", -- takes a motion
                comment_line = "gcc",
                comment_visual = "gc",
                textobject = "gc", -- allow comment to work as textobject
            },
        },
    },
    {
        "echasnovski/mini.notify",
        enabled = false,
        lazy = true,
        version = "*",
        opts = {
            lsp_progress = {
                enable = false,
            },
        },
        config = function(_, opts)
            local notify = require("mini.notify")
            notify.setup(opts)
            vim.notify = notify.make_notify({
                ERROR = { duration = 5000 },
                WARN = { duration = 4000 },
                INFO = { duration = 3000 },
            })
        end,
    },
    {
        "echasnovski/mini.bracketed",
        keys = { "[", "]" },
        version = "*",
        opts = {},
    },
    {
        "echasnovski/mini.clue",
        events = { "BufReadPre", "BufNewFile" },
        keys = { "<leader>", "<C-x>", "g", "'", "`", '"', "<C-r>", "<C-w>", "z" },
        version = "*",
        config = function(_, _)
            require("mini.clue").setup({
                triggers = {
                    -- Leader triggers
                    { mode = "n", keys = "<Leader>" },
                    { mode = "x", keys = "<Leader>" },

                    -- Built-in completion
                    { mode = "i", keys = "<C-x>" },

                    -- `g` key
                    { mode = "n", keys = "g" },
                    { mode = "x", keys = "g" },

                    -- Marks
                    { mode = "n", keys = "'" },
                    { mode = "n", keys = "`" },
                    { mode = "x", keys = "'" },
                    { mode = "x", keys = "`" },

                    -- Registers
                    { mode = "n", keys = '"' },
                    { mode = "x", keys = '"' },
                    { mode = "i", keys = "<C-r>" },
                    { mode = "c", keys = "<C-r>" },

                    -- Window commands
                    { mode = "n", keys = "<C-w>" },

                    -- `z` key
                    { mode = "n", keys = "z" },
                    { mode = "x", keys = "z" },
                },
                clues = {
                    -- Enhance this by adding descriptions for <Leader> mapping groups
                    { mode = "n", keys = "<Leader>b", desc = " Buffer" },
                    { mode = "n", keys = "<Leader>g", desc = "󰊢 Git" },
                    { mode = "n", keys = "<Leader>l", desc = "󰘦 LSP" },
                    { mode = "n", keys = "<Leader>f", desc = " Find" },
                    { mode = "n", keys = "<Leader>t", desc = " Terminal" },
                    { mode = "n", keys = "<leader>s", desc = "󰆓 Sessions" },
                    { mode = "n", keys = "<leader>u", desc = "  Toggles" },
                    require("mini.clue").gen_clues.builtin_completion(),
                    require("mini.clue").gen_clues.g(),
                    require("mini.clue").gen_clues.marks(),
                    require("mini.clue").gen_clues.registers(),
                    require("mini.clue").gen_clues.windows(),
                    require("mini.clue").gen_clues.z(),
                },
                window = {
                    delay = 300,
                },
            })
        end,
    },
    {
        "echasnovski/mini.animate",
        event = { "BufReadPost", "BufNewFile" },
        version = "*",
        opts = {
            cursor = { enable = false },
            scroll = { enable = false },
        },
    },
    {
        "echasnovski/mini.diff",
        event = { "BufReadPost", "BufNewFile" },
        version = "*",
        opts = {
            view = {
                style = "number",
            },
        },
    },
    {
        "olivergrass/mini.pick",
        enabled = true,
        lazy = true,
        cmd = { "Pick" },
        version = "*",
        config = function(_, _)
            local win_config = function()
                local height = math.floor(0.618 * vim.o.lines)
                local width = math.floor(0.618 * vim.o.columns)
                return {
                    anchor = "NW",
                    height = height,
                    width = width,
                    border = "rounded",
                    row = math.floor(0.5 * (vim.o.lines - height)),
                    col = math.floor(0.5 * (vim.o.columns - width)),
                }
            end
            require("mini.pick").setup({
                mappings = {
                    choose_in_vsplit = "<C-CR>",
                },
                options = {
                    use_cache = true,
                },
                window = {
                    config = win_config,
                },
            })
        end,
    },
    {
        "echasnovski/mini.ai",
        event = { "BufReadPre", "BufNewFile" },
        version = "*",
        opts = {},
    },
    {
        "echasnovski/mini.surround",
        event = { "BufReadPre", "BufNewFile" },
        version = "*",
        opts = {},
    },
    {
        "echasnovski/mini.sessions",
        lazy = true,
        version = "*",
        opts = {},
    },
    {
        "echasnovski/mini.move",
        keys = {
            { "<M-h>", mode = { "n", "v" } },
            { "<M-j>", mode = { "n", "v" } },
            { "<M-k>", mode = { "n", "v" } },
            { "<M-l>", mode = { "n", "v" } },
            { "<", mode = { "n", "v" } },
            { ">", mode = { "n", "v" } },
        },
        version = "*",
        opts = {},
    },
    {
        "echasnovski/mini.pairs",
        enabled = false,
        event = { "InsertEnter" },
        version = "*",
        opts = {},
    },
}
