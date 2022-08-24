local M = {}

-- Illuminate
local function highlight(client)
	local present, illuminate = pcall(require, "illuminate")
	if not present then return end
	illuminate.on_attach(client)
end

-- LSP specific keymaps
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

-- LSP specific autocommands
local function autocommands(bufnr)
	vim.api.nvim_create_autocmd("BufWritePre", {
		group = vim.api.nvim_create_augroup("Format", { clear = true }),
		buffer = bufnr,
		callback = function() vim.lsp.buf.formatting_seq_sync() end,
	})
end

M.on_attach = function(client, bufnr)
	highlight(client)
	keymaps(bufnr)
	autocommands(bufnr)

	-- Disable autoformat
	client.resolved_capabilities.document_formatting = false
	client.resolved_capabilities.document_range_formatting = false
end

local present, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if not present then return end

M.capabilities = cmp_nvim_lsp.update_capabilities(vim.lsp.protocol.make_client_capabilities())

return M
