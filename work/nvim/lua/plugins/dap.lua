return {
	{
		"mfussenegger/nvim-dap",
		dependencies = {
			"rcarriga/nvim-dap-ui",
			"nvim-neotest/nvim-nio",
			"theHamsta/nvim-dap-virtual-text",
			"jay-babu/mason-nvim-dap.nvim",
		},
		lazy = false,
		keys = {
			{ "<leader>d", "", desc = "debug" },
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
			local mason_path = vim.fn.stdpath("data") .. "/mason"

			dap.adapters["pwa-chrome"] = {
				type = "server",
				host = "127.0.0.1",
				port = "${port}",
				executable = {
					command = "node",
					args = {
						mason_path .. "/packages/js-debug-adapter/js-debug/src/dapDebugServer.js",
						"${port}",
						"127.0.0.1",
					},
				},
			}

			-- Firefox debugging via firefox-debug-adapter (Mason)
			dap.adapters.firefox = {
				type = "executable",
				command = "node",
				args = { mason_path .. "/packages/firefox-debug-adapter/dist/adapter.bundle.js" },
			}

			local chrome_exe = "C:/Program Files/Google/Chrome/Application/chrome.exe"
			local chrome_profile = vim.fn.expand("$LOCALAPPDATA") .. "\\nvim-dap-chrome-profile"
			local js_configs = {
				{
					type = "pwa-chrome",
					request = "launch",
					name = "Launch Chrome",
					url = "http://localhost:4200",
					webRoot = "${workspaceFolder}",
					sourceMaps = true,
					runtimeExecutable = chrome_exe,
					userDataDir = chrome_profile,
					sourceMapPathOverrides = {
						["webpack:///./~/*"] = "${webRoot}/node_modules/*",
						["webpack:///./*"] = "${webRoot}/*",
						["webpack:///*"] = "*",
						["webpack:///src/*"] = "${webRoot}/src/*",
					},
				},
				{
					type = "pwa-chrome",
					request = "attach",
					name = "Attach to Chrome (must start with --remote-debugging-port=9222)",
					port = 9222,
					webRoot = "${workspaceFolder}",
					sourceMaps = true,
					sourceMapPathOverrides = {
						["webpack:///./~/*"] = "${webRoot}/node_modules/*",
						["webpack:///./*"] = "${webRoot}/*",
						["webpack:///*"] = "*",
						["webpack:///src/*"] = "${webRoot}/src/*",
					},
				},
				{
					name = "Launch Firefox",
					type = "firefox",
					request = "launch",
					reAttach = true,
					url = "http://localhost:4200",
					webRoot = "${workspaceFolder}",
					firefoxExecutable = "C:/Program Files/Mozilla Firefox/firefox.exe",
					sourceMaps = true,
					pathMappings = {
						{
							url = "webpack:///./",
							path = "${workspaceFolder}/",
						},
						{
							url = "webpack:///src",
							path = "${workspaceFolder}/src",
						},
					},
				},
			}

			dap.configurations.javascript = js_configs
			dap.configurations.javascriptreact = js_configs
			dap.configurations.typescriptreact = js_configs
			dap.configurations.typescript = js_configs

			local dapui = require("dapui")
			dapui.setup({
				layouts = {
					-- {
					-- TODO: Need to figure out how to add these only when ft = C# or something
					-- elements = {
					-- 	{ id = "easy-dotnet_cpu", size = 0.20 },
					-- 	{ id = "easy-dotnet_mem", size = 0.20 },
					-- },
					-- 	size = 25, -- Width of the sidebar
					-- 	position = "right",
					-- },
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
							--{ id = "stacks", size = 0.25 }, -- Call stacks panel (25% of layout)
							{ id = "watches", size = 0.25 }, -- Watches panel (25% of layout)
						},
						size = 30, -- Width of the sidebar
						position = "left",
					},
				},
			})

			dap.listeners.after.event_initialized["dapui_config"] = function()
				dapui.open({})
			end
			dap.listeners.before.event_terminated["dapui_config"] = function()
				dapui.close({})
			end
			dap.listeners.before.event_exited["dapui_config"] = function()
				dapui.close({})
			end

			require("nvim-dap-virtual-text").setup()

			vim.fn.sign_define("DapBreakpoint", { text = "", texthl = "DiagnosticError", linehl = "", numhl = "" })
			vim.fn.sign_define(
				"DapBreakpointCondition",
				{ text = "C", texthl = "DiagnosticWarn", linehl = "", numhl = "" }
			)
			vim.fn.sign_define(
				"DapBreakpointRejected",
				{ text = "R", texthl = "DiagnosticHint", linehl = "", numhl = "" }
			)
			vim.fn.sign_define("DapLogPoint", { ftext = "L", texthl = "DiagnosticInfo", linehl = "", numhl = "" })

			vim.fn.sign_define("DapStopped", { text = "", texthl = "DiagnosticInfo", linehl = "Visual", numhl = "" })
		end,
	},
}
