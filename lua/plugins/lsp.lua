return {
	"neovim/nvim-lspconfig",
	dependencies = {
		"williamboman/mason.nvim",
		"williamboman/mason-lspconfig.nvim",
		"hrsh7th/cmp-nvim-lsp",
	},
	config = function()
		-- Mason setup
		require("mason").setup()
		require("mason-lspconfig").setup({
			ensure_installed = {
				"lua_ls", "ts_ls", "pyright",
				"gopls", "jdtls", "angularls",
				"dockerls", "jsonls", "html", "cssls",
				"prismals", "sqlls", "tailwindcss"
			},
		})

		-- Capabilities para autocompletion
		local capabilities = require("cmp_nvim_lsp").default_capabilities()

		-- Function para configurar keymaps quando LSP anexa ao buffer
		local on_attach = function(_, bufnr)
			local opts = { noremap = true, silent = true, buffer = bufnr }
			local keymap = vim.keymap.set

			keymap("n", "gd", vim.lsp.buf.definition, opts)
			keymap("n", "gr", vim.lsp.buf.references, opts)
			keymap("n", "K", vim.lsp.buf.hover, opts)
			keymap("n", "<leader>rn", vim.lsp.buf.rename, opts)
			keymap("n", "<leader>ca", vim.lsp.buf.code_action, opts)
			keymap("n", "<leader>d", vim.diagnostic.open_float, opts)
			keymap("n", "[d", vim.diagnostic.goto_prev, opts)
			keymap("n", "]d", vim.diagnostic.goto_next, opts)
		end

		-- Verifica se tem a nova API disponível
		local has_new_config = pcall(function() return vim.lsp.config end) and vim.lsp.config ~= nil

		if has_new_config then
			-- Usando a nova API vim.lsp.config (Neovim 0.11+)
			local default_config = {
				capabilities = capabilities,
				on_attach = on_attach,
			}

			local servers = {
				"ts_ls", "pyright", "gopls", "jdtls",
				"angularls", "dockerls", "jsonls", "html",
				"cssls", "prismals", "sqlls", "tailwindcss"
			}

			-- Setup servidores básicos
			for _, server in ipairs(servers) do
				vim.lsp.config(server, default_config)
			end

			-- Setup específico para Lua
			vim.lsp.config("lua_ls", {
				capabilities = capabilities,
				on_attach = on_attach,
				settings = {
					Lua = {
						diagnostics = { globals = { "vim" } },
						workspace = { library = vim.api.nvim_get_runtime_file("", true) },
						telemetry = { enable = false },
					},
				},
			})
		else
			-- Fallback para lspconfig tradicional
			local lspconfig = require("lspconfig")
			local servers = {
				"ts_ls", "pyright", "gopls", "jdtls",
				"angularls", "dockerls", "jsonls", "html",
				"cssls", "prismals", "sqlls", "tailwindcss"
			}

			for _, server in ipairs(servers) do
				lspconfig[server].setup({
					capabilities = capabilities,
					on_attach = on_attach,
				})
			end

			lspconfig.lua_ls.setup({
				capabilities = capabilities,
				on_attach = on_attach,
				settings = {
					Lua = {
						diagnostics = { globals = { "vim" } },
						workspace = { library = vim.api.nvim_get_runtime_file("", true) },
						telemetry = { enable = false },
					},
				},
			})
		end
	end,
}
