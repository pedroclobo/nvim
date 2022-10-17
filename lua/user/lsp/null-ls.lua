local present, null_ls = pcall(require, "null-ls")
if not present then return end

local formatting = null_ls.builtins.formatting
local diagnostics = null_ls.builtins.diagnostics

local formatters = require("user.lsp.servers")["formatters"]

null_ls.setup({
	debug = false,
	sources = {
		diagnostics.shellcheck,
		diagnostics.write_good,
		formatting.clang_format.with(formatters["clang_format"]),
		formatting.latexindent.with(formatters["latexindent"]),
		formatting.prettierd.with(formatters["prettierd"]),
		formatting.rustfmt.with(formatters["rustfmt"]),
		formatting.shfmt.with(formatters["shfmt"]),
		formatting.stylua.with(formatters["stylua"]),
		formatting.yapf.with(formatters["yapf"]),
	},
})
