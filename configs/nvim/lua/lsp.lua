-- Set capabilities globally for all LSP servers (Neovim 0.11+)
vim.lsp.config('*', {
    capabilities = require('blink.cmp').get_lsp_capabilities(),
})
