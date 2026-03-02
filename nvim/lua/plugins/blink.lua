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
                use_nvim_cmp_as_default = false,
                nerd_font_variant = 'mono'
            },
            fuzzy = { implementation = "prefer_rust_with_warning" },
            sources = {
                default = { 'lsp', 'path', 'buffer', 'easy-dotnet' },
                providers = {
                    ["easy-dotnet"] = {
                        name = "easy-dotnet",
                        enabled = true,
                        module = "easy-dotnet.completion.blink",
                        score_offset = 10000,
                        async = true,
                    },
                }
            },
            completion = {
                menu = {
                    border = "single",
                    draw = {
                        treesitter = { 'lsp' },
                        columns = { { 'kind_icon' }, { 'label', 'label_description', gap = 1 } },
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
                            },
                            label = {
                                width = { fill = true, max = 60 },
                                text = function(ctx) return ctx.label .. ctx.label_detail end,
                                highlight = function(ctx)
                                    local label = ctx.label
                                    local highlights = {
                                        { 0, #label, group = ctx.deprecated and 'BlinkCmpLabelDeprecated' or 'BlinkCmpLabel' },
                                    }
                                    if ctx.label_detail then
                                        table.insert(
                                            highlights,
                                            { #label, #label + #ctx.label_detail, group = 'BlinkCmpLabelDetail' }
                                        )
                                    end

                                    if vim.list_contains(ctx.self.treesitter, ctx.source_id) and not ctx.deprecated then
                                        vim.list_extend(
                                            highlights,
                                            require('blink.cmp.completion.windows.render.treesitter').highlight(ctx)
                                        )
                                    end

                                    for _, idx in ipairs(ctx.label_matched_indices) do
                                        table.insert(highlights, { idx, idx + 1, group = 'BlinkCmpLabelMatch' })
                                    end

                                    return highlights
                                end,
                            },
                            label_description = {
                                width = { max = 30 },
                                text = function(ctx) return ctx.label_description end,
                                highlight = 'BlinkCmpLabelDescription',
                            },
                        }
                    },
                },
                documentation = {
                    auto_show = true,
                    auto_show_delay_ms = 300,
                    window = {
                        border = 'single',
                        winhighlight = "Normal:BlinkCmpDoc,FloatBorder:BlinkCmpDocBorder",
                    }
                },
                accept = { 
                    auto_brackets = { enabled = true }
                },
                ghost_text = {
                    enabled = true
                },
                keyword = {
                    range = 'prefix',
                },
            },
            signature = {
                enabled = true,
                window = {
                    border = "single",
                    winhighlight = "Normal:BlinkCmpMenu,FloatBorder:BlinkCmpMenuBorder",
                },
            },
        },
        opts_extend = {
            "sources.completion.enabled_provides"
        },
    },
    {
        "xzbdmw/colorful-menu.nvim",
        config = function()
            -- You don't need to set these options.
            require("colorful-menu").setup({
                ls = {
                    lua_ls = {
                        -- Maybe you want to dim arguments a bit.
                        arguments_hl = "@comment",
                    },
                    gopls = {
                        -- By default, we render variable/function's type in the right most side,
                        -- to make them not to crowd together with the original label.
                        -- when true:
                        -- foo             *Foo
                        -- ast         "go/ast"
                        -- when false:
                        -- foo *Foo
                        -- ast "go/ast"
                        align_type_to_right = true,
                        -- When true, label for field and variable will format like "foo: Foo"
                        -- instead of go's original syntax "foo Foo". If align_type_to_right is
                        -- true, this option has no effect.
                        add_colon_before_type = false,
                        -- See https://github.com/xzbdmw/colorful-menu.nvim/pull/36
                        preserve_type_when_truncate = true,
                    },
                    -- for lsp_config or typescript-tools
                    ts_ls = {
                        -- false means do not include any extra info,
                        -- see https://github.com/xzbdmw/colorful-menu.nvim/issues/42
                        extra_info_hl = "@comment",
                    },
                    vtsls = {
                        -- false means do not include any extra info,
                        -- see https://github.com/xzbdmw/colorful-menu.nvim/issues/42
                        extra_info_hl = "@comment",
                    },
                    ["rust-analyzer"] = {
                        -- Such as (as Iterator), (use std::io).
                        extra_info_hl = "@comment",
                        -- Similar to the same setting of gopls.
                        align_type_to_right = true,
                        -- See https://github.com/xzbdmw/colorful-menu.nvim/pull/36
                        preserve_type_when_truncate = true,
                    },
                    clangd = {
                        -- Such as "From <stdio.h>".
                        extra_info_hl = "@comment",
                        -- Similar to the same setting of gopls.
                        align_type_to_right = true,
                        -- the hl group of leading dot of "•std::filesystem::permissions(..)"
                        import_dot_hl = "@comment",
                        -- See https://github.com/xzbdmw/colorful-menu.nvim/pull/36
                        preserve_type_when_truncate = true,
                    },
                    zls = {
                        -- Similar to the same setting of gopls.
                        align_type_to_right = true,
                    },
                    roslyn = {
                        extra_info_hl = "@comment",
                    },
                    dartls = {
                        extra_info_hl = "@comment",
                    },
                    -- The same applies to pyright/pylance
                    basedpyright = {
                        -- It is usually import path such as "os"
                        extra_info_hl = "@comment",
                    },
                    pylsp = {
                        extra_info_hl = "@comment",
                        -- Dim the function argument area, which is the main
                        -- difference with pyright.
                        arguments_hl = "@comment",
                    },
                    -- If true, try to highlight "not supported" languages.
                    fallback = true,
                    -- this will be applied to label description for unsupport languages
                    fallback_extra_info_hl = "@comment",
                },
                -- If the built-in logic fails to find a suitable highlight group for a label,
                -- this highlight is applied to the label.
                fallback_highlight = "@variable",
                -- If provided, the plugin truncates the final displayed text to
                -- this width (measured in display cells). Any highlights that extend
                -- beyond the truncation point are ignored. When set to a float
                -- between 0 and 1, it'll be treated as percentage of the width of
                -- the window: math.floor(max_width * vim.api.nvim_win_get_width(0))
                -- Default 60.
                max_width = 60,
            })
        end,
    }
}
