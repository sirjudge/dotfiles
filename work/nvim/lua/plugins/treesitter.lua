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

      require'nvim-treesitter'.setup {
          -- Directory to install parsers and queries to (prepended to `runtimepath` to have priority)
          install_dir = vim.fn.stdpath('data') .. '/site'
      }

  end
}
