local lsp_zero = require('lsp-zero')

lsp_zero.on_attach(function(client, bufnr)
  -- see :help lsp-zero-keybindings
  -- to learn the available actions
  local opts = {buffer = bufnr, remap = true} 

  vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
  vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
  vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts)
  vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float() end, opts)
  vim.keymap.set("n", "[d", function() vim.diagnostic.goto_prev() end, opts)
  vim.keymap.set("n", "]d", function() vim.diagnostic.goto_next() end, opts)
  vim.keymap.set("n", "<leader>vca", function() vim.lsp.buf.code_action() end, opts)
  vim.keymap.set("n", "<leader>vrr", function() vim.lsp.buf.references() end, opts)
  vim.keymap.set("n", "<leader>vrn", function() vim.lsp.buf.rename() end, opts)
  vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
end)
  
-- to learn how to use mason.nvim with lsp-zero
-- read this: https://github.com/VonHeikemen/lsp-zero.nvim/blob/v3.x/doc/md/guide/integrate-with-mason-nvim.md
require('mason').setup({})
require('mason-lspconfig').setup({
  ensure_installed = {'jdtls', 'clangd'},
  handlers = {
    lsp_zero.default_setup,
    jdtls = lsp_zero.noop, 
    -- tsserver = function()
    --   require('lspconfig').tsserver.setup({
    --     settings = {
    --       completions = {
    --         completeFunctionCalls = true
    --       },
    --       implicitProjectConfiguration = {
    --         checkJs = true
    --       }
    --     }
    --   })
    -- end,
  },
})

local cmp_autopairs = require('nvim-autopairs.completion.cmp')
local cmp = require('cmp')

cmp.setup({
  window = {
    completion = {
      winhighlight = "Normal:NormalNC,FloatBorder:NormalNC,Search:None",
      border = "rounded"
    },
    documentation = {
      winhighlight = "Normal:NormalNC,FloatBorder:NormalNC,Search:None"
    }
  },
  mapping = {
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
    ...
  },
})

local cmp_select = {behavior = cmp.SelectBehavior.Select}
lsp_zero.defaults.cmp_mappings({
  ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
  ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
  ['<C-y>'] = cmp.mapping.confirm({select = true}),
  ['<C-Spaces>'] = cmp.mapping.complete(),
})
