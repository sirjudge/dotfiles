vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
  -- initialize packer plugin
  use 'wbthomason/packer.nvim'

   -- set up telescope + plenary
  use {
	  'nvim-telescope/telescope.nvim', tag = '0.1.2',
	  requires = { {'nvim-lua/plenary.nvim'} }
  }

  use {
      'nvim-lualine/lualine.nvim',
      requires = { 'nvim-tree/nvim-web-devicons', opt = true }
  }

  --color schemes
  use({'folke/tokyonight.nvim',as = 'tokyonight'})
  use({ 'rose-pine/neovim', as = 'rose-pine' })
  -- vim.cmd.colorscheme('tokyonight')
  vim.cmd.colorscheme('rose-pine')

  use('nvim-treesitter/nvim-treesitter', { run = ':TSUpdate'})
  use('nvim-treesitter/playground', {})
  use('nvim-lua/plenary.nvim')
  use( 'ThePrimeagen/harpoon')
  use ('tpope/vim-fugitive')
  use ('github/copilot.vim')
  use({ 'numToStr/Comment.nvim',lazy = true })


  -- Display mark down real nice
  use {"ellisonleao/glow.nvim", config = function() require("glow").setup() end}


  -- DotNet stuff
  use({
      "utilyre/barbecue.nvim",
      name = "barbecue",
      version = "*",
      dependencies = {
          "SmiteshP/nvim-navic",
          "nvim-tree/nvim-web-devicons", -- optional dependency
      },
      lazy = true
  })


  --debug stuff
  use({ 'mfussenegger/nvim-dap',                        lazy = true })
  use({ "rcarriga/nvim-dap-ui",                         dependencies = { "mfussenegger/nvim-dap" }, lazy = true })
  use({ 'theHamsta/nvim-dap-virtual-text',              lazy = true })
  use({ 'nvim-telescope/telescope-dap.nvim',            lazy = true })
  use({
		'nvim-treesitter/nvim-treesitter-textobjects',
		dependencies = { 'nvim-treesitter/nvim-treesitter' },
		lazy = false,
	})

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

  -- rust
  use 'simrat39/rust-tools.nvim'

  -- Debugging
  use 'mfussenegger/nvim-dap'

end)
