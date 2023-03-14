vim.g.mapleader = " "

local opts = {buffer = bufnr, remap = false}
vim.keymap.set("v", "<", "<gv", opts)
vim.keymap.set("v", ">", ">gv", opts)
vim.keymap.set("i", "jj", "<Esc>", opts)

local function toggleLine()
    vim.o.relativenumber = not vim.o.relativenumber
end

vim.keymap.set("n", "<leader>tl", toggleLine, opts)


