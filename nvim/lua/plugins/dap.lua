return {
	{
		"mfussenegger/nvim-dap",
		dependencies = {
			"rcarriga/nvim-dap-ui",
			"nvim-neotest/nvim-nio",
			"theHamsta/nvim-dap-virtual-text",
			"jay-babu/mason-nvim-dap.nvim",
		},
		keys = {
			{ "<leader>d", "", desc = "debug" },
			{
				"<F12>",
				function()
					require("dap").step_out()
				end,
				desc = "DAP Step Out",
			},
			{
				"<leader>dc",
				function()
					require("dap").continue()
				end,
				desc = "DAP Continue",
			},
			{
				"<leader>do",
				function()
					require("dap").step_over()
				end,
				desc = "DAP Step Over",
			},
			{
				"<leader>di",
				function()
					require("dap").step_into()
				end,
				desc = "DAP Step Into",
			},
			{
				"<leader>dO",
				function()
					require("dap").step_out()
				end,
				desc = "DAP Step Out",
			},
			{
				"<leader>db",
				function()
					require("dap").toggle_breakpoint()
				end,
				desc = "DAP Toggle Breakpoint",
			},
			{
				"<leader>dn",
				function()
					require("dap").new()
				end,
				desc = "DAP Toggle Breakpoint",
			},
			{
				"<leader>dB",
				function()
					require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: "))
				end,
				desc = "DAP Conditional Breakpoint",
			},
			{
				"<leader>dl",
				function()
					require("dap").set_breakpoint(nil, nil, vim.fn.input("Log point message: "))
				end,
				desc = "DAP Log Point",
			},
			{
				"<leader>dr",
				function()
					require("dap").repl.open()
				end,
				desc = "DAP REPL",
			},
			{
				"<leader>dR",
				function()
					require("dap").run_last()
				end,
				desc = "DAP Run Last",
			},
			{
				"<leader>dt",
				function()
					require("dap").terminate()
				end,
				desc = "DAP Terminate",
			},
			{
				"<leader>du",
				function()
					require("dapui").toggle()
				end,
				desc = "DAP UI Toggle",
			},
		},
		config = function()
			local dap = require("dap")
			local dapui = require("dapui")

			dapui.setup({
				layouts = {
					{
						elements = function()
							local has_easy_dotnet = package.loaded["easy-dotnet"] ~= nil
							if not has_easy_dotnet then
								return nil
							end
							return {
								{ id = "easy-dotnet_cpu", size = 0.5 },
								{ id = "easy-dotnet_mem", size = 0.5 },
							}
						end,
						size = 25, -- Width of the sidebar
						position = "right",
					},
					{
						elements = {
							{ id = "repl", size = 1.0 }, -- REPL panel (100% of layout)
						},
						size = 10,
						position = "bottom",
					},
					{
						elements = {
							{ id = "scopes", size = 0.25 }, -- Scopes panel (25% of layout)
							{ id = "breakpoints", size = 0.25 }, -- Breakpoints panel (25% of layout)
							{ id = "stacks", size = 0.25 }, -- Call stacks panel (25% of layout)
							{ id = "watches", size = 0.25 }, -- Watches panel (25% of layout)
						},
						size = 30, -- Width of the sidebar
						position = "left",
					},
				},
			})
			require("nvim-dap-virtual-text").setup()

			vim.fn.sign_define("DapBreakpoint", { text = "B", texthl = "DiagnosticError", linehl = "", numhl = "" })
			vim.fn.sign_define(
				"DapBreakpointCondition",
				{ text = "C", texthl = "DiagnosticWarn", linehl = "", numhl = "" }
			)
			vim.fn.sign_define(
				"DapBreakpointRejected",
				{ text = "R", texthl = "DiagnosticHint", linehl = "", numhl = "" }
			)
			vim.fn.sign_define("DapLogPoint", { text = "L", texthl = "DiagnosticInfo", linehl = "", numhl = "" })
			vim.fn.sign_define("DapStopped", { text = ">", texthl = "DiagnosticInfo", linehl = "Visual", numhl = "" })

			dap.listeners.after.event_initialized["dapui_config"] = function()
				dapui.open()
			end
			dap.listeners.before.event_terminated["dapui_config"] = function()
				dapui.close()
			end
			dap.listeners.before.event_exited["dapui_config"] = function()
				dapui.close()
			end

			local mason_dap_ok, mason_dap = pcall(require, "mason-nvim-dap")
			if mason_dap_ok then
				mason_dap.setup({
					ensure_installed = { "netcoredbg", "js-debug-adapter" },
					automatic_installation = true,
				})
			end

			local function mason_package_path(package_name)
				return vim.fs.joinpath(vim.fn.stdpath("data"), "mason", "packages", package_name)
			end

			local is_windows = vim.fn.has("win32") == 1
			local path_sep = is_windows and "\\" or "/"
			local netcoredbg_exe =
				vim.fs.joinpath(mason_package_path("netcoredbg"), is_windows and "netcoredbg.exe" or "netcoredbg")

			local last_dll_path = nil

			local function pick_dll_path()
				local default_dir = vim.fn.getcwd() .. path_sep
				local dll = vim.fn.input("Path to dll: ", default_dir, "file")
				if dll ~= nil and dll ~= "" then
					last_dll_path = dll
				end
				return last_dll_path
			end

			local function project_dir_from_dll(dll_path)
				if not dll_path or dll_path == "" then
					return vim.fn.getcwd()
				end

				local normalized = dll_path:gsub("\\", "/")
				local project_dir = normalized:match("^(.-)/bin/.*$")
				if not project_dir then
					return vim.fn.fnamemodify(dll_path, ":h")
				end

				if is_windows then
					project_dir = project_dir:gsub("/", "\\")
				end
				return project_dir
			end

			local function load_launch_profile_env(project_dir)
				local env = {
					ASPNETCORE_ENVIRONMENT = "Development",
					DOTNET_ENVIRONMENT = "Development",
					DOTNET_LAUNCH_PROFILE = "V3.Api",
					ASPNETCORE_URLS = "https://localhost:5002",
				}

				local launch_settings_path = vim.fs.joinpath(project_dir, "Properties", "launchSettings.json")
				if vim.fn.filereadable(launch_settings_path) == 0 then
					return env
				end

				local ok, launch_settings =
					pcall(vim.fn.json_decode, table.concat(vim.fn.readfile(launch_settings_path), "\n"))
				if not ok or type(launch_settings) ~= "table" or type(launch_settings.profiles) ~= "table" then
					return env
				end

				local selected_profile = nil
				local selected_profile_name = nil
				local preferred_profile_name = vim.env.DOTNET_LAUNCH_PROFILE

				if type(preferred_profile_name) == "string" and preferred_profile_name ~= "" then
					local preferred_profile = launch_settings.profiles[preferred_profile_name]
					if type(preferred_profile) == "table" and preferred_profile.commandName == "Project" then
						selected_profile = preferred_profile
						selected_profile_name = preferred_profile_name
					end
				end

				if type(selected_profile) ~= "table" then
					for profile_name, profile in pairs(launch_settings.profiles) do
						if
							type(profile) == "table"
							and profile.commandName == "Project"
							and type(profile.applicationUrl) == "string"
							and profile.applicationUrl:find("https://", 1, true)
						then
							selected_profile = profile
							selected_profile_name = profile_name
							break
						end
					end
				end

				if type(selected_profile) ~= "table" then
					local project_profile_names = {}
					for profile_name, profile in pairs(launch_settings.profiles) do
						if type(profile) == "table" and profile.commandName == "Project" then
							table.insert(project_profile_names, profile_name)
						end
					end

					table.sort(project_profile_names)
					local fallback_profile_name = project_profile_names[1]
					if type(fallback_profile_name) == "string" then
						selected_profile = launch_settings.profiles[fallback_profile_name]
						selected_profile_name = fallback_profile_name
					end
				end

				if type(selected_profile) ~= "table" then
					return env
				end

				if type(selected_profile_name) == "string" and selected_profile_name ~= "" then
					env.DOTNET_LAUNCH_PROFILE = selected_profile_name
				end

				if type(selected_profile.environmentVariables) == "table" then
					env = vim.tbl_extend("force", env, selected_profile.environmentVariables)
				end

				if type(selected_profile.applicationUrl) == "string" and selected_profile.applicationUrl ~= "" then
					env.ASPNETCORE_URLS = selected_profile.applicationUrl
				end

				return env
			end

			dap.adapters.coreclr = {
				type = "executable",
				command = netcoredbg_exe,
				args = { "--interpreter=vscode" },
			}

			local js_debug_server =
				vim.fs.joinpath(mason_package_path("js-debug-adapter"), "js-debug", "src", "dapDebugServer.js")

			dap.adapters["pwa-node"] = {
				type = "server",
				host = "localhost",
				port = "${port}",
				executable = {
					command = "node",
					args = { js_debug_server, "${port}" },
				},
			}

			dap.adapters["pwa-chrome"] = {
				type = "server",
				host = "localhost",
				port = "${port}",
				executable = {
					command = "node",
					args = { js_debug_server, "${port}" },
				},
			}

			-- https://github.com/GustavEikaas/easy-dotnet.nvim/blob/main/docs/debugging.md
			dap.configurations.cs = {
				{
					type = "coreclr",
					name = "Launch - netcoredbg",
					request = "launch",
					env = function()
						local dll = last_dll_path or pick_dll_path()
						local project_dir = project_dir_from_dll(dll)
						return load_launch_profile_env(project_dir)
					end,
					cwd = function()
						local dll = last_dll_path or pick_dll_path()
						return project_dir_from_dll(dll)
					end,
					program = function()
						return pick_dll_path()
					end,
					args = {
						"--urls",
						"https://localhost:5002",
					},
				},
				{
					type = "coreclr",
					name = "Attach - netcoredbg",
					request = "attach",
					processId = require("dap.utils").pick_process,
				},
			}

			local js_configs = {
				{
					type = "pwa-node",
					request = "launch",
					name = "Launch file",
					program = "${file}",
					cwd = "${workspaceFolder}",
				},
				{
					type = "pwa-node",
					request = "attach",
					name = "Attach",
					processId = require("dap.utils").pick_process,
					cwd = "${workspaceFolder}",
				},
				{
					type = "pwa-chrome",
					request = "launch",
					name = "Launch Chrome",
					url = "http://localhost:3000",
					webRoot = "${workspaceFolder}",
				},
			}

			dap.configurations.javascript = js_configs
			dap.configurations.typescript = js_configs
			dap.configurations.javascriptreact = js_configs
			dap.configurations.typescriptreact = js_configs
		end,
	},
}
