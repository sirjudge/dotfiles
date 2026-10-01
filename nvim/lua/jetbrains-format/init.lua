-- jetbrains-format: run ReSharper CleanupCode on current buffer's file
-- https://www.jetbrains.com/help/resharper/CleanupCode.html

local M = {}

M.config = {
  -- path to CleanupCode.exe (ReSharper Command Line Tools), or "jb" if using
  -- the `JetBrains.ReSharper.GlobalTools` dotnet global tool
  executable = nil,

  -- if true, invoke as `<executable> cleanupcode ...` (dotnet global tool form)
  dotnet_tool = false,

  -- path to .sln/.csproj to run against. If nil, nearest *.sln above the
  -- current file is searched for and used automatically.
  solution = nil,

  -- optional cleanup profile name (--profile=)
  profile = nil,

  -- extra raw args appended to the command
  extra_args = {},
}

function M.setup(opts)
  M.config = vim.tbl_deep_extend("force", M.config, opts or {})
end

local function find_solution(start_dir)
  local found = vim.fs.find(function(name)
    return name:match("%.sln$") ~= nil
  end, { path = start_dir, upward = true, type = "file", limit = 1 })
  return found[1]
end

local function sanitize_slashes_in_path(path)
  return (path:gsub("\\", "/"))
end

local function relative_path(filepath, solution)
  local base = sanitize_slashes_in_path(vim.fn.fnamemodify(solution, ":p:h")) .. "/"
  local full = sanitize_slashes_in_path(vim.fn.fnamemodify(filepath, ":p"))
  if full:sub(1, #base):lower() == base:lower() then
    return full:sub(#base + 1)
  end
  return nil
end

local function build_cmd(filepath)
  if not M.config.executable or M.config.executable == "" then
    error("jetbrains-format: config.executable not set (path to CleanupCode.exe, or \"jb\")")
  end

  local solution = M.config.solution or find_solution(vim.fn.fnamemodify(filepath, ":h"))
  if not solution then
    error("jetbrains-format: no solution configured and none found searching upward from file")
  end

  local include = relative_path(filepath, solution)
  if not include then
    error("jetbrains-format: file is not under the solution directory (" .. solution .. ")")
  end

  local cmd = { M.config.executable }
  if M.config.dotnet_tool then
    table.insert(cmd, "cleanupcode")
  end
  table.insert(cmd, solution)
  table.insert(cmd, "--include=" .. include)

  if M.config.profile and M.config.profile ~= "" then
    table.insert(cmd, "--profile=" .. M.config.profile)
  end

  for _, arg in ipairs(M.config.extra_args) do
    table.insert(cmd, arg)
  end

  return cmd
end

function M.format_buffer(bufnr)
  bufnr = bufnr or 0
  if bufnr == 0 then
    bufnr = vim.api.nvim_get_current_buf()
  end

  local filepath = vim.api.nvim_buf_get_name(bufnr)
  if filepath == "" then
    vim.notify("jetbrains-format: buffer has no file name", vim.log.levels.ERROR)
    return
  end

  -- CleanupCode reads from disk, so persist unsaved edits first
  if vim.api.nvim_buf_get_option(bufnr, "modified") then
    vim.api.nvim_buf_call(bufnr, function()
      vim.cmd("silent write")
    end)
  end

  -- run jetbrains command
  local ok, cmd = pcall(build_cmd, filepath)
  if not ok then
    vim.notify(cmd, vim.log.levels.ERROR)
    return
  end

  vim.notify("jetbrains-format: running cleanup on " .. vim.fn.fnamemodify(filepath, ":t") .. "...")

  vim.system(cmd, { text = true }, function(result)
    vim.schedule(function()
      if result.code ~= 0 then
        local msg = result.stderr ~= "" and result.stderr or result.stdout
        vim.notify("jetbrains-format failed (exit " .. result.code .. "):\n" .. msg, vim.log.levels.ERROR)
        return
      end

      if vim.api.nvim_buf_is_valid(bufnr) then
        vim.api.nvim_buf_call(bufnr, function()
          vim.cmd("checktime")
        end)
      end
      vim.notify("jetbrains-format: cleaned up " .. vim.fn.fnamemodify(filepath, ":t"))
    end)
  end)
end

return M
