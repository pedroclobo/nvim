local status_ok, _ = pcall(require, "lspconfig")
if not status_ok then
	vim.notify "Failed to require lspconfig!"
	return
end

require "user.lsp.lsp-installer"
require "user.lsp.null-ls"
require("user.lsp.handlers").setup()
