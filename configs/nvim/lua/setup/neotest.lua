local M = {}

function M.setup()
    require("neotest").setup({
        adapters = {
            require("neotest-vitest"),
            require("neotest-jest")({
                jestCommand = "npx jest",
            }),
        },
    })
end

return M
