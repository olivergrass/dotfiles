local alpha = require("alpha")
local banners = require("tables.banners")
local icons = require("tables.icons")

local date_gen = assert(io.popen('echo "$(date +%a) $(date +%d) $(date +%b)" | tr -d "\n"'))
local date = date_gen:read("*a")
date_gen:close()

-- Don"t display tall elements in a short window
local function is_win_tall()
    return vim.fn.winheight(0) > 30
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
local function randomBanner()
    local keys = {}
    for k, _ in pairs(banners) do
        table.insert(keys, k)
    end

    if is_win_tall() then
        return banners[keys[math.random(#keys)]]
    else
        return banners["neobold"]
    end
end
local banner = randomBanner()

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
        if is_win_tall() then
            return "┌─ " .. icons.ui.Calendar .. "  Today is " .. date .. " ─┐"
        else
            return " "
        end
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
        if is_win_tall() then
            return "└─ " .. icons.ui.Package .. "  " .. stats.count .. " plugins in total ─┘"
        else
            return " "
        end
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
local headerPadding = vim.fn.max { 2, vim.fn.floor(vim.fn.winheight(0) / 2) - vim.tbl_count(banner) - 2}
local dynamic_padding = (is_win_tall() and 2 or 0)

alpha.setup {
    layout = {
        { type = "padding", val = headerPadding },
        heading,
        { type = "padding", val = dynamic_padding },
        date_section,
        plugin_section,
        { type = "padding", val = dynamic_padding },
        buttons,
    },
    opts = { margin = 10 },
}

