local utils = require('utils')

local keymap = vim.keymap

-- ============================================================================
-- Insert Mode
-- ============================================================================
keymap.set("i", "jk", "<Esc>", { desc = "Exit insert mode with jk" })

-- ============================================================================
-- Leader Commands
-- ============================================================================
-- Code / LSP
keymap.set("n", "<leader>cf", vim.lsp.buf.format, { desc = "Format file with LSP" })
keymap.set("n", "<leader>cd", vim.diagnostic.open_float, { desc = "Line diagnostics" })

-- Search & Replace
keymap.set("n", "<leader>r", ":%s/<C-r><C-w>//g<Left><Left>", { desc = "Search and replace word under cursor" })
keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>", { desc = "Clear highlight search" })

-- ============================================================================
-- Split Management
-- ============================================================================
-- Navigation
keymap.set("n", "<leader>h", "<C-w>h", { desc = "Move to left split" })
keymap.set("n", "<leader>j", "<C-w>j", { desc = "Move to bottom split" })
keymap.set("n", "<leader>k", "<C-w>k", { desc = "Move to top split" })
keymap.set("n", "<leader>l", "<C-w>l", { desc = "Move to right split" })

-- Creation
keymap.set("n", "<leader>wv", ":vsplit<CR>", { desc = "Split vertically" })
keymap.set("n", "<leader>ws", ":split<CR>", { desc = "Split horizontally" })

-- Resizing
keymap.set("n", "<C-A-h>", "<C-w><", { desc = "Decrease split width" })
keymap.set("n", "<C-A-l>", "<C-w>>", { desc = "Increase split width" })
keymap.set("n", "<C-A-k>", "<C-w>-", { desc = "Decrease split height" })
keymap.set("n", "<C-A-j>", "<C-w>+", { desc = "Increase split height" })

-- ============================================================================
-- Text Editing
-- ============================================================================
keymap.set("v", "<S-j>", ":m '>+1<CR>gv", { desc = "Move lines down" })
keymap.set("v", "<S-k>", ":m '<-2<CR>gv", { desc = "Move lines up" })

-- Keep the cursor centered while scrolling / searching
keymap.set("n", "<C-d>", "<C-d>zz", { desc = "Scroll down and center" })
keymap.set("n", "<C-u>", "<C-u>zz", { desc = "Scroll up and center" })
keymap.set("n", "n", "nzzzv", { desc = "Next search result and center" })
keymap.set("n", "N", "Nzzzv", { desc = "Prev search result and center" })

-- ============================================================================
-- Buffers
-- ============================================================================
keymap.set("n", "<S-l>", "<cmd>bnext<CR>", { desc = "Next buffer" })
keymap.set("n", "<S-h>", "<cmd>bprevious<CR>", { desc = "Prev buffer" })

-- ============================================================================
-- Diagnostics
-- ============================================================================
keymap.set("n", "]d", function() vim.diagnostic.jump({ count = 1, float = true }) end,
    { desc = "Next diagnostic" })
keymap.set("n", "[d", function() vim.diagnostic.jump({ count = -1, float = true }) end,
    { desc = "Prev diagnostic" })

-- ============================================================================
-- Config
-- ============================================================================
keymap.set("n", "<leader>sv", function()
    for name, _ in pairs(package.loaded) do
        if name:match("^config") or name:match("^plugins") or name:match("^setup") or name:match("^utils") then
            package.loaded[name] = nil
        end
    end
    dofile(vim.fn.stdpath("config") .. "/init.lua")
    vim.notify("Config reloaded", vim.log.levels.INFO)
end, { desc = "Reload config" })

-- ============================================================================
-- File Switching
-- ============================================================================
keymap.set("n", "<leader>tt", utils.toggle_test_file, { desc = "Toggle source/test file" })

-- ============================================================================
-- Snacks — Pickers & Explorer
-- ============================================================================
keymap.set("n", "<leader><space>", function() Snacks.picker.smart() end, { desc = "Smart Find Files" })
keymap.set("n", "<leader>,", function() Snacks.picker.buffers() end, { desc = "Buffers" })
keymap.set("n", "<leader>/", function() Snacks.picker.grep() end, { desc = "Grep" })
keymap.set("n", "<leader>:", function() Snacks.picker.command_history() end, { desc = "Command History" })
keymap.set("n", "<leader>e", function() Snacks.explorer() end, { desc = "File Explorer" })

