return {
    'MeanderingProgrammer/render-markdown.nvim',
    ft = { 'markdown' },
    dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.nvim' }, -- if you use the mini.nvim suite
    opts = {
    },
    config = function()
        require('render-markdown').setup({
            completions = {
                blink = { enabled = true }
            },
            latex = { enabled = false },
            html = { enabled = false },
            yaml = { enabled = false },
        })    end
}
