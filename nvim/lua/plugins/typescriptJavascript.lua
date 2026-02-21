return {
    "pmizio/typescript-tools.nvim",
    enabled = false,
    dependencies = { 
        "nvim-lua/plenary.nvim",
        "neovim/nvim-lspconfig"
    },
    config = function()
        require("typescript-tools").setup({
            settings = {
                separate_diagnostic_server = true,
                publish_diagnostic_on = "insert_leave",
                expose_as_code_action = {
                    "fix_all",
                    "add_missing_imports",
                    "remove_unused",
                },
                tsserver_max_memory = "auto",
                complete_function_calls = false,
                include_completions_with_insert_text = true,
            } 
        })
    end
}
