-- PINKYPOP
-- created on https://nvimcolors.com

-- Clear existing highlights and reset syntax
vim.cmd('highlight clear')
vim.cmd('syntax reset')

-- Basic UI elements
vim.cmd('highlight Normal guibg=#211122 guifg=#cccad2')
vim.cmd('highlight NonText guibg=#211122 guifg=#211122')
vim.cmd('highlight CursorLine guibg=#2b6a7d')
vim.cmd('highlight LineNr guifg=#ac01ba')
vim.cmd('highlight CursorLineNr guifg=#f5c9fc')
vim.cmd('highlight SignColumn guibg=#211122')
vim.cmd('highlight StatusLine gui=bold guibg=#2b6a7d guifg=#cccad2')
vim.cmd('highlight StatusLineNC gui=bold guibg=#2b6a7d guifg=#7c9aa8')
vim.cmd('highlight Directory guifg=#e868d1')
vim.cmd('highlight Visual guibg=#2b6a7d')
vim.cmd('highlight Search guibg=#2b6a7d guifg=#ffffff')
vim.cmd('highlight CurSearch guibg=#ffffff guifg=#000000')
vim.cmd('highlight IncSearch gui=None guibg=#ffffff guifg=#000000')
vim.cmd('highlight MatchParen guibg=#2b6a7d guifg=#ffffff')
vim.cmd('highlight Pmenu guibg=#2b6a7d guifg=#e7e7e7')
vim.cmd('highlight PmenuSel guibg=#132f37 guifg=#c2bfca')
vim.cmd('highlight PmenuSbar guibg=#132f37 guifg=#ffffff')
vim.cmd('highlight VertSplit guifg=#2b6a7d')
vim.cmd('highlight MoreMsg guifg=#ff80ff')
vim.cmd('highlight Question guifg=#ff80ff')
vim.cmd('highlight Title guifg=#f9b3fb')

-- Syntax highlighting
vim.cmd('highlight Comment guifg=#ffffff gui=italic')
vim.cmd('highlight Constant guifg=#ff8aad')
vim.cmd('highlight Identifier guifg=#f9b3fb')
vim.cmd('highlight Statement guifg=#9f8bfe')
vim.cmd('highlight PreProc guifg=#9f8bfe')
vim.cmd('highlight Type guifg=#8b97fe gui=None')
vim.cmd('highlight Special guifg=#ff80ff')

-- Refined syntax highlighting
vim.cmd('highlight String guifg=#c4c4c4')
vim.cmd('highlight Number guifg=#c4c4c4')
vim.cmd('highlight Boolean guifg=#c4c4c4')
vim.cmd('highlight Function guifg=#398da6')
vim.cmd('highlight Keyword guifg=#7ad8e9 gui=italic')

-- Html syntax highlighting
vim.cmd('highlight Tag guifg=#f791f9')
vim.cmd('highlight @tag.delimiter guifg=#ff80ff')
vim.cmd('highlight @tag.attribute guifg=#8b97fe')

-- Messages
vim.cmd('highlight ErrorMsg guifg=#ff0000')
vim.cmd('highlight Error guifg=#ff0000')
vim.cmd('highlight DiagnosticError guifg=#ff0000')
vim.cmd('highlight DiagnosticVirtualTextError guibg=#370f1f guifg=#ff0000')
vim.cmd('highlight WarningMsg guifg=#ffcc00')
vim.cmd('highlight DiagnosticWarn guifg=#ffcc00')
vim.cmd('highlight DiagnosticVirtualTextWarn guibg=#37241f guifg=#ffcc00')
vim.cmd('highlight DiagnosticInfo guifg=#00ccff')
vim.cmd('highlight DiagnosticVirtualTextInfo guibg=#1e2438 guifg=#00ccff')
vim.cmd('highlight DiagnosticHint guifg=#00ffff')
vim.cmd('highlight DiagnosticVirtualTextHint guibg=#1e2938 guifg=#00ffff')
vim.cmd('highlight DiagnosticOk guifg=#00ff00')

-- Common plugins
vim.cmd('highlight CopilotSuggestion guifg=#ffffff') -- Copilot suggestion
vim.cmd('highlight TelescopeSelection guibg=#2b6a7d') -- Telescope selection
