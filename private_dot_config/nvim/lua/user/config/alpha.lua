local alpha = require("alpha")
local banners = require("tables.banners")
local icons = require("tables.icons")

local date_gen = assert(io.popen('echo "$(date +%a) $(date +%d) $(date +%b)" | tr -d "\n"'))
local date = date_gen:read("*a")
date_gen:close()

local function banner_height(banner)
    return vim.tbl_count(banner)
end

local function window_height()
    return vim.fn.winheight(0)
end

-- Calculate total height of UI elements excluding banner
local function non_banner_height()
    local button_height = 6*2 -- since each button has spacing too
    local date_height = 1
    local plugin_height = 1
    local padding_height = 2*2 -- we pad twice
    return button_height + date_height + plugin_height + padding_height
end

-- Create a single button
local function button(sc, txt, keybind)
    local opts = {
        position = "center",
        text = txt,
        shortcut = sc,
        cursor = 0,
        width = 44,
        align_shortcut = "right",
        hl_shortcut = "AlphaShortcut",
        hl = "AlphaButton",
    }

    if keybind then
        opts.keymap = { "n", sc, keybind, { noremap = true, silent = true } }
    end

    return {
        type = "button",
        val = txt,
        on_press = function()
            local key = vim.api.nvim_replace_termcodes(sc, true, false, true)
            vim.api.nvim_feedkeys(key, "normal", false)
        end,
        opts = opts,
    }
end

-- Get banner to display in header
local function get_fitting_banner()
    local max_banner_height = window_height() - non_banner_height()

    local fitting_banners = {}
    for _, banner in pairs(banners) do
        if banner_height(banner) <= max_banner_height then
            table.insert(fitting_banners, banner)
        end
    end

    if #fitting_banners > 0 then
        return fitting_banners[math.random(#fitting_banners)]
    else
        return banners["neobold"]
    end
end
local banner = get_fitting_banner()

local heading = {
    type = "text",
    val = banner,
    opts = {
        position = "center",
        hl = "AlphaHeader",
    },
}

local date_section = {
    type = "text",
    val = function()
        return "┌─ " .. icons.ui.Calendar .. "  Today is " .. date .. " ─┐"
    end,
    opts = {
        position = "center",
        hl = "Type",
    }
}

local stats = require("lazy").stats()

local plugin_section = {
    type = "text",
    val = function()
        return "└─ " .. icons.ui.Package .. "  " .. stats.count .. " plugins in total ─┘"
    end,
    opts = {
        position = "center",
        hl = "Type",
    },
}

local buttons = {
    type = "group",
    val = {
        button("e", icons.ui.NewFile  .. "  > New file",  ":ene | startinsert<CR>"),
        button("f", icons.ui.FindFile .. "  > Find file", ":cd $HOME | Telescope find_files<CR>"),
        button("r", icons.ui.History  .. "  > Recent",    ":Telescope oldfiles<CR>"),
        button("p", icons.ui.Projects .. "  > Projects",  ":Telescope projects<CR>"),
        button("s", icons.ui.Gear     .. "  > Settings",  ":cd $HOME/.config/nvim | Telescope find_files<CR>"),
        button("q", icons.ui.SignOut  .. "  > Quit NVIM", ":qa<CR>"),
    },
    opts = {
        spacing = 1,
    },
}

-- Dynamic padding
local header_padding = vim.fn.max { 2, vim.fn.floor(vim.fn.winheight(0) / 2) - banner_height(banner) - 2}
local dynamic_padding = 2

alpha.setup {
    layout = {
        { type = "padding", val = header_padding },
        heading,
        { type = "padding", val = dynamic_padding },
        date_section,
        plugin_section,
        { type = "padding", val = dynamic_padding },
        buttons,
    },
    opts = { margin = 10 },
}

