return {
    {
        "aserowy/tmux.nvim",
        event = "VeryLazy",
        config = function()
            -- TODO: Should eventually come back and make this a toggle for 
            -- windows/linux because I don't have tmux on windows
            require("tmux").setup()
        end
    }
}
