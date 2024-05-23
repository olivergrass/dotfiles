local Log = require("utils.log")

local status_ok, which_key = pcall(require, "which-key")
if not status_ok then
    Log:error("Failed to load which-key")
    return
end

local setup = {
    plugins = {
        marks = true, -- shows a list of your marks on " and `
        registers = true, -- shows your registers on " in NORMAL or <C-r> in INSERT mode
        spelling = {
            enabled = true, -- enabling this will show WhichKey when pressing z= to select spelling suggestions
            suggestions = 20, -- how many suggestions should be shown in the list?
        },
        -- the presets plugin, adds help for a bunch of default keybindings in Neovim
        -- No actual key bindings are created
        presets = {
            operators = false, -- adds help for operators like d, y, ... and registers them for motion / text object completion
            motions = false, -- adds help for motions
            text_objects = false, -- help for text objects triggered after entering an operator
            windows = true, -- default bindings on <c-w>
            nav = true, -- misc bindings to work with windows
            z = true, -- bindings for folds, spelling and others prefixed with z
            g = true, -- bindings for prefixed with g
        },
    },
    -- add operators that will trigger motion and text object completion
    -- to enable all native operators, set the preset / operators plugin above
    -- operators = { gc = "Comments" },
    key_labels = {
        -- override the label used to display some keys. It doesn"t effect WK in any other way.
        -- For example:
        -- ["<space>"] = "SPC",
        -- ["<CR>"] = "RET",
        -- ["<tab>"] = "TAB",
    },
    icons = {
        breadcrumb = "»", -- symbol used in the command line area that shows your active key combo
        separator = "➜", -- symbol used between a key and it"s label
        group = "+", -- symbol prepended to a group
    },
    popup_mappings = {
        scroll_down = "<c-d>", -- binding to scroll down inside the popup
        scroll_up = "<c-u>", -- binding to scroll up inside the popup
    },
    window = {
        border = "none", -- none, single, double, shadow
        position = "bottom", -- bottom, top
        margin = { 1, 0, 1, 0 }, -- extra window margin [top, right, bottom, left]
        padding = { 2, 2, 2, 2 }, -- extra window padding [top, right, bottom, left]
        winblend = 0
    },
    layout = {
        height = { min = 4, max = 25 }, -- min and max height of the columns
        width = { min = 20, max = 50 }, -- min and max width of the columns
        spacing = 3, -- spacing between columns
        align = "left", -- align columns left, center or right
    },
    ignore_missing = false, -- enable this to hide mappings for which you didn"t specify a label
    hidden = { "<silent>", "<cmd>", "<Cmd>", "<CR>", "call", "lua", "^:", "^ " }, -- hide mapping boilerplate
    show_help = true, -- show help message on the command line when the popup is visible
    triggers = "auto", -- automatically setup triggers
    -- triggers = {"<leader>"} -- or specify a list manually
    triggers_blacklist = {
        -- list of mode / prefixes that should never be hooked by WhichKey
        -- this is mostly relevant for key maps that start with a native binding
        -- most people should not need to change this
        i = { "j", "k" },
        v = { "j", "k" },
    },
    -- disable the WhichKey popup for certain buf types and file types.
    -- Disabled by deafult for Telescope
    disable = {
        buftypes = {},
        filetypes = { "TelescopePrompt" },
    },
}

local opts = {
    mode = "n", -- NORMAL mode
    prefix = "<leader>",
    buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
    silent = true, -- use `silent` when creating keymaps
    noremap = true, -- use `noremap` when creating keymaps
    nowait = true, -- use `nowait` when creating keymaps
}

