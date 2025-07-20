vim.g.mapleader = " "

local keymap = vim.keymap
keymap.set("n", "<leader>e", ":NvimTreeToggle<CR>", { desc = "Toggle File Tree" })
keymap.set("n", "<leader>sf", ":Telescope find_files<CR>")
keymap.set("n", "<leader>sg", ":Telescope live_grep<CR>")
keymap.set("n", "<leader>sb", ":Telescope buffers<CR>")
keymap.set("n", "<leader>g", ":LazyGit<CR>")
keymap.set("n", "<leader>f", function()
    require("conform").format({ async = true, lsp_fallback = true })
end, { desc = "Format file with conform" })
keymap.set('n', '<leader>d', vim.diagnostic.open_float)
keymap.set("i", "jk", "<Esc>", { desc = "Exit insert mode with jk" })
