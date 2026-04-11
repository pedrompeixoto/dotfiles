require('utils')

local keymap = vim.keymap

-- ============================================================================
-- Insert Mode
-- ============================================================================
keymap.set("i", "jk", "<Esc>", { desc = "Exit insert mode with jk" })

-- ============================================================================
-- Leader Commands
-- ============================================================================
-- Format & Diagnostics
keymap.set("n", "<leader>f", vim.lsp.buf.format, { desc = "Format file with LSP" })
keymap.set("n", "<leader>d", vim.diagnostic.open_float, { desc = "Diagnostics" })

-- Search & Replace
keymap.set("n", "<leader>r", ":%s/<C-r><C-w>//g<Left><Left>", { desc = "Search and replace word under cursor" })

-- UI Toggles
keymap.set("n", "<leader>nh", ":nohlsearch<CR>", { desc = "Clear highlight search" })

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
    keymap.set('n', 'K', vim.lsp.buf.hover, opts)
    keymap.set('n', 'ca', vim.lsp.buf.code_action, opts)
    keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
  end,
})

-- ============================================================================
-- Project-Specific
-- ============================================================================
local function setup_rn_keymap()
  pcall(vim.keymap.del, "n", "<leader>tn")
  if IsReactNativeProj() then
    keymap.set("n", "<leader>tn", ToggleNativeFile, { desc = "Toggle native/non-native file" })
  end
end

vim.api.nvim_create_autocmd("VimEnter", { once = true, callback = setup_rn_keymap })
vim.api.nvim_create_autocmd("DirChanged", { callback = setup_rn_keymap })
