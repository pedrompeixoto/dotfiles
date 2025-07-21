function ToggleLineNumbers()
    if vim.wo.relativenumber then
        vim.wo.number = true
        vim.wo.relativenumber = false
    else
        vim.wo.number = false
        vim.wo.relativenumber = true
    end
end
