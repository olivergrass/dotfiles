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

vim.opt.iskeyword:append("-") -- Treat dash-separated words as one word
vim.opt.fillchars = { eob = " " } -- Stop drawing tilde"s for blank lines
vim.cmd("autocmd BufEnter * set formatoptions-=cro") -- Stop automatic newline continuation of comments
vim.cmd("autocmd BufEnter * setlocal formatoptions-=cro")
vim.cmd("autocmd TermOpen * startinsert") -- Automatically start insert mode in terminal buffers

-- Enable switching between underline and inline diagnostics
vim.diagnostic.config({
    virtual_text = false,
    virtual_lines = false,
})

-- Open debug info on "hover"
vim.cmd([[ autocmd CursorHold * lua vim.diagnostic.open_float(nil, { focusable = false }) ]])

local options = {
    mouse = "a",                                  -- Enable mouse
    clipboard = "unnamedplus",                    -- Access system clipboard
    hlsearch = true,                              -- Highlight search
    ignorecase = true,                            -- Ignore case in search
    showmode = false,                             -- We don"t need to see -- INSERT --
    showtabline = 1,                              -- Show tabline when more than one exists
    termguicolors = true,                         -- Show accurate colors
    smartcase = true,                             -- Smart case
    smartindent = true,                           -- Smart indent
    hidden = true,                                -- Enable multiple buffers
    splitbelow = true,                            -- Force splitting below
    splitright = true,                            -- Force splitting right
    number = true,                                -- Show line numbers
    wrap = false,                                 -- Don"t wrap text
    scrolloff = 8,                                -- Keep at least 8 lines above and below cursor
    sidescrolloff = 8,                            -- Keep at least 8 chars to either side of cursor
    ruler = false,                                -- Tabline does this
    expandtab = true,                             -- Convert tabs to spaces
    shiftwidth = 4,                               -- Number of spaces for each indentation
    tabstop = 4,                                  -- Insert 4 spaces for a tab
    signcolumn = "number",                        -- Display signs with numbers
    timeoutlen = 300,                             -- Time to wait for a mapped sequence to complete
    updatetime = 100,                             -- Faster completion
    undodir = vim.fn.stdpath("cache") .. "/undo", -- Set an undo directory
    undofile = true,                              -- Enable persistent undo
    writebackup = false,                          -- Don"t clash between programs
    cursorline = true,                            -- Highlight the current line
    cmdheight = 0,                                -- Experimental: remove command section
    autochdir = false,                            -- Change directory to the file being edited
}

for k, v in pairs(options) do
    vim.opt[k] = v
end
