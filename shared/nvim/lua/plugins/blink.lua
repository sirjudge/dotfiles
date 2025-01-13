return {
    {
        'saghen/blink.compat',
        version = '*',
        lazy = true,
        opts = {},
    },
    {
        'saghen/blink.cmp',
        lazy = false,
        dependencies = 'rafamadriz/friendly-snippets',
        version = '*',
        ---@module 'blink.cmp'
        ---@type blink.cmp.Config
        opts = {
            keymap = { 
                preset = 'super-tab', 
            },
            appearance = {
                use_nvim_cmp_as_default = true,
                nerd_font_variant = 'mono'
            },
            sources = {
                default = { 'lsp', 'path', 'snippets', 'buffer', 'ecolog', 'digraphs' },
                providers = {
                    ecolog = {
                        name = 'ecolog', module = 'ecolog.integrations.cmp.blink_cmp'
                    },
                    digraphs = {
                        name = 'digraphs', module = 'blink.compat.source'
                    },
                }
            },
        },
        opts_extend = {
            "sources.completion.enabled_provides"
        },
        completion = {
            keyword = {
                range = 'prefix',
                regex = '[-_]\\|\\k',
                exclude_from_prefix_regex = '[\\-]',
                menu = { border = 'single' },
                documentation = {
                    window = { border = 'single' }
                },
            },
        },
        signature = { window = { border = 'single' } },
    }
}
