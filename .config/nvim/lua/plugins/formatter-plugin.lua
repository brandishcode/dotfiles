return {
	"stevearc/conform.nvim",
	config = function()
		require("conform").setup({
			format_on_save = {
				timeout_ms = 500,
				lsp_fallback = false,
			},
			formatters_by_ft = {
				lua = { "stylua" },
				java = { "google-java-format" },
				css = { "stylelint" },
				xml = { "xmlformat" },
				html = { "htmlbeautifier" },
			},
		})
	end,
}
