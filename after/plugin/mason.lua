local present, mason = pcall(require, "mason")
if not present then return end

local present, mason_lspconfig = pcall(require, "mason-lspconfig")
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

mason_lspconfig.setup({
	ensure_installed = servers,
	automatic_installation = true,
})
