return {
    {
        "ThePrimeagen/harpoon",
        branch = "harpoon2",
        dependencies = { "nvim-lua/plenary.nvim" },
        config = function()
            local harpoon = require("harpoon").setup({
                settings = {
                    save_on_toggle = true
                }
            })

            vim.keymap.set("n", "<leader>h", "", { desc = "Harpoon" })
            vim.keymap.set("n", "<leader>ha", function() harpoon:list():add() end, { desc = "Add file to Harpoon" })
            vim.keymap.set("n", "<leader>he", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end, { desc = "Toggle Harpoon quick menu" })
            vim.keymap.set("n", "<leader>h1", function() harpoon:list():select(1) end, {desc = "Go to Harpoon file 1"})
            vim.keymap.set("n", "<leader>h2", function() harpoon:list():select(2) end, {desc = "Go to Harpoon file 2"})
            vim.keymap.set("n", "<leader>h3", function() harpoon:list():select(3) end, {desc = "Go to Harpoon file 3"})
            vim.keymap.set("n", "<leader>h4", function() harpoon:list():select(4) end, {desc = "Go to Harpoon file 4"})
            vim.keymap.set("n", "<leader>h5", function() harpoon:list():select(5) end, {desc = "Go to Harpoon file 5"})
        end,
    }
}
