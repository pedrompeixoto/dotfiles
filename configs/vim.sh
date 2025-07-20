
#!/bin/bash

VIM_DIR="./nvim"
LUA_DIR="${VIM_DIR}/lua"

echo "📦 Creating local Neovim config in: ${VIM_DIR}"
mkdir -p "${LUA_DIR}"

echo "📁 Creating Lua modules..."
touch "${VIM_DIR}/init.lua"
mkdir -p "${LUA_DIR}"/{plugins,lsp}
touch "${LUA_DIR}/options.lua" "${LUA_DIR}/keymaps.lua" "${LUA_DIR}/plugins.lua" "${LUA_DIR}/lsp.lua"

echo "⚙️ Writing init.lua..."
cat > "${VIM_DIR}/init.lua" << 'EOF'
vim.cmd("set runtimepath+=" .. vim.fn.getcwd() .. "/vim")
require("options")
require("keymaps")
require("plugins")
require("lsp")
EOF

echo "⚙️ Writing options.lua..."
cat > "${LUA_DIR}/options.lua" << 'EOF'
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.termguicolors = true
vim.opt.cursorline = true
vim.opt.scrolloff = 8
vim.opt.wrap = false
EOF

echo "🎮 Writing keymaps.lua..."
cat > "${LUA_DIR}/keymaps.lua" << 'EOF'
vim.g.mapleader = " "

local keymap = vim.keymap
keymap.set("n", "<leader>e", ":NvimTreeToggle<CR>")
keymap.set("n", "<leader>ff", ":Telescope find_files<CR>")
keymap.set("n", "<leader>fg", ":Telescope live_grep<CR>")
keymap.set("n", "<leader>fb", ":Telescope buffers<CR>")
keymap.set("n", "<leader>gs", ":LazyGit<CR>")
EOF

echo "📦 Writing plugins.lua..."
cat > "${LUA_DIR}/plugins.lua" << 'EOF'
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git", "clone", "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    lazypath
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  "neovim/nvim-lspconfig",
  "williamboman/mason.nvim",
  "williamboman/mason-lspconfig.nvim",
  "jose-elias-alvarez/typescript.nvim",
  "nvim-tree/nvim-tree.lua",
  "nvim-telescope/telescope.nvim",
  "nvim-lua/plenary.nvim",
  "hrsh7th/nvim-cmp",
  "hrsh7th/cmp-nvim-lsp",
  "L3MON4D3/LuaSnip",
  "saadparwaiz1/cmp_luasnip",
  "nvimtools/none-ls.nvim",
  "kdheepak/lazygit.nvim",
  "folke/tokyonight.nvim",
  "nvim-lualine/lualine.nvim",
})
EOF

echo "🔧 Writing lsp.lua..."
cat > "${LUA_DIR}/lsp.lua" << 'EOF'
require("mason").setup()
require("mason-lspconfig").setup({
  ensure_installed = { "tsserver", "eslint" }
})

local lspconfig = require("lspconfig")

require("typescript").setup({
  server = {
    on_attach = function(client, bufnr)
      client.server_capabilities.document_formatting = false
    end,
  }
})

lspconfig.eslint.setup({
  on_attach = function(client, bufnr)
    client.server_capabilities.document_formatting = true
  end,
})

local cmp = require("cmp")
cmp.setup({
  snippet = {
    expand = function(args)
      require("luasnip").lsp_expand(args.body)
    end
  },
  mapping = cmp.mapping.preset.insert({
    ["<Tab>"] = cmp.mapping.select_next_item(),
    ["<S-Tab>"] = cmp.mapping.select_prev_item(),
    ["<CR>"] = cmp.mapping.confirm({ select = true }),
  }),
  sources = {
    { name = "nvim_lsp" },
    { name = "luasnip" }
  }
})
EOF

echo "✅ All files written to ./vim"
echo "🚀 To try it out, launch Neovim like this:"
echo ""
echo "    nvim -u ./vim/init.lua"
echo ""
