local status_ok, lsp_lines = pcall(require, "lsp_lines")
if not status_ok then
	vim.notify "Failed to require lsp_lines!"
	return
end

lsp_lines.setup()
