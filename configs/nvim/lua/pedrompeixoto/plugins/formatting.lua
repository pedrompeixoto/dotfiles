return {
    'sbdchd/neoformat',

    config = function()
        vim.g.neoformat_try_node_exe = 1
        vim.keymap.set('n', '<leader>F', ':Neoformat <CR>', { noremap = true, silent = true })
    end
}
