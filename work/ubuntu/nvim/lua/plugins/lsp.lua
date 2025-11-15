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

            local project_library_path = "/home/nico/.angular"
            vim.lsp.config('angularls', {
                cmd = {"ngserver", "--stdio", "--tsProbeLocations", project_library_path , "--ngProbeLocations", project_library_path},
            })
            vim.lsp.enable('angularls')


            vim.lsp.config('omnisharp', coq.lsp_ensure_capabilities({
                capabilities = capabilities,
                enable_roslyn_analysers = true,
				enable_import_completion = true,
				organize_imports_on_format = true,
				enable_decompilation_support = true,
				filetypes = { 'cs', 'vb', 'csproj', 'sln', 'slnx', 'props', 'csx', 'targets', 'tproj', 'slngen', 'fproj' },
            }))
            vim.lsp.enable('omnisharp')

        end
    }
}
