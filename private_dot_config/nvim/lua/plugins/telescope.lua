return {
    -- Multi-file search/replace
    {
        "nvim-pack/nvim-spectre",
        -- stylua: ignore
        keys = {
            { "<leader>ss", function() require("spectre").open() end, desc = "Replace in files (Spectre)" },
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
        },
        config = function()
            require("telescope").setup({
                pickers = {
                    colorscheme = {
                        enable_preview = true,
                    },
                },
            })
        end,
    },
}
