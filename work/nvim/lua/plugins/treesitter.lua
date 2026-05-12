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

    end
}
