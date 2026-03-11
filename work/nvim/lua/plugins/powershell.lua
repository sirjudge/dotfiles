return {
	"TheLeoP/powershell.nvim",
	---@type powershell.user_config
	opts = {
        shell = "pwsh",
        bundle_path = vim.fn.stdpath("data") .. "/mason/packages/powershell-editor-services",
        feature_flags = {},
        lsp_log_level = "Warning",
        capabilities = vim.lsp.protocol.make_client_capabilities(),
        init_options = vim.empty_dict() --[[@as table]],
        settings = vim.empty_dict() --[[@as table]],
        handlers = base_handlers, -- see lua/powershell/handlers.lua
        commands = base_commands, -- see lua/powershell/commands.lua
        root_dir = function(buf)
            local current_file_dir = fs.dirname(api.nvim_buf_get_name(buf))
            return fs.dirname(fs.find({ ".git" }, { upward = true, path = current_file_dir })[1])
            or current_file_dir
        end,
	},
}
