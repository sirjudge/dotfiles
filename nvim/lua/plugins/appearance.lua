return {
    -- makes cursor be all smooth like
    {
        "gen740/SmoothCursor.nvim",
        config = function()
            require("smoothcursor").setup()
        end,
    },
    {
        'zeybek/camouflage.nvim',
        event = { 'BufReadPre', 'BufNewFile' },
        opts = {
            enabled = true,
            auto_enable = true,
            max_lines = 5000,
            -- Parser settings
            parsers = {
                include_commented = true,      -- Include commented lines (all parsers)
                env = {
                    include_export = true,       -- Include export KEY=value
                },
                json = {
                    max_depth = 10,              -- Maximum nesting depth
                },
                yaml = {
                    max_depth = 10,              -- Maximum nesting depth
                },
            },
            -- Integrations
            integrations = {
                telescope = true,
                cmp = {
                    disable_in_masked = true,
                },
            },
        },
        keys = {
            { 
                '<leader>ct',
                '<cmd>CamouflageToggle<cr>',
                desc = 'Toggle Camouflage' 
            },
        },
    },
}
