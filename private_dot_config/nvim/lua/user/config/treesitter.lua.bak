local Log = require('utils.log')

local status_ok, treesitter_configs = pcall(require, 'nvim-treesitter.configs')
if not status_ok then
    Log:error('Failed to load treesitter')
    return
end

treesitter_configs.setup {
    highlight = {
        enable = true,
        -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
        -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
        -- Using this option may slow down your editor, and you may see some duplicate highlights.
        -- Instead of true it can also be a list of languages
        additional_vim_regex_highlighting = false,
    },
    textobjects = {
        select = {
            enable = true,

            -- Automatically jump forward to textobj, similar to targets.vim
            lookahead = true,

            keymaps = {
                -- You can use the capture groups defined in textobjects.scm
                ["af"] = { query = "@function.outer", desc = "Select outer part of function region"},
                ["if"] = { query = "@function.inner", desc = "Select inner part of function region"},
                ["ac"] = { query = "@class.outer", desc = "Select outer part of a class region" },
                ["ic"] = { query = "@class.inner", desc = "Select inner part of a class region" },
            },
        },
    },
    playground = {
        enable = true,
    },
}
