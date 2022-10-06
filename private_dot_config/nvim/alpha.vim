lua << EOF
local alpha = require('alpha')
local dashboard = require('alpha.themes.dashboard')

local plugins_gen = io.popen('cd $HOME/.local/share/nvim/plugged && ls | wc -l | tr -d "\n"')
local plugins = plugins_gen:read("*a")
plugins_gen:close()

local date_gen = io.popen('echo "$(date +%a) $(date +%d) $(date +%b)" | tr -d "\n"')
local date = date_gen:read("*a")
date_gen:close()

local plugin_count = {
    type = "text",
    val = "└─   " .. plugins .. " plugins in total ─┘",
    opts = {
        position = "center",
        hl = "Folded",
    }
}

local date = {
    type = "text",
    val = "┌─   Today is " .. date .. " ─┐",
    opts = {
        position = "center",
        hl = "Folded",
    }
}

-- dynamic header padding
local fn = vim.fn
local marginTopPercent = 0.25
local headerPadding = fn.max { 2, fn.floor(fn.winheight(0) * marginTopPercent) }

dashboard.section.buttons.val = {
    dashboard.button( "e", "  > New file" , ":ene <BAR> startinsert <CR>"),
    dashboard.button( "f", "  > Find file", ":cd $HOME | Telescope find_files<CR>"),
    dashboard.button( "r", "  > Recent"   , ":Telescope oldfiles<CR>"),
    dashboard.button( "p", "  > Projects" , ":Telescope projects<CR>"),
    dashboard.button( "s", "  > Settings" , ":cd $HOME/.config/nvim | Telescope find_files<CR>"),
    dashboard.button( "q", "  > Quit NVIM", ":qa<CR>"),
}

dashboard.section.date = date
dashboard.section.plugin_count = plugin_count

alpha.setup {
    layout = {
        {type = "padding", val = headerPadding},
        dashboard.section.header,
        {type = "padding", val = 2},
        dashboard.section.date,
        dashboard.section.plugin_count,
        {type = "padding", val = 3},
        dashboard.section.buttons,
    },
    opts = {},
}

-- Disable statusline in dashboard
vim.api.nvim_create_autocmd("FileType", {
  pattern = "alpha",
  callback = function()
    -- store current statusline value and use that
    local old_laststatus = vim.opt.laststatus
    vim.api.nvim_create_autocmd("BufUnload", {
      buffer = 0,
      callback = function()
        vim.opt.laststatus = old_laststatus
      end,
    })
    vim.opt.laststatus = 0
  end,
})
EOF

