return {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
        require("nvim-treesitter.configs").setup({
            -- A list of parser names, or "all"
            ensure_installed = {
                "javascript", "typescript", "c", "lua", "astro", 'css', 'tsx'
            },

            highlight = {
                enable = true,
            },
        })
    end
}
