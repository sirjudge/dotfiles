return {
    {
        "mfussenegger/nvim-dap",
        config = function()
            local dap = require('dap')
            dap.adapters.coreclr = {
                type = 'executable',
                command = '/home/nicholas.judge/tools/netcoredbg',
                args = {'--interpreter=vscode'}
            }

            dap.configurations.cs = {
                type = "coreclr",
                name = "launch - netcoredbg",
                request = "launch",
                program = function()
                    return vim.fn.input('/home/nicholas.judge/tools/netcoredbg', vim.fn.getcwd() .. '/bin/Debug/', 'file')
                end,
            }
        end
    },
    {
        "rcarriga/nvim-dap-ui",
        dependencies = {"mfussenegger/nvim-dap", "nvim-neotest/nvim-nio"},
        config = function()
            require("dapui").setup()
        end
    }
}
