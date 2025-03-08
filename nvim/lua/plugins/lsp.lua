return {
    {
        'neovim/nvim-lspconfig',
        cmd = 'LspInfo',
        dependencies = {
            { 'saghen/blink.cmp' },
            { "ms-jpq/coq_nvim"}, 
            { "ms-jpq/coq.artifacts", branch = "artifacts" },
        },
        -- example using `opts` for defining servers
        config = function()
            local capabilities = require('blink.cmp').get_lsp_capabilities()
            local lspconfig = require "lspconfig"
            local coq = require "coq"

            lspconfig['lua-ls'].setup({ capabilities = capabilities })

            lspconfig['bashls'].setup(coq.lsp_ensure_capabilities(
            {
                capabilities = capabilities,
                cmd = { "bash-language-server", "start" },
                filetypes = { "sh", "bash" },
            }))

            lspconfig['ts_ls'].setup(coq.lsp_ensure_capabilities({
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

            lspconfig['omnisharp'].setup(coq.lsp_ensure_capabilities({
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
}
