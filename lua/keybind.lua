local keymap = vim.api.nvim_set_keymap
keymap('n', '<c-s>', ':w<CR>',{})
keymap('i', '<c-s>', '<Esc>:w<CR>a', {})
local opts = {noremap = true, }
keymap('n', '<c-j>', '<c-w>j', opts)
keymap('n', '<c-h>', '<c-w>h', opts)
keymap('n', '<c-k>', '<c-w>k', opts)
keymap('n', '<c-l>', '<c-w>l', opts)
keymap('n', '<s-l>', '<c-w>>', opts)
keymap('n', '<s-h>', '<c-w><', opts)
--keymap('n', '<s-h>', ':vertical-resize -5<CR>', opts)
--keymap('n', '<s-l>', ':vertical-resize +5<CR>', opts)

keymap('n', '<space><space>s', '<cmd>:so ~/.config/nvim/lua/snips.lua<CR>', opts)
keymap('n', '<space><space>n', '<cmd>:OpenNotes<CR>', opts)
keymap('n', '<space><space>cn', '<cmd>:CreateNote<CR>', opts)
keymap('n', '<space><space>cl', "<cmd>:SetupCheck<CR>", opts)
