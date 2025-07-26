local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git", "clone", "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        lazypath
    })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
    {
        "mason-org/mason-lspconfig.nvim",
        opts = {
            ensure_installed = { "lua_ls", "ts_ls" },
        },
        dependencies = {
            { "mason-org/mason.nvim", opts = {} },
            "neovim/nvim-lspconfig",
        },
    },
    "nvim-tree/nvim-tree.lua",
    "nvim-telescope/telescope.nvim",
    "nvim-lua/plenary.nvim",
    "hrsh7th/nvim-cmp",
    "hrsh7th/cmp-nvim-lsp",
    "L3MON4D3/LuaSnip",
    "saadparwaiz1/cmp_luasnip",
    "stevearc/conform.nvim",
    "mfussenegger/nvim-lint",
    "kdheepak/lazygit.nvim",
    "folke/tokyonight.nvim",
    "nvim-lualine/lualine.nvim",
    "lewis6991/gitsigns.nvim"
})
