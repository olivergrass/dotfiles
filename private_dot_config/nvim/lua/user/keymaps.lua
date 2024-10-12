local map = vim.keymap.set

local split_sensibly = function()
    if vim.api.nvim_win_get_width(0) > math.floor(vim.api.nvim_win_get_height(0) * 2.3) then
        vim.cmd("vs")
    else
        vim.cmd("split")
    end
end

-- Enable buffer switching
map("n", "<TAB>", ":bn<CR>", { noremap = true, silent = true, desc = "Next Buffer" })
map("n", "<S-TAB>", ":bN<CR>", { noremap = true, silent = true, desc = "Prev Buffer" })

-- Copy/paste with system clipboard
map({ 'n', 'x' }, 'gy', '"+y', { desc = 'Copy to system clipboard' })
-- map(  'n',        'gp', '"+p', { desc = 'Paste from system clipboard' })
-- - Paste in Visual with `P` to not copy selected text (`:h v_P`)
-- map(  'x',        'gp', '"+P', { desc = 'Paste from system clipboard' })

-- Reselect latest changed, put, or yanked text
map('n', 'gV', '"`[" . strpart(getregtype(), 0, 1) . "`]"',
    { expr = true, replace_keycodes = false, desc = 'Visually select changed text' })

-- Move Lines. NOTE: Replaced by mini.move
-- map("n", "<A-j>", "<cmd>m .+1<cr>==", { silent = true, desc = "Move down" })
-- map("n", "<A-k>", "<cmd>m .-2<cr>==", { silent = true, desc = "Move up" })
-- map("i", "<A-j>", "<esc><cmd>m .+1<cr>==gi", { silent = true, desc = "Move down" })
-- map("i", "<A-k>", "<esc><cmd>m .-2<cr>==gi", { silent = true, desc = "Move up" })
-- map("v", "<A-j>", ":m '>+1<cr>gv=gv", { silent = true, desc = "Move down" })
-- map("v", "<A-k>", ":m '<-2<cr>gv=gv", { silent = true, desc = "Move up" })

-- Better indenting. NOTE: Replaced by mini.move
-- map("v", "<", "<gv", { noremap = true, silent = true })
-- map("v", ">", ">gv", { noremap = true, silent = true })

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
map("n", "<leader>w", "<cmd>w!<CR>", { desc = "Save" })
map("n", "<leader>q", "<cmd>q!<CR>", { desc = "Quit" })
map("n", "<leader>h", "<cmd>nohlsearch<CR>", { desc = "No Highlight" })
map("n", "<leader>L", "<cmd>Lazy<CR>", { desc = "Lazy" })

-- Buffer mappings
-- map("n", "<leader>bb", "<cmd>Telescope buffers<CR>", { desc = "Buffers" })
map(
    "n",
    "<leader>bb",
    function() require("mini.pick").builtin.buffers() end,
    { noremap = true, silent = true, desc = "Buffers" }
)
map("n", "<leader>bc", "<cmd>Bdelete!<CR>", { desc = "Close Buffer" })
map("n", "<leader>bd", "<cmd>Bdelete!<CR>", { desc = "Close Buffer" })
map("n", "<leader>bs", split_sensibly, { desc = "Split Buffer" })
-- Format Buffer with and without LSP
-- map("n", "<leader>bf", format_buffer, { noremap = true, silent = true, desc = "Format Buffer" })

-- Find mappings
-- map("n", "<leader>ff", "<cmd>Telescope find_files<CR>", { desc = "Find Files" })
-- map("n", "<leader>fg", "<cmd>Telescope live_grep<CR>", { desc = "Find Text" })
map(
    "n",
    "<leader>ff",
    function() require("mini.pick").builtin.files() end,
    { noremap = true, silent = true, desc = "Find Files" }
)
map(
    "n",
    "<leader>fg",
    function() require("mini.pick").builtin.grep_live() end,
    { noremap = true, silent = true, desc = "Find Text" }
)
map(
    "n",
    "<leader>fa",
    function() require("mini.pick").builtin.resume() end,
    { noremap = true, silent = true, desc = "Resume Picker" }
)

-- Git mappings
map("n", "<leader>gl", function()
    require("mini.misc").setup_auto_root()
    split_sensibly()
    vim.cmd("terminal lazygit")
end, { noremap = true, silent = true, desc = "Lazygit" })
map("n", "<leader>gp", "<cmd>:Git pull<cr>", { noremap = true, silent = true, desc = "Git Push" })
map("n", "<leader>gs", "<cmd>:Git push<cr>", { noremap = true, silent = true, desc = "Git Pull" })
map("n", "<leader>ga", "<cmd>:Git add .<cr>", { noremap = true, silent = true, desc = "Git Add All" })

-- Session mappings
local sessions = require("mini.sessions")
map("n", "<leader>ss", function()
    vim.cmd("wall") -- save all buffers
    sessions.write()
    sessions.select()
end, { desc = "Switch Session" })
map("n", "<leader>sw", function()
    local cwd = vim.fn.getcwd()
    local last_folder = cwd:match("([^/]+)$")
    sessions.write(last_folder)
end, { desc = "Write Session" })
map("n", "<leader>sf", function()
    vim.cmd("wall") -- save all buffers
    sessions.select()
end, { desc = "Load Session" })

