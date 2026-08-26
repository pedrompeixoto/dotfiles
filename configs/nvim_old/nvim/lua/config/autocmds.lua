local utils = require("utils")
local keymap = vim.keymap

-- ============================================================================
-- LSP buffer-local keymaps
-- ============================================================================
vim.api.nvim_create_autocmd('LspAttach', {
    callback = function(args)
        local opts = { noremap = true, silent = true, buffer = args.buf }
        keymap.set('n', 'K', vim.lsp.buf.hover, opts)
        keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, opts)
        keymap.set('n', '<leader>cr', vim.lsp.buf.rename, opts)
    end,
})

-- ============================================================================
-- Project-Specific (React Native)
-- ============================================================================
local function setup_rn_keymap()
    pcall(vim.keymap.del, "n", "<leader>tn")
    if utils.is_react_native_project() then
        keymap.set("n", "<leader>tn", utils.toggle_native_file, { desc = "Toggle native/non-native file" })
    end
end

vim.api.nvim_create_autocmd("VimEnter", { once = true, callback = setup_rn_keymap })
vim.api.nvim_create_autocmd("DirChanged", { callback = setup_rn_keymap })
