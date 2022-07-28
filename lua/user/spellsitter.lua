local status_ok, spellsitter = pcall(require, "spellsitter")
if not status_ok then
	vim.notify "Failed to require spellsitter!"
	return
end

spellsitter.setup()
