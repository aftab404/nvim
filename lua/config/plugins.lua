-- Packages

local mason_lsp = {
	"neovim/nvim-lspconfig",
	dependencies = {
		"williamboman/mason.nvim",
		"williamboman/mason-lspconfig.nvim",
	},
	config = function()
		-- Setup Mason
		require("mason").setup()

		require("mason-lspconfig").setup({
			ensure_installed = { "ts_ls", "lua_ls" },
		})

		vim.lsp.config("ruff", {
			init_options = {
				settings = {
					-- Ruff language server settings go here
				},
			},
		})

		vim.lsp.config("lua_ls", {
			settings = {
				Lua = {
					diagnostics = {
						globals = { "vim" },
					},
				},
			},
		})

		vim.lsp.enable("ruff")
		vim.lsp.config["ts_ls"] = {}
	end,
}

local catppuccin_theme = {
	"catppuccin/nvim",
	name = "catppuccin",
	priority = 1000,
}

local telescope = {
	"nvim-telescope/telescope.nvim",
	version = "*",
	dependencies = {
		"nvim-lua/plenary.nvim",
		{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
	},
}

local fugitive = {
	"tpope/vim-fugitive",
}

local copilot = {
	"github/copilot.vim",
}

local bufferline = {
	"akinsho/bufferline.nvim",
	version = "*",
	dependencies = "nvim-tree/nvim-web-devicons",
	config = function()
		require("bufferline").setup({})
	end,
}

local blink_intellisense = {
	"saghen/blink.cmp",
	dependencies = { "rafamadriz/friendly-snippets" },

	version = "1.*",
	---@module 'blink.cmp'
	---@type blink.cmp.Config
	opts = {
		keymap = { preset = "enter" },
		appearance = {
			nerd_font_variant = "mono",
		},

		completion = { documentation = { auto_show = false } },

		sources = {
			default = { "lsp", "path", "snippets", "buffer" },
		},

		fuzzy = { implementation = "lua" },
	},
	opts_extend = { "sources.default" },
}

local conform = {
	"stevearc/conform.nvim",
	opts = {},
	config = function()
		require("conform").setup({
			formatters_by_ft = {
				["*"] = { "trim_whitespace" },
				lua = { "stylua" },
				typescript = { "prettier" },
				python = { "black" },
				javascript = { "prettier" },
			},
			notify_on_error = true,
			format_after_save = true,
		})
	end,
}

local smear_cursor = {
	"sphamba/smear-cursor.nvim",
	opts = {
		stiffness = 0.9,
		trailing_stiffness = 0.4,
	},
}

local oil_explorer = {
	"stevearc/oil.nvim",
	---@module 'oil'
	---@type oil.SetupOpts
	opts = {},
	-- Optional dependencies
	dependencies = { { "nvim-mini/mini.icons", opts = {} } },
	-- dependencies = { "nvim-tree/nvim-web-devicons" }, -- use if you prefer nvim-web-devicons
	-- Lazy loading is not recommended because it is very tricky to make it work correctly in all situations.
	lazy = false,
}

require("lazy").setup({
	-- Define packages as variables above and add them to the list below.
	spec = {
		mason_lsp,
		catppuccin_theme,
		telescope,
		fugitive,
		copilot,
		--		bufferline,
		blink_intellisense,
		conform,
		smear_cursor,
		oil_explorer,
	},
	install = { colorscheme = { "catppuccin" } },
	checker = { enabled = true },
})
