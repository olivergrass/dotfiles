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

local function winbar()
    -- Get the path and expand variables.
    local path = vim.fs.normalize(vim.fn.expand("%:p") --[[@as string]])

    -- Replace slashes by arrows.
    local separator = " %#@text# "

    local prefix, prefix_path = "", ""

    -- If the window gets too narrow, shorten the path and drop the prefix.
    if vim.api.nvim_win_get_width(0) < math.floor(vim.o.columns / 3) then
        path = vim.fn.pathshorten(path)
    else
        -- For some special folders, add a prefix instead of the full path (making
        -- sure to pick the longest prefix).
        ---@type table<string, string>
        local special_dirs = {
            PROJECTS = vim.g.projects_dir,
            DOTFILES = vim.fn.stdpath("config") --[[@as string]],
            HOME = vim.env.HOME,
            -- PERSONAL = vim.g.personal_projects_dir,
        }
        for dir_name, dir_path in pairs(special_dirs) do
            if vim.startswith(path, vim.fs.normalize(dir_path)) and #dir_path > #prefix_path then
                prefix, prefix_path = dir_name, dir_path
            end
        end
        if prefix ~= "" then
            path = path:gsub("^" .. prefix_path, "")
            prefix = string.format("%%#@keyword#%s %s%s", icons.ui.Folder, prefix, separator)
        end
    end

    -- Remove leading slash.
    path = path:gsub("^/", "")

    return table.concat({
        " ",
        prefix,
        table.concat(vim.split(path, "/"), separator),
    })
end

lualine.setup({
    options = {
        icons_enabled = true,
        theme = "auto",
        component_separators = { left = "", right = "" },
        section_separators = {
            left = icons.ui.CircleHalfRight,
            right = icons.ui.CircleHalfLeft,
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
                color = { gui = "bold" },
                padding = { left = 1, right = 0 },
            },
        },
        lualine_b = {
            { "branch" },
            { "diff" },
        },
        lualine_c = {
            -- {
            --     "filetype",
            --     icon_only = true,
            --     padding = { left = 1, right = 0 },
            -- },
            -- {
            --     "filename",
            --     padding = { left = 0, right = 1 },
            -- },
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
    winbar = {
        lualine_c = {
            { winbar },
        },
    },
    inactive_winbar = {},
    extensions = { "toggleterm" },
})
