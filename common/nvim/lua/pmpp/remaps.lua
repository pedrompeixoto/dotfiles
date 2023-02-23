vim.g.mapleader = " "

local opts = {buffer = bufnr, remap = false}
vim.keymap.set("v", "<", "<gv", opts)
vim.keymap.set("v", ">", ">gv", opts)
