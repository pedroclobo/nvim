local status_ok, which_key = pcall(require, "which-key")
if not status_ok then
	vim.notify "Failed to require which-key!"
	return
end

local setup = {
	plugins = {
		spelling = {
			enabled = true,
			suggestions = 20,
		},
	},
	window = {
		border = "rounded",
		position = "bottom",
		margin = { 1, 0, 1, 0 },
		padding = { 1, 1, 1, 1 },
		winblend = 0,
	},
}

which_key.setup(setup)
