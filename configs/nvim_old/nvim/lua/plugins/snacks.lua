return {
    {
        "folke/snacks.nvim",
        priority = 1000,
        lazy = false,
        init = function() require("setup.snacks").init() end,
        config = function() require("setup.snacks").setup() end,
    },
}
