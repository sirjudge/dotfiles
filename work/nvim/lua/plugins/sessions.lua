return {
    "Shatur/neovim-session-manager",
    version = false,
    keys = {
        { "<leader>ss", "<cmd>SessionManager load_session<cr>", desc = "Load session" },
        { "<leader>sd", "<cmd>SessionManager load_current_dir_session<cr>", desc = "Load session for current dir" },
        { "<leader>sl", "<cmd>SessionManager load_last_session<cr>", desc = "Load last session" },
        { "<leader>ss", "<cmd>SessionManager save_current_session<cr>", desc = "Save session" },
        { "<leader>sc", "<cmd>SessionManager available_commands<cr>", desc = "Session Commands" },

    },
    config = function()
        local Path = require('plenary.path')
        local config = require('session_manager.config')
        require('session_manager').setup({
            sessions_dir = Path:new(vim.fn.stdpath('data'), 'sessions'), -- The directory where the session files will be saved.
            session_filename_to_dir = session_filename_to_dir, -- Function that replaces symbols into separators and colons to transform filename into a session directory.
            dir_to_session_filename = dir_to_session_filename, -- Function that replaces separators and colons into special symbols to transform session directory into a filename. Should use `vim.uv.cwd()` if the passed `dir` is `nil`.
            autoload_mode = config.AutoloadMode.LastSession, -- GitSession,LastSession,CurrentDir, Disabled
            autosave_last_session = true, -- Automatically save last session on exit and on session switch.
            autosave_ignore_not_normal = true, -- Plugin will not save a session when no buffers are opened, or all of them aren't writable or listed.
            autosave_ignore_dirs = {
                '.git',
                '.vim',
                '.idea',
                '.vs',
                'obj',
                'bin',
            }, -- A list of directories where the session will not be autosaved.
            autosave_ignore_filetypes = { -- All buffers of these file types will be closed before the session is saved.
                'gitcommit',
                'gitrebase',
                'env',
            },
            autosave_ignore_buftypes = {}, -- All buffers of these bufer types will be closed before the session is saved.
            autosave_only_in_session = true, -- Always autosaves session. If true, only autosaves after a session is active.
            max_path_length = 80,  -- Shorten the display path if length exceeds this threshold. Use 0 if don't want to shorten the path at all.
            load_include_current = false,  -- The currently loaded session appears in the load_session UI.
        })

        -- Auto save session
        vim.api.nvim_create_autocmd({ 'BufWritePre' }, {
            callback = function ()
                for _, buf in ipairs(vim.api.nvim_list_bufs()) do
                    -- Don't save while there's any 'nofile' buffer open.
                    if vim.api.nvim_get_option_value("buftype", { buf = buf }) == 'nofile' then
                        return
                    end
                end
                local session_manager = require("session_manager")
                session_manager.save_current_session()
            end
        })
    end
}
