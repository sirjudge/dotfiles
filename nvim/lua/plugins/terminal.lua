return {
	{
		"akinsho/toggleterm.nvim",
		version = "*",
		keys = {
			{
				"<leader>tb",
				"<cmd>:ToggleTerm direction=horizontal size=20 border=curved<CR>",
				desc = "Toggle terminal bottom",
			},
			-- {
			-- 	"<leader>ts",
			-- 	"<cmd>:ToggleTerm direction=vertical size=20 border=curved<CR>",
			-- 	desc = "Toggle terminal side",
			-- },
			-- {
			-- 	"<leader>tf",
			-- 	"<cmd>:ToggleTerm direction=float size=20 border=curved<CR>",
			-- 	desc = "Toggle terminal side",
			-- },
		},
		opts = {
			close_on_exit = false,
			start_in_insert = false,
			insert_mappings = true,
			hide_numbers = true,
			persist_mode = true,
			size = 30,
			border = "curved",
		},
		config = function()
			require("toggleterm").setup({})
			local opts = { buffer = 0 }
			vim.keymap.set("t", "<C-c>", [[<C-\><C-n>]], opts)
			vim.keymap.set("t", "<C-h>", [[<Cmd>wincmd h<CR>]], opts)
			vim.keymap.set("t", "<C-j>", [[<Cmd>wincmd j<CR>]], opts)
			vim.keymap.set("t", "<C-k>", [[<Cmd>wincmd k<CR>]], opts)
			vim.keymap.set("t", "<C-l>", [[<Cmd>wincmd l<CR>]], opts)
			vim.keymap.set("t", "<C-w>", [[<C-\><C-n><C-w>]], opts)
		end,
	},
}
