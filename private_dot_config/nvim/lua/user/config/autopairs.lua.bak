local Log = require('utils.log')

local status_ok, autopairs = pcall(require, 'nvim-autopairs')
if not status_ok then
    Log:error('Failed to load autopairs')
    return
end

autopairs.setup({
    disabled_filetype = { 'TelescopePrompt' }
})

local cmp_autopairs = require('nvim-autopairs.completion.cmp')
local cmp = require('cmp')
cmp.event:on(
  'confirm_done',
  cmp_autopairs.on_confirm_done()
)