local mappings = {
    -- ["/"] = { "<cmd>lua require('Comment.api').toggle.linewise.current()<CR>", "Comment" },
    ["a"] = { "<cmd>Alpha<CR>", "Alpha" },
    ["b"] = { "<cmd>Telescope buffers<CR>", "Buffers", },
    -- ["e"] = { "<cmd>NvimTreeToggle<CR>", "Explorer" },
    ["e"] = {
        function()
            if not MiniFiles.close() then MiniFiles.open(vim.api.nvim_buf_get_name(0)) end
    end , "Explorer" },
    ["w"] = { "<cmd>w!<CR>", "Save" },
    ["q"] = { "<cmd>q!<CR>", "Quit" },
    ["c"] = { "<cmd>Bdelete!<CR>", "Close Buffer" },
    ["h"] = { "<cmd>nohlsearch<CR>", "No Highlight" },
    ["f"] = { "<cmd>Telescope find_files<CR>", "Find files", },
    ["F"] = { "<cmd>Telescope live_grep<CR>", "Find Text" },
    ["L"] = { "<cmd>Lazy<CR>", "Lazy" },
    -- ["P"] = { "<cmd>Telescope projects<CR>", "Projects" },

    g = {
        name = "Git",
        g = {
            function ()
                _LAZYGIT_TOGGLE()
            end, "Lazygit" },
        j = { "<cmd>lua require 'gitsigns'.next_hunk()<CR>", "Next Hunk" },
        k = { "<cmd>lua require 'gitsigns'.prev_hunk()<CR>", "Prev Hunk" },
        l = { "<cmd>lua require 'gitsigns'.blame_line()<CR>", "Blame" },
        p = { "<cmd>lua require 'gitsigns'.preview_hunk()<CR>", "Preview Hunk" },
        r = { "<cmd>lua require 'gitsigns'.reset_hunk()<CR>", "Reset Hunk" },
        R = { "<cmd>lua require 'gitsigns'.reset_buffer()<CR>", "Reset Buffer" },
        s = { "<cmd>lua require 'gitsigns'.stage_hunk()<CR>", "Stage Hunk" },
        u = { "<cmd>lua require 'gitsigns'.undo_stage_hunk()<CR>", "Undo Stage Hunk", },
        o = { "<cmd>Telescope git_status<CR>", "Open changed file" },
        b = { "<cmd>Telescope git_branches<CR>", "Checkout branch" },
        c = { "<cmd>Telescope git_commits<CR>", "Checkout commit" },
        d = {
            function ()
                _GITDIFF_TOGGLE()
            end, "Diff Delta", },
    },

    l = {
        name = "LSP",
        f = { "<cmd>lua vim.lsp.buf.format { async = true }<CR>", "Format" },
        i = { "<cmd>lua vim.lsp.buf.implementation()<CR>", "Go To Implementation" },
        j = { "<cmd>lua vim.lsp.diagnostic.goto_next()<CR>", "Next Diagnostic" },
        k = { "<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>", "Prev Diagnostic" },
        d = { "<cmd>lua vim.lsp.buf.definition()<CR>", "Go To Definition" },
        D = { "<cmd>lua vim.lsp.buf.declaration()<CR>", "Go To Declaration" },
        h = { "<cmd>lua vim.lsp.buf.hover()<CR>", "Hover" },
        r = { "<cmd>lua vim.lsp.buf.rename()<CR>", "Rename" },
        s = { "<cmd>Telescope lsp_document_symbols<CR>", "Document Symbols" },
        t = {
            function()
                vim.diagnostic.config({
                    -- virtual_text = not vim.diagnostic.config().virtual_text,
                    virtual_lines = not vim.diagnostic.config().virtual_lines,})
            end,
            "Toggle Display-mode"
        },
    },
    s = {
        name = "Search",
        b = { "<cmd>Telescope git_branches<CR>", "Checkout Branch" },
        c = { "<cmd>Telescope colorscheme<CR>", "Colorscheme" },
        h = { "<cmd>Telescope help_tags<CR>", "Find Help" },
        M = { "<cmd>Telescope man_pages<CR>", "Man Pages" },
        r = { "<cmd>Telescope oldfiles<CR>", "Open Recent File" },
        R = { "<cmd>Telescope registers<CR>", "Registers" },
        k = { "<cmd>Telescope keymaps<CR>", "Keymaps" },
        C = { "<cmd>Telescope commands<CR>", "Commands" },
        d = { "<cmd>Telescope diagnostics<CR>", "Diagnostics" },
    },

    t = {
        name = "Terminal",
        f = { "<cmd>ToggleTerm direction=float<CR>", "Float" },
        F = {
            function ()
                _CWDTERM_TOGGLE()
            end, "Current Buffer Directory" },
        h = { "<cmd>ToggleTerm size=10 direction=horizontal<CR>", "Horizontal" },
        v = { "<cmd>ToggleTerm size=80 direction=vertical<CR>", "Vertical" },
    },
}

local vopts = {
    mode = "v", -- VISUAL mode
    prefix = "<leader>",
    buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
    silent = true, -- use `silent` when creating keymaps
    noremap = true, -- use `noremap` when creating keymaps
    nowait = true, -- use `nowait` when creating keymaps
}
local vmappings = {
    -- ["/"] = { "<ESC><CMD>lua require(\"Comment.api\").toggle.linewise(vim.fn.visualmode())<CR>", "Comment" },
}

which_key.setup(setup)
which_key.register(mappings, opts)
which_key.register(vmappings, vopts)
