local opts = { noremap = true, silent = true }

vim.g.mapleader = " "

vim.keymap.set('n', '<leader>d', vim.diagnostic.open_float, { desc = 'Show line diagnostics' })
