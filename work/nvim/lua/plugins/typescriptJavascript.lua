return {
	"pmizio/typescript-tools.nvim",
    event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		"nvim-lua/plenary.nvim",
		"neovim/nvim-lspconfig",
	},
	opts = {
		settings = {
			separate_diagnostic_server = true,
			publish_diagnostic_on = "insert_leave",
			expose_as_code_action = {
				"fix_all",
				"add_missing_imports",
				"remove_unused",
			},
			tsserver_plugins = {
				"@styled/typescript-styled-plugin",
			},
			tsserver_max_memory = "auto",
			complete_function_calls = true,
			include_completions_with_insert_text = true,
			-- CodeLens
			-- WARNING: Experimental feature also in VSCode, because it might hit performance of server.
			-- possible values: ("off"|"all"|"implementations_only"|"references_only")
			code_lens = "off",
			-- by default code lenses are displayed on all referencable values and for some of you it can
			-- be too much this option reduce count of them by removing member references from lenses
			disable_member_code_lens = true,
			-- tsserver_file_preferences = function(ft)
			-- 	-- Some "ifology" using `ft` of opened file
			-- 	return {
			-- 		includeInlayParameterNameHints = "all",
			-- 		includeCompletionsForModuleExports = true,
			-- 		quotePreference = "auto",
			-- 	}
			-- end,
			-- tsserver_format_options = function(ft)
			-- 	-- Some "ifology" using `ft` of opened file
			-- 	return {
			-- 		allowIncompleteCompletions = false,
			-- 		allowRenameOfImportPath = false,
			-- 	}
			-- end,
		},
	},
	config = function()
		require("typescript-tools").setup()
	end,
}
