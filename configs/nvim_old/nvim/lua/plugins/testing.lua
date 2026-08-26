return {
    {
        "nvim-neotest/neotest",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-neotest/nvim-nio",
            "nvim-treesitter/nvim-treesitter",
            "marilari88/neotest-vitest",
            "nvim-neotest/neotest-jest",
        },
        ft = { "javascript", "typescript", "javascriptreact", "typescriptreact" },
        keys = {
            { "<leader>tr", function() require("neotest").run.run() end, desc = "Run nearest test" },
            { "<leader>tR", function() require("neotest").run.run(vim.fn.expand("%")) end, desc = "Run test file" },
            { "<leader>tA", function() require("neotest").run.run(vim.fn.getcwd()) end, desc = "Run entire suite" },
            {
                "<leader>tC",
                function() require("neotest").run.run({ vim.fn.expand("%"), extra_args = { "--coverage" } }) end,
                desc = "Run file with coverage",
            },
            { "<leader>to", function() require("neotest").output.open({ enter = true }) end, desc = "Test output" },
            { "<leader>tO", function() require("neotest").output_panel.toggle() end, desc = "Toggle output panel" },
            { "<leader>ts", function() require("neotest").summary.toggle() end, desc = "Test summary" },
        },
        config = function() require("setup.neotest").setup() end,
    },
    {
        "andythigpen/nvim-coverage",
        dependencies = { "nvim-lua/plenary.nvim" },
        ft = { "javascript", "typescript", "javascriptreact", "typescriptreact" },
        keys = {
            { "<leader>tc", function() require("coverage").load(true) end, desc = "Load & show coverage" },
            { "<leader>tx", function() require("coverage").toggle() end, desc = "Toggle coverage signs" },
            { "<leader>tv", function() require("coverage").summary() end, desc = "Coverage report" },
        },
        opts = {
            auto_reload = true,
            lang = {
                javascript = { coverage_file = vim.fn.getcwd() .. "/coverage/lcov.info" },
                typescript = { coverage_file = vim.fn.getcwd() .. "/coverage/lcov.info" },
            },
        },
    },
}