-- map("n", "gg", function() _LAZYGIT_TOGGLE() end, { desc = "Lazygit" })
-- map("n", "<leader>gj", "<cmd>lua require 'gitsigns'.next_hunk()<CR>", { desc = "Next Hunk" })
-- map("n", "<leader>gk", "<cmd>lua require 'gitsigns'.prev_hunk()<CR>", { desc = "Prev Hunk" })
-- map("n", "<leader>gl", "<cmd>lua require 'gitsigns'.blame_line()<CR>", { desc = "Blame" })
-- map("n", "<leader>gp", "<cmd>lua require 'gitsigns'.preview_hunk()<CR>", { desc = "Preview Hunk" })
-- map("n", "<leader>gr", "<cmd>lua require 'gitsigns'.reset_hunk()<CR>", { desc = "Reset Hunk" })
-- map("n", "<leader>gR", "<cmd>lua require 'gitsigns'.reset_buffer()<CR>", { desc = "Reset Buffer" })
-- map("n", "<leader>gs", "<cmd>lua require 'gitsigns'.stage_hunk()<CR>", { desc = "Stage Hunk" })
-- map("n", "<leader>gu", "<cmd>lua require 'gitsigns'.undo_stage_hunk()<CR>", { desc = "Undo Stage Hunk" })
-- map("n", "<leader>go", "<cmd>Telescope git_status<CR>", { desc = "Open changed file" })
-- map("n", "<leader>gb", "<cmd>Telescope git_branches<CR>", { desc = "Checkout branch" })
-- map("n", "<leader>gc", "<cmd>Telescope git_commits<CR>", { desc = "Checkout commit" })
-- map("n", "gd", function() _GITDIFF_TOGGLE() end, { desc = "Diff Delta" })

-- LSP mappings
-- map("n", "<leader>lf", format_buffer, { desc = "Format" })
map("n", "<leader>li", "<cmd>lua vim.lsp.buf.implementation()<CR>", { desc = "Go To Implementation" })
map("n", "<leader>ld", "<cmd>lua vim.lsp.buf.definition()<CR>", { desc = "Go To Definition" })
map("n", "<leader>lh", "<cmd>lua vim.lsp.buf.hover()<CR>", { desc = "Hover" })
map("n", "<leader>lr", "<cmd>lua vim.lsp.buf.rename()<CR>", { desc = "Rename" })
map("n", "<leader>lq", "<cmd>lua vim.lsp.diagnostic.setqflist()<CR>", { desc = "Populate Quickfix" })
map("n", "<leader>lj", "<cmd>lua vim.lsp.diagnostic.goto_next()<CR>", { desc = "Next Diagnostic" })
map("n", "<leader>lk", "<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>", { desc = "Prev Diagnostic" })
-- map("n", "<leader>lD", "<cmd>lua vim.lsp.buf.declaration()<CR>", { desc = "Go To Declaration" })
-- map("n", "<leader>ls", "<cmd>Telescope lsp_document_symbols<CR>", { desc = "Document Symbols" })
-- map("n", "lt", function()
--     vim.diagnostic.config({
--         virtual_lines = not vim.diagnostic.config().virtual_lines
--     })
-- end, { desc = "Toggle Display-mode" })

-- Search mappings
-- map("n", "<leader>sb", "<cmd>Telescope git_branches<CR>", { desc = "Checkout Branch" })
-- map("n", "<leader>sc", "<cmd>Telescope colorscheme<CR>", { desc = "Colorscheme" })
-- map("n", "<leader>sh", "<cmd>Telescope help_tags<CR>", { desc = "Find Help" })
-- map("n", "<leader>sM", "<cmd>Telescope man_pages<CR>", { desc = "Man Pages" })
-- map("n", "<leader>sr", "<cmd>Telescope oldfiles<CR>", { desc = "Open Recent File" })
-- map("n", "<leader>sR", "<cmd>Telescope registers<CR>", { desc = "Registers" })
-- map("n", "<leader>sk", "<cmd>Telescope keymaps<CR>", { desc = "Keymaps" })
-- map("n", "<leader>sC", "<cmd>Telescope commands<CR>", { desc = "Commands" })
-- map("n", "<leader>sd", "<cmd>Telescope diagnostics<CR>", { desc = "Diagnostics" })

-- Terminal mappings
map("n", "<leader>tf", "<cmd>ToggleTerm direction=float<CR>", { desc = "Float" })
map("n", "<leader>th", "<cmd>ToggleTerm size=10 direction=horizontal<CR>", { desc = "Horizontal" })
map("n", "<leader>tv", "<cmd>ToggleTerm size=80 direction=vertical<CR>", { desc = "Vertical" })
-- map("n", "tF", function() _CWDTERM_TOGGLE() end, { desc = "Current Buffer Directory" })
