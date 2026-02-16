return {
    {
        'joeveiga/ng.nvim',
        config = function()
            local is_windows = vim.fn.has("win32") == 1
            if is_windows then
                local dotnet_root = vim.fn.expand("$USERPROFILE") .. "\\.dotnet"
                vim.env.DOTNET_ROOT = dotnet_root
                vim.env.DOTNET_ROOT_X64 = dotnet_root
                vim.env.PATH = dotnet_root .. ";" .. dotnet_root .. "\\tools;" .. (vim.env.PATH or "")
            end
            local ng = require("ng")
            vim.keymap.set("n", "<leader>a", "", { desc = "angular" })
            vim.keymap.set("n", "<leader>at", ng.goto_template_for_component,
                { noremap = true, silent = true, desc = "Go to Angular Component Template" })
            vim.keymap.set("n", "<leader>ac", ng.goto_component_with_template_file,
                { noremap = true, silent = true, desc = "go to component with template file" })
            vim.keymap.set("n", "<leader>aT", ng.get_template_tcb,
                { noremap = true, silent = true, desc = "get angular template" })
        end
    },
    {
        'neovim/nvim-lspconfig',
        event = { 'BufReadPre', 'BufNewFile' },
        cmd = 'LspInfo',
        dependencies = {
            { 'saghen/blink.cmp' },
        },
        keys = {
            {
                "gd",
                function()
                    vim.lsp.buf.definition()
                end,
                desc = "Goto Definition"
            },
            {
                "<leader>gr",
                function()
                    vim.lsp.buf.references()
                end,
                desc = "Goto References"
            },
            {
                "<leader>gi",
                function()
                    vim.lsp.buf.implementation()
                end,
                desc = "lsp implementation"
            },
            {
                "<leader>lh",
                function()
                    vim.lsp.buf.hover()
                end,
                desc = "LSP hover"
            },
            {
                "<leader>lca",
                function()
                    vim.lsp.buf.code_action()
                end,
                desc = "lsp code action"
            },
            {
                "<leader>lf",
                function()
                    vim.lsp.buf.format({ async = true })
                end,
                desc = "lsp format"
            },
        },
        opts = {
            servers = {
                organize_imports_on_format = true,
                enable_import_completion = true,
            }
        },
        config = function()
            local float_border = "rounded"
            local float_opts = {
                border = float_border,
                max_width = 80,
                max_height = 20,
                focusable = false,
            }
            vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, float_opts)
            vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, float_opts)
            vim.diagnostic.config({
                float = {
                    border = float_border,
                    source = "if_many",
                    header = "",
                    prefix = " ",
                },
            })
            -- Note: Need to come back and figure out why this exists
            vim.lsp.handlers["window/showMessage"] = function(_, result, ctx)
                local client = vim.lsp.get_client_by_id(ctx.client_id)
                local name = client and client.name or "LSP"
                if name == "copilot" then
                    return
                end
                local level = ({ "ERROR", "WARN", "INFO", "LOG" })[result.type] or "UNKOWN"
                if message ~= "" then
                    Snacks.notify(result.message, {
                        title = client and client.name or "LSP",
                        level = vim.log.levels[level]
                    })
                end
            end

            vim.lsp.handlers["window/logMessage"] = function(_, result, ctx)
                local client = vim.lsp.get_client_by_id(ctx.client_id)
                local name = client and client.name or "LSP"
                if name == "copilot" then
                    return
                end
                local level = ({ "ERROR", "WARN", "INFO", "LOG" })[result.type] or "UNKOWN"
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
            local cmd = { "ngserver", "--stdio", "--tsProbeLocations", project_library_path .. "," .. global_node_modules,
                "--ngProbeLocations", project_library_path .. "," .. global_node_modules }

            vim.lsp.config['harper-ls'] = {
                cmd = cmd,
                capabilities = capabilities,
            }

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
                            languages = { "javascript", "typescript", "vue" },
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

            local csharp_cmd_env = nil
            if not is_windows then
                csharp_cmd_env = {
                    DOTNET_ROOT = "/nix/store/vbbna5qax4agd3mf2cv94zn9j1kjapr0-dotnet-combined/share/dotnet",
                }
            end

            vim.lsp.config['csharp_ls'] = {
                capabilities = capabilities,
                cmd = {
                    "csharp-ls",
                    "--loglevel",
                    "warning"
                },
                cmd_env = csharp_cmd_env,
                filetypes = { 'cs' },
                root_markers = { '*.sln', '*.csproj', 'Directory.Build.props', '.git' },
            }
            vim.lsp.enable('csharp_ls')
        end
    }
}
