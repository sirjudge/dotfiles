return{
    {
        'mbbill/undotree',
        event = { "BufReadPre", "BufNewFile" },
        keys = {
             {
                 "<leader>u",
                 vim.cmd.UndotreeToggle,
                 desc = "Undotree Toggle" 
             }
        },
        opts = {}
    }
}
