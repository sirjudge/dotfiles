return {
	{
		"akinsho/bufferline.nvim",
		version = "*",
		dependencies = "nvim-tree/nvim-web-devicons",
		event = { "BufReadPre", "BufNewFile" },
		keys = {
			{ "<leader>bn", "<cmd>bnext<cr>", desc = "buffer next" },
			{ "<leader>bp", "<cmd>bprevious<cr>", desc = "buffer previous" },
			{ "<leader>bd", "<cmd>bdelete<cr>", desc = "buffer delete" },
			{ "<leader>bcr", "<cmd>BufferLineCloseRight<cr>", desc = "bufferline close right" },
			{ "<leader>bcl", "<cmd>BufferLineCloseLeft<cr>", desc = "bufferline close left" },
			{ "<leader>blp", "<cmd>BufferLinePick<cr>", desc = "bufferline pick" },
			{ "<leader>b1", "<cmd>BufferLinePick<cr>", desc = "bufferline pick" },
		},
		config = function()
			local bufferline = require("bufferline")
			bufferline.setup({
				options = {
					hover = {
						enabled = true,
						delay = 200,
						reveal = { "close" },
					},
					mode = "buffers", -- set to "tabs" to only show tabpages instead
					style_preset = bufferline.style_preset.default, -- or bufferline.style_preset.minimal,
					themable = true, --true | false, -- allows highlight groups to be overriden i.e. sets highlights as default
					numbers = "ordinal", -- "none" | "ordinal" | "buffer_id" | "both" | function({ ordinal, id, lower, raise }): string,
					close_command = "bdelete! %d", -- can be a string | function, | false see "Mouse actions"
					right_mouse_command = "bdelete! %d", -- can be a string | function | false, see "Mouse actions"
					left_mouse_command = "buffer %d", -- can be a string | function, | false see "Mouse actions"
					middle_mouse_command = nil, -- can be a string | function, | false see "Mouse actions"
					indicator = {
						icon = "▎", -- this should be omitted if indicator style is not 'icon'
						style = "underline", -- icon | 'underline' | 'none',
					},
					buffer_close_icon = "󰅖",
					modified_icon = "● ",
					close_icon = " ",
					left_trunc_marker = " ",
					right_trunc_marker = " ",
					offsets = {
						{
							filetype = "NvimTree",
							text = "File Explorer",
							highlight = "Directory",
							separator = true, -- use a "true" to enable the default, or set your own character
						},
					},
					max_name_length = 18,
					max_prefix_length = 15, -- prefix used when a buffer is de-duplicated
					truncate_names = true, -- whether or not tab names should be truncated
					tab_size = 18,
					diagnostics = "nvim-lsp", --false | "nvim_lsp" | "coc",
					diagnostics_update_in_insert = false, -- only applies to coc
					diagnostics_update_on_event = true, -- use nvim's diagnostic handler
					show_buffer_icons = true, -- true | false, -- disable filetype icons for buffers
					show_buffer_close_icons = true, --true | false,
					show_close_icon = true, --true | false,
					show_tab_indicators = true, -- true | false,
					show_duplicate_prefix = true, -- true | false, -- whether to show duplicate buffer prefix
					duplicates_across_groups = false, -- whether to consider duplicate paths in different groups as duplicates
					persist_buffer_sort = true, -- whether or not custom sorted buffers should persist
					move_wraps_at_ends = false, -- whether or not the move command "wraps" at the first or last position
					separator_style = "slant", --"slant" | "slope" | "thick" | "thin" | { 'any', 'any' },
				},
			})
		end,
	},
}
