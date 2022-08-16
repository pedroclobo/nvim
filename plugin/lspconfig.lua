local present, lsp = pcall(require, "lspconfig")
if not present then return end

local servers = {
	"bashls",
	"clangd",
	"pyright",
	"rust_analyzer",
	"sumneko_lua",
}

local function highlight(client)
	local present, illuminate = pcall(require, "illuminate")
	if not present then return end
	illuminate.on_attach(client)
end

local function keymaps(bufnr)
	local opts = { noremap = true, silent = true }
	local keymap = vim.api.nvim_buf_set_keymap

	keymap(bufnr, "n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
	keymap(bufnr, "n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
	keymap(bufnr, "n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
	keymap(bufnr, "n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
	keymap(bufnr, "n", "<C-k>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
	keymap(bufnr, "n", "gr", "<cmd>Telescope lsp_references<CR>", opts)
	keymap(bufnr, "n", "gl", "<cmd>lua vim.diagnostic.open_float({ border = \"rounded\" })<CR>", opts)
	keymap(bufnr, "n", "<leader>a", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)
	keymap(bufnr, "n", "<leader>r", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
end

local function autocommands(bufnr)
	vim.api.nvim_create_autocmd("BufWritePre", {
		group = vim.api.nvim_create_augroup("Format", { clear = true }),
		buffer = bufnr,
		callback = function() vim.lsp.buf.formatting_seq_sync() end,
	})
end

local on_attach = function(client, bufnr)
	highlight(client)
	keymaps(bufnr)
	autocommands(bufnr)

	-- disable autoformat
	client.resolved_capabilities.document_formatting = false
	client.resolved_capabilities.document_range_formatting = false
end

local present, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if not present then return end
local capabilities = cmp_nvim_lsp.update_capabilities(vim.lsp.protocol.make_client_capabilities())

for _, server in pairs(servers) do
	local opts = {
		on_attach = on_attach,
		capabilities = capabilities,
	}

	if server == "sumneko_lua" then
		local sumneko_opts = require "user.lsp.settings.sumneko_lua"
		opts = vim.tbl_deep_extend("force", sumneko_opts, opts)
	end

	if server == "pyright" then
		local pyright_opts = require "user.lsp.settings.pyright"
		opts = vim.tbl_deep_extend("force", pyright_opts, opts)
	end

	lsp[server].setup(opts)
end
