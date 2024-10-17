return {

}
--[[require("CopilotChat").setup{
    debug = true,
    question_header = '',
    answer_header = '',
    error_header = '',
    allow_insecure = true,
    mappings = {
        reset = {
            normal = '',
            insert = '',
        },
    },
    prompts = {
        Explain = {
            mapping = '<leader>ae',
            description = 'AI Explain',
        },
        Review = {
            mapping = '<leader>ar',
            description = 'AI Review',
        },
        Tests = {
            mapping = '<leader>at',
            description = 'AI Tests',
        },
        Fix = {
            mapping = '<leader>af',
            description = 'AI Fix',
        },
        Optimize = {
            mapping = '<leader>ao',
            description = 'AI Optimize',
        },
        Docs = {
            mapping = '<leader>ad',
            description = 'AI Documentation',
        },
        CommitStaged = {
            mapping = '<leader>ac',
            description = 'AI Generate Commit',
        },
    },
}
--]]
--vim.api.nvim_set_keymap('i','<Tab>','copilot#Accept("<CR>")', {expr = true, silent=true})
--vim.api.nvim_set_keymap('i','<S-Tab>','copilot#Accept("<CR>")', {expr = true, silent=true})
--vim.g.copilot_filetypes = { VimspectorPrompt = false }a
--
