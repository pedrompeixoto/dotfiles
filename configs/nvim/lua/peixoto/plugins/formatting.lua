return {
	"stevearc/conform.nvim",
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		local conform = require("conform")

		conform.setup({
            formatters = {},
            formatters_by_ft = {
                javascript = { "oxfmt", "prettier" },
                typescript = { "oxfmt", "prettier" },
            },
		})

		vim.keymap.set({ "n", "v" }, "<leader>f", function()
			conform.format({
				lsp_fallback = true,
			})
		end, { desc = "Format whole file or range in visual mode" })
	end,
}
