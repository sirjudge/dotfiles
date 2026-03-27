return {
	{
		"olimorris/codecompanion.nvim",
		event = { "BufReadPre", "BufNewFile" },
		keys = {
			{
				"<leader>caa",
				"<cmd>CodeCompanionActions<CR>",
				desc = "CodeCompanion Actions",
			},
			{
				"<leader>cac",
				"<cmd>CodeCompanionChat<CR>",
				desc = "CodeCompanion Chat",
			},
			{
				"<leader>caf",
				"<cmd>CodeCompanion /fix<CR>",
				desc = "CodeCompanion Chat",
			},
			{
				"<leader>cat",
				"<cmd>CodeCompanion /test<CR>",
				desc = "CodeCompanion Chat",
			},
		},
		dependencies = {
			"dyamon/codecompanion-copilot-enterprise.nvim",
			"nvim-lua/plenary.nvim",
			"nvim-treesitter/nvim-treesitter",
		},
		opts = {
			adapters = {
				http = {
					copilot_enterprise = function()
						local adapter = require("codecompanion.adapters.http.copilot_enterprise")
						adapter.opts.provider_url = "ntracts-inc.ghe.com" -- 'https://' can be removed but doesn't hurt.
						return adapter
					end,
				},
			},
			interactions = {
				chat = {
					adapter = {
						name = "copilot_enterprise",
						model = "claude-opus-4-6",
					},
					opts = {
						completion_provider = "blink",
						proxy = "https://ntracts-inc.ghe.com/",
					},
				},
				inline = { adapter = "copilot_enterprise" },
				cmd = { adapter = "copilot_enterprise" },
			},
			opts = {
				log_level = "DEBUG", -- or "TRACE"
			},
		},
	},
}
