
vim.opt.nu = true
vim.opt.nu = true
vim.opt.relativenumber = true

-- indentation
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.smartindent = false
vim.opt.wrap = false

-- backup and undo
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = vim.fn.stdpath("data") .. "/undodir"
vim.opt.undofile = true

-- misc
vim.opt.guicursor = ""
vim.opt.updatetime = 50
vim.opt.colorcolumn = "0"
vim.opt.clipboard:append("unnamedplus")
vim.opt.mouse = "a"
