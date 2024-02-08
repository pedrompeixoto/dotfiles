return {
    {
        "folke/tokyonight.nvim",
        lazy = false,
        priority = 1000,
        config = function()
            --vim.cmd([[colorscheme tokyonight]])
        end
    },
    { 
        'rose-pine/neovim',
        name = 'rose-pine',
        config = function()
            vim.cmd("colorscheme rose-pine")
        end
    },
    { 
        'morhetz/gruvbox',
        config = function()
            --vim.cmd([[colorscheme gruvbox]])
        end
    }
}
