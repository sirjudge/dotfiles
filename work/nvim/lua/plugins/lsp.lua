return {
    {
        {
            'VonHeikemen/lsp-zero.nvim',
            branch = 'v4.x',
            lazy = true,
            config = false,
        },

        -- Autocompletion
        {
            'hrsh7th/nvim-cmp',
            event = 'InsertEnter',
            config = function()
                local cmp = require('cmp')

                cmp.setup({
                    sources = {
                        {name = 'nvim_lsp'},
                    },
                    mapping = cmp.mapping.preset.insert({
                        ['<C-Space>'] = cmp.mapping.complete(),
                        ['<C-u>'] = cmp.mapping.scroll_docs(-4),
                        ['<C-d>'] = cmp.mapping.scroll_docs(4),
                    }),
                    snippet = {
                        expand = function(args)
                            vim.snippet.expand(args.body)
                        end,
                    },
                })
            end
        },

        -- LSP
        {
            'neovim/nvim-lspconfig',
            cmd = 'LspInfo',
            event = {'BufReadPre', 'BufNewFile'},
            dependencies = {
                {'hrsh7th/cmp-nvim-lsp'},
            },
            init = function()
                -- Reserve a space in the gutter
                -- This will avoid an annoying layout shift in the screen
                vim.opt.signcolumn = 'yes'
            end,
            config = function()
                local lsp_defaults = require('lspconfig').util.default_config

                -- Add cmp_nvim_lsp capabilities settings to lspconfig
                -- This should be executed before you configure any language server
                lsp_defaults.capabilities = vim.tbl_deep_extend(
                    'force',
                    lsp_defaults.capabilities,
                    require('cmp_nvim_lsp').default_capabilities()
                )

                -- LspAttach is where you enable features that only work
                -- if there is a language server active in the file
                vim.api.nvim_create_autocmd('LspAttach', {
                    desc = 'LSP actions',
                    callback = function(event)
                        local opts = {buffer = event.buf}

                        vim.keymap.set('n', 'K', '<cmd>lua vim.lsp.buf.hover()<cr>', opts)
                        vim.keymap.set('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>', opts)
                        vim.keymap.set('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>', opts)
                        vim.keymap.set('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<cr>', opts)
                        vim.keymap.set('n', 'go', '<cmd>lua vim.lsp.buf.type_definition()<cr>', opts)
                        vim.keymap.set('n', 'gr', '<cmd>lua vim.lsp.buf.references()<cr>', opts)
                        vim.keymap.set('n', 'gs', '<cmd>lua vim.lsp.buf.signature_help()<cr>', opts)
                        vim.keymap.set('n', '<F2>', '<cmd>lua vim.lsp.buf.rename()<cr>', opts)
                        vim.keymap.set({'n', 'x'}, '<F3>', '<cmd>lua vim.lsp.buf.format({async = true})<cr>', opts)
                        vim.keymap.set('n', '<F4>', '<cmd>lua vim.lsp.buf.code_action()<cr>', opts)
                    end,
                })

                -- These are just examples. Replace them with the language
                -- servers you have installed in your system
                require('lspconfig').gopls.setup({
                    cmd = {"gopls", "serve"},
                    settings = {
                        gopls = {
                            analyses = { unusedparams = true},
                            staticcheck = true
                        }
                    }
                })

                require('lspconfig').omnisharp.setup({
                    cmd = { "dotnet", "/home/nicholas.judge/.local/share/nvim/mason/packages/omnisharp/libexec/OmniSharp.dll"},
                    settings = {
                        FormattingOptions = {
                            -- Enables support for reading code style, naming convention and analyzer
                            -- settings from .editorconfig.
                            EnableEditorConfigSupport = false,

                            -- Specifies whether 'using' directives should be grouped and sorted during
                            -- document formatting.
                            OrganizeImports = nil,
                        },
                        MsBuild = {
                            -- If true, MSBuild project system will only load projects for files that
                            -- were opened in the editor. This setting is useful for big C# codebases
                            -- and allows for faster initialization of code navigation features only
                            -- for projects that are relevant to code that is being edited. With this
                            -- setting enabled OmniSharp may load fewer projects and may thus display
                            -- incomplete reference lists for symbols.
                            LoadProjectsOnDemand = nil,
                        },
                        RoslynExtensionsOptions = {
                            -- Enables support for roslyn analyzers, code fixes and rulesets.
                            EnableAnalyzersSupport = true,
                            -- Enables support for showing unimported types and unimported extension
                            -- methods in completion lists. When committed, the appropriate using
                            -- directive will be added at the top of the current file. This option can
                            -- have a negative impact on initial completion responsiveness,
                            -- particularly for the first few completion sessions after opening a
                            -- solution.
                            EnableImportCompletion = true,
                            -- Only run analyzers against open files when 'enableRoslynAnalyzers' is
                            -- true
                            AnalyzeOpenDocumentsOnly = nil,
                        },
                        Sdk = {
                            -- Specifies whether to include preview versions of the .NET SDK when
                            -- determining which version to use for project loading.
                            IncludePrereleases = true,
                        },
                    },
                })
            end
        }
    }}
