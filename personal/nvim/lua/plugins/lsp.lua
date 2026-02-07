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
        event = { 'BufReadPre', 'BufNewFile' },
        cmd = 'LspInfo',
        dependencies = {
            { 'saghen/blink.cmp' },
        },
        opts = {
            servers = {
                keys = {
                    {
                        "gd",
                        function()
                            vim.lsp.buf.definition()
                        end,
                        desc = "Goto Definition"
                    },
                    {
                        "gr",
                        function()
                            vim.lsp.buf.references()
                        end,
                        desc = "Goto References"
                    },
                    {
                        "gi",
                        function()
                            vim.lsp.buf.implmentation()
                        end,
                        desc = "Goto Implementation"
                    },
                    {
                        "k",
                        function()
                            vim.lsp.buf.hover()
                        end,
                        desc = "hover"
                    },
                    {
                        "<leader>ca",
                        function()
                            vim.lsp.buf.code_action()
                        end,
                        desc = "lsp code action"
                    },
                    {
                        "<leader>f",
                        function()
                            vim.lsp.buf.format({async = true})
                        end,
                        desc = "lsp code action"
                    },
                },
                organize_imports_on_format = true,
                enable_import_completion = true, 
            }
        },

        config = function()

            vim.lsp.handlers["window/showMessage"] = function(_, result, ctx)
                local client = vim.lsp.get_client_by_id(ctx.client_id)
                local level = ({ "ERROR", "WARN", "INFO", "LOG" })[result.type] or "INFO"
                Snacks.notify(result.message, { 
                    title = client and client.name or "LSP",
                    level = vim.log.levels[level]
                })
            end


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
                        if message:find("Policy watcher not available", 1, true) then
                            return
                        end
                    end
                    Snacks.notify(message, { title = name, level = level })
                end
            end
            local capabilities = require('blink.cmp').get_lsp_capabilities()

            vim.lsp.config['lua_ls'] = {
                cmd = { "lua-language-server" },
                capabilities = capabilities,
                filetypes = { "lua" },
                root_markers = { '.git', '.luarc.json', '.luarc.jsonc', '.luacheckrc', 'stylua.toml', 'selene.toml' },
            }
            vim.lsp.enable('lua_ls')

            local project_library_path = "C:\\Users\\NicoJudge\\solutions"
            local global_node_modules = "C:\\Users\\NicoJudge\\AppData\\Roaming\\npm\\node_modules"
            local cmd = {"ngserver", "--stdio", "--tsProbeLocations", project_library_path .. "," .. global_node_modules, "--ngProbeLocations", project_library_path .. "," .. global_node_modules}
            
            vim.lsp.config['angularls'] = {
                cmd = cmd,
                capabilities = capabilities,
                filetypes = { "typescript", "html", "typescriptreact", "typescript.tsx", "htmlangular" },
                root_markers = { "angular.json", "nx.json" },
            }
            vim.lsp.enable('angularls')

            vim.lsp.config['ts_ls'] = {
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
            }
            vim.lsp.enable('ts_ls')

            vim.lsp.config['csharp_ls'] = {
                capabilities = capabilities,
                cmd = { "csharp-ls" },
                cmd_env = {
                    DOTNET_ROOT = "/nix/store/vbbna5qax4agd3mf2cv94zn9j1kjapr0-dotnet-combined/share/dotnet",
                },
                filetypes = { 'cs' },
                root_markers = { '*.sln', '*.csproj', 'Directory.Build.props', '.git' },
                handlers = {
                    ["window/showMessage"] = function(_, result, ctx)
                        local client = vim.lsp.get_client_by_id(ctx.client_id)
                        local level = ({ "ERROR", "WARN", "INFO", "LOG" })[result.type] or "INFO"
                        Snacks.notify(result.message, { 
                            title = client and client.name or "LSP",
                            level = vim.log.levels[level]
                        })
                    end,
                },
            }
            vim.lsp.enable('csharp_ls')
        end
    }
}
