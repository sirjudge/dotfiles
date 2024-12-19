return {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    ---@type snacks.Config
    opts = {
        animate = {
            enabled = true,
            fps = 60,
            duration = 20
        },
        bigfile = { enabled = true },
        dashboard = {
            enabled = true,
            width = 60,
            row = nil, -- dashboard position. nil for center
            col = nil, -- dashboard position. nil for center
            pane_gap = 4, -- empty columns between vertical panes
            autokeys = "1234567890abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ", -- autokey sequence
            -- These settings are used by some built-in sections
            preset = {
                -- Defaults to a picker that supports `fzf-lua`, `telescope.nvim` and `mini.pick`
                ---@type fun(cmd:string, opts:table)|nil
                pick = nil,
                -- Used by the `keys` section to show keymaps.
                -- Set your custom keymaps here.
                -- When using a function, the `items` argument are the default keymaps.
                ---@type snacks.dashboard.Item[]
                keys = {
                    { icon = " ", key = "f", desc = "Find File", action = ":lua Snacks.dashboard.pick('files')" },
                    { icon = " ", key = "n", desc = "New File", action = ":ene | startinsert" },
                    { icon = " ", key = "g", desc = "Find Text", action = ":lua Snacks.dashboard.pick('live_grep')" },
                    { icon = " ", key = "r", desc = "Recent Files", action = ":lua Snacks.dashboard.pick('oldfiles')" },
                    { icon = " ", key = "c", desc = "Config", action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})" },
                    { icon = " ", key = "s", desc = "Restore Session", section = "session" },
                    { icon = "󰒲 ", key = "L", desc = "Lazy", action = ":Lazy", enabled = package.loaded.lazy ~= nil },
                    { icon = " ", key = "q", desc = "Quit", action = ":qa" },
                },
                -- Used by the `header` section
                header = [[
                ⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠿⠿⢟⣛⣛⣛⣉⣉⣉⣙⣛⣛⣛⠻⠿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿
                ⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠿⢋⣥⣶⡿⠟⠅⡿⠿⠿⠾⠿⠿⠍⠛⠋⢿⣶⣦⣍⡻⢿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿
                ⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠟⠡⠾⢟⣋⣀⣠⣤⣴⣶⣶⣶⣾⣿⣷⣶⣶⣶⣬⣁⣉⣙⠻⠦⣉⠿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿
                ⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠿⢟⣡⣴⣶⣾⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡿⢿⣿⣿⣿⣿⣶⣦⣀⠙⢿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿
                ⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠿⢛⣡⣾⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠿⠿⠛⢉⣴⣿⣿⣿⣿⣿⣿⣿⣿⣿⣦⣉⠻⢿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿
                ⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡿⠟⣡⡾⠟⣻⣿⣿⣿⣿⣿⣿⣿⣿⣿⡿⠛⠉⠁⠀⠀⠀⠀⠀⠴⢿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣦⣙⠻⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿
                ⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡿⢋⣤⡞⡣⢐⣾⣿⣿⣿⣿⣿⣿⡿⠟⠋⠀⠀⠀⢠⣦⠀⠀⠀⠀⡀⠀⠀⠀⠉⠻⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡿⢟⢳⡌⠻⣿⣿⣿⣿⣿⣿⣿⣿
                ⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⢋⣴⠟⡡⢪⢜⡯⣿⣿⢉⡭⢛⠟⠋⠀⠀⠀⣠⣾⠀⣿⣿⣆⠀⠀⠀⢱⣄⠀⠀⠀⠀⠀⠙⠿⣿⢿⡛⢿⡛⣿⢷⡘⡦⣦⢹⣦⠘⣿⣿⣿⣿⣿⣿⣿
                ⣿⣿⣿⣿⣿⣿⣿⣿⡿⢡⣾⢋⣼⣼⡵⣡⣪⠟⢁⣤⠒⠁⠀⠀⠀⢀⣼⣿⣿⠀⣿⣿⣿⣦⠀⠀⠈⣿⣧⡀⠀⠀⠀⠀⠀⠈⠳⢝⢂⠋⢻⡁⡐⡐⣙⣦⡍⣷⡈⢿⣿⣿⣿⣿⣿
                ⣿⣿⣿⣿⣿⣿⣿⡟⢀⣿⣿⣿⣿⣿⡟⣱⠟⣠⣿⠁⠀⠀⠀⡄⢀⣾⣿⣿⣿⡄⣿⣿⣿⣿⣷⣄⠀⢹⣿⣿⡄⠀⢠⠀⠀⠀⠀⠀⠀⠁⠡⢴⣴⣾⣿⣿⣿⣿⣿⡄⢻⣿⣿⣿⣿
                ⣿⣿⣿⣿⣿⣿⡿⢠⣿⣿⣿⣿⣿⣿⠖⣧⣎⣾⠁⠀⠀⢀⡜⠠⠟⠛⠿⢿⣿⣿⣿⣿⣿⣿⣿⣿⣦⠈⠛⣻⣭⣄⠀⣧⠀⠀⠀⠹⣷⠳⡄⠘⠟⢻⣿⣿⣿⣿⣿⣿⡄⢻⣿⣿⣿
                ⣿⣿⣿⣿⣿⡿⢠⡟⡸⠻⠛⠹⣿⡟⠸⣿⣿⠁⠀⠀⠀⣼⢃⣾⣿⣿⣿⣷⣶⣿⣿⣿⣿⣿⣿⣿⣿⣿⣷⣿⣿⣿⣦⢹⡆⠀⠀⠀⠹⠓⠸⡄⠜⠇⠆⠉⣿⣿⣿⣿⣿⠈⣿⣿⣿
                ⣿⣿⣿⣿⡿⠀⡿⢀⠁⠃⠇⡆⢻⢰⢰⡆⢁⡀⠀⠀⣰⣿⣿⣿⡿⠿⢿⣿⣿⣿⣿⣧⠹⣿⣿⣿⣿⣿⡿⠟⠛⠙⠛⢿⣿⠀⠀⠀⠀⠀⢄⠰⣴⣸⡘⣴⡌⣿⣧⣿⣿⠀⣿⣿⣿
                ⣿⣿⣿⣿⠀⢸⠀⡇⡎⡆⡆⡇⡈⡈⠚⣠⣿⣿⠀⠀⣿⣿⡿⠃⣠⣤⣤⡀⢙⣿⣿⣟⠀⢻⣿⣿⣿⣿⢠⣶⣿⣷⣄⠘⣿⡆⠃⠀⢹⣿⣾⣧⡈⠁⠃⢸⢸⣷⡍⡿⣿⠀⣿⣿⣿
                ⣿⣿⣿⣿⡀⢸⠀⡇⡇⡇⡇⣇⠁⣶⣾⣿⣿⣿⡆⢰⣿⣿⠃⣼⣿⣿⣿⣿⣿⣿⣿⣿⢀⡞⢿⣿⣿⣿⣏⠛⠟⠻⠟⠛⠛⢿⣼⢠⣼⣿⣿⣿⣧⠀⠆⠘⠌⡏⠇⣇⣿⠆⣿⣿⣿
                ⣿⣿⣿⣿⡇⢸⡆⡇⡇⠁⡡⢸⠁⣹⣿⣿⣿⣿⣿⠘⠟⠉⠙⣻⣿⣿⣿⡿⠿⠿⠟⣛⣛⣛⣛⣛⣛⣛⣛⣛⠷⠼⠿⣶⣶⣀⠉⢰⣿⣿⣿⣿⡟⠀⡼⠠⠠⠠⡠⡸⢿⢠⣿⣿⣿
                ⣿⣿⣿⣿⣷⠘⣧⢹⠘⠀⣁⣡⡁⣿⣿⣿⣿⣿⣿⡆⢴⣶⠻⠟⡋⢩⣵⣶⣶⣿⣿⣿⣿⠿⠿⠿⢿⣿⣿⣿⣿⣷⣄⣬⠙⣿⠂⢍⢿⣿⣿⣿⠏⣸⡷⠠⢁⠁⠁⢠⠁⣾⣿⣿⣿
                ⣿⣿⣿⣿⣿⠀⢿⢠⠡⠁⡹⢠⡄⢸⣿⣿⣿⣿⣿⣏⠘⣿⡆⢼⣿⣿⣿⡿⠟⠉⠉⠀⠀⠀⠀⠀⠀⠀⠉⠉⠙⠿⠿⡿⢠⣿⢠⣆⠼⠛⠉⣡⣈⠓⢰⣠⠋⠔⣱⢋⣼⣿⣿⣿⣿
                ⣿⣿⣿⣿⣿⣧⠘⢄⢢⠁⡑⢦⡙⢸⣿⣿⣿⣿⡿⣿⡁⢹⣷⡘⠿⠟⠁⠀⢠⣂⣴⣿⣿⣶⣶⣾⣿⣦⣄⣀⠀⠀⠉⣡⣿⠃⠞⣁⣀⣴⣶⣎⠛⣷⣄⢱⣠⡾⢋⣾⣿⣿⣿⣿⣿
                ⣿⣿⣿⣿⣿⣿⣶⡈⢾⣦⣹⣾⣷⡈⠻⣿⣿⣿⣿⣿⠟⡂⢿⣿⣆⡀⢰⡾⠿⠿⠿⣛⣛⣛⣛⣛⣛⣛⡻⠿⡧⢀⡴⠿⠿⠈⣾⣿⣿⣿⣿⣿⢣⢸⡏⠈⢋⣴⣿⣿⣿⣿⣿⣿⣿
                ⣿⣿⣿⣿⣿⣿⣿⣿⣦⡙⠿⣿⣏⡱⠄⠻⣿⣷⢿⠽⣷⠙⠆⢻⣿⣷⣆⣀⠲⠿⣿⣿⣿⣿⣿⣿⣿⠿⠿⣃⣴⡞⢰⣶⠦⢐⣠⣿⣿⣿⣿⠏⠀⠈⣴⠀⣤⠙⣿⣿⣿⣿⣿⣿⣿
                ⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣶⣬⡑⠿⡿⢷⣌⠻⣍⣶⠞⠗⡆⠀⠉⠻⠿⢿⣷⣶⣦⣭⣭⣭⣭⣭⣶⣶⣾⣟⠉⠰⢻⣿⣷⣿⣿⣿⡿⢿⣿⡂⠆⠀⢿⣦⠹⣃⣉⢿⣿⣿⣿⣿⣿
                ⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣶⡮⠭⠉⠗⣈⡑⠀⠈⠁⠄⢀⣠⡀⡐⠈⠉⠙⠛⠿⠿⠿⠟⠛⡉⠉⡀⠂⠀⠘⠿⠿⠿⢛⣥⣶⣦⣉⣙⢳⡿⢆⣹⠃⣿⣿⡄⣿⣿⣿⣿⣿
                ⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠿⣋⣩⣴⣾⣶⣿⣿⣿⣾⣿⣿⣦⣀⡈⠀⣿⣷⣄⠀⠀⠀⢀⡆⠀⠀⡆⣰⢱⡠⢀⣉⣁⣤⣾⣿⣿⣿⣿⣿⣿⣮⡳⠿⣀⣀⠿⢛⣡⣿⣿⣿⣿⣿
                ⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿
                ▗▖  ▗▖▄ ▗▞▀▘ ▄▄▄  ▗▖  ▗▖▄ ▄▄▄▄                
                ▐▛▚▖▐▌▄ ▝▚▄▖█   █ ▐▌  ▐▌▄ █ █ █               
                ▐▌ ▝▜▌█     ▀▄▄▄▀ ▐▌  ▐▌█ █   █               
                ▐▌  ▐▌█            ▝▚▞▘ █                    ]],
            },
            -- item field formatters
            formats = {
                icon = function(item)
                    if item.file and item.icon == "file" or item.icon == "directory" then
                        return M.icon(item.file, item.icon)
                    end
                    return { item.icon, width = 2, hl = "icon" }
                end,
                footer = { "%s", align = "center" },
                header = { "%s", align = "center" },
                file = function(item, ctx)
                    local fname = vim.fn.fnamemodify(item.file, ":~")
                    fname = ctx.width and #fname > ctx.width and vim.fn.pathshorten(fname) or fname
                    if #fname > ctx.width then
                        local dir = vim.fn.fnamemodify(fname, ":h")
                        local file = vim.fn.fnamemodify(fname, ":t")
                        if dir and file then
                            file = file:sub(-(ctx.width - #dir - 2))
                            fname = dir .. "/…" .. file
                        end
                    end
                    local dir, file = fname:match("^(.*)/(.+)$")
                    return dir and { { dir .. "/", hl = "dir" }, { file, hl = "file" } } or { { fname, hl = "file" } }
                end,
            },
            sections = {
                { section = "header" },
                { section = "keys", gap = 1, padding = 1 },
                { section = "startup" },
            },
        },
        statuscolumn = {
            enabled = true,
            left = { "mark", "sign" }, -- priority of signs on the left (high to low)
            right = { "fold", "git" }, -- priority of signs on the right (high to low)
            folds = {
                open = false, -- show open fold icons
                git_hl = false, -- use Git Signs hl for fold icons
            },
            git = {
                -- patterns to match Git signs
                patterns = { "GitSign", "MiniDiffSign" },
            },
            refresh = 50, -- refresh at most every 50ms
        },
        input = { enabled = true },
        notifier = { enabled = true },
        quickfile = { enabled = true },
        scroll = { enabled = true },
        indent = {
            priority = 1,
            enabled = true, -- enable indent guides
            char = "│",
            only_scope = false, -- only show indent guides of the scope
            only_current = false, -- only show indent guides in the current window
            hl = "SnacksIndent", ---@type string|string[] hl groups for indent guides
            -- can be a list of hl groups to cycle through
            -- hl = {
                --     "SnacksIndent1",
                --     "SnacksIndent2",
                --     "SnacksIndent3",
                --     "SnacksIndent4",
                --     "SnacksIndent5",
                --     "SnacksIndent6",
                --     "SnacksIndent7",
                --     "SnacksIndent8",
                -- },
            },
        },
    }