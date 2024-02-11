local Log = require("utils.log")

local status_ok, rt = pcall(require, "rust-tools")
if not status_ok then
    Log:error("Failed to load rust-tools")
    return
end

local capabilities = require("cmp_nvim_lsp").default_capabilities()

rt.setup({
    inlay_hints = {
        auto = true,
        only_current_line = true,
        show_parameter_hints = true,
    },
    server = {
        capabilities = capabilities;
        on_attach = function(_, bufnr)
            -- Hover actions
            vim.keymap.set("n", "<C-space>", rt.hover_actions.hover_actions, { buffer = bufnr })
            -- Code action groups
            vim.keymap.set("n", "<Leader>a", rt.code_action_group.code_action_group, { buffer = bufnr })
        end,
    },
})
