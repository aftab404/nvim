-- Vim Config

vim.cmd.colorscheme("catppuccin")

vim.diagnostic.config({
	virtual_text = true, -- This shows the error message at the end of the line
	signs = true, -- Shows the 'E', 'W', etc. in the gutter
	underline = true, -- Underlines the text causing the error
	update_in_insert = false, -- Wait until you exit insert mode to update errors
})

vim.opt.relativenumber = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.termguicolors = true

-- Transparent Background

vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
vim.api.nvim_set_hl(0, "NormalNC", { bg = "none" })
vim.api.nvim_set_hl(0, "SignColumn", { bg = "none" })
vim.api.nvim_set_hl(0, "EndOfBuffer", { bg = "none" })
