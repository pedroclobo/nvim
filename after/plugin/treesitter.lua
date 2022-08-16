local present, configs = pcall(require, "nvim-treesitter.configs")
if not present then return end

configs.setup({
	ensure_installed = "all",
	highlight = {
		enable = true,
		additional_vim_regex_highlighting = false,
	},
	autotag = {
		enable = true,
	},
	indent = {
		enable = true,
	},
	rainbow = {
		enable = true,
	},
})
