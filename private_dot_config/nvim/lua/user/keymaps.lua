-- Enable buffer switching
vim.keymap.set('n', 'L', ':bn<CR>', { noremap = true })
vim.keymap.set('n', 'H', ':bN<CR>', { noremap = true })
vim.keymap.set('n', '<TAB>', ':bn<CR>', { noremap = true })
vim.keymap.set('n', '<S-TAB>', ':bN<CR>', { noremap = true })

-- Move code blocks
vim.keymap.set("v", "<A-k>", ":m '<-2<CR>gv=gv", { noremap = true })
vim.keymap.set("v", "<A-j>", ":m '>+1<CR>gv=gv", { noremap = true })
vim.keymap.set("n", "<A-k>", ":m .-2<cr>==", { noremap = true })
vim.keymap.set("n", "<A-j>", ":m .+1<cr>==", { noremap = true })

-- Better indenting
vim.keymap.set("v", "<", "<gv", { noremap = true, silent = true })
vim.keymap.set("v", ">", ">gv", { noremap = true, silent = true })

-- Stop pressing ESC
vim.keymap.set('i', 'jk', '<ESC>', { noremap = true })
vim.keymap.set('i', 'kj', '<ESC>', { noremap = true })

-- Move around in insert mode
vim.keymap.set('i', '<C-h>', '<Left>', { noremap = true })
vim.keymap.set('i', '<C-j>', '<Down>', { noremap = true })
vim.keymap.set('i', '<C-k>', '<Up>', { noremap = true })
vim.keymap.set('i', '<C-l>', '<Right>', { noremap = true })

