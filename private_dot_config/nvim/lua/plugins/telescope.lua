return {
    -- Multi-file search/replace
    {
        "nvim-pack/nvim-spectre",
        enabled = false,
        keys = {
            { "<leader>fs", function() require("spectre").open() end, desc = "Replace in files (Spectre)" },
        },
    },
    {
        "MagicDuck/grug-far.nvim",
        opts = {},
        keys = {
            { "<leader>fr", function() require("grug-far").open({ transient = true }) end, desc = "Replace in files (Grug)" },
        },
    },

    -- Telescope
    {
        "nvim-telescope/telescope.nvim",
        cmd = "Telescope",
        version = false, -- Telescope did only one release, so use HEAD for now
        dependencies = {
            "nvim-lua/plenary.nvim",
            -- "ahmedkhalf/project.nvim",
            -- config = function()
            --     require("user.config.projects")
            -- end,
            {
                "nvim-telescope/telescope-fzf-native.nvim",
                build = "make",
            }
        },
        config = function()
            require("telescope").setup({
                pickers = {
                    colorscheme = {
                        enable_preview = true,
                    },
                },
            })
            require("telescope").load_extension("fzf")
        end,
    },
}
