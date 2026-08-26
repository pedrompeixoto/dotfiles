return {
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        event = "BufReadPost",
        opts = {
            ensure_installed = { "lua", "javascript", "typescript", "svelte", "html", "css" },
            highlight = { enable = true },
        },
    },
    {
        "lewis6991/gitsigns.nvim",
        event = "BufReadPre",
        opts = {},
    },
    "nvim-lua/plenary.nvim",
}
