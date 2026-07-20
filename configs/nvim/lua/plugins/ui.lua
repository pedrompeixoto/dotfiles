return {
    {
        "aktersnurra/no-clown-fiesta.nvim",
        priority = 1000,
        lazy = false,
        init = function()
            vim.cmd.colorscheme("no-clown-fiesta")
        end,
    },
    {
        "nvim-lualine/lualine.nvim",
        event = "VeryLazy",
        opts = {
            options = {
                theme = "auto",
                component_separators = { left = '', right = '|' },
                section_separators = { left = '', right = '' },
            },
        },
    },
    {
        "folke/which-key.nvim",
        event = "VeryLazy",
        opts = {},
    },
    {
        "MeanderingProgrammer/render-markdown.nvim",
        ft = "markdown",
    },
    {
        'nvim-mini/mini.nvim',
        version = '*',
        init = function()
            require('mini.icons').setup()
        end
    },
}
