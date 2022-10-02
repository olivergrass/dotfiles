" COQ OPTIONS
let g:coq_settings = { 'auto_start': 'shut-up','display.icons.spacing': 2 }

" LSP OPTIONS
lua << EOF
local lspconfig = require('lspconfig')

-- Enable some language servers with the additional completion capabilities offered by coq_nvim
local servers = {'pyright', 'jdtls'}
for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup(require('coq').lsp_ensure_capabilities({
    -- on_attach = my_custom_on_attach,
  }))
end
EOF
