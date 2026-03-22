function ToggleLineNumbers()
    if vim.wo.relativenumber then
        vim.wo.number = true
        vim.wo.relativenumber = false
    else
        vim.wo.number = false
        vim.wo.relativenumber = true
    end
end

function IsReactNativeProj()
  local root = vim.fn.getcwd()

  -- Check if node_modules/react-native exists
  local rn_path = root .. "/node_modules/react-native"
  if vim.fn.isdirectory(rn_path) == 1 then
    return true
  end

  -- Check if package.json mentions react-native
  local pkg = root .. "/package.json"
  if vim.fn.filereadable(pkg) == 1 then
    local lines = vim.fn.readfile(pkg)
    for _, line in ipairs(lines) do
      if line:match('"react%-native"') then
        return true
      end
    end
  end

  return false
end

function ToggleNativeFile()
  local current_file = vim.api.nvim_buf_get_name(0)
  if current_file == "" then
    vim.api.nvim_err_writeln("No file is currently open")
    return
  end

  local dir = vim.fn.fnamemodify(current_file, ":h")
  local filename = vim.fn.fnamemodify(current_file, ":t")
  local ext = filename:match("^.+(%..+)$")
  local is_native = filename:find("%.native" .. ext .. "$")

  if not ext then
    vim.api.nvim_err_writeln("Could not determine file extension")
    return
  end

  local target_filename
  if is_native then
    -- We're in a native file, remove `.native` to go to base version
    target_filename = filename:gsub("%.native" .. ext .. "$", ext)
  else
    -- We're in base version, add `.native` before extension
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
