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
