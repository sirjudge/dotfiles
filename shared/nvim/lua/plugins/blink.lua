return {
    {
        "giuxtaposition/blink-cmp-copilot",
        config = function()
            require("copilot").setup({
                suggestion = { enabled = false },
                panel = { enabled = false },
            })
        end,
    },
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
                -- preset = 'super-tab', 
                preset = 'default',
            },
            appearance = {
                use_nvim_cmp_as_default = true,
                nerd_font_variant = 'mono'
            },
            sources = {
                default = { 'lsp', 'path', 'snippets', 'buffer', 'ecolog', 'digraphs', 'copilot' },
                providers = {
                    copilot = {
                        name = "copilot", module = "blink-cmp-copilot", async = true, score_offset = 100
                    },
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
                menu = { 
                    border = 'single' 
                },
                documentation = {
                    window = { 
                        border = 'single' 
                    }
                },
            },
        },
        signature = { 
            window = {
                border = 'single' 
            } 
        },
    }
}
