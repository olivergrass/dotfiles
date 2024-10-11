return {
    { "folke/tokyonight.nvim" },
    { "joshdick/onedark.vim" },
    { "lunarvim/darkplus.nvim" },
    { "savq/melange-nvim" },
    { "projekt0n/github-nvim-theme" },
    { "rebelot/kanagawa.nvim" },
    { "ilof2/posterpole.nvim" },
    {
        "catppuccin/nvim",
        as = "catppuccin",
        priority = 1000,
        config = function()
            vim.cmd("colorscheme catppuccin")
        end,
    },
}
