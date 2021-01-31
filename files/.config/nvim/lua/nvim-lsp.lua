local lspcfg = require('lspconfig')
local lsp_status = require('lsp-status')
lsp_status.register_progress()

lspcfg.clangd.setup{}
lspcfg.cmake.setup{}
lspcfg.dockerls.setup{}
lspcfg.gopls.setup{}
lspcfg.html.setup{
	cmd = {"vscode-html-languageserver", "--stdio"}
}
lspcfg.julials.setup{}
lspcfg.pyls.setup{}
lspcfg.rome.setup{}
lspcfg.rust_analyzer.setup{
--	on_attach = lsp_status.on_attach,
	capabilities = lsp_status.capabilities
}
lspcfg.sumneko_lua.setup{}
lspcfg.texlab.setup{}
lspcfg.vimls.setup{}
lspcfg.yamlls.setup{}
lspcfg.zls.setup{}

local saga = require 'lspsaga'
saga.init_lsp_saga()
