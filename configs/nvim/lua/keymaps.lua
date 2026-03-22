require('utils')

vim.g.mapleader = " "

local keymap = vim.keymap

-- ============================================================================
-- Insert Mode
-- ============================================================================
keymap.set("i", "jk", "<Esc>", { desc = "Exit insert mode with jk" })

-- ============================================================================
-- Leader Commands
-- ============================================================================
-- File Tree
keymap.set("n", "<leader>e", ":NvimTreeToggle<CR>", { desc = "Toggle File Tree" })

-- Telescope
keymap.set("n", "<leader>sf", ":Telescope find_files<CR>", { desc = "Find files" })
keymap.set("n", "<leader>sg", ":Telescope live_grep<CR>", { desc = "Live grep" })
keymap.set("n", "<leader>sb", ":Telescope buffers<CR>", { desc = "Buffers" })

-- Git
keymap.set("n", "<leader>g", ":Neogit<CR>", { desc = "Neogit" })

-- Format & Diagnostics
keymap.set("n", "<leader>f", function()
    require("conform").format({ async = true, lsp_fallback = true })
end, { desc = "Format file with conform" })
keymap.set("n", "<leader>d", vim.diagnostic.open_float, { desc = "Diagnostics" })

-- Search & Replace
keymap.set("n", "<leader>r", ":%s/<C-r><C-w>//g<Left><Left>", { desc = "Search and replace word under cursor" })

-- UI Toggles
keymap.set("n", "<leader>nh", ":nohlsearch<CR>", { desc = "Clear highlight search" })
keymap.set("n", "<leader>tn", function() ToggleLineNumbers() end, { desc = "Toggle line numbers" })

-- ============================================================================
-- Split Management
-- ============================================================================
-- Navigation
keymap.set("n", "<leader>h", "<C-w>h", { desc = "Move to left split" })
keymap.set("n", "<leader>j", "<C-w>j", { desc = "Move to bottom split" })
keymap.set("n", "<leader>k", "<C-w>k", { desc = "Move to top split" })
keymap.set("n", "<leader>l", "<C-w>l", { desc = "Move to right split" })

-- Creation
keymap.set("n", "<leader>sv", ":vsplit<CR>", { desc = "Split vertically" })
keymap.set("n", "<leader>sh", ":split<CR>", { desc = "Split horizontally" })

-- Resizing
keymap.set("n", "<C-A-h>", "<C-w><", { desc = "Decrease split width" })
keymap.set("n", "<C-A-l>", "<C-w>>", { desc = "Increase split width" })
keymap.set("n", "<C-A-k>", "<C-w>-", { desc = "Decrease split height" })
keymap.set("n", "<C-A-j>", "<C-w>+", { desc = "Increase split height" })

-- ============================================================================
-- Terminal
-- ============================================================================
-- Open Terminal
keymap.set("n", "<leader>tt", ":split<CR>:terminal<CR>", { desc = "Open terminal" })

-- Terminal Mode - Backspace
keymap.set("t", "<BS>", "<C-h>", { noremap = true, desc = "Backspace in terminal" })

-- Terminal Mode - Split Navigation
keymap.set("t", "<C-h>", "<C-\\><C-n><C-w>h", { desc = "Move to left split" })
keymap.set("t", "<C-j>", "<C-\\><C-n><C-w>j", { desc = "Move to bottom split" })
keymap.set("t", "<C-k>", "<C-\\><C-n><C-w>k", { desc = "Move to top split" })
keymap.set("t", "<C-l>", "<C-\\><C-n><C-w>l", { desc = "Move to right split" })

-- Terminal Mode - Split Resizing
keymap.set("t", "<C-A-h>", "<C-\\><C-n><C-w><", { desc = "Decrease split width" })
keymap.set("t", "<C-A-l>", "<C-\\><C-n><C-w>>", { desc = "Increase split width" })
keymap.set("t", "<C-A-k>", "<C-\\><C-n><C-w>-", { desc = "Decrease split height" })
keymap.set("t", "<C-A-j>", "<C-\\><C-n><C-w>+", { desc = "Increase split height" })

-- ============================================================================
-- Text Editing
-- ============================================================================
keymap.set("v", "<S-j>", ":m '>+1<CR>gv", { desc = "Move lines down" })
keymap.set("v", "<S-k>", ":m '<-2<CR>gv", { desc = "Move lines up" })

-- ============================================================================
-- LSP
-- ============================================================================
vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(args)
    local bufnr = args.buf
    local opts = { noremap=true, silent=true, buffer=bufnr }
    keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
    keymap.set('n', 'gr', vim.lsp.buf.references, opts)
    keymap.set('n', 'K', vim.lsp.buf.hover, opts)
    keymap.set('n', 'ca', vim.lsp.buf.code_action, opts)
    keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
  end,
})

-- ============================================================================
-- Project-Specific
-- ============================================================================
if IsReactNativeProj() then
  keymap.set("n", "<leader>tn", function()
    ToggleNativeFile()
  end, { desc = "Toggle between native and non-native file for react native projects" })
end
