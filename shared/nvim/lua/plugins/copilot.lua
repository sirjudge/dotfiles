return {
    {
        "zbirenbaum/copilot.lua",
        cmd = "Copilot",
        --event = "InsertEnter",
        config = function()
            require('copilot').setup({
                panel = {
                    enabled = true,
                    auto_refresh = false,
                    keymap = {
                        jump_prev = "[[",
                        jump_next = "]]",
                        accept = "<CR>",
                        refresh = "gr",
                        open = "<M-CR>" },
                    layout = {
                        position = "bottom", -- | top | left | right
                        ratio = 0.4
                    },
                },
                suggestion = {
                    enabled = true,
                    auto_trigger = false,
                    hide_during_completion = true,
                    debounce = 75,
                    keymap = {
                        accept = "<M-l>",
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
                    ["."] = false,
                },
                copilot_node_command = 'node', -- Node.js version must be > 18.x
                server_opts_overrides = {},
            })            
            --vim.api.nvim_set_keymap('i','<Tab>','copilot#Accept("<CR>")', {expr = true, silent=true})
            --vim.api.nvim_set_keymap('i','<S-Tab>','copilot#Accept("<CR>")', {expr = true, silent=true})
            --vim.g.copilot_filetypes = { VimspectorPrompt = false }
        end
    },
    {
        "CopilotC-Nvim/CopilotChat.nvim",
        branch = "canary",
        dependencies = {
            { "zbirenbaum/copilot.lua" }, -- or github/copilot.vim
            { "nvim-lua/plenary.nvim" }, -- for curl, log wrapper
        },
        --build = "make tiktoken", -- Only on MacOS or Linux
        opts = {
            debug = false, -- Enable debug logging
            model = 'gpt-4o', -- GPT model to use, 'gpt-3.5-turbo', 'gpt-4', or 'gpt-4o'
            temperature = 0.1, -- GPT temperature

            question_header = '## User ', -- Header to use for user questions
            answer_header = '## Copilot ', -- Header to use for AI answers
            error_header = '## Error ', -- Header to use for errors
            separator = '───', -- Separator to use in chat
            window = {
                layout = 'float',
                relative = 'cursor',
                width = 1,
                height = 0.4,
                row = 1
            },
            show_folds = true, -- Shows folds for sections in chat
            show_help = true, -- Shows help message as virtual lines when waiting for user input
            auto_follow_cursor = true, -- Auto-follow cursor in chat
            auto_insert_mode = false, -- Automatically enter insert mode when opening window and on new prompt
            insert_at_end = false, -- Move cursor to end of buffer when inserting text
            clear_chat_on_new_prompt = false, -- Clears chat on every new prompt
            highlight_selection = true, -- Highlight selection in the source buffer when in the chat window
            history_path = vim.fn.stdpath('data') .. '/copilotchat_history', -- Default path to stored history
        },
        event = "VeryLazy",
        keys = {
            -- Show help actions with telescope
            {
                "<leader>ah",
                function()
                    local actions = require("CopilotChat.actions")
                    require("CopilotChat.integrations.telescope").pick(actions.help_actions())
                end,
                desc = "CopilotChat - Help actions",
            },
            -- Show prompts actions with telescope
            {
                "<leader>ap",
                function()
                    local actions = require("CopilotChat.actions")
                    require("CopilotChat.integrations.telescope").pick(actions.prompt_actions())
                end,
                desc = "CopilotChat - Prompt actions",
            },
            {
                "<leader>ap",
                ":lua require('CopilotChat.integrations.telescope').pick(require('CopilotChat.actions').prompt_actions({selection = require('CopilotChat.select').visual}))<CR>",
                mode = "x",
                desc = "CopilotChat - Prompt actions",
            },
            -- Code related commands
            { "<leader>ae", "<cmd>CopilotChatExplain<cr>", desc = "CopilotChat - Explain code" },
            { "<leader>at", "<cmd>CopilotChatTests<cr>", desc = "CopilotChat - Generate tests" },
            { "<leader>ar", "<cmd>CopilotChatReview<cr>", desc = "CopilotChat - Review code" },
            { "<leader>aR", "<cmd>CopilotChatRefactor<cr>", desc = "CopilotChat - Refactor code" },
            { "<leader>an", "<cmd>CopilotChatBetterNamings<cr>", desc = "CopilotChat - Better Naming" },
            -- Chat with Copilot in visual mode
            {
                "<leader>av",
                ":CopilotChatVisual",
                mode = "x",
                desc = "CopilotChat - Open in vertical split",
            },
            {
                "<leader>ax",
                ":CopilotChatInline<cr>",
                mode = "x",
                desc = "CopilotChat - Inline chat",
            },
            -- Custom input for CopilotChat
            {
                "<leader>ai",
                function()
                    local input = vim.fn.input("Ask Copilot: ")
                    if input ~= "" then
                        vim.cmd("CopilotChat " .. input)
                    end
                end,
                desc = "CopilotChat - Ask input",
            },
            -- Generate commit message based on the git diff
            {
                "<leader>am",
                "<cmd>CopilotChatCommit<cr>",
                desc = "CopilotChat - Generate commit message for all changes",
            },
            {
                "<leader>aM",
                "<cmd>CopilotChatCommitStaged<cr>",
                desc = "CopilotChat - Generate commit message for staged changes",
            },
            -- Quick chat with Copilot
            {
                "<leader>aq",
                function()
                    local input = vim.fn.input("Quick Chat: ")
                    if input ~= "" then
                        vim.cmd("CopilotChatBuffer " .. input)
                    end
                end,
                desc = "CopilotChat - Quick chat",
            },
            -- Debug
            { "<leader>ad", "<cmd>CopilotChatDebugInfo<cr>", desc = "CopilotChat - Debug Info" },
            -- Fix the issue with diagnostic
            { "<leader>af", "<cmd>CopilotChatFixDiagnostic<cr>", desc = "CopilotChat - Fix Diagnostic" },
            -- Clear buffer and chat history
            { "<leader>al", "<cmd>CopilotChatReset<cr>", desc = "CopilotChat - Clear buffer and chat history" },
            -- Toggle Copilot Chat Vsplit
            { "<leader>av", "<cmd>CopilotChatToggle<cr>", desc = "CopilotChat - Toggle" },
            -- Copilot Chat Models
            { "<leader>a?", "<cmd>CopilotChatModels<cr>", desc = "CopilotChat - Select Models" },
        },
    },
}
