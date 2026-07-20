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

return M
