vim.g.mapleader = ' '
vim.g.clipboard = {
    name = "xsel",
    copy = {
        ["+"] = "xsel -i -b",
        ["*"] = "xsel -i -p"
    },
    paste = {
        ["+"] = "xsel -b",
        ["*"] = "xsel -p"
    },
}

vim.opt.iskeyword:append('-') -- Treat dash-separated words as one word
vim.cmd("autocmd BufEnter * set formatoptions-=cro") -- Stop automatic newline continuation of comments
vim.cmd("autocmd BufEnter * setlocal formatoptions-=cro")

local options = {
    mouse = "a", -- Enable mouse
    clipboard = "unnamedplus", -- Access system clipboard
    hlsearch = true, -- Highlight search
    ignorecase = true, -- Ignore case in search
    showmode = false, -- We don't need to see -- INSERT --
    showtabline = 2, -- Always show tabline
    termguicolors = true, -- Show accurate colors
    smartcase = true, -- Smart case
    smartindent = true, -- Smart indent
    hidden = true, -- Enable multiple buffers
    splitbelow = true, -- Force splitting below
    splitright = true, --Force splitting right
    number = true, -- Show line numbers
    wrap = false, -- Don't wrap text
    scrolloff = 8, -- Keep at least 8 lines above and below cursor
    sidescrolloff = 8, -- -//-
    ruler = false, -- Tabline does this
    expandtab = true, -- Convert tabs to spaces
    shiftwidth = 4, -- Number of spaces for each indentation
    tabstop = 4, -- Insert 4 spaces for a tab
    signcolumn = 'yes', -- always show sign column, otherwise it would shift text
    timeoutlen = 300, -- Time to wait for a mapped sequence to complete
    updatetime = 100, -- Faster completion
    undodir = vim.fn.stdpath('cache') .. '/undo', -- Set an undo directory
    undofile = true, -- Enable persistent undo
    writebackup = false, -- Don't clash between programs
    cursorline = true, -- Highlight the current line
    fileencoding = 'utf-8',
    fileformats = 'unix,dos',
    cmdheight = 0, -- Experimental
}

for k, v in pairs(options) do
    vim.opt[k] = v
end
