return {
    {
        'akinsho/toggleterm.nvim',
        version = "*",
        keys = {
            {'<leader>tt', "<cmd>:ToggleTerm direction=horizontal size=20 border=curved<CR>", desc = "Toggle terminal"},
            {'<leader>tts',
            function ()
                local trim_spaces = true
                require("toggleterm")
                    .send_lines_to_terminal("single_line", trim_spaces, { args = vim.v.count })
            end,
            desc = "Open terminal in split"}
        },
        opts = {
            close_on_exit = true,
            start_in_insert = true,
            hide_numbers = true,
            direction = 'vertical',
            persist_mode = true,
            size = 30,
            border = 'curved'
        },
        config = function ()
            require("toggleterm").setup({})
        end
    }
}
