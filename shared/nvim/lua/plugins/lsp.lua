return {
    {
        {
            'VonHeikemen/lsp-zero.nvim',
            branch = 'v4.x',
            config = false,
        },
        {
            'ms-jpq/coq_nvim',
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
                        -- `Enter` key to confirm completion
                        ['<CR>'] = cmp.mapping.confirm({select = false}),
                        -- Ctrl+Space to trigger completion menu
                        ['<C-Space>'] = cmp.mapping.complete(),
                        -- unmap tab and shift tab because copilot should use those
                        ['<Tab>'] = nil,
                        ['<S-Tab>'] = nil,
                        -- Navigate between cmp items
                        ['<C-j>'] = cmp.mapping.select_next_item({behavior = cmp.SelectBehavior.Select}),
                        ['<C-k>'] = cmp.mapping.select_prev_item({behavior = cmp.SelectBehavior.Select})
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
--                {'hrsh7th/cmp-nvim-lsp'},
                { 'saghen/blink.cmp' }
            },
            init = function()
                -- Reserve a space in the gutter
                -- This will avoid an annoying layout shift in the screen
                vim.opt.signcolumn = 'yes'
            end,
            config = function()
                local lsp_config = require('lspconfig').util.default_config
                local coq = require('coq')
                local capabilities = require('blink.cmp').get_lsp_capabilities()

                -- Add cmp_nvim_lsp capabilities settings to lspconfig
                -- This should be executed before you configure any language server
                lsp_config.capabilities = vim.tbl_deep_extend(
                    'force',
                    lsp_config.capabilities,
                    capabilities
                    --require('cmp_nvim_lsp').default_capabilities()
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

                require'lspconfig'.html.setup(coq.lsp_ensure_capabilities({
                    capabilities = capabilities,
                    filetypes = { "html", "cshtml" },
                    init_options = {
                        configurationSection = { "html", "css", "javascript" },
                        embeddedLanguages = {
                            css = true,
                            javascript = true
                        }
                    }
                }))

                -- These are just examples. Replace them with the language
                -- servers you have installed in your system
                require('lspconfig').gopls.setup(coq.lsp_ensure_capabilities({
                    capabilities = capabilities,
                    cmd = {"gopls", "serve"},
                    settings = {
                        gopls = {
                            analyses = { unusedparams = true},
                            staticcheck = true
                        }
                    }
                }))


                require'lspconfig'.lua_ls.setup(coq.lsp_ensure_capabilities({
                    capabilities = capabilities,
                    on_init = function(client)
                        if client.workspace_folders then
                            local path = client.workspace_folders[1].name
                            if vim.uv.fs_stat(path..'/.luarc.json') or vim.uv.fs_stat(path..'/.luarc.jsonc') then
                                return
                            end
                        end

                        client.config.settings.Lua = vim.tbl_deep_extend('force', client.config.settings.Lua, {
                            runtime = {
                                -- Tell the language server which version of Lua you're using
                                -- (most likely LuaJIT in the case of Neovim)
                                version = 'LuaJIT'
                            },
                            -- Make the server aware of Neovim runtime files
                            workspace = {
                                checkThirdParty = false,
                                library = {
                                    vim.env.VIMRUNTIME
                                    -- Depending on the usage, you might want to add additional paths here.
                                    -- "${3rd}/luv/library"
                                    -- "${3rd}/busted/library",
                                }
                                -- or pull in all of 'runtimepath'. NOTE: this is a lot slower and will cause issues when working on your own configuration (see https://github.com/neovim/nvim-lspconfig/issues/3189)
                                -- library = vim.api.nvim_get_runtime_file("", true)
                            }
                        })
                    end,
                    settings = {
                        Lua = {}
                    }
                }))

                require('lspconfig').ts_ls.setup(coq.lsp_ensure_capabilities(
                {
                    capabilities = capabilities,
                    init_options = {
                        plugins = {
                            {
                                name = "@vue/typescript-plugin",
                                location = "/usr/local/lib/node_modules/@vue/typescript-plugin",
                                languages = {"javascript", "typescript", "vue"},
                            },
                        },
                    },
                    filetypes = {
                        "javascript",
                        "typescript",
                        "vue"
                    }
                }))

                require('lspconfig').eslint.setup(coq.lsp_ensure_capabilities({
                    capabilities = capabilities,
                    on_attach = function(client, bufnr)
                        vim.api.nvim_create_autocmd("BufWritePre", {
                            buffer = bufnr,
                            command = "EslintFixAll",
                        })
                    end
                }))

                require('lspconfig').omnisharp.setup(coq.lsp_ensure_capabilities({
                    capabilities = capabilities,
                    cmd = { "dotnet", "/home/nicholas.judge/.local/share/nvim/mason/packages/omnisharp/libexec/OmniSharp.dll"},
                    settings = {
                        FormattingOptions = {
                            -- Enables support for reading code style, naming convention and analyzer
                            -- settings from .editorconfig.
                            EnableEditorConfigSupport = true,

                            -- Specifies whether 'using' directives should be grouped and sorted during
                            -- document formatting.
                            OrganizeImports = true,
                        },
                        MsBuild = {
                            -- If true, MSBuild project system will only load projects for files that
                            -- were opened in the editor. This setting is useful for big C# codebases
                            -- and allows for faster initialization of code navigation features only
                            -- for projects that are relevant to code that is being edited. With this
                            -- setting enabled OmniSharp may load fewer projects and may thus display
                            -- incomplete reference lists for symbols.
                            LoadProjectsOnDemand = false,
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
                            IncludePrereleases = false,
                        },
                    },
                }))
            end
        }
    }}
