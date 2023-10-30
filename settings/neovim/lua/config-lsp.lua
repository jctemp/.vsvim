local lspconfig = require('lspconfig')
local lsp_defaults = lspconfig.util.default_config

-- Merge the defaults lspconfig provides with the capabilities nvim-cmp adds
lsp_defaults.capabilities = vim.tbl_deep_extend(
	'force',
	lsp_defaults.capabilities,
	require('cmp_nvim_lsp').default_capabilities()
)

-- Useful remaps if lsp attaches
vim.api.nvim_create_autocmd('LspAttach', {
	desc = 'LSP actions',
	callback = function()
		local bufmap = function(mode, lhs, rhs)
			local opts = { buffer = true }
			vim.keymap.set(mode, lhs, rhs, opts)
		end

		bufmap("n", "gd", '<cmd>lua vim.lsp.buf.definition()<cr>')
		bufmap("n", "K", '<cmd>lua vim.lsp.buf.hover()<cr>')
		bufmap("n", "<leader>vws", '<cmd>lua vim.lsp.buf.workspace_symbol()<cr>')
		bufmap("n", "<leader>vd", '<cmd>lua vim.diagnostic.open_float()<cr>')
		bufmap("n", "[d", '<cmd>lua vim.diagnostic.goto_next()<cr>')
		bufmap("n", "]d", '<cmd>lua vim.diagnostic.goto_prev()<cr>')
		bufmap("n", "<leader>vca", '<cmd>lua vim.lsp.buf.code_action()<cr>')
		bufmap("n", "<leader>vrr", '<cmd>lua vim.lsp.buf.references()<cr>')
		bufmap("n", "<leader>vrn", '<cmd>lua vim.lsp.buf.rename()<cr>')
		bufmap("i", "<C-h>", '<cmd>lua vim.lsp.buf.signature_help()<cr>')
	end
})

lspconfig.bashls.setup {} 
lspconfig.clangd.setup {}
lspconfig.cssls.setup {}
lspconfig.html.setup {}
lspconfig.jsonls.setup {}
lspconfig.lua_ls.setup {}
lspconfig.marksman.setup {}
lspconfig.metals.setup {}
lspconfig.nil_ls.setup {}
lspconfig.pylsp.setup{}
lspconfig.rust_analyzer.setup {}
lspconfig.texlab.setup {}
lspconfig.tsserver.setup {}
lspconfig.typst_lsp.setup{}
