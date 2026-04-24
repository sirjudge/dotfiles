-- Ensure the config directory is in the runtime path
vim.opt.runtimepath:prepend(vim.fn.stdpath("config"))

-- Things we can skip loading to speed
-- up profile start time
vim.g.loaded_netrwPlugin = 1 -- 59ms
vim.g.loaded_tohtml = 1 -- 35ms
vim.g.loaded_tutor = 1 -- 21ms
vim.g.loaded_zipPlugin = 1 -- 22ms
vim.g.loaded_tarPlugin = 1 -- 22ms
vim.g.loaded_rplugin = 1 -- 27ms
vim.g.loaded_spellfile = 1 -- 20ms
vim.g.loaded_gzip = 1

if vim.fn.has("win32") == 1 then
	vim.opt.shell = "pwsh"
	vim.opt.shellcmdflag = "-NoLogo -NoProfile -ExecutionPolicy RemoteSigned -Command"
	vim.opt.shellquote = ""
	vim.opt.shellxquote = ""
end

require("config")

vim.cmd([[colorscheme laserwave]])
