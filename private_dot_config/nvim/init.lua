-- Have to set mapleader before loading lazy
vim.g.mapleader = " "

-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

-- Install your plugins here
require("lazy").setup({
    spec = { { import = "plugins" } },
    install = { colorscheme = { "catppuccin", "habamax" } },
})

local modules = {
    -- "user.disabled",
    "user.options",
    "user.keymaps",
    "user.colorscheme",
}

for _, mod in ipairs(modules) do
    local ok, err = pcall(require, mod)
    if not ok then
        error(("Error loading %s...\n\n%s"):format(mod, err))
    end
end

vim.cmd("autocmd BufNewFile,BufRead *.bend setfiletype python")
