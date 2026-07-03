local M = {}

function M.is_react_native_project()
    local root = vim.fn.getcwd()

    if vim.fn.isdirectory(root .. "/node_modules/react-native") == 1 then
        return true
    end

    local pkg = root .. "/package.json"
    if vim.fn.filereadable(pkg) == 1 then
        for _, line in ipairs(vim.fn.readfile(pkg)) do
            if line:match('"react%-native"') then
                return true
            end
        end
    end

    return false
end

function M.toggle_native_file()
    local current_file = vim.api.nvim_buf_get_name(0)
    if current_file == "" then
        vim.api.nvim_err_writeln("No file is currently open")
        return
    end

    local dir = vim.fn.fnamemodify(current_file, ":h")
    local filename = vim.fn.fnamemodify(current_file, ":t")
    local ext = filename:match("^.+(%..+)$")

    if not ext then
        vim.api.nvim_err_writeln("Could not determine file extension")
        return
    end

    local is_native = filename:find("%.native" .. ext .. "$")
    local target_filename
    if is_native then
        target_filename = filename:gsub("%.native" .. ext .. "$", ext)
    else
        local basename = vim.fn.fnamemodify(filename, ":r")
        target_filename = basename .. ".native" .. ext
    end

    local target_filepath = dir .. "/" .. target_filename

    if vim.fn.filereadable(target_filepath) == 1 then
        vim.cmd("edit " .. vim.fn.fnameescape(target_filepath))
    else
        vim.api.nvim_err_writeln("Alternate file not found: " .. target_filepath)
    end
end

function M.toggle_test_file()
    local current_file = vim.api.nvim_buf_get_name(0)
    if current_file == "" then
        vim.api.nvim_err_writeln("No file is currently open")
        return
    end

    local dir = vim.fn.fnamemodify(current_file, ":h")
    local filename = vim.fn.fnamemodify(current_file, ":t")

    local function try_open(path)
        if vim.fn.filereadable(path) == 1 then
            vim.cmd("edit " .. vim.fn.fnameescape(path))
            return true
        end
        return false
    end

    -- TS/JS: foo.test.ts / foo.spec.ts
    local base, ext = filename:match("^(.+)%.(tsx?|jsx?|[a-z]+)$")
    if not base then
        base = vim.fn.fnamemodify(filename, ":r")
        ext = vim.fn.fnamemodify(filename, ":e")
    end

    -- On a test/spec file → go to source
    local stripped = base:match("^(.+)%.test$") or base:match("^(.+)%.spec$")
    if stripped then
        return try_open(dir .. "/" .. stripped .. "." .. ext)
            or vim.api.nvim_err_writeln("Source file not found")
    end

    -- Go / Python suffix: foo_test.go, foo_test.py
    local go_stripped = base:match("^(.+)_test$")
    if go_stripped then
        return try_open(dir .. "/" .. go_stripped .. "." .. ext)
            or vim.api.nvim_err_writeln("Source file not found")
    end

    -- Python prefix: test_foo.py
    local py_stripped = base:match("^test_(.+)$")
    if py_stripped then
        return try_open(dir .. "/" .. py_stripped .. "." .. ext)
            or vim.api.nvim_err_writeln("Source file not found")
    end

    -- On a source file → look for test counterpart
    local candidates = {
        dir .. "/" .. base .. ".test." .. ext,
        dir .. "/" .. base .. ".spec." .. ext,
        dir .. "/" .. base .. "_test." .. ext,
        dir .. "/test_" .. base .. "." .. ext,
        -- one level up in __tests__ / tests dirs
        dir .. "/__tests__/" .. base .. ".test." .. ext,
        dir .. "/__tests__/" .. base .. ".spec." .. ext,
        dir .. "/../tests/test_" .. base .. "." .. ext,
    }

    for _, path in ipairs(candidates) do
        if try_open(path) then return end
    end

    vim.api.nvim_err_writeln("No test file found for: " .. filename)
end

function M.run_test_file()
    local current_file = vim.api.nvim_buf_get_name(0)
    if current_file == "" then
        vim.api.nvim_err_writeln("No file is currently open")
        return
    end

    local ext = vim.fn.fnamemodify(current_file, ":e")
    if ext ~= "ts" and ext ~= "tsx" and ext ~= "js" and ext ~= "jsx" then
        vim.api.nvim_err_writeln("run_test_file only supports TypeScript/JavaScript files")
        return
    end

    local file_dir = vim.fn.fnamemodify(current_file, ":h")
    local root = vim.fn.system(
        "git -C " .. vim.fn.shellescape(file_dir) .. " rev-parse --show-toplevel 2>/dev/null"
    ):gsub("%s+$", "")
    if root == "" then root = vim.fn.getcwd() end

    local pkg_path = root .. "/package.json"
    if vim.fn.filereadable(pkg_path) == 0 then
        vim.api.nvim_err_writeln("No package.json found at: " .. pkg_path)
        return
    end

    local content = table.concat(vim.fn.readfile(pkg_path), "\n")
    local ok, pkg = pcall(vim.json.decode, content)
    if not ok or type(pkg.scripts) ~= "table" then
        vim.api.nvim_err_writeln("Could not parse package.json scripts")
        return
    end

    local test_scripts = {}
    for name, cmd in pairs(pkg.scripts) do
        if name:match("test") then
            table.insert(test_scripts, { name = name, cmd = cmd })
        end
    end
    table.sort(test_scripts, function(a, b) return a.name < b.name end)

    if #test_scripts == 0 then
        vim.api.nvim_err_writeln("No test scripts found in package.json")
        return
    end

    local runner
    if vim.fn.filereadable(root .. "/bun.lockb") == 1 then
        runner = "bun"
    elseif vim.fn.filereadable(root .. "/yarn.lock") == 1 then
        runner = "yarn"
    elseif vim.fn.filereadable(root .. "/pnpm-lock.yaml") == 1 then
        runner = "pnpm"
    else
        runner = "npm"
    end

    local rel_path = vim.fn.fnamemodify(current_file, ":.")

    vim.ui.select(test_scripts, {
        prompt = "Run test script:",
        format_item = function(item)
            return item.name .. "  →  " .. item.cmd
        end,
    }, function(choice)
        if not choice then return end
        local default = runner .. " run " .. choice.name .. " " .. rel_path
        vim.ui.input({ prompt = "Command: ", default = default }, function(cmd)
            if not cmd or cmd == "" then return end
            Snacks.terminal(cmd, { cwd = root, win = { position = "bottom" } })
        end)
    end)
end

return M
