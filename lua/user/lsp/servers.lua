local M = {}

M.servers = {
	bashls = {},
	clangd = {},
	html = {},
	jdtls = {},
	pyright = {},
	r_language_server = {},
	rust_analyzer = {},
	sumneko_lua = {
		settings = {
			Lua = {
				diagnostics = {
					globals = { "vim" },
				},
				workspace = {
					library = {
						[vim.fn.expand "$VIMRUNTIME/lua"] = true,
						[vim.fn.stdpath "config" .. "/lua"] = true,
					},
				},
				telemetry = {
					enable = false,
				},
			},
		},
	},
	texlab = {},
}

M.formatters = {
	clang_format = {
		extra_args = {
			"--style",
			"{UseTab: ForIndentation, IndentWidth: 8, SortIncludes: true, PointerAlignment: Right, SortUsingDeclarations: false}",
		},
	},
	latexindent = {},
	prettierd = {
		extra_args = {
			"--use-tabs",
		},
	},
	rustfmt = {
		extra_args = {
			"--config",
			"hard_tabs=true",
		},
	},
	shfmt = {
		extra_args = {
			"--keep-padding",
			"--space-redirects",
			"--switch-case-indent",
		},
	},
	stylua = {
		extra_args = {
			"--call-parentheses",
			"NoSingleString",
			"--quote-style",
			"ForceDouble",
			"--collapse-simple-statement",
			"Always",
		},
	},
	yapf = {
		extra_args = {
			"--style",
			"{use_tabs: True}",
		},
	},
}

return M
