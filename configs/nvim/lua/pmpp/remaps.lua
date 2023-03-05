vim.g.mapleader = " "

local opts = {buffer = bufnr, remap = false}
vim.keymap.set("v", "<", "<gv", opts)
vim.keymap.set("v", ">", ">gv", opts)
vim.keymap.set("i", "jj", "<Esc>", opts)
vim.keymap.set("n", "<leader>tl", "<cmd>set relativenumber<CR>", opts)
vim.keymap.set("n", "<leader>tL", "<cmd>set norelativenumber<CR>", opts)
