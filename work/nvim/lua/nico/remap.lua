vim.g.mapleader = " "
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

-- neo-test suite
vim.keymap.set("n", "<leader>t", ":TestNearest<CR>")
vim.keymap.set("n", "<leader>T", ":TestFile<CR>")
vim.keymap.set("n", "<leader>a", ":TestSuite<CR>")
vim.keymap.set("n", "<leader>l", ":TestLast<CR>")
vim.keymap.set("n", "<leader>g", ":TestVisit<CR>")

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

--when pasting over something else don't put the highlted something else in the register
vim.keymap.set("x", "<leader>p", [["_dP]])

-- next greatest remap ever : asbjornHaland
-- when in normal visual mode, leader + y copies into system clipboard
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])

-- set ctrl+c to escape
vim.keymap.set("i", "<C-c>", "<Esc>")

-- unbind the holy hell that is capital Q
vim.keymap.set("n", "Q", "<nop>")

-- do good indentation using lsp
vim.keymap.set("n", "<leader>f", vim.lsp.buf.format)

-- quick fix naviagtation
vim.keymap.set("n", "<C-k>", "<cmd>cnext<CR>zz")
vim.keymap.set("n", "<C-j>", "<cmd>cprev<CR>zz")
vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz")
vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz")

-- replace the currently highlited word
vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })
vim.keymap.set("n", "<leader>vpp", "<cmd>e ~/.dotfiles/nvim/.config/nvim/lua/theprimeagen/packer.lua<CR>");
vim.keymap.set("n", "<leader>mr", "<cmd>CellularAutomaton make_it_rain<CR>");
vim.keymap.set("n", "<leader><leader>", function()
    vim.cmd("so")
end)
