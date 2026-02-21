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
            { "<F5>", function() require("dap").continue() end, desc = "DAP Continue" },
            { "<F10>", function() require("dap").step_over() end, desc = "DAP Step Over" },
            { "<F11>", function() require("dap").step_into() end, desc = "DAP Step Into" },
            { "<F12>", function() require("dap").step_out() end, desc = "DAP Step Out" },
            { "<leader>dc", function() require("dap").continue() end, desc = "DAP Continue" },
            { "<leader>do", function() require("dap").step_over() end, desc = "DAP Step Over" },
            { "<leader>di", function() require("dap").step_into() end, desc = "DAP Step Into" },
            { "<leader>dO", function() require("dap").step_out() end, desc = "DAP Step Out" },
            { "<leader>db", function() require("dap").toggle_breakpoint() end, desc = "DAP Toggle Breakpoint" },
            { "<leader>dn", function() require("dap").new() end, desc = "DAP Toggle Breakpoint" },
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
            { "<leader>dr", function() require("dap").repl.open() end, desc = "DAP REPL" },
            { "<leader>dR", function() require("dap").run_last() end, desc = "DAP Run Last" },
            { "<leader>dt", function() require("dap").terminate() end, desc = "DAP Terminate" },
            { "<leader>du", function() require("dapui").toggle() end, desc = "DAP UI Toggle" },
        },
        config = function()
            local dap = require("dap")
            local dapui = require("dapui")

            dapui.setup()
            require("nvim-dap-virtual-text").setup()

            vim.fn.sign_define("DapBreakpoint", { text = "B", texthl = "DiagnosticError", linehl = "", numhl = "" })
            vim.fn.sign_define("DapBreakpointCondition", { text = "C", texthl = "DiagnosticWarn", linehl = "", numhl = "" })
            vim.fn.sign_define("DapBreakpointRejected", { text = "R", texthl = "DiagnosticHint", linehl = "", numhl = "" })
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
            local netcoredbg_exe = vim.fs.joinpath(
                mason_package_path("netcoredbg"),
                is_windows and "netcoredbg.exe" or "netcoredbg"
            )

            dap.adapters.coreclr = {
                type = "executable",
                command = netcoredbg_exe,
                args = { "--interpreter=vscode" },
            }

            local js_debug_server = vim.fs.joinpath(
                mason_package_path("js-debug-adapter"),
                "js-debug",
                "src",
                "dapDebugServer.js"
            )

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

            dap.configurations.cs = {
                {
                    type = "coreclr",
                    name = "Launch - netcoredbg",
                    request = "launch",
                    program = function()
                        return vim.fn.input("Path to dll: ", vim.fn.getcwd() .. (is_windows and "\\" or "/"), "file")
                    end,
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
