return {
	"GustavEikaas/easy-dotnet.nvim",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		"nvim-lua/plenary.nvim",
		"mfussenegger/nvim-dap",
		"folke/snacks.nvim",
	},
	keys = {
		{ "<leader>q", nil, desc = "load dotnet" },
		{ "<leader>qr", "<cmd>lua require('easy-dotnet').run()<CR>", desc = "run" },
		{ "<leader>qd", "<cmd>lua require('easy-dotnet').debug_profile_default()<CR>", desc = "debug (profile)" },
		{ "<leader>qt", "<cmd>lua require('easy-dotnet').test()<CR>", desc = "test" },
		{ "<leader>qc", "<cmd>lua require('easy-dotnet').clean()<CR>", desc = "clean" },
		{ "<leader>qb", "<cmd>lua require('easy-dotnet').build()<CR>", desc = "build" },
		{ "<leader>qs", "<cmd>lua require('easy-dotnet').secrets()<CR>", desc = "secrets" },
		{ "<leader>qe", "<cmd>lua require('easy-dotnet').expand()<CR>", desc = "expand" },
		{ "<leader>qE", "<cmd>lua require('easy-dotnet').new()<CR>", desc = "expand node" },
		{ "<leader>qE", "<cmd>lua require('easy-dotnet').collapse_all()<CR>", desc = "collapse all" },
		{ "<leader>qf", "<cmd>lua require('easy-dotnet').filter_failed_tests()<CR>", desc = "filter failed tests" },
		{ "<leader>qpa", "<cmd>lua require('easy-dotnet').add_package()<CR>", desc = "add package" },
		{ "<leader>qpr", "<cmd>lua require('easy-dotnet').add_package()<CR>", desc = "remove package" },
		{ "<leader>qpa", "<cmd>lua require('easy-dotnet').add_package()<CR>", desc = "add package" },
		{
			"<leader>qc",
			function()
				vim.lsp.codelens.run()
			end,
			desc = "CodeLens",
		},
	},
	config = function()
		-- Workaround for Roslyn LSP bug: Neovim can send semanticTokens/range
		-- requests with an end line equal to the line count, causing
		-- ArgumentOutOfRangeException in Roslyn's SemanticTokensHelpers.
		-- Disabling semantic tokens here is safe — treesitter handles highlighting.
		vim.api.nvim_create_autocmd("LspAttach", {
			callback = function(args)
				local client = vim.lsp.get_client_by_id(args.data.client_id)
				if client and client.name == "easy_dotnet" then
					client.server_capabilities.semanticTokensProvider = nil
				end
			end,
		})

		local default_log_handler = vim.lsp.handlers["window/logMessage"]
		vim.lsp.handlers["window/logMessage"] = function(err, result, ctx, config)
			-- remove noise from info messages
			if
				result
				and result.type == vim.lsp.protocol.MessageType.Info
				and result.message
				and result.message:find("DotnetCliHelper", 1, true)
				and result.message:find("Using dotnet executable configured on the PATH", 1, true)
				and result.message:find("Restoring Canonical.cs", 1, true)
			then
				return
			end
			-- remove noise from code lens warnings
			if
				result
				and result.type == vim.lsp.protocol.MessageType.Warning
				and result.message
				and result.message:find("Canonical.csproj has unresolved dependencies", 1, true)
			then
				return
			end

			return default_log_handler(err, result, ctx, config)
		end

		-- easy-dotnet injects EasyDotnet.StartupHook.dll (a Release build) into every
		-- debugged process. With justMyCode=true (the netcoredbg default) the debugger
		-- warns about every Release assembly it encounters, producing noise. Patching
		-- all registered C# configs to justMyCode=false suppresses that at the source.
		vim.api.nvim_create_autocmd("FileType", {
			pattern = { "cs", "fsharp" },
			once = true,
			callback = function()
				vim.schedule(function()
					local dap = require("dap")
					for _, ft_configs in pairs({ dap.configurations.cs, dap.configurations.fsharp }) do
						if ft_configs then
							for _, config in ipairs(ft_configs) do
								config.justMyCode = false
							end
						end
					end
				end)
			end,
		})

		local dotnet = require("easy-dotnet")
		dotnet.setup({
			lsp = {
				enabled = true, -- Enable builtin roslyn lsp
				preload_roslyn = true, -- Only start roslyn when a .cs buffer is opened
				roslynator_enabled = true, -- Automatically enable roslynator analyzer
				easy_dotnet_analyzer_enabled = true, -- Enable roslyn analyzer from easy-dotnet-server
				auto_refresh_codelens = false,
				analyzer_assemblies = {}, -- Any additional roslyn analyzers you might use like SonarAnalyzer.CSharp
				config = {
					["csharp|inlay_hints"] = {
						csharp_enable_inlay_hints_for_implicit_object_creation = true,
						csharp_enable_inlay_hints_for_implicit_variable_types = true,
					},
					["csharp|code_lens"] = {
						dotnet_enable_references_code_lens = true,
					},
					["csharp|formatting"] = {
						dotnet_organize_imports_on_format = true,
					},
				},
			},
			-- https://github.com/GustavEikaas/easy-dotnet.nvim/blob/main/docs/debugging.md
			debugger = {
				-- Path to custom coreclr DAP adapter
				-- easy-dotnet-server falls back to its own netcoredbg binary if bin_path is nil
				bin_path = nil,
                console = "integratedTerminal",
				apply_value_converters = true,
				auto_register_dap = true,
				mappings = {
					open_variable_viewer = { lhs = "T", desc = "open variable viewer" },
				},
			},
			---@type TestRunnerOptions
			test_runner = {
                neotest_integration = true,
				---@type "split" | "vsplit" | "float" | "buf"
				viewmode = "float",
				---@type number|nil
				vsplit_width = nil,
				---@type string|nil "topleft" | "topright"
				vsplit_pos = nil,
				enable_buffer_test_execution = true, --Experimental, run tests directly from buffer
				noBuild = false,
				icons = {
					passed = "",
					skipped = "",
					failed = "",
					success = "",
					reload = "",
					test = "",
					sln = "󰘐",
					project = "󰘐",
					dir = "",
					package = "",
				},
                mappings = {
                    run_test_from_buffer = { lhs = "<leader>r", desc = "run test from buffer" },
                    run_all_tests_from_buffer = { lhs = "<leader>t", desc = "Run all tests in file" },
                    get_build_errors = { lhs = "<leader>e", desc = "get build errors" },
                    peek_stack_trace_from_buffer = { lhs = "<leader>p", desc = "peek stack trace from buffer" },
                    debug_test_from_buffer = { lhs = "<leader>d", desc = "run test from buffer" },
                    debug_test = { lhs = "<leader>d", desc = "debug test" },
                    go_to_file = { lhs = "g", desc = "go to file" },
                    run_all = { lhs = "<leader>R", desc = "run all tests" },
                    run = { lhs = "<leader>r", desc = "run test" },
                    peek_stacktrace = { lhs = "<leader>p", desc = "peek stacktrace of failed test" },
                    expand = { lhs = "o", desc = "expand" },
                    expand_node = { lhs = "E", desc = "expand node" },
                    collapse_all = { lhs = "W", desc = "collapse all" },
                    close = { lhs = "q", desc = "close testrunner" },
                    refresh_testrunner = { lhs = "<C-r>", desc = "refresh testrunner" },
                    cancel = { lhs = "<C-c>", desc = "cancel in-flight operation" },
                },
				--- Optional table of extra args e.g "--blame crash"
				additional_args = {},
			},
			new = {
				project = {
					prefix = "sln", -- "sln" | "none"
				},
			},
			csproj_mappings = true,
			fsproj_mappings = true,
			auto_bootstrap_namespace = {
				enabled = true,
				type = "file_scoped",
				use_clipboard_json = {
					behavior = "prompt",
					register = "+",
				},
			},
			server = {
				---@type nil | "Off" | "Critical" | "Error" | "Warning" | "Information" | "Verbose" | "All"
				log_level = "Warning",
			},
			picker = "snacks",
			background_scanning = true,
			notifications = nil,
			diagnostics = {
				default_severity = "warning",
				setqflist = true,
			},
			---@param action "test" | "restore" | "build" | "run"
			terminal = function(path, action, args)
				args = args or ""
				local commands = {
					run = function()
						return string.format("dotnet run --project %s %s", path, args)
					end,
					test = function()
						return string.format("dotnet test %s %s", path, args)
					end,
					restore = function()
						return string.format("dotnet restore %s %s", path, args)
					end,
					build = function()
						return string.format("dotnet build %s %s", path, args)
					end,
					watch = function()
						return string.format("dotnet watch --project %s %s", path, args)
					end,
				}
				local command = commands[action]()
				if require("easy-dotnet.extensions").isWindows() == true then
					command = command .. "\r"
				end
				vim.cmd("vsplit")
				vim.cmd("term " .. command)
			end,
		})
	end,
}
