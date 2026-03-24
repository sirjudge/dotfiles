return {
    {
        "zbirenbaum/copilot.lua",
        cmd = "Copilot",
        keys = {
            { "<leader>cpp", "<cmd>Copilot panel<CR>", desc = "Copilot Panel" },
            { "<leader>cpt", "<cmd>Copilot toggle<CR>", desc = "Copilot Toggle" },
            { "<leader>cps", "<cmd>Copilot suggestion toggle_auto_trigger<CR>", desc = "Toggle Copilot Auto Trigger" },
        },
        config = function()
            require('copilot').setup({
                auth_provider_url = "https://ntracts-inc.ghe.com/",
                trace_lsp = false,
                panel = {
                    enabled = false,
                    auto_refresh = false,
                    keymap = {
                        jump_prev = "[[",
                        jump_next = "]]",
                        accept = "<CR>",
                        refresh = "gr",
                        open = "<M-CR>" },
                    layout = {
                        position = "bottom",
                        ratio = 0.4
                    },
                },
                suggestion = {
                    enabled = false,
                    auto_trigger = true,
                    hide_during_completion = true,
                    debounce = 75,
                    keymap = {
                        accept = "<S-tab>",
                        accept_word = false,
                        accept_line = false,
                        next = "<M-]>",
                        prev = "<M-[>",
                        dismiss = "<C-]>",
                    },
                },
                filetypes = {
                    yaml = false,
                    markdown = false,
                    help = false,
                    gitcommit = false,
                    gitrebase = false,
                    hgcommit = false,
                    svn = false,
                    cvs = false,
                    cs = true,
                    lua = true,
                    javascript = true,
                    typescript = true,
                    -- disable for .env files
                    sh = function ()
                        if string.match(vim.fs.basename(vim.api.nvim_buf_get_name(0)), '^%.env.*') then
                            return false
                        end
                        return true
                    end,
                    ["."] = false,
                },
                copilot_node_command = { 'node', '--no-warnings' },
                server_opts_overrides = {},
            })
        end
    },
}
