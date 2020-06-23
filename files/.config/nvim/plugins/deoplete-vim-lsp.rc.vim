if (executable('clangd'))
	let s:clangd_path = '/usr/bin/clangd'
	augroup LspClang
		autocmd!
		autocmd User lsp_setup call lsp#register_server({
	  \ 'name': 'clangd',
	  \ 'cmd': {server_info->['clangd']},
	  \ 'whitelist': ['c', 'cpp']
	  \ })
	augroup END
endif
