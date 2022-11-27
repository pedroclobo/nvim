local present, mason = pcall(require, "mason")
if not present then return end

local present, mason_lspconfig = pcall(require, "mason-lspconfig")
if not present then return end

local present, lsp = pcall(require, "lspconfig")
if not present then return end

mason.setup({
	ui = {
		keymaps = {
			toggle_server_expand = "<CR>",
			install_server = "i",
			update_server = "u",
			check_server_version = "c",
			update_all_servers = "U",
			check_outdated_servers = "C",
			uninstall_server = "x",
		},
	},
	log_level = vim.log.levels.INFO,
	max_concurrent_installers = 4,
})

local servers = require("user.lsp.servers")["servers"]
mason_lspconfig.setup()

-- Setup all installed servers
local on_attach = require("user.lsp.handlers").on_attach
local capabilites = require("user.lsp.handlers").capabilities

for _, server in pairs(mason_lspconfig.get_installed_servers()) do
	local opts = {
		on_attach = on_attach,
		capabilities = capabilites,
	}

	-- Extend opts with specific server settings
	opts = vim.tbl_deep_extend("force", opts, servers[server] or {})

	lsp[server].setup(opts)
end
