return {
	"TheLeoP/powershell.nvim",
	ft = "ps1",
	opts = {
        shell = "pwsh",
        bundle_path = vim.fn.stdpath("data") .. "/mason/packages/powershell-editor-services",
	},
}
