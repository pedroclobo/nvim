local M = {}

M.setup = function()
	local config = {
		update_in_insert = true,
		underline = true,
		severity_sort = true,
		float = {
			style = "minimal",
			border = "rounded",
			header = "",
			prefix = "",
		},
	}

	vim.diagnostic.config(config)

	-- Rounded borders
	vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
		border = "rounded",
	})

	vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
		border = "rounded",
	})
end

local function lsp_highlight_document(client)
	local status_ok, illuminate = pcall(require, "illuminate")
	if not status_ok then
		vim.notify "Failed to require illuminate!"
		return
	end
	illuminate.on_attach(client)
end

-- lsp keymaps
local function lsp_keymaps(bufnr)
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
end

local function lsp_autocommands()
	local autocmd = vim.api.nvim_create_autocmd

	autocmd({ "BufWritePre" }, {
		callback = function()
			vim.lsp.buf.formatting_sync()
		end,
	})
end

-- on_attach function
M.on_attach = function(client, bufnr)
	if client.name == "rust_analyzer" then
		client.resolved_capabilities.document_formatting = false
	elseif client.name == "clangd" then
		client.resolved_capabilities.document_formatting = false
	elseif client.name == "tsserver" then
		client.resolved_capabilities.document_formatting = false
	elseif client.name == "sumneko_lua" then
		client.resolved_capabilities.document_formatting = false
	end

	lsp_keymaps(bufnr)
	lsp_autocommands()
	lsp_highlight_document(client)
end

-- Setup cmp lsp completion
local capabilities = vim.lsp.protocol.make_client_capabilities()
local status_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if not status_ok then
	vim.notify "Failed to require cmp_nvim_lsp!"
	return
end
M.capabilities = cmp_nvim_lsp.update_capabilities(capabilities)

return M
