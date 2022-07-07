local status_ok, project = pcall(require, "project_nvim")
if not status_ok then
	vim.notify "Failed to require project_nvim!"
	return
end

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

local telescope_status_ok, telescope = pcall(require, "telescope")
if not telescope_status_ok then
	vim.notify "Failed to require telescope!"
	return
end

telescope.load_extension "projects"
