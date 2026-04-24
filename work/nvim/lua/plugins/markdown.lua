return {
	"MeanderingProgrammer/render-markdown.nvim",
	ft = { "markdown" },
	dependencies = { "nvim-treesitter/nvim-treesitter", "echasnovski/mini.nvim" },
	opts = {},
	config = function()
		require("render-markdown").setup({
			completions = {
				blink = { enabled = true },
			},
			latex = { enabled = false },
			html = { enabled = false },
			yaml = { enabled = false },
		})
	end,
}
