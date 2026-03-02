-- Highlights the current word and line the cursor is on
-- to increase readability
return {
    {
        "yamatsum/nvim-cursorline",
        opts ={
            cursorline = {
                enable = true,
                timeout = 1000,
                number = false,
            },
            cursorword = {
                enable = true,
                min_length = 3,
                hl = { underline = true },
            }
        }
    }
}
