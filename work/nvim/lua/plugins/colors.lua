return {
	{
		"lettertwo/laserwave.nvim",
		lazy = false,
		priority = 1000,
	},
	{
		"rose-pine/neovim",
		lazy = false,
		priority = 1000,
	},
	{
		"folke/tokyonight.nvim",
		lazy = false,
		priority = 1000,
	},
	{
		"catppuccin/nvim",
		name = "catppuccin",
		opts = {
			integrations = {
				aerial = true,
				alpha = true,
				cmp = true,
				dashboard = true,
				flash = true,
				fzf = true,
				grug_far = true,
				gitsigns = true,
				headlines = true,
				illuminate = true,
				indent_blankline = { enabled = true },
				leap = true,
				lsp_trouble = true,
				mason = true,
				mini = true,
				navic = { enabled = true, custom_bg = "lualine" },
				neotest = true,
				neotree = true,
				noice = true,
				notify = true,
				snacks = true,
				telescope = true,
				treesitter_context = true,
				which_key = true,
			},
		},
	},
	{
		"folke/tokyonight.nvim",
		lazy = false,
		priority = 1000,
	},
	{
		"nyoom-engineering/oxocarbon.nvim",
		lazy = false,
		priority = 1000,
	},
	{
		"comfysage/cuddlefish.nvim",
		lazy = false,
		priority = 1000,
		config = function()
			require("cuddlefish").setup({
				theme = {
					accent = "pink",
				},
				editor = {
					transparent_background = false,
				},
				style = {
					tabline = { "reverse" },
					search = { "italic", "reverse" },
					incsearch = { "italic", "reverse" },
					types = { "italic" },
					keyword = { "italic" },
					comment = { "italic" },
				},
                lsp_styles = {
                    underlines = {
                        errors = { "undercurl" },
                        hints = { "undercurl" },
                        warnings = { "undercurl" },
                        information = { "undercurl" },
                    },
                },
                overrides = function(colors)
					return {}
				end,
			})

		end,
	},
}
