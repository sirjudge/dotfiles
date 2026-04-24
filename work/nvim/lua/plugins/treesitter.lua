return {
    'nvim-treesitter/nvim-treesitter',
    lazy = false,
    build = ':TSUpdate',
    config = function()
        require'nvim-treesitter'.install {
            'rust',
            'javascript',
            'angular',
            'c_sharp',
            'dockerfile',
            'editorconfig',
            'zsh',
            'xml',
            'typescript',
            'yaml',
            'powershell'
        }

        vim.api.nvim_create_autocmd("FileType", {
            pattern = { "<filetype>" },
            callback = function()
                vim.wo[0][0].foldexpr = "v:lua.vim.treesitter.foldexpr()"
                vim.wo[0][0].foldmethod = "expr"
                vim.treesitter.start()
            end,
        })
    end
}
