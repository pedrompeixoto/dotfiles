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

return M
