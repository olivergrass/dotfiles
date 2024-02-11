local Log = require('utils.log')

local status_ok, nvimtree = pcall(require, 'nvim-tree')
if not status_ok then
    Log:error('Failed to load nvim-tree')
    return
end

-- disable netrw at the very start of your init.lua (strongly advised)
vim.g.loaded = 1
vim.g.loaded_netrwPlugin = 1

nvimtree.setup{}

