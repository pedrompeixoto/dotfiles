return {
    'nvim-telescope/telescope.nvim', tag = '0.1.5',

    dependencies = { 'nvim-lua/plenary.nvim' },

    config = function()
        local telescope = require('telescope')
        local builtin = require("telescope.builtin")

        telescope.setup({
            pickers = {
                find_files = {
                    hidden = true
                }
            }
        })

        vim.keymap.set('n', '<leader>sf', builtin.find_files, {})
        vim.keymap.set('n', '<leader>sr', builtin.git_files, {})
        vim.keymap.set('n', '<leader>sg', builtin.live_grep, {})
        vim.keymap.set('n', '<leader>sb', builtin.buffers, {})
        vim.keymap.set('n', '<leader>sh', builtin.help_tags, {})
    end
}
