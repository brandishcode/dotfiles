return {
	"brandishcode/thymeleaf-compile.nvim",
	event = { "VeryLazy" },
	branch = "develop",
	dependencies = {
		"nvim-lua/plenary.nvim",
	},
	config = function()
		require("thymeleaf.compile").setup({
			pattern = "*.md",
		})
	end,
}
