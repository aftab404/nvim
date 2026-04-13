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
			ensure_installed = {
				"ts_ls",
				"lua_ls",
				"clang-format",
				"black",
				"prettier",
				"stylua",
				"clangd",
				"cssls",
				"html",
				"jsonls",
				"pyright",
				"tailwindcss",
			},
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

		vim.lsp.config["ts_ls"] = {}

		vim.lsp.enable("ruff")
		vim.lsp.enable("lua_ls")
		vim.lsp.enable("ts_ls")
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
	config = function()
		local actions = require("telescope.actions")

		require("telescope").setup({
			pickers = {
				buffers = {
					mappings = {
						i = {
							["<A-j>"] = actions.delete_buffer,
						},
						n = {
							["<A-j>"] = actions.delete_buffer,
						},
					},
				},
			},
		})
	end,
}

local bufferline = {
	"akinsho/bufferline.nvim",
	version = "*",
	dependencies = "nvim-tree/nvim-web-devicons",
	config = function()
		require("bufferline").setup({
			options = {
				mode = "tabs",
			},
		})
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
				cpp = { "clang-format" },
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
	config = function()
		require("oil").setup({
			default_file_explorer = true,
			view_options = {
				show_hidden = true,
				is_tree = true,
			},
		})
	end,
}

local origami = {
	"chrisgrieser/nvim-origami",
	event = "VeryLazy",
	opts = {}, -- required even when using default config

	-- recommended: disable vim's auto-folding
	init = function()
		vim.opt.foldlevel = 99
		vim.opt.foldlevelstart = 99
	end,

	config = function(_, opts)
		-- default settings
		require("origami").setup({
			useLspFoldsWithTreesitterFallback = {
				enabled = true,
				foldmethodIfNeitherIsAvailable = "indent", ---@type string|fun(bufnr: number): string
			},
			pauseFoldsOnSearch = true,
			foldtext = {
				enabled = true,
				padding = {
					character = " ",
					width = 3, ---@type number|fun(win: number, foldstart: number, currentVirtualTextLength: number): number
					hlgroup = nil,
				},
				lineCount = {
					template = "%d lines", -- `%d` is replaced with the number of folded lines
					hlgroup = "Comment",
				},
				diagnosticsCount = true, -- uses hlgroups and icons from `vim.diagnostic.config().signs`
				gitsignsCount = true, -- requires `gitsigns.nvim`
				disableOnFt = { "snacks_picker_input" }, ---@type string[]
			},
			autoFold = {
				enabled = true,
				kinds = { "comment", "imports" }, ---@type lsp.FoldingRangeKind[]
			},
			foldKeymaps = {
				setup = true, -- modifies `h`, `l`, `^`, and `$`
				closeOnlyOnFirstColumn = false, -- `h` and `^` only fold in the 1st column
				scrollLeftOnCaret = false, -- `^` should scroll left (basically mapped to `0^`)
			},
		})
	end,
}

local treesitter = {
	"nvim-treesitter/nvim-treesitter",
	lazy = false,
	build = ":TSUpdate",
}

local git_conflicts = {
	"akinsho/git-conflict.nvim",
	version = "*",
	config = function()
		require("git-conflict").setup({
			default_mappings = true, -- disable buffer local mapping created by this plugin
			default_commands = true, -- disable commands created by this plugin
			disable_diagnostics = true, -- This will disable the diagnostics in a buffer whilst it is conflicted
			highlights = {
				incoming = "DiffText", -- The highlight group used for incoming changes
				current = "DiffAdd", -- The highlight group used for current changes
			},
		})
	end,
}

local fugitive = {
	"tpope/vim-fugitive",
}

local copilot = {
	"github/copilot.vim",
}

vim.o.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"

local auto_session = {
	"rmagatti/auto-session",
	lazy = false,

	---enables autocomplete for opts
	---@module "auto-session"
	---@type AutoSession.Config
	opts = {
		suppressed_dirs = { "~/", "~/Projects", "~/Downloads", "/" },
		--	log_level = "debug",
		auto_restore = true,
		auto_restore_last_session = false,
		args_allow_files_auto_save = true,
	},
}

require("lazy").setup({
	-- Define packages as variables above and add them to the list below.
	spec = {
		mason_lsp,
		catppuccin_theme,
		telescope,
		fugitive,
		copilot,
		bufferline,
		blink_intellisense,
		conform,
		smear_cursor,
		oil_explorer,
		origami,
		treesitter,
		git_conflicts,
		auto_session,
	},
	install = { colorscheme = { "catppuccin" } },
	checker = { enabled = true },
})
