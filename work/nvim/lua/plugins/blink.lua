return {
    {
        'onsails/lspkind.nvim'
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
                preset = 'default',
            },
            appearance = {
                use_nvim_cmp_as_default = true,
                nerd_font_variant = 'mono'
            },
            fuzzy = { implementation = "prefer_rust_with_warning" },
            sources = {
                default = { 'lsp', 'path', 'buffer'},
            },
        },
        opts_extend = {
            "sources.completion.enabled_provides"
        },
        completion = {
            menu = {
                draw = {
                    components = {
                        kind_icon = {
                            text = function(ctx)
                                if ctx.source_name ~= "Path" then
                                    return require("lspkind").symbol_map[ctx.kind] or "" .. ctx.icon_gap
                                end

                                local is_unknown_type = vim.tbl_contains({ "link", "socket", "fifo", "char", "block", "unknown" }, ctx.item.data.type)
                                local mini_icon, _ = require("mini.icons").get(
                                    is_unknown_type and "os" or ctx.item.data.type,
                                    is_unknown_type and "" or ctx.label
                                )

                                return (mini_icon or ctx.kind_icon) .. ctx.icon_gap
                            end,

                            highlight = function(ctx)
                                if ctx.source_name ~= "Path" then return ctx.kind_hl end

                                local is_unknown_type = vim.tbl_contains({ "link", "socket", "fifo", "char", "block", "unknown" }, ctx.item.data.type)
                                local mini_icon, mini_hl = require("mini.icons").get(
                                    is_unknown_type and "os" or ctx.item.data.type,
                                    is_unknown_type and "" or ctx.label
                                )
                                return mini_icon ~= nil and mini_hl or ctx.kind_hl
                            end,
                        }
                    }
                },
            },
            accept = { 
                auto_brackets = { enabled = true }
            },
            ghost_text = {
                enabled = true
            },
            keyword = {
                range = 'prefix',
                regex = '[-_]\\|\\k',
                exclude_from_prefix_regex = '[\\-]',
                menu = { 
                    border = 'single' 
                },
                documentation = {
                    auto_show = true,
                    auto_show_delay_ms = 500,
                    window = { 
                        border = 'single' 
                    }
                },
            },
        },
        signature = { 
            enabled = true,
            window = {
                border = 'single' 
            } 
        },
    }
}
