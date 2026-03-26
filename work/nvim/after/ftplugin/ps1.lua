vim.keymap.set(
    { "n", "x" },
    "<leader>pwe",
    function()
        require("powershell").eval()
    end,
    "Powershell eval"
)

vim.keymap.set(
    "n",
    "<leader>pwt",
    function()
        require("powershell").toggle_term()
    end,
    "Powershell toggle_term"
)

