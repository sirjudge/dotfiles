return {
    {
        'akinsho/bufferline.nvim',
        version = "*",
        dependencies = 'nvim-tree/nvim-web-devicons',
        event = { "BufReadPre", "BufNewFile" },
        keys = {
            { "<leader>bn", "<cmd>bnext<cr>", desc = "buffer next" },
            { "<leader>bp", "<cmd>bprevious<cr>", desc = "buffer previous" },
            { "<leader>bd", "<cmd>bdelete<cr>", desc = "buffer delete" },
            { "<leader>blcr", "<cmd>BufferLineCloseRight<cr>", desc = "bufferline close right"},
            { "<leader>blcl", "<cmd>BufferLineCloseLeft<cr>", desc = "bufferline close left"},
            { "<leader>blp", "<cmd>BufferLinePick<cr>", desc = "bufferline pick"},
        },
        config = function()
            local bufferline = require('bufferline')
            bufferline.setup {
                options = {
                    mode = "buffers", -- set to "tabs" to only show tabpages instead
                    style_preset = bufferline.style_preset.default, -- or bufferline.style_preset.minimal,
                    themable = true,--true | false, -- allows highlight groups to be overriden i.e. sets highlights as default
                    numbers = "ordinal", -- "none" | "ordinal" | "buffer_id" | "both" | function({ ordinal, id, lower, raise }): string,
                    close_command = "bdelete! %d",       -- can be a string | function, | false see "Mouse actions"
                    right_mouse_command = "bdelete! %d", -- can be a string | function | false, see "Mouse actions"
                    left_mouse_command = "buffer %d",    -- can be a string | function, | false see "Mouse actions"
                    middle_mouse_command = nil,          -- can be a string | function, | false see "Mouse actions"
                    indicator = {
                        icon = '▎', -- this should be omitted if indicator style is not 'icon'
                        style = 'icon'-- icon | 'underline' | 'none',
                    },
                    buffer_close_icon = '󰅖',
                    modified_icon = '● ',
                    close_icon = ' ',
                    left_trunc_marker = ' ',
                    right_trunc_marker = ' ',
                    offsets = {
                        {
                            filetype = "NvimTree",
                            text = "File Explorer",
                            highlight = "Directory",
                            separator = true -- use a "true" to enable the default, or set your own character
                        }
                    },
                    --- name_formatter can be used to change the buffer's label in the bufferline.
                    --- Please note some names can/will break the
                    --- bufferline so use this at your discretion knowing that it has
                    --- some limitations that will *NOT* be fixed.
                    -- name_formatter = function(buf)  -- buf contains:
                    --     -- name
                    --
                    --     -- name                | str        | the basename of the active file
                    --     -- path                | str        | the full path of the active file
                    --     -- bufnr               | int        | the number of the active buffer
                    --     -- buffers (tabs only) | table(int) | the numbers of the buffers in the tab
                    --     -- tabnr (tabs only)   | int        | the "handle" of the tab, can be converted to its ordinal number using: `vim.api.nvim_tabpage_get_number(buf.tabnr)`
                    -- end
                    max_name_length = 18,
                    max_prefix_length = 15, -- prefix used when a buffer is de-duplicated
                    truncate_names = true, -- whether or not tab names should be truncated
                    tab_size = 18,
                    diagnostics = "nvim-lsp", --false | "nvim_lsp" | "coc",
                    diagnostics_update_in_insert = false, -- only applies to coc
                    diagnostics_update_on_event = true, -- use nvim's diagnostic handler
                    -- The diagnostics indicator can be set to nil to keep the buffer name highlight but delete the highlighting
                    diagnostics_indicator = function(count, level, diagnostics_dict, context)
                        return "("..count..")"
                    end,
                    show_buffer_icons = true,-- true | false, -- disable filetype icons for buffers
                    show_buffer_close_icons = true, --true | false,
                    show_close_icon = true, --true | false,
                    show_tab_indicators =true,-- true | false,
                    show_duplicate_prefix =true, -- true | false, -- whether to show duplicate buffer prefix
                    duplicates_across_groups = false, -- whether to consider duplicate paths in different groups as duplicates
                    persist_buffer_sort = true, -- whether or not custom sorted buffers should persist
                    move_wraps_at_ends = false, -- whether or not the move command "wraps" at the first or last position
                    -- separator_style ="thin", --"slant" | "slope" | "thick" | "thin" | { 'any', 'any' },
                    -- enforce_regular_tabs = true,--false | true,
                    -- always_show_bufferline = true,--true | false,
                    -- auto_toggle_bufferline = true, --true | false,
                    -- hover = {
                    --     enabled = true,
                    --     delay = 200,
                    --     reveal = {'close'}
                    -- },
                    -- sort_by = --'insert_after_current' |'insert_at_end' | 'id' | 'extension' | 'relative_directory' | 'directory' | 'tabs' | function(buffer_a, buffer_b)
                        -- add custom logic
                    --     local modified_a = vim.fn.getftime(buffer_a.path)
                    --     local modified_b = vim.fn.getftime(buffer_b.path)
                    --     return modified_a > modified_b
                    -- end,
                    -- sort_by = 'insert_at_end',
                    -- pick = {
                    --     alphabet = "abcdefghijklmopqrstuvwxyzABCDEFGHIJKLMOPQRSTUVWXYZ1234567890",
                    -- },
                }
            }
        end
    }
}
