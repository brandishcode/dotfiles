-- to learn how to use mason.nvim with lsp-zero
-- read this: https://github.com/VonHeikemen/lsp-zero.nvim/blob/v3.x/doc/md/guide/integrate-with-mason-nvim.md
require('mason').setup()
require('mason-lspconfig').setup({
  ensure_installed = {'jdtls', 'clangd', 'lua_ls', 'tsserver', 'tailwindcss'},
  handlers = {
    lua_ls = function()
      require'lspconfig'.lua_ls.setup({
        on_init = function(client)
          local path = client.workspace_folders[1].name
          if vim.loop.fs_stat(path..'/.luarc.json') or vim.loop.fs_stat(path..'/.luarc.jsonc') then
            return
          end

          client.config.settings.Lua = vim.tbl_deep_extend('force', client.config.settings.Lua, {
            runtime = {
              -- Tell the language server which version of Lua you're using
              -- (most likely LuaJIT in the case of Neovim)
              version = 'LuaJIT'
            },
            -- Make the server aware of Neovim runtime files
            workspace = {
              checkThirdParty = false,
              library = {
                vim.env.VIMRUNTIME
                -- Depending on the usage, you might want to add additional paths here.
                -- "${3rd}/luv/library"
                -- "${3rd}/busted/library",
              }
              -- or pull in all of 'runtimepath'. NOTE: this is a lot slower
              -- library = vim.api.nvim_get_runtime_file("", true)
            }
          })
        end,
        settings = {
          Lua = {}
        }
      })
    end,
    tsserver = function()
      require"lspconfig".tsserver.setup({})
    end,
    tailwindcss = function()
      require"lspconfig".tailwindcss.setup({})
    end
  },
})

-- local cmp_autopairs = require('nvim-autopairs.completion.cmp')
local cmp = require('cmp')
local cmp_select = {behavior = cmp.SelectBehavior.Select}
cmp.setup({
  sources = {
    { name = 'nvim_lsp' },
    { name = 'nvim_lsp_signature_help' },
    { name = 'vsnip' }
  },
  snippet = {
    expand = function(args)
      vim.fn['vsnip#anonymous'](args.body)
    end
  },
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

    ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
    ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-y>'] = cmp.mapping.confirm({select = true}),
    ['<C-Spaces>'] = cmp.mapping.complete(),
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
