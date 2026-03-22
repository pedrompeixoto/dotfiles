require('lualine').setup({
    options = {
        theme = "tokyonight",
        component_separators = { left = '', right = '|' },
        section_separators = { left = '', right = '' },
    }
})

require("nvim-tree").setup()

require("telescope").setup({
    defaults = {
        prompt_prefix = " ",
        selection_caret = " ",
        path_display = { "smart" },
        dynamic_preview_title = true,
        winblend = 10,
        sorting_strategy = "ascending",
        layout_strategy = "vertical",
        layout_config = {
            prompt_position = "bottom",
            height = 0.95,
        },
    },
})