-- find
keymap.set("n", "<leader>fb", function() Snacks.picker.buffers() end, { desc = "Buffers" })
keymap.set("n", "<leader>fc", function() Snacks.picker.files({ cwd = vim.fn.stdpath("config") }) end,
    { desc = "Find Config File" })
keymap.set("n", "<leader>ff", function() Snacks.picker.files() end, { desc = "Find Files" })
keymap.set("n", "<leader>fg", function() Snacks.picker.git_files() end, { desc = "Find Git Files" })
keymap.set("n", "<leader>fp", function() Snacks.picker.projects() end, { desc = "Projects" })
keymap.set("n", "<leader>fr", function() Snacks.picker.recent() end, { desc = "Recent" })

-- git
keymap.set("n", "<leader>gb", function() Snacks.picker.git_branches() end, { desc = "Git Branches" })
keymap.set("n", "<leader>gl", function() Snacks.picker.git_log() end, { desc = "Git Log" })
keymap.set("n", "<leader>gL", function() Snacks.picker.git_log_line() end, { desc = "Git Log Line" })
keymap.set("n", "<leader>gs", function() Snacks.picker.git_status() end, { desc = "Git Status" })
keymap.set("n", "<leader>gS", function() Snacks.picker.git_stash() end, { desc = "Git Stash" })
keymap.set("n", "<leader>gd", function() Snacks.picker.git_diff() end, { desc = "Git Diff (Hunks)" })
keymap.set("n", "<leader>gf", function() Snacks.picker.git_log_file() end, { desc = "Git Log File" })
keymap.set("n", "<leader>gi", function() Snacks.picker.gh_issue() end, { desc = "GitHub Issues (open)" })
keymap.set("n", "<leader>gI", function() Snacks.picker.gh_issue({ state = "all" }) end, { desc = "GitHub Issues (all)" })
keymap.set("n", "<leader>gp", function() Snacks.picker.gh_pr() end, { desc = "GitHub Pull Requests (open)" })
keymap.set("n", "<leader>gP", function() Snacks.picker.gh_pr({ state = "all" }) end,
    { desc = "GitHub Pull Requests (all)" })

-- grep / search
keymap.set("n", "<leader>sb", function() Snacks.picker.lines() end, { desc = "Buffer Lines" })
keymap.set("n", "<leader>sB", function() Snacks.picker.grep_buffers() end, { desc = "Grep Open Buffers" })
keymap.set("n", "<leader>sg", function() Snacks.picker.grep() end, { desc = "Grep" })
keymap.set({ "n", "x" }, "<leader>sw", function() Snacks.picker.grep_word() end, { desc = "Visual selection or word" })
keymap.set("n", '<leader>s"', function() Snacks.picker.registers() end, { desc = "Registers" })
keymap.set("n", '<leader>s/', function() Snacks.picker.search_history() end, { desc = "Search History" })
keymap.set("n", "<leader>sa", function() Snacks.picker.autocmds() end, { desc = "Autocmds" })
keymap.set("n", "<leader>sc", function() Snacks.picker.command_history() end, { desc = "Command History" })
keymap.set("n", "<leader>sC", function() Snacks.picker.commands() end, { desc = "Commands" })
keymap.set("n", "<leader>sd", function() Snacks.picker.diagnostics() end, { desc = "Diagnostics" })
keymap.set("n", "<leader>sD", function() Snacks.picker.diagnostics_buffer() end, { desc = "Buffer Diagnostics" })
keymap.set("n", "<leader>sh", function() Snacks.picker.help() end, { desc = "Help Pages" })
keymap.set("n", "<leader>sH", function() Snacks.picker.highlights() end, { desc = "Highlights" })
keymap.set("n", "<leader>si", function() Snacks.picker.icons() end, { desc = "Icons" })
keymap.set("n", "<leader>sj", function() Snacks.picker.jumps() end, { desc = "Jumps" })
keymap.set("n", "<leader>sk", function() Snacks.picker.keymaps() end, { desc = "Keymaps" })
keymap.set("n", "<leader>sl", function() Snacks.picker.loclist() end, { desc = "Location List" })
keymap.set("n", "<leader>sm", function() Snacks.picker.marks() end, { desc = "Marks" })
keymap.set("n", "<leader>sM", function() Snacks.picker.man() end, { desc = "Man Pages" })
keymap.set("n", "<leader>sp", function() Snacks.picker.lazy() end, { desc = "Search for Plugin Spec" })
keymap.set("n", "<leader>sq", function() Snacks.picker.qflist() end, { desc = "Quickfix List" })
keymap.set("n", "<leader>sR", function() Snacks.picker.resume() end, { desc = "Resume" })
keymap.set("n", "<leader>su", function() Snacks.picker.undo() end, { desc = "Undo History" })
keymap.set("n", "<leader>uC", function() Snacks.picker.colorschemes() end, { desc = "Colorschemes" })

