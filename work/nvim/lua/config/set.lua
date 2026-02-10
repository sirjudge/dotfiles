-- turn on line and relative line numbers
vim.wo.relativenumber = true
vim.wo.number = true

-- edgy.nvim recommended settings
-- views can only be fully collapsed with the global statusline
vim.opt.laststatus = 3

-- Default splitting will cause your main splits to jump when opening an edgebar.
-- To prevent this, set `splitkeep` to either `screen` or `topline`.
vim.opt.splitkeep = "screen"

vim.opt.guicursor = ""
vim.opt.nu = true

-- set tabs to spaces and 4 spaces per tab
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.smartindent = true

-- stop wrapping don't like
vim.opt.wrap = false

-- don't use a swapfile, too slow
vim.opt.swapfile = false

-- git is my backup, don't need
vim.opt.backup = false

-- set undo file to get better support for undo history
local undodir = vim.fn.expand("~/.vim/undodir")
vim.opt.undodir = undodir
vim.opt.undofile = true

-- better search options
vim.opt.hlsearch = false
vim.opt.incsearch = true

-- misc settings for better experience
vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")
vim.opt.updatetime = 50
vim.opt.colorcolumn = "80"

-- set terminal emulator based on OS
local is_windows = vim.fn.has("win32") == 1 or vim.fn.has("win64") == 1
local terminal_emulator = is_windows and "powershell" or "zsh"
vim.g.terminal_emulator = terminal_emulator
vim.api.nvim_set_var("terminal_emulator", terminal_emulator)

-- enable better color support
vim.o.termguicolors = true
