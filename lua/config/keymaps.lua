-- Vim KeyBindings

vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

local builtin = require("telescope.builtin")
vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Telescope find files" })
vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "Telescope live grep" })
vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Telescope buffers" })
vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "Telescope help tags" })

-- To avoid paragraph select conflict on Shift+v+j
vim.keymap.set("n", "J", "<Nop>")
vim.keymap.set("v", "J", "<Nop>")

vim.keymap.set("n", "<A-h>", ":bprev<CR>")
vim.keymap.set("n", "<A-l>", ":bnext<CR>")
vim.keymap.set("n", "<A-j>", ":bdelete!<CR>")

-- Format Code ((f)ormat (a)ll)

local function format_buffer()
	require("conform").format({
		async = true,
		lsp_fallback = true,
	})
end

vim.keymap.set("n", "<leader>fa", format_buffer, { desc = "Format code" })

-- Open init.lua ((o)pen (i)nit)

vim.keymap.set("n", "<leader>oi", function()
	vim.cmd("edit ~/.config/nvim/init.lua")
end, { desc = "Edit init.lua" })

-- Open plugins.lua ((o)pen (p)lugins)

vim.keymap.set("n", "<leader>op", function()
	vim.cmd("edit ~/.config/nvim/lua/config/plugins.lua")
end, { desc = "Edit plugins.lua" })

-- Open keymaps.lua ((o)pen (k)eymaps)

vim.keymap.set("n", "<leader>ok", function()
	vim.cmd("edit ~/.config/nvim/lua/config/keymaps.lua")
end, { desc = "Edit keymaps.lua" })
--
-- Open keymaps.lua ((o)pen (o)ptions)

vim.keymap.set("n", "<leader>oo", function()
	vim.cmd("edit ~/.config/nvim/lua/config/options.lua")
end, { desc = "Edit keymaps.lua" })

vim.cmd("command! E Explore")

-- Open terminal in a new split ((s)plit (t)erminal)

vim.keymap.set("n", "<leader>st", function()
	vim.cmd.vnew()
	vim.cmd.term()
	vim.cmd.wincmd("J")
	vim.api.nvim_feedkeys("i", "n", false)
	vim.api.nvim_win_set_height(0, 10)
end)

vim.keymap.set("t", "<Esc>", [[<C-\><C-n>]], { desc = "Exit terminal mode" })

-- Open file explorer in a vertical split ((e)xplorer)

vim.keymap.set("n", "<leader>e", function()
	vim.cmd.vsplit()
	vim.cmd.Explore()
end, { desc = "Open file explorer in a vertical split" })
