return {
    { 
        'joeveiga/ng.nvim',
        config = function()
            local ng = require("ng")
            vim.keymap.set("n", "<leader>at", ng.goto_template_for_component, { noremap = true, silent = true, desc="Go to Angular Component Template" })
            vim.keymap.set("n", "<leader>ac", ng.goto_component_with_template_file, { noremap = true, silent = true, desc="go to component with template file" })
            vim.keymap.set("n", "<leader>aT", ng.get_template_tcb, { noremap = true, silent = true, desc="get angular template" })
        end
    },
    {
        'neovim/nvim-lspconfig',
        cmd = 'LspInfo',
        dependencies = {
            { 'saghen/blink.cmp' },
            { 'nvim-java/nvim-java' },  
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
                            vim.lsp.buf.definition()
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
            -- Setup LSP progress notifications
            vim.api.nvim_create_autocmd('LspProgress', {
                callback = function(ev)
                    local client = vim.lsp.get_client_by_id(ev.data.client_id)
                    local value = ev.data.params.value
                    if not client or type(value) ~= 'table' then
                        return
                    end
                    local message = value.message
                    if message then
                        local notification = string.format("%s: %s", client.name, message)
                        if value.percentage then
                            notification = string.format("%s (%.0f%%)", notification, value.percentage)
                        end
                        Snacks.notify(notification, { title = "LSP Progress" })
                    end
                end
            })

            local capabilities = require('blink.cmp').get_lsp_capabilities()

            vim.lsp.config('jdtls',
            {
                capabilities = capabilities,
            })
            vim.lsp.enable('jdtls')

            vim.lsp.config('lua-ls',
            {
                capabilities = capabilities,
                filetypes = { "lua" },
            })
            vim.lsp.enable('lua-ls')


            local project_library_path = "C:\\Users\\NicoJudge\\solutions"
            local global_node_modules = "C:\\Users\\NicoJudge\\AppData\\Roaming\\npm\\node_modules"
            local cmd = {"ngserver", "--stdio", "--tsProbeLocations", project_library_path .. "," .. global_node_modules, "--ngProbeLocations", project_library_path .. "," .. global_node_modules}
            vim.lsp.config('angularls',
            {
                cmd = cmd,
                filetypes = { "typescript", "html", "typescriptreact", "typescript.tsx", "htmlangular" },
                root_markers = { "angular.json", "nx.json" },
            })
            vim.lsp.enable('angularls')

            vim.lsp.config('ts_ls',
            {
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
                    "vue",
                }
            })
            vim.lsp.enable('ts_ls')

            vim.lsp.config('omnisharp', {
                cmd = {
                    "C:\\Users\\NicoJudge\\tools\\omnisharp\\OmniSharp.exe",
                    "--languageserver",
                    "--hostPID",
                    tostring(vim.fn.getpid()),
                    "--encoding",
                    "utf-8",
                    "--loglevel",
                    "Error"
                },
                enable_roslyn_analyzers = true,
                enable_import_completion = true,
                organize_imports_on_format = true,
                enable_decompilation_support = true,
                filetypes = { 'cs', 'vb', 'csproj', 'sln', 'slnx', 'props', 'csx', 'targets', 'tproj', 'slngen', 'fproj' },
                settings = {
                    FormattingOptions = {
                        EnableEditorConfigSupport = true
                    },
                    MsBuild = {},
                    RenameOptions = {},
                    RoslynExtensionsOptions = {},
                    Sdk = {
                        IncludePrereleases = true
                    }
                }
            })
            vim.lsp.enable('omnisharp')
        end
    }
}
