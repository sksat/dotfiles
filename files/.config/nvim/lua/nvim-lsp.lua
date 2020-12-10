local lsp_status = require('lsp-status')
lsp_status.register_progress()

require'lspconfig'.clangd.setup{}
require'lspconfig'.cmake.setup{}
require'lspconfig'.dockerls.setup{}
require'lspconfig'.gopls.setup{}
require'lspconfig'.rust_analyzer.setup{
	on_attach = lsp_status.on_attach,
	capabilities = lsp_status.capabilities
}
require'lspconfig'.texlab.setup{}
require'lspconfig'.yamlls.setup{}
