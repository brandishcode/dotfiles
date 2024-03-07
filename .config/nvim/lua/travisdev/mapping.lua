vim.g.mapleader = ' '
vim.keymap.set('n', '<leader>w', vim.cmd.Ex)
vim.keymap.set('n', '<leader>W', vim.cmd.Lex)

vim.api.nvim_create_user_command('PeekOpen', require('peek').open, {})
vim.api.nvim_create_user_command('PeekClose', require('peek').close, {})
vim.keymap.set('n', '<leader>p', vim.cmd.PeekOpen)
vim.keymap.set('n', '<leader>P', vim.cmd.PeekClose)
