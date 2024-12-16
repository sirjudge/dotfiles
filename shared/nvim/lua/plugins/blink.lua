return {
    {
        'saghen/blink.cmp',
        lazy = false, -- lazy loading handled internally
        -- optional: provides snippets for the snippet source
        dependencies = 'rafamadriz/friendly-snippets',

        -- use a release tag to download pre-built binaries
        version = 'v0.*',
        keymap = { preset = 'default' },

        ---@module 'blink.cmp'
        ---@type blink.cmp.Config
        opts = {
            -- 'default' for mappings similar to built-in completion
            -- 'super-tab' for mappings similar to vscode (tab to accept, arrow keys to navigate)
            -- 'enter' for mappings similar to 'super-tab' but with 'enter' to accept
            -- see the "default configuration" section below for full documentation on how to define
            -- your own keymap.
            keymap = { preset = 'default' },

            appearance = {
                -- Sets the fallback highlight groups to nvim-cmp's highlight groups
                -- Useful for when your theme doesn't support blink.cmp
                -- will be removed in a future release
                use_nvim_cmp_as_default = true,
                -- Set to 'mono' for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
                -- Adjusts spacing to ensure icons are aligned
                nerd_font_variant = 'mono'
            },

            -- default list of enabled providers defined so that you can extend it
            -- elsewhere in your config, without redefining it, via `opts_extend`
            sources = {
                default = { 'lsp', 'path', 'snippets', 'buffer' },
                -- optionally disable cmdline completions
                -- cmdline = {},
                providers = {
                    copilot = {
                        name = "copilot",
                        module = "blink-cmp-copilot",
                    },
                }
            },

            -- experimental signature help support
            -- signature = { enabled = true }
        },
        -- allows extending the providers array elsewhere in your config
        -- without having to redefine it
        opts_extend = { "sources.default" },

        completion = {
            keyword = {
                -- 'prefix' will fuzzy match on the text before the cursor
                -- 'full' will fuzzy match on the text before *and* after the cursor
                -- example: 'foo_|_bar' will match 'foo_' for 'prefix' and 'foo__bar' for 'full'
                range = 'prefix',
                -- Regex used to get the text when fuzzy matching
                regex = '[-_]\\|\\k',
                -- After matching with regex, any characters matching this regex at the prefix will be excluded
                exclude_from_prefix_regex = '[\\-]',
            },
        },

    }
}
