local M = {}

function M.blink()
    require("blink.cmp").setup({
        keymap = {
            preset = "enter",
            ["<Tab>"] = { "select_next", "fallback" },
            ["<S-Tab>"] = { "select_prev", "fallback" },
        },
        sources = {
            default = { "lsp", "path", "snippets", "buffer" },
        },
    })
end

function M.neocodeium()
    require("neocodeium").setup()
end

return M
