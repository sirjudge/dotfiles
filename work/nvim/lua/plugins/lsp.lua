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
            { 'Hoffs/omnisharp-extended-lsp.nvim' }, 
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
                organize_imports_on_format = true,
                enable_import_completion = true, 
            }
        },

        -- example using `opts` for defining servers
        config = function()
            local util = require("lspconfig.util")
            vim.lsp.handlers["window/logMessage"] = function(_, result, ctx)
                local client = vim.lsp.get_client_by_id(ctx.client_id)
                local name = client and client.name or "LSP"
                local level_map = {
                    [1] = vim.log.levels.ERROR,
                    [2] = vim.log.levels.WARN,
                    [3] = vim.log.levels.INFO,
                    [4] = vim.log.levels.DEBUG,
                }
                local level = level_map[result.type] or vim.log.levels.INFO
                local message = result.message or ""
                if message ~= "" then
                    if level == vim.log.levels.INFO then
                        return
                    end
                    if name == "omnisharp" then
                        if message:find("LspServerOutputFilter", 1, true)
                            or message:find("o#/msbuildprojectdiagnostics", 1, true)
                            or message:find("Tried to send request or notification before initialization was completed", 1, true) then
                            return
                        end
                    end
                    vim.notify(string.format("%s: %s", name, message), level, { title = "LSP Log" })
                end
            end
            local capabilities = require('blink.cmp').get_lsp_capabilities()

            -- vim.lsp.config('jdtls',
            -- {
            --     capabilities = capabilities,
            -- })
            -- vim.lsp.enable('jdtls')

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
                capabilities = capabilities,
                filetypes = { "typescript", "html", "typescriptreact", "typescript.tsx", "htmlangular" },
                root_markers = { "angular.json", "nx.json" },
            })
            vim.lsp.enable('angularls')

            vim.lsp.config('ts_ls',
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
                    "vue",
                }
            })
            vim.lsp.enable('ts_ls')

            vim.lsp.config('omnisharp', {
                capabilities = capabilities,
                cmd = {
                    "C:\\Users\\NicoJudge\\.dotnet\\dotnet.exe",
                    "C:\\Users\\NicoJudge\\tools\\omnisharp\\OmniSharp.dll",
                    "--languageserver",
                    "--hostPID",
                    tostring(vim.fn.getpid()),
                },
                cmd_env = {
                    DOTNET_ROOT = "C:\\Users\\NicoJudge\\.dotnet",
                    DOTNET_MSBUILD_SDK_RESOLVER_CLI_DIR = "C:\\Users\\NicoJudge\\.dotnet",
                    DOTNET_MULTILEVEL_LOOKUP = "0",
                    MSBuildSDKsPath = "C:\\Users\\NicoJudge\\.dotnet\\sdk\\10.0.102\\Sdks",
                    PATH = "C:\\Users\\NicoJudge\\.dotnet;" .. vim.env.PATH,
                },
                capabilities = capabilities,
                enable_roslyn_analyzers = true,
                organize_imports_on_format = true,
                enable_decompilation_support = true,
                on_attach = function(client, bufnr)
                    client.server_capabilities.semanticTokensProvider = nil
                end,
                filetypes = { 'cs', 'vb', 'csproj', 'sln', 'slnx', 'props', 'csx', 'targets', 'tproj', 'slngen', 'fproj' },
                settings = {
                    omnisharp = {
                        useModernNet = true,
                    },
                    MsBuild = {
                        LoadProjectsOnDemand = true,
                        EnablePackageAutoRestore = true,
                    },
                    RoslynExtensionsOptions = {
                        enableAnalyzersSupport = true,
                    }, 
                },
            })
            vim.lsp.enable('omnisharp')
        end
    }
}
