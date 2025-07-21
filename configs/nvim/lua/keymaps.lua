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
keymap.set("n", "<leader>nh", ":nohlsearch<CR>")

vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(args)
    local bufnr = args.buf -- buffer number
    local opts = { noremap=true, silent=true, buffer=bufnr }
    keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
    keymap.set('n', 'gr', vim.lsp.buf.references, opts)
    keymap.set('n', 'K', vim.lsp.buf.hover, opts)
  end,
})
