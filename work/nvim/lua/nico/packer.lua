vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
  -- initialize packer plugin
  use 'wbthomason/packer.nvim'

   -- set up telescope + plenary
  use {
	  'nvim-telescope/telescope.nvim', tag = '0.1.2',
	  requires = { {'nvim-lua/plenary.nvim'} }
  }

  
  --color schemes
  use({'folke/tokyonight.nvim',as = 'tokyonight'})
  use({ 'rose-pine/neovim', as = 'rose-pine' })
 -- vim.cmd.colorscheme('tokyonight')

  use('nvim-treesitter/nvim-treesitter', { run = ':TSUpdate'})
  use('nvim-treesitter/playground', {})
  use('nvim-lua/plenary.nvim')
  use( 'ThePrimeagen/harpoon')
  use ('tpope/vim-fugitive')
  use ('github/copilot.vim')

  -- ls-zero stuff
  use {
	  'VonHeikemen/lsp-zero.nvim',
	  branch = 'v2.x',
	  requires = {
		  -- LSP Support
		  {'neovim/nvim-lspconfig'},             -- Required
		  {'williamboman/mason.nvim'},           -- Optional
		  {'williamboman/mason-lspconfig.nvim'}, -- Optional

		  -- Autocompletion
		  {'hrsh7th/nvim-cmp'},     -- Required
		  {'hrsh7th/cmp-nvim-lsp'}, -- Required
		  {'L3MON4D3/LuaSnip'},     -- Required
	  }
  }

end)
