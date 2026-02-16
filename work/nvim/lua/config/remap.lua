-- move highlited text up and down
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- append current line to above line and keep cursor at beginning of thel ine
vim.keymap.set("n", "J", "mzJ`z")

-- control up and down to keep cursor in the same place
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

-- search terms are in the middle of the screen
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

--TODO: shift + P does this same thing. This currently conflicts with 
-- my snacks.picker()
--when pasting over something else don't put the highlted something else in the register
-- vim.keymap.set("x", "<leader>p", [["_dP]])

-- when in normal visual mode, leader + y copies into system clipboard
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])

-- set ctrl+c to escape
vim.keymap.set("i", "<C-c>", "<Esc>")

-- unbind the holy hell that is capital Q
vim.keymap.set("n", "Q", "<nop>")

-- quick fix naviagtation
vim.keymap.set("n", "<C-k>", "<cmd>cnext<CR>zz")
vim.keymap.set("n", "<C-j>", "<cmd>cprev<CR>zz")
vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz")
vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz")

-- TODO: Conflicts with session keybinds which I use more than this.
-- This functionality is replaced with <leader>rn to rename using LSP magic
-- replace the currently highlited word
-- vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

-- TODO:Need to eventually add a check for if I'm on windows or linux
-- and use tmux vs wezterm accordingly
-- remap tmux things
vim.keymap.set("n", "<C-h>", "<cmd>lua require('tmux').move_left()<CR>")
vim.keymap.set("n", "<C-j>", "<cmd>lua require('tmux').move_bottom()<CR>")
vim.keymap.set("n", "<C-k>", "<cmd>lua require('tmux').move_top()<CR>")
vim.keymap.set("n", "<C-l>", "<cmd>lua require('tmux').move_right()<CR>")
vim.keymap.set("n", "<C-\\>", "<cmd>lua require('tmux').toggle_zoom()<CR>")
