local status_ok, null_ls = pcall(require, "null-ls")
if not status_ok then
	vim.notify "null-ls not installed!"
	return
end

local formatting = null_ls.builtins.formatting

null_ls.setup({
	debug = false,
	sources = {
		formatting.clang_format.with(require "user.lsp.settings.clang_format"),
		formatting.prettier.with(require "user.lsp.settings.prettier"),
		formatting.rustfmt.with(require "user.lsp.settings.rustfmt"),
		formatting.shfmt.with(require "user.lsp.settings.shfmt"),
		formatting.stylua.with(require "user.lsp.settings.stylua"),
		formatting.yapf.with(require "user.lsp.settings.yapf"),
	},
})
