local present, project = pcall(require, "project_nvim")
if not present then return end

project.setup({
	active = true,
	on_config_done = nil,
	manual_mode = false,
	detection_methods = { "pattern" },
	patterns = { ".git", "Makefile" },
	show_hidden = false,
	silent_chdir = true,
	datapath = vim.fn.stdpath "data",
})

local present, telescope = pcall(require, "telescope")
if not present then return end

telescope.load_extension "projects"
