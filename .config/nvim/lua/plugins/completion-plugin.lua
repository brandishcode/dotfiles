return {
	{
		"hrsh7th/nvim-cmp",
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-vsnip",
			"hrsh7th/vim-vsnip",
			"L3MON4D3/LuaSnip",
		},
		config = function()
			local cmp = require("cmp")
			local cmp_select = { behavior = cmp.SelectBehavior.Select }
			cmp.setup({
				sources = {
					{ name = "nvim_lsp" },
					{ name = "nvim_lsp_signature_help" },
					{ name = "vsnip" },
				},
				snippet = {
					expand = function(args)
						vim.fn["vsnip#anonymous"](args.body)
					end,
				},
				window = {
					completion = {
						winhighlight = "Normal:NormalNC,FloatBorder:NormalNC,Search:None",
						border = "rounded",
					},
					documentation = {
						winhighlight = "Normal:NormalNC,FloatBorder:NormalNC,Search:None",
					},
				},
				mapping = {
					["<C-p>"] = cmp.mapping.select_prev_item(cmp_select),
					["<C-n>"] = cmp.mapping.select_next_item(cmp_select),
					["<C-b>"] = cmp.mapping.scroll_docs(-4),
					["<C-f>"] = cmp.mapping.scroll_docs(4),
					["<C-y>"] = cmp.mapping.confirm({ select = true }),
					["<C-Spaces>"] = cmp.mapping.complete(),
					--    ["<Tab>"] = cmp.mapping(function(fallback)
					--      -- This little snippet will confirm with tab, and if no entry is selected, will confirm the first item
					--      if cmp.visible() then
					--        local entry = cmp.get_selected_entry()
					--        if not entry then
					--          cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
					--        else
					--          cmp.confirm()
					--        end
					--      else
					--        fallback()
					--      end
					--    end, {"i","s","c",}),
				},
			})
		end,
	},
	{
		"windwp/nvim-autopairs",
		dependencies = {
			"windwp/nvim-ts-autotag",
		},
		config = function()
			local npairs = require("nvim-autopairs")
			local Rule = require("nvim-autopairs.rule")

			require("nvim-ts-autotag").setup()

			npairs.setup({
				check_ts = true,
				ts_config = {
					lua = { "string" }, -- it will not add a pair on that treesitter node
					java = false, -- don't check treesitter on java
				},
			})

			local ts_conds = require("nvim-autopairs.ts-conds")

			-- press % => %% only while inside a comment or string
			npairs.add_rules({
				-- Rule("%", "%", "lua"):with_pair(ts_conds.is_ts_node({ "string", "comment" })),
				Rule("$", "$", "lua"):with_pair(ts_conds.is_not_ts_node({ "function" })),
			})
		end,
	},
}
