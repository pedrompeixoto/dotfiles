return {
    { "L3MON4D3/LuaSnip" },
    { "rafamadriz/friendly-snippets" },
    {
        "saghen/blink.cmp",
        version = "*",
        config = function() require("setup.completion").blink() end,
    },
    {
        "monkoose/neocodeium",
        event = "VeryLazy",
        keys = {
            { "<A-f>", function() require("neocodeium").accept() end, mode = "i", desc = "Accept AI suggestion" },
            { "<A-w>", function() require("neocodeium").accept_word() end, mode = "i", desc = "Accept AI suggestion word" },
            { "<A-a>", function() require("neocodeium").accept_line() end, mode = "i", desc = "Accept AI suggestion line" },
            { "<A-e>", function() require("neocodeium").cycle_or_complete() end, mode = "i", desc = "Cycle AI suggestions" },
            {
                "<A-r>",
                function() require("neocodeium").cycle_or_complete(-1) end,
                mode = "i",
                desc = "Cycle AI suggestions (reverse)",
            },
            { "<A-c>", function() require("neocodeium").clear() end, mode = "i", desc = "Clear AI suggestion" },
        },
        config = function() require("setup.completion").neocodeium() end,
    },
}
