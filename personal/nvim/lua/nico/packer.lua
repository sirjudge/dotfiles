
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
  --use({'folke/tokyonight.nvim',as = 'tokyonight'})
  -- vim.cmd.colorscheme('tokyonight')
  use({ 'rose-pine/neovim', as = 'rose-pine' })
  vim.cmd.colorscheme('rose-pine')

  -- treesitter
  use('nvim-treesitter/nvim-treesitter', { run = ':TSUpdate'})
  use('nvim-treesitter/playground', {})

  -- file exploration
  use('nvim-lua/plenary.nvim')
  use( 'ThePrimeagen/harpoon')

  -- Git
  use ('tpope/vim-fugitive')

  -- Ai assitance
  use ('github/copilot.vim')

  -- ls-zero and lsp
  use 'neovim/nvim-lspconfig'
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

  -- dap + debugging
  use 'ldelossa/nvim-dap-projects'
  require("nvim-dap-projects").search_project_config()
 
  use {
      'mfussenegger/nvim-dap',
      opts = function(_, opts)
         -- add more things to the ensure_installed table protecting against community packs modifying it
         opts.ensure_installed =
         require("astronvim.utils")
             .list_insert_unique(opts.ensure_installed, {
                 "codelldb",
                 "cpptools",
             })
       end,
  }


  -- markdown and writing
  use {
        "lukas-reineke/headlines.nvim",
        after = "nvim-treesitter",
        config = function()
            require("headlines").setup()
        end,
    }

    use {
        "nvim-neorg/neorg",
        run = ":Neorg sync-parsers", -- This is the important bit!
        config = function()
            require("neorg").setup {
                load = {
                    ["core.defaults"] = {},
                    ["core.concealer"] = {},
                    ["core.dirman"] = {
                        config = {
                            workspaces = {
                                work = "~/notes/work",
                                home = "~/notes/home",
                                dnd = "~/notes/dnd",
                                journal = "~/notes/journal"
                            },
                            default_workspace = "home"
                        }
                    }
                }
            }
        end,
    }

    use {
            "folke/zen-mode.nvim",
            opts = {
                -- your configuration comes here
                -- or leave it empty to use the default settings
                -- refer to the configuration section below
            }
        }

    use {
         "christoomey/vim-tmux-navigator",
         lazy = false,
    }

    use {
        'mrcjkb/rustaceanvim',
        version = '^4', -- Recommended
        ft = { 'rust' },
    }


end)
