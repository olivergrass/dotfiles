return {
    {
        "folke/tokyonight.nvim",
        lazy = true,
    },
    {
        "joshdick/onedark.vim",
        lazy = true,
    },
    {
        "lunarvim/darkplus.nvim",
        lazy = true,
    },
    {
        "savq/melange-nvim",
        lazy = true,
    },
    {
        "projekt0n/github-nvim-theme",
        lazy = true,
    },
    {
        "rebelot/kanagawa.nvim",
        lazy = true,
    },
    {
        "ilof2/posterpole.nvim",
        lazy = true,
    },
    {
        "nyoom-engineering/oxocarbon.nvim",
        lazy = true,
    },
    {
        "aktersnurra/no-clown-fiesta.nvim",
        lazy = true,
    },
    {
        "mcauley-penney/ice-cave.nvim",
        lazy = true,
    },
    {
        "rose-pine/neovim",
        name = "rose-pine",
        lazy = true,
    },
    {
        "catppuccin/nvim",
        as = "catppuccin",
        priority = 1000,
        config = function()
            require("catppuccin").setup({
                compile_path = vim.fn.stdpath("cache") .. "/catppuccin",
            })
            vim.cmd("colorscheme catppuccin")
        end,
    },
}
