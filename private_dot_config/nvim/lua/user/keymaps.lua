
local map = vim.api.nvim_set_keymap

-- Enable buffer switching
map("n", "L", ":bn<CR>", { noremap = true, silent = true, desc = "Next Buffer" })
map("n", "H", ":bN<CR>", { noremap = true, silent = true, desc = "Prev Buffer" })
map("n", "<TAB>", ":bn<CR>", { noremap = true, silent = true, desc = "Next Buffer" })
map("n", "<S-TAB>", ":bN<CR>", { noremap = true, silent = true, desc = "Prev Buffer" })

-- Move Lines
map("n", "<A-j>", "<cmd>m .+1<cr>==", { silent = true, desc = "Move down" })
map("n", "<A-k>", "<cmd>m .-2<cr>==", { silent = true, desc = "Move up" })
map("i", "<A-j>", "<esc><cmd>m .+1<cr>==gi", { silent = true, desc = "Move down" })
map("i", "<A-k>", "<esc><cmd>m .-2<cr>==gi", { silent = true, desc = "Move up" })
map("v", "<A-j>", ":m '>+1<cr>gv=gv", { silent = true, desc = "Move down" })
map("v", "<A-k>", ":m '<-2<cr>gv=gv", { silent = true, desc = "Move up" })

-- Better indenting
map("v", "<", "<gv", { noremap = true, silent = true })
map("v", ">", ">gv", { noremap = true, silent = true })

-- Disable default behaviour to help surrouind
map("n", "s", "<NOP>", { noremap = true })

-- Stop pressing ESC
map("i", "jk", "<ESC>", { noremap = true })
map("i", "kj", "<ESC>", { noremap = true })

-- Move around in insert mode
map("i", "<C-h>", "<Left>", { noremap = true })
map("i", "<C-j>", "<Down>", { noremap = true })
map("i", "<C-k>", "<Up>", { noremap = true })
map("i", "<C-l>", "<Right>", { noremap = true })

-- General mappings
map("n", "<leader>a", "<cmd>Alpha<CR>", { desc = "Alpha" })
map("n", "<leader>b", "<cmd>Telescope buffers<CR>", { desc = "Buffers" })
map("n", "<leader>w", "<cmd>w!<CR>", { desc = "Save" })
map("n", "<leader>q", "<cmd>q!<CR>", { desc = "Quit" })
map("n", "<leader>c", "<cmd>Bdelete!<CR>", { desc = "Close Buffer" })
map("n", "<leader>h", "<cmd>nohlsearch<CR>", { desc = "No Highlight" })
map("n", "<leader>f", "<cmd>Telescope find_files<CR>", { desc = "Find files" })
map("n", "<leader>F", "<cmd>Telescope live_grep<CR>", { desc = "Find Text" })
map("n", "<leader>L", "<cmd>Lazy<CR>", { desc = "Lazy" })

-- Git mappings
-- map("n", "<leader>g", nil, { desc = "Git" })
-- map("n", "gg", function() _LAZYGIT_TOGGLE() end, { desc = "Lazygit" })
map("n", "<leader>gj", "<cmd>lua require 'gitsigns'.next_hunk()<CR>", { desc = "Next Hunk" })
map("n", "<leader>gk", "<cmd>lua require 'gitsigns'.prev_hunk()<CR>", { desc = "Prev Hunk" })
map("n", "<leader>gl", "<cmd>lua require 'gitsigns'.blame_line()<CR>", { desc = "Blame" })
map("n", "<leader>gp", "<cmd>lua require 'gitsigns'.preview_hunk()<CR>", { desc = "Preview Hunk" })
map("n", "<leader>gr", "<cmd>lua require 'gitsigns'.reset_hunk()<CR>", { desc = "Reset Hunk" })
map("n", "<leader>gR", "<cmd>lua require 'gitsigns'.reset_buffer()<CR>", { desc = "Reset Buffer" })
map("n", "<leader>gs", "<cmd>lua require 'gitsigns'.stage_hunk()<CR>", { desc = "Stage Hunk" })
map("n", "<leader>gu", "<cmd>lua require 'gitsigns'.undo_stage_hunk()<CR>", { desc = "Undo Stage Hunk" })
map("n", "<leader>go", "<cmd>Telescope git_status<CR>", { desc = "Open changed file" })
map("n", "<leader>gb", "<cmd>Telescope git_branches<CR>", { desc = "Checkout branch" })
map("n", "<leader>gc", "<cmd>Telescope git_commits<CR>", { desc = "Checkout commit" })
-- map("n", "gd", function() _GITDIFF_TOGGLE() end, { desc = "Diff Delta" })

-- LSP mappings
-- map("n", "<leader>l", nil, { desc = "LSP" })
map("n", "<leader>lf", "<cmd>lua vim.lsp.buf.format { async = true }<CR>", { desc = "Format" })
map("n", "<leader>li", "<cmd>lua vim.lsp.buf.implementation()<CR>", { desc = "Go To Implementation" })
map("n", "<leader>lj", "<cmd>lua vim.lsp.diagnostic.goto_next()<CR>", { desc = "Next Diagnostic" })
map("n", "<leader>lk", "<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>", { desc = "Prev Diagnostic" })
map("n", "<leader>ld", "<cmd>lua vim.lsp.buf.definition()<CR>", { desc = "Go To Definition" })
map("n", "<leader>lD", "<cmd>lua vim.lsp.buf.declaration()<CR>", { desc = "Go To Declaration" })
map("n", "<leader>lh", "<cmd>lua vim.lsp.buf.hover()<CR>", { desc = "Hover" })
map("n", "<leader>lr", "<cmd>lua vim.lsp.buf.rename()<CR>", { desc = "Rename" })
map("n", "<leader>ls", "<cmd>Telescope lsp_document_symbols<CR>", { desc = "Document Symbols" })
-- map("n", "lt", function()
--     vim.diagnostic.config({
--         virtual_lines = not vim.diagnostic.config().virtual_lines
--     })
-- end, { desc = "Toggle Display-mode" })

-- Search mappings
-- map("n", "<leader>s", nil, { desc = "Search" })
map("n", "<leader>sb", "<cmd>Telescope git_branches<CR>", { desc = "Checkout Branch" })
map("n", "<leader>sc", "<cmd>Telescope colorscheme<CR>", { desc = "Colorscheme" })
map("n", "<leader>sh", "<cmd>Telescope help_tags<CR>", { desc = "Find Help" })
map("n", "<leader>sM", "<cmd>Telescope man_pages<CR>", { desc = "Man Pages" })
map("n", "<leader>sr", "<cmd>Telescope oldfiles<CR>", { desc = "Open Recent File" })
map("n", "<leader>sR", "<cmd>Telescope registers<CR>", { desc = "Registers" })
map("n", "<leader>sk", "<cmd>Telescope keymaps<CR>", { desc = "Keymaps" })
map("n", "<leader>sC", "<cmd>Telescope commands<CR>", { desc = "Commands" })
map("n", "<leader>sd", "<cmd>Telescope diagnostics<CR>", { desc = "Diagnostics" })

-- Terminal mappings
map("n", "<leader>tf", "<cmd>ToggleTerm direction=float<CR>", { desc = "Float" })
-- map("n", "tF", function() _CWDTERM_TOGGLE() end, { desc = "Current Buffer Directory" })
map("n", "<leader>th", "<cmd>ToggleTerm size=10 direction=horizontal<CR>", { desc = "Horizontal" })
map("n", "<leader>tv", "<cmd>ToggleTerm size=80 direction=vertical<CR>", { desc = "Vertical" })
