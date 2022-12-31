-- Automatically install packer
local install_path = vim.fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
	PACKER_BOOTSTRAP = vim.fn.system({
		"git",
		"clone",
		"--depth",
		"1",
		"https://github.com/wbthomason/packer.nvim",
		install_path,
	})
	vim.cmd [[packadd packer.nvim]]
end

local present, packer = pcall(require, "packer")
if not present then return end

-- Use a popup window
packer.init({
	display = {
		open_fn = function() return require("packer.util").float({ border = "rounded" }) end,
	},
	profile = {
		enable = true,
		threshold = 0,
	},
})

-- Caching to improve performance
pcall(require, "impatient")

return packer.startup(function(use)
	use "wbthomason/packer.nvim"
	use "goolord/alpha-nvim"
	use "windwp/nvim-autopairs"
	use "lewis6991/gitsigns.nvim"
	use "numToStr/Comment.nvim"
	use "lewis6991/impatient.nvim"
	use({
		"kyazdani42/nvim-tree.lua",
		requires = {
			"kyazdani42/nvim-web-devicons",
		},
	})
	use "zbirenbaum/copilot.lua"
	use "andweeb/presence.nvim"

	-- Colorschemes
	use "shaunsingh/nord.nvim"

	-- LSP
	use({
		"neovim/nvim-lspconfig",
		requires = {
			"jose-elias-alvarez/null-ls.nvim",
			"RRethy/vim-illuminate",
		},
	})

	-- LSP Installer
	use({
		"williamboman/mason.nvim",
		requires = {
			"williamboman/mason-lspconfig.nvim",
		},
	})
	use({ "mfussenegger/nvim-jdtls", ft = { "java" } })

	-- Completion
	use({
		"hrsh7th/nvim-cmp",
		requires = {
			"L3MON4D3/LuaSnip",
			"onsails/lspkind.nvim",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-cmdline",
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-nvim-lua",
			"zbirenbaum/copilot-cmp",
		},
	})

	-- Telescope
	use({
		"nvim-telescope/telescope.nvim",
		requires = {
			"nvim-lua/plenary.nvim",
		},
	})

	-- Treesitter
	use({
		"nvim-treesitter/nvim-treesitter",
		run = ":TSUpdate",
		requires = {
			"nvim-treesitter/nvim-treesitter-textobjects",
			"p00f/nvim-ts-rainbow",
			"windwp/nvim-ts-autotag",
			"lewis6991/spellsitter.nvim",
		},
	})

	-- Set up configuration after cloning packer.nvim
	if PACKER_BOOTSTRAP then require("packer").sync() end
end)
