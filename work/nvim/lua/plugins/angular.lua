return {
	"joeveiga/ng.nvim",
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		local ngNvim = require("ng")
		vim.keymap.set(
			"n",
			"<leader>at",
			ngNvim.goto_template_for_component,
			{ noremap = true, silent = true, desc = "Go to Angular Component Template" }
		)
		vim.keymap.set(
			"n",
			"<leader>ac",
			ngNvim.goto_component_with_template_file,
			{ noremap = true, silent = true, desc = "go to component with template file" }
		)
		vim.keymap.set(
			"n",
			"<leader>aT",
			ngNvim.get_template_tcb,
			{ noremap = true, silent = true, desc = "get angular template" }
		)
	end,
}
