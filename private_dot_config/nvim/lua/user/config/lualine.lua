local Log = require("utils.log")
local icons = require("tables.icons")

local status_ok, lualine = pcall(require, "lualine")
if not status_ok then
    Log:error("Failed to load lualine")
    return
end

local function trailing_whitespace()
    local space = vim.fn.search([[\s\+$]], "nwc")
    return space ~= 0 and "TW:" .. space or ""
end

local function mixed_indent()
    local space_pat = [[\v^ +]]
    local tab_pat = [[\v^\t+]]
    local space_indent = vim.fn.search(space_pat, "nwc")
    local tab_indent = vim.fn.search(tab_pat, "nwc")
    local mixed = (space_indent > 0 and tab_indent > 0)
    local mixed_same_line
    if not mixed then
        mixed_same_line = vim.fn.search([[\v^(\t+ | +\t)]], "nwc")
        mixed = mixed_same_line > 0
    end
    if not mixed then
        return ""
    end
    if mixed_same_line ~= nil and mixed_same_line > 0 then
        return "MI:" .. mixed_same_line
    end
    local space_indent_cnt = vim.fn.searchcount({ pattern = space_pat, max_count = 1e3 }).total
    local tab_indent_cnt = vim.fn.searchcount({ pattern = tab_pat, max_count = 1e3 }).total
    if space_indent_cnt > tab_indent_cnt then
        return "MI:" .. tab_indent
    else
        return "MI:" .. space_indent
    end
end

lualine.setup({
    options = {
        icons_enabled = true,
        theme = "auto",
        component_separators = { left = "", right = "" },
        section_separators = {
            -- left = icons.ui.UpperLeftTriangle .. " ",
            -- right = icons.ui.CircleHalfLeft,
        },
        disabled_filetypes = { "alpha" },
        ignore_focus = {},
        always_divide_middle = true,
        globalstatus = false,
        refresh = {
            statusline = 1000,
            tabline = 1000,
            winbar = 1000,
        },
    },
    sections = {
        lualine_a = {
            {
                "mode",
                icons_enabled = true,
                color = { gui = "bold" },
            },
        },
        lualine_b = {
            { "branch" },
            { "diff" },
        },
        lualine_c = {
            {
                "filetype",
                icon_only = true,
                padding = { left = 1, right = 0 },
            },
            {
                "filename",
                padding = { left = 0, right = 1 },
            },
        },
        lualine_x = {
            { "diagnostics" },
            { trailing_whitespace },
            { mixed_indent },
            { "location" },
            {
                -- "vim.fn.expand('%:p:h:t')",
                -- icon = icons.ui.Folder,
                -- padding = { left = 1, right = 1 },
            },
        },
        lualine_y = {},
        lualine_z = {},
    },
    inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = { "filename" },
        lualine_x = {},
        lualine_y = {},
        lualine_z = {},
    },
    tabline = {},
    winbar = {},
    inactive_winbar = {},
    extensions = { "toggleterm" },
})
