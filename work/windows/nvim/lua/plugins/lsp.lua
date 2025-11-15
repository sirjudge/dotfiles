return {
    {
        'neovim/nvim-lspconfig',
        cmd = 'LspInfo',
        dependencies = {
            { 'saghen/blink.cmp' },
            { "ms-jpq/coq_nvim"}, 
            { "ms-jpq/coq.artifacts", branch = "artifacts" },
            { 'nvim-java/nvim-java' },  -- Add nvim-java as a dependency
        },
        opts = {
            servers = {
                handlers = {
                    ["textDocument/definition"] = function(...)
                        return require("omnisharp_extended").handler(...)
                    end,
                },
                keys = {
                    {
                        "gd",
                        function()
                            require("omnisharp_extended").telescope_lsp_definitions()
                        end,
                        desc = "Goto Definition"
                    },
                },
                enable_roslyn_analyzers = true,
                organize_imports_on_format = true,
                enable_import_completion = true, 
            }
        },
        -- example using `opts` for defining servers
        config = function()
            local capabilities = require('blink.cmp').get_lsp_capabilities()
            local lspconfig = require "lspconfig"
            local coq = require "coq"

            -- require('java').setup()
            vim.lsp.config('jdtls',coq.lsp_ensure_capabilities(
            {
                capabilities = capabilities,
            }))
            vim.lsp.enable('jdtls')

            vim.lsp.config('lua-ls',coq.lsp_ensure_capabilities(
            {
                capabilities = capabilities,
            }))
            vim.lsp.enable('lua-ls')
            
            vim.lsp.config('bashls',coq.lsp_ensure_capabilities(
            {
                capabilities = capabilities,
                cmd = { "bash-language-server", "start" },
                filetypes = { "sh", "bash" },
            }))
            vim.lsp.enable('bashls')

            vim.lsp.config('ts_ls',coq.lsp_ensure_capabilities({
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
            vim.lsp.enable('ts_ls')
            
            vim.lsp.config('omnisharp', coq.lsp_ensure_capabilities({
                capabilities = capabilities,
                enable_roslyn_analysers = true,
				enable_import_completion = true,
				organize_imports_on_format = true,
				enable_decompilation_support = true,
				filetypes = { 'cs', 'vb', 'csproj', 'sln', 'slnx', 'props', 'csx', 'targets', 'tproj', 'slngen', 'fproj' },
            }))
            vim.lsp.enable('omnisharp')

            -- vim.lsp.config('omnisharp',coq.lsp_ensure_capabilities({
            --     capabilities = capabilities,
            --     cmd = { "dotnet", "/home/nico/.local/share/nvim/mason/packages/omnisharp/OmniSharp.dll"},
            --     settings = {
            --         FormattingOptions = {
            --             -- Enables support for reading code style, naming convention and analyzer
            --             -- settings from .editorconfig.
            --             EnableEditorConfigSupport = true,
            --
            --             -- Specifies whether 'using' directives should be grouped and sorted during
            --             -- document formatting.
            --             OrganizeImports = true,
            --         },
            --         MsBuild = {
            --             -- If true, MSBuild project system will only load projects for files that
            --             -- were opened in the editor. This setting is useful for big C# codebases
            --             -- and allows for faster initialization of code navigation features only
            --             -- for projects that are relevant to code that is being edited. With this
            --             -- setting enabled OmniSharp may load fewer projects and may thus display
            --             -- incomplete reference lists for symbols.
            --             LoadProjectsOnDemand = false,
            --         },
            --         RoslynExtensionsOptions = {
            --             -- Enables support for roslyn analyzers, code fixes and rulesets.
            --             EnableAnalyzersSupport = true,
            --             -- Enables support for showing unimported types and unimported extension
            --             -- methods in completion lists. When committed, the appropriate using
            --             -- directive will be added at the top of the current file. This option can
            --             -- have a negative impact on initial completion responsiveness,
            --             -- particularly for the first few completion sessions after opening a
            --             -- solution.
            --             EnableImportCompletion = true,
            --             -- Only run analyzers against open files when 'enableRoslynAnalyzers' is
            --             -- true
            --             AnalyzeOpenDocumentsOnly = nil,
            --         },
            --         Sdk = {
            --             -- Specifies whether to include preview versions of the .NET SDK when
            --             -- determining which version to use for project loading.
            --             IncludePrereleases = false,
            --         },
            --     },
            -- }))
            -- vim.lsp.enable('omnisharp')
        end
    }
}
