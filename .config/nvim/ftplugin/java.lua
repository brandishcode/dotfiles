local install_path = require"mason-registry".get_package("jdtls"):get_install_path()
local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ':p:h:t')
local workspace_dir = vim.fn.expand('~/Development/projects/mvn/workspace/' .. project_name)

local config = {
  cmd = {
    'java', -- or '/path/to/java17_or_newer/bin/java'
            -- depends on if `java` is in your $PATH env variable and if it points to the right version.

    '-Declipse.application=org.eclipse.jdt.ls.core.id1',
    '-Dosgi.bundles.defaultStartLevel=4',
    '-Declipse.product=org.eclipse.jdt.ls.core.product',
    '-Dlog.protocol=true',
    '-Dlog.level=ALL',
    '--add-modules=ALL-SYSTEM',
    '-javaagent:' .. install_path .. '/lombok.jar',
    '-jar', install_path .. '/plugins/org.eclipse.equinox.launcher_1.6.700.v20231214-2017.jar',
    '-configuration', install_path .. '/config_linux',
    '-data', workspace_dir
  },
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

vim.opt_local.shiftwidth = 4
vim.opt_local.softtabstop = 4
vim.opt_local.tabstop = 4
