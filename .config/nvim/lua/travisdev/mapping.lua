vim.g.mapleader = " "
vim.keymap.set("n", "<leader>w", vim.cmd.Ex)
vim.keymap.set("n", "<leader>W", vim.cmd.Lex)

vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Goto Previous [D]iagnostic" })
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Goto Next [D]iagnostic" })
vim.keymap.set("n", "<leader>vd", vim.diagnostic.open_float, { desc = "[V]iew [D]iagnostic" })
vim.keymap.set("n", "nh", vim.cmd.nohl, { desc = "Remove search highlight" })
