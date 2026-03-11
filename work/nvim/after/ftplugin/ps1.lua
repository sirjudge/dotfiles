vim.keymap.set(
    { "n", "x" },
    "<leader>le",
    function()
        require("powershell").eval()
    end
)
