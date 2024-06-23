local install_path = require("mason-registry").get_package("jdtls"):get_install_path()
local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")
local workspace_dir = vim.fn.expand(os.getenv("MYCONFIG_NVIM_JAVA_WORKSPACE") .. project_name)

local config = {
	cmd = {
		"java", -- or '/path/to/java17_or_newer/bin/java'
		-- depends on if `java` is in your $PATH env variable and if it points to the right version.

		"-Declipse.application=org.eclipse.jdt.ls.core.id1",
		"-Dosgi.bundles.defaultStartLevel=4",
		"-Declipse.product=org.eclipse.jdt.ls.core.product",
		"-Dlog.protocol=true",
		"-Dlog.level=ALL",
		"--add-modules=ALL-SYSTEM",
		"-javaagent:" .. install_path .. "/lombok.jar",
		"-jar",
		install_path .. "/plugins/org.eclipse.equinox.launcher_1.6.800.v20240330-1250.jar",
		"-configuration",
		install_path .. "/config_linux",
		"-data",
		workspace_dir,
	},
	root_dir = vim.fs.dirname(vim.fs.find({ "gradlew", ".git", "mvnw" }, { upward = true })[1]),
	capabilities = require("cmp_nvim_lsp").default_capabilities(),
	init_options = {
		bundles = {
			vim.fn.glob(vim.fn.expand(os.getenv("MYCONFIG_NVIM_JAVA_DEBUG")), 1),
		},
	},
	on_attach = function(client, bufnr)
		require("jdtls").setup_dap({ hotcodereplace = "auto" })
	end,
}
require("jdtls").start_or_attach(config)

vim.api.nvim_create_autocmd("BufWritePre", {
	pattern = "*.java",
	callback = function(args)
		require("conform").format({ bufnr = args.buf })
	end,
})

local function attach_to_debug()
	require("dap").configurations.java = {
		{
			type = "java",
			request = "attach",
			name = "Debug (Attach) - Remote",
			hostName = "127.0.0.1",
			port = 8000,
		},
	}
	require("dap").continue()
end

local function show_dap_scopes()
	local widgets = require("dap.ui.widgets")
	widgets.centered_float(widgets.scopes)
end

vim.keymap.set("n", "<leader>da", attach_to_debug)
vim.keymap.set("n", "<leader>dS", show_dap_scopes)
