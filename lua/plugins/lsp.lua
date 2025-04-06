return {
	-- Install LSP servers
	{
		"williamboman/mason.nvim",
		lazy = false,
		opts = {},
	},

	-- Neovim autocompletion
	{
		"folke/lazydev.nvim",
		ft = "lua", -- only load on lua files
		opts = {
			library = {
				-- See the configuration section for more details
				-- Load luvit types when the `vim.uv` word is found
				{ path = "${3rd}/luv/library", words = { "vim%.uv" } },
			},
		},
	},

	-- Autocompletion
	{
		"saghen/blink.cmp",
		build = "cargo +nightly build --release",
		dependencies = {
			{
				"giuxtaposition/blink-cmp-copilot",
				'Kaiser-Yang/blink-cmp-avante',
				"rafamadriz/friendly-snippets",
			},
		},
		opts = {
			keymap = { preset = "default" },

			appearance = {
				use_nvim_cmp_as_default = true,
				nerd_font_variant = 'mono'
			},

			sources = {
				default = {
					"avante",
					"lazydev",
					"lsp",
					"path",
					"snippets",
					"buffer",
					"copilot",
				},
				providers = {
					lazydev = {
						name = "LazyDev",
						module = "lazydev.integrations.blink",
						score_offset = 100,
					},
					copilot = {
						name = "copilot",
						module = "blink-cmp-copilot",
						score_offset = 100,
						async = true,
					},
					avante = {
						module = 'blink-cmp-avante',
						name = 'Avante',
						score_offset = 100,
						opts = {
							-- options for blink-cmp-avante
						},
					}
				},
			},
			fuzzy = { implementation = "prefer_rust_with_warning" },
			signature = { enabled = true },
		},
	},

	-- LSP
	{
		"neovim/nvim-lspconfig",
		cmd = { "LspInfo", "LspInstall", "LspStart" },
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			{ "saghen/blink.cmp" },
			{ "williamboman/mason.nvim" },
			{ "williamboman/mason-lspconfig.nvim" },
		},

		config = function()
			local lsp_defaults = require("lspconfig").util.default_config

			-- Add blink.cmp capabilities settings to lspconfig
			-- This should be executed before you configure any language server
			lsp_defaults.capabilities = require("blink.cmp").get_lsp_capabilities()
			-- LspAttach is where you enable features that only work
			-- if there is a language server active in the file
			vim.api.nvim_create_autocmd("LspAttach", {
				desc = "LSP actions",
				callback = function(event)
					local opts = { buffer = event.buf }

					vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
					vim.keymap.set("n", "gs", vim.lsp.buf.signature_help, opts)
					vim.keymap.set("n", "grn", vim.lsp.buf.rename, opts)
					vim.keymap.set({ "n", "x" }, "<F3>", function()
						vim.lsp.buf.format({ async = true })
					end, opts)
					vim.keymap.set("n", "ca", vim.lsp.buf.code_action, opts)

					-- WARN: This is not Goto Definition, this is Goto Declaration.
					--  For example, in C this would take you to the header.
					vim.keymap.set({ "n" }, "gD", vim.lsp.buf.declaration, { desc = "[G]oto [D]eclaration" })

					-- The following two autocommands are used to highlight references of the
					-- word under your cursor when your cursor rests there for a little while.
					--    See `:help CursorHold` for information about when this is executed
					--
					-- When you move your cursor, the highlights will be cleared (the second autocommand).
					local client = vim.lsp.get_client_by_id(event.data.client_id)
					if client and client.supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight) then
						local highlight_augroup = vim.api.nvim_create_augroup("lsp-highlight", { clear = false })
						vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
							buffer = event.buf,
							group = highlight_augroup,
							callback = vim.lsp.buf.document_highlight,
						})

						vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
							buffer = event.buf,
							group = highlight_augroup,
							callback = vim.lsp.buf.clear_references,
						})

						vim.api.nvim_create_autocmd("LspDetach", {
							group = vim.api.nvim_create_augroup("lsp-detach", { clear = true }),
							callback = function(event2)
								vim.lsp.buf.clear_references()
								vim.api.nvim_clear_autocmds({ group = "lsp-highlight", buffer = event2.buf })
							end,
						})
					end

					-- The following code creates a keymap to toggle inlay hints in your
					-- code, if the language server you are using supports them
					--
					-- This may be unwanted, since they displace some of your code
					if client and client.supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint) then
						vim.keymap.set("n", "<leader>th", function()
							vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = event.buf }))
						end, { desc = "[T]oggle Inlay [H]ints" })
					end
				end,
			})

			require("mason-lspconfig").setup({
				ensure_installed = { "lua_ls" },
				automatic_installation = true,
				handlers = {
					-- this first function is the "default handler"
					-- it applies to every language server without a "custom handler"
					function(server_name)
						require("lspconfig")[server_name].setup({})
					end,
				},
			})

			vim.lsp.handlers['textDocument/publishDiagnostics'] = vim.lsp.with(
				vim.lsp.diagnostic.on_publish_diagnostics,
				{
					underline = true,
					virtual_text = {
						spacing = 5,
						severity_limit = 'Warning',
					},
					update_in_insert = true,
				}
			)
		end,
	},
}
