return {
    {
        'nvim-telescope/telescope.nvim',
        dependencies = { 'nvim-lua/plenary.nvim' },
        config = function()
            local builtin = require('telescope.builtin')
            vim.keymap.set('n', '<leader>pf', builtin.find_files, {})
            vim.keymap.set('n', '<C-p>', builtin.git_files, {})
            vim.keymap.set('n', '<leader>ph', builtin.help_tags, {})
            vim.keymap.set('n', '<leader>ps', function()
                builtin.grep_string({ search = vim.fn.input("Grep > ") }
                );
            end)
            vim.keymap.set("n", "gd", "<cmd>Telescope lsp_definitions<cr>")
            require('telescope').load_extension('ecolog')

            require('telescope').setup({
                extensions = {
                    ecolog = {
                        shelter = {
                            -- Whether to show masked values when copying to clipboard
                            mask_on_copy = false,
                        },
                        -- Default keybindings
                        mappings = {
                            -- Key to copy value to clipboard
                            copy_value = "<C-y>",
                            -- Key to copy name to clipboard
                            copy_name = "<C-n>",
                            -- Key to append value to buffer
                            append_value = "<C-a>",
                            -- Key to append name to buffer (defaults to <CR>)
                            append_name = "<CR>",
                        },
                    }
                }
            })
        end
    }
}
