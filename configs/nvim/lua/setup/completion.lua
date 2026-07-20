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
        completion = {
            menu = {
                -- keep the menu closed by default so NeoCodeium's ghost text
                -- isn't fighting the cmp popup for screen space
                auto_show = function(ctx)
                    return ctx.mode ~= "default"
                end,
            },
        },
    })
end

function M.neocodeium()
    local neocodeium = require("neocodeium")
    local blink = require("blink.cmp")

    neocodeium.setup({
        filter = function()
            return not blink.is_visible()
        end,
    })

    -- close the AI ghost text as soon as the cmp menu takes over
    vim.api.nvim_create_autocmd("User", {
        pattern = "BlinkCmpMenuOpen",
        callback = function() neocodeium.clear() end,
    })
end

return M
