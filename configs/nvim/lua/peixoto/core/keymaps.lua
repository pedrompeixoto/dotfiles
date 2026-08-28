vim.g.mapleader = " "

vim.keymap.set('n', '<leader>d', vim.diagnostic.open_float, { desc = 'Show line diagnostics' })

vim.keymap.set("n", "<leader>sv", "<cmd>vsplit<CR>", { desc = "Vertical split" })
vim.keymap.set("n", "<leader>sh", "<cmd>split<CR>",  { desc = "Horizontal split" })
vim.keymap.set("n", "<C-h>", "<C-w>h", { desc = "Go left split" })
vim.keymap.set("n", "<C-j>", "<C-w>j", { desc = "Go lower split" })
vim.keymap.set("n", "<C-k>", "<C-w>k", { desc = "Go upper split" })
vim.keymap.set("n", "<C-l>", "<C-w>l", { desc = "Go right split" })
vim.keymap.set("n", "<C-A-h>", "<cmd>vertical resize -2<CR>", { desc = "Resize left" })
vim.keymap.set("n", "<C-A-l>", "<cmd>vertical resize +2<CR>", { desc = "Resize right" })
vim.keymap.set("n", "<C-A-j>", "<cmd>resize -2<CR>", { desc = "Resize down" })
vim.keymap.set("n", "<C-A-k>", "<cmd>resize +2<CR>", { desc = "Resize up" })

vim.keymap.set("n", "<Tab>", "<cmd>bnext<CR>", { desc = "Next buffer" })
vim.keymap.set("n", "<S-Tab>", "<cmd>bprevious<CR>", { desc = "Previous buffer" })
