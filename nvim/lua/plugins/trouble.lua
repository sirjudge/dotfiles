return {
    "folke/trouble.nvim",
    event = { "BufReadPre", "BufNewFile" },
    opts = {
        modes = {
            test = {
                mode = "diagnostics",
                preview = {
                    type = "split",
                    relative = "win",
                    position = "right",
                    size = 0.3,
                },
            },
        },
        auto_close = true,       -- auto close when there are no items
        auto_open = false,        -- auto open when there are items
        auto_preview = true,     -- automatically open preview when on an item
        auto_refresh = true,     -- auto refresh when open
        auto_jump = true,        -- auto jump to the item when there's only one
        focus = true,            -- Focus the window when opened
        restore = true,          -- restores the last location in the list when opening
        follow = true,           -- Follow the current item
        indent_guides = true,    -- show indent guides
        max_items = 200,         -- limit number of items that can be displayed per section
        multiline = true,        -- render multi-line messages
        pinned = false,          -- When pinned, the opened trouble window will be bound to the current buffer
        warn_no_results = true,  -- show a warning when there are no results
        open_no_results = false, -- open the trouble window when there are no results
        preview = {
            type = "main",
            -- when a buffer is not yet loaded, the preview window will be created
            -- in a scratch buffer with only syntax highlighting enabled.
            -- Set to false, if you want the preview to always be a real loaded buffer.
            scratch = true,
        },

    }, -- for default options, refer to the configuration section for custom setup.
    cmd = "Trouble",
    keys = {
        {
            "<leader>xt",
            "<cmd>Trouble diagnostics toggle<cr>",
            desc = "Diagnostics (Trouble)",
        },
        {
            "<leader>xs",
            "<cmd>Trouble symbols toggle focus=false<cr>",
            desc = "Symbols (Trouble)",
        },
        {
            "<leader>xl",
            "<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
            desc = "LSP Definitions / references / ... (Trouble)",
        },
        {
            "<leader>xL",
            "<cmd>Trouble loclist toggle<cr>",
            desc = "Location List (Trouble)",
        },
    },
}
