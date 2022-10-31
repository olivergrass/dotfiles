require('mason.settings').set {
    ui = {
        border = 'rounded',
        icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗"
        },
    },
}

local lsp = require('lsp-zero')
lsp.preset('recommended')
lsp.configure('sumneko_lua', {
    settings = {
        Lua = {
            diagnostics = {
                globals = { 'vim' },
            },
        },
    },
})

local rust_lsp = lsp.build_options('rust_analyzer', {})

local luasnip = require('luasnip')
local cmp = require('cmp')
local cmp_select = { behavior = cmp.SelectBehavior.Select }
local icons = require('tables.icons')

lsp.setup_nvim_cmp({
    mapping = lsp.defaults.cmp_mappings({
        ['<Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_next_item(cmp_select)
            elseif luasnip.expand_or_jumpable() then
                luasnip.expand_or_jump()
            else
                fallback()
            end
        end, { 'i', 's' }),
        ['<S-Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_prev_item(cmp_select)
            elseif luasnip.jumpable(-1) then
                luasnip.jump(-1)
            else
                fallback()
            end
        end, { 'i', 's' }),
    }),
    formatting = {
        format = function(entry, vim_item)
            -- icons
            vim_item.kind = string.format('%s %s', icons.kind[vim_item.kind], vim_item.kind) -- concat icon and text
            -- disable source text
            vim_item.menu = ({
                buffer = '',
                nvim_lsp = '',
                luasnip = '',
                nvim_lua = '',
            })[entry.source.name]
            return vim_item
        end
    },
})

vim.diagnostic.config({
    virtual_text = false,
    virtual_lines = false,
})

vim.cmd([[
autocmd CursorHold * lua vim.diagnostic.open_float(nil, { focusable = false })
]])

lsp.setup()

require('rust-tools').setup({
    tools = {
        inlay_hints = {
            auto = true,
            only_current_line = true,
            show_parameter_hints = true,
        },
    },
    server = rust_lsp,
})
