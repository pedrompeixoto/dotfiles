vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

require("config.options")
require("config.autocmds")
require("config.lazy")     -- bootstrap + install plugins
require("config.keymaps")  -- last, so plugin globals (Snacks.*) are available
