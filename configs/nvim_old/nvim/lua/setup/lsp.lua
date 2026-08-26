local M = {}

function M.setup()
    vim.lsp.config('*', {
        capabilities = require('blink.cmp').get_lsp_capabilities(),
    })
    require('mason-lspconfig').setup({
        ensure_installed = { "lua_ls", "ts_ls", "svelte", "eslint", "oxfmt", "oxlint" },
        automatic_enable = true,
    })
end

return M
