vim.g.catppuccin_flavour = 'mocha' -- latte, frappe, macchiato, mocha
local status_ok, catppuccin = pcall(require, 'catppuccin')
if not status_ok then
    vim.api.nvim_command('colorscheme o-wick')
    return
end

catppuccin.setup {
    transparent_background = false,
    term_colors = false,
    dim_inactive = {
        enabled = false,
        shade = "dark",
        percentage = 0.15,
    },
    styles = {
        comments = { "italic" },
        conditionals = { "italic" },
        loops = {},
        functions = {},
        keywords = {},
        strings = {},
        variables = {},
        numbers = {},
        booleans = {},
        properties = {},
        types = {},
        operators = {},
    },
    integrations = {
        bufferline = true,
        cmp = true,
        gitsigns = true,
        lualine = true,
        mason = true,
        nvimtree = true,
        notify = true,
        telescope = true,
        treesitter = true,
        which_key = true,
        -- For more plugins integrations please scroll down (https://github.com/catppuccin/nvim#integrations)
    },
    color_overrides = {},
    custom_highlights = {

    },
}

vim.api.nvim_command('colorscheme catppuccin')

