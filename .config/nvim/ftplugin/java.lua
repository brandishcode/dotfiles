local config = {
  cmd = {vim.fn.expand('~/.local/share/nvim/mason/bin/jdtls')},
  root_dir = vim.fs.dirname(vim.fs.find({'gradlew', '.git', 'mvnw'}, { upward = true })[1]),
  capabilities = require('cmp_nvim_lsp').default_capabilities(),
}
require('jdtls').start_or_attach(config)

vim.api.nvim_create_autocmd('BufWritePre', {
  pattern = '*.java',
  callback = function(args)
    require('conform').format({ bufnr = args.buf })
  end
})
