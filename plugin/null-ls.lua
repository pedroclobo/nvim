local present, null_ls = pcall(require, "null-ls")
if not present then return end

local formatting = null_ls.builtins.formatting
local diagnostics = null_ls.builtins.diagnostics

null_ls.setup({
	debug = false,
	sources = {
		diagnostics.shellcheck,
		diagnostics.write_good,
		formatting.clang_format.with(require "user.lsp.settings.clang_format"),
		formatting.prettier.with(require "user.lsp.settings.prettier"),
		formatting.rustfmt.with(require "user.lsp.settings.rustfmt"),
		formatting.shfmt.with(require "user.lsp.settings.shfmt"),
		formatting.stylua.with(require "user.lsp.settings.stylua"),
		formatting.yapf.with(require "user.lsp.settings.yapf"),
	},
})
