-- Ensure the config directory is in the runtime path
vim.opt.runtimepath:prepend(vim.fn.stdpath("config"))

require("config")
