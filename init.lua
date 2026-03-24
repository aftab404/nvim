-- Package Manager

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
	if vim.v.shell_error ~= 0 then
		vim.api.nvim_echo({
			{ "Failed to clone lazy.nvim:\n", "ErrorMsg" },
			{ out,                            "WarningMsg" },
			{ "\nPress any key to exit..." },
		}, true, {})
		vim.fn.getchar()
		os.exit(1)
	end
end
vim.opt.rtp:prepend(lazypath)

-- Packages

local mason_lsp = {
	"neovim/nvim-lspconfig",
	dependencies = {
		"williamboman/mason.nvim",
		"williamboman/mason-lspconfig.nvim",
	},
	config = function()
		-- Setup Mason
		require("mason").setup()

		require("mason-lspconfig").setup({
			ensure_installed = { "ts_ls" },
		})

		vim.lsp.config['ts_ls'] = {}
	end,
}

local catppuccin_theme = {
	"catppuccin/nvim",
	name = "catppuccin",
	priority = 1000,
}

local telescope = {
	'nvim-telescope/telescope.nvim',
	version = '*',
	dependencies = {
		'nvim-lua/plenary.nvim',
		{ 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
	}
}

local fugitive = {
	'tpope/vim-fugitive'
}

local copilot = {
	'github/copilot.vim'
}

local bufferline = {
	'akinsho/bufferline.nvim',
	version = '*',
	dependencies = 'nvim-tree/nvim-web-devicons',
	config = function()
		require("bufferline").setup({})
	end,
}

require("lazy").setup({
	-- Define packages as variables above and add them to the list below.
	spec = { mason_lsp, catppuccin_theme, telescope, fugitive, copilot, bufferline },
	install = { colorscheme = { "catppuccin" } },
	checker = { enabled = true },
})


-- Vim Config

vim.cmd.colorscheme("catppuccin")

vim.diagnostic.config({
	virtual_text = true,     -- This shows the error message at the end of the line
	signs = true,            -- Shows the 'E', 'W', etc. in the gutter
	underline = true,        -- Underlines the text causing the error
	update_in_insert = false, -- Wait until you exit insert mode to update errors
})

vim.opt.relativenumber = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.termguicolors = true

-- Vim KeyBindings

vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Telescope find files' })
vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope live grep' })
vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Telescope buffers' })
vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' })

-- To avoid paragraph select conflict on Shift+v+j
vim.keymap.set('n', 'J', '<Nop>')
vim.keymap.set('v', 'J', '<Nop>')

vim.keymap.set('n', '<A-h>', ':bprev<CR>')
vim.keymap.set('n', '<A-l>', ':bnext<CR>')
vim.keymap.set('n', '<A-j>', ':bdelete!<CR>')

-- Format Code ((f)ormat (a)ll)

vim.keymap.set("n", "<leader>fa", function()
	vim.lsp.buf.format()
end, { desc = "Format code" })

-- Open init.lua ((o)pen (c)onfig)

vim.keymap.set("n", "<leader>oc", function()
	vim.cmd("edit $MYVIMRC")
end, { desc = "Edit init.lua" })

vim.cmd('command! E Explore')

-- Transparent Background

vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
vim.api.nvim_set_hl(0, "NormalNC", { bg = "none" })
vim.api.nvim_set_hl(0, "SignColumn", { bg = "none" })
vim.api.nvim_set_hl(0, "EndOfBuffer", { bg = "none" })
