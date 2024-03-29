local present, comment = pcall(require, "Comment")
if not present then return end

comment.setup({
	padding = true,
	sticky = true,
	ignore = nil,
	toggler = {
		line = "gcc",
		block = "gbc",
	},
	opleader = {
		line = "gc",
		block = "gb",
	},
	extra = {
		above = "gcO",
		below = "gco",
		eol = "gcA",
	},
	mappings = {
		basic = true,
		extra = true,
		extended = false,
	},
	pre_hook = nil,
	post_hook = nil,
})
