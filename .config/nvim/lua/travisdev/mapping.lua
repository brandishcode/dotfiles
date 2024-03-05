vim.g.mapleader = ' '
vim.keymap.set('n', '<leader>w', vim.cmd.Ex)
vim.keymap.set('n', '<leader>W', vim.cmd.Lex)

vim.api.nvim_create_user_command('PeekOpen', require('peek').open, {})
vim.api.nvim_create_user_command('PeekClose', require('peek').close, {})