-- LSP (via Snacks pickers)
keymap.set("n", "gd", function() Snacks.picker.lsp_definitions() end, { desc = "Goto Definition" })
keymap.set("n", "gD", function() Snacks.picker.lsp_declarations() end, { desc = "Goto Declaration" })
keymap.set("n", "gr", function() Snacks.picker.lsp_references() end, { nowait = true, desc = "References" })
keymap.set("n", "gI", function() Snacks.picker.lsp_implementations() end, { desc = "Goto Implementation" })
keymap.set("n", "gy", function() Snacks.picker.lsp_type_definitions() end, { desc = "Goto T[y]pe Definition" })
keymap.set("n", "gai", function() Snacks.picker.lsp_incoming_calls() end, { desc = "C[a]lls Incoming" })
keymap.set("n", "gao", function() Snacks.picker.lsp_outgoing_calls() end, { desc = "C[a]lls Outgoing" })
keymap.set("n", "<leader>ss", function() Snacks.picker.lsp_symbols() end, { desc = "LSP Symbols" })
keymap.set("n", "<leader>sS", function() Snacks.picker.lsp_workspace_symbols() end, { desc = "LSP Workspace Symbols" })

-- Snacks — misc
keymap.set("n", "<leader>z", function() Snacks.zen() end, { desc = "Toggle Zen Mode" })
keymap.set("n", "<leader>Z", function() Snacks.zen.zoom() end, { desc = "Toggle Zoom" })
keymap.set("n", "<leader>.", function() Snacks.scratch() end, { desc = "Toggle Scratch Buffer" })
keymap.set("n", "<leader>S", function() Snacks.scratch.select() end, { desc = "Select Scratch Buffer" })
keymap.set("n", "<leader>n", function() Snacks.notifier.show_history() end, { desc = "Notification History" })
keymap.set("n", "<leader>bd", function() Snacks.bufdelete() end, { desc = "Delete Buffer" })
keymap.set("n", "<leader>cR", function() Snacks.rename.rename_file() end, { desc = "Rename File" })
keymap.set({ "n", "v" }, "<leader>gB", function() Snacks.gitbrowse() end, { desc = "Git Browse" })
keymap.set("n", "<leader>gg", function() Snacks.lazygit() end, { desc = "Lazygit" })
keymap.set("n", "<leader>un", function() Snacks.notifier.hide() end, { desc = "Dismiss All Notifications" })
keymap.set("n", "<c-/>", function() Snacks.terminal() end, { desc = "Toggle Terminal" })
keymap.set("n", "<c-_>", function() Snacks.terminal() end, { desc = "which_key_ignore" })
keymap.set("n", "<leader>cc", function() Snacks.terminal("claude", { win = { position = "right" } }) end,
    { desc = "Toggle Claude Terminal" })
keymap.set({ "n", "t" }, "]]", function() Snacks.words.jump(vim.v.count1) end, { desc = "Next Reference" })
keymap.set({ "n", "t" }, "[[", function() Snacks.words.jump(-vim.v.count1) end, { desc = "Prev Reference" })
keymap.set("n", "<leader>N", function()
    Snacks.win({
        file = vim.api.nvim_get_runtime_file("doc/news.txt", false)[1],
        width = 0.6,
        height = 0.6,
        wo = {
            spell = false,
            wrap = false,
            signcolumn = "yes",
            statuscolumn = " ",
            conceallevel = 3,
        },
    })
end, { desc = "Neovim News" })
