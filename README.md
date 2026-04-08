# Neovim Setup

This configuration uses a small Lua-based Neovim setup built around `lazy.nvim` for plugin management. The entry point is [`init.lua`](/home/aftab/.config/nvim/init.lua), which bootstraps `lazy.nvim` if it is missing and then loads:

- [`lua/config/plugins.lua`](/home/aftab/.config/nvim/lua/config/plugins.lua)
- [`lua/config/keymaps.lua`](/home/aftab/.config/nvim/lua/config/keymaps.lua)
- [`lua/config/options.lua`](/home/aftab/.config/nvim/lua/config/options.lua)

## Structure

- [`init.lua`](/home/aftab/.config/nvim/init.lua): bootstraps `lazy.nvim` and loads the config modules.
- [`lua/config/plugins.lua`](/home/aftab/.config/nvim/lua/config/plugins.lua): plugin declarations and plugin-specific setup.
- [`lua/config/keymaps.lua`](/home/aftab/.config/nvim/lua/config/keymaps.lua): leader key, navigation, formatting, split helpers, and utility mappings.
- [`lua/config/options.lua`](/home/aftab/.config/nvim/lua/config/options.lua): colorscheme, diagnostics, editor options, and transparency tweaks.
- [`lazy-lock.json`](/home/aftab/.config/nvim/lazy-lock.json): pinned plugin versions used by `lazy.nvim`.

## Requirements

Core requirements:

- Neovim with Lua config support and the modern `vim.lsp`/`vim.uv` APIs. This setup is best suited to a recent Neovim release.
- `git` for bootstrapping `lazy.nvim`.
- A Nerd Font if you want icon support from `mini.icons`.

Build/runtime requirements from plugins:

- `make` for `telescope-fzf-native.nvim`.
- Treesitter compilation support for `nvim-treesitter` parsers.

External tools expected by the config:

- LSP servers:
  - `lua_ls`
  - `ts_ls`
  - `ruff`
- Formatters:
  - `stylua` for Lua
  - `prettier` for TypeScript and JavaScript
  - `black` for Python
  - `clang-format` for C++

Notes:

- `mason.nvim` and `mason-lspconfig.nvim` are configured to ensure `ts_ls` and `lua_ls`.
- `ruff` is enabled through `vim.lsp.enable("ruff")`, but it is not included in Mason's `ensure_installed` list here, so you should make sure it is available in your environment.
- Clipboard integration is set to `unnamedplus`, so a system clipboard provider is expected.
- `<leader>sa` opens a terminal and runs `codex`, so that command must be installed if you want that mapping to work.

## Plugins

Active plugins from [`lua/config/plugins.lua`](/home/aftab/.config/nvim/lua/config/plugins.lua):

- `folke/lazy.nvim`: plugin manager, bootstrapped automatically from `init.lua`.
- `neovim/nvim-lspconfig`: LSP client configuration.
- `williamboman/mason.nvim`: installer/manager for external editor tooling.
- `williamboman/mason-lspconfig.nvim`: Mason integration for LSP servers.
- `catppuccin/nvim`: colorscheme, selected in [`options.lua`](/home/aftab/.config/nvim/lua/config/options.lua).
- `nvim-telescope/telescope.nvim`: fuzzy finder for files, grep, buffers, and help.
- `nvim-lua/plenary.nvim`: Telescope dependency.
- `nvim-telescope/telescope-fzf-native.nvim`: native FZF sorter for Telescope, built with `make`.
- `tpope/vim-fugitive`: Git integration.
- `github/copilot.vim`: GitHub Copilot integration.
- `saghen/blink.cmp`: completion engine.
- `rafamadriz/friendly-snippets`: snippet collection for completion.
- `stevearc/conform.nvim`: formatting orchestration.
- `sphamba/smear-cursor.nvim`: cursor trail animation.
- `stevearc/oil.nvim`: file explorer, set as the default file explorer.
- `nvim-mini/mini.icons`: icon support for Oil.
- `chrisgrieser/nvim-origami`: folding UX, with LSP/Treesitter fallback.
- `nvim-treesitter/nvim-treesitter`: Treesitter support and parser management.

Defined but currently disabled:

- `akinsho/bufferline.nvim`: the plugin config exists, but it is commented out in the active `spec` list, so it does not load.
- `nvim-tree/nvim-web-devicons`: referenced only as an optional/dependency path for disabled or alternative setups.

Pinned versions are recorded in [`lazy-lock.json`](/home/aftab/.config/nvim/lazy-lock.json).

## Behavior And Options

From [`lua/config/options.lua`](/home/aftab/.config/nvim/lua/config/options.lua):

- Colorscheme: `catppuccin`
- Line numbers enabled
- `tabstop = 2`
- `shiftwidth = 2`
- `termguicolors = true`
- Clipboard uses `unnamedplus`
- Diagnostics:
  - virtual text enabled
  - signs enabled
  - underline enabled
  - no updates while in insert mode
- Transparent background applied to:
  - `Normal`
  - `NormalNC`
  - `SignColumn`
  - `EndOfBuffer`

From plugin setup in [`lua/config/plugins.lua`](/home/aftab/.config/nvim/lua/config/plugins.lua):

- `Oil` shows hidden files and uses tree view.
- `Origami` sets high initial fold levels, uses LSP folds with Treesitter fallback, and auto-folds comments/imports.
- `Conform` trims trailing whitespace for all filetypes and formats supported languages after save.
- `blink.cmp` uses the `enter` keymap preset and sources completions from LSP, paths, snippets, and buffers.

## Keymaps

Leader configuration from [`lua/config/keymaps.lua`](/home/aftab/.config/nvim/lua/config/keymaps.lua):

- `mapleader = <Space>`
- `maplocalleader = \`

Telescope:

- `<leader>ff`: find files
- `<leader>fg`: live grep
- `<leader>fb`: list buffers
- `<leader>fh`: help tags

Buffer navigation:

- `<A-h>`: previous buffer
- `<A-l>`: next buffer
- `<A-j>`: delete current buffer

Formatting:

- `<leader>fa`: format buffer with `conform.nvim` using LSP fallback

Open config files:

- `<leader>oi`: open [`init.lua`](/home/aftab/.config/nvim/init.lua)
- `<leader>op`: open [`plugins.lua`](/home/aftab/.config/nvim/lua/config/plugins.lua)
- `<leader>ok`: open [`keymaps.lua`](/home/aftab/.config/nvim/lua/config/keymaps.lua)
- `<leader>oo`: open [`options.lua`](/home/aftab/.config/nvim/lua/config/options.lua)

Explorer and splits:

- `<leader>e`: open Oil explorer
- `<leader>st`: open a terminal in a bottom split and enter insert mode
- `<leader>se`: open Oil in a vertical split
- `<leader>sa`: open a vertical split terminal and run `codex`

Terminal mode:

- `<Esc>`: leave terminal mode

Disabled defaults:

- `J` in normal mode is mapped to `<Nop>`
- `J` in visual mode is mapped to `<Nop>`

## LSP And Formatting Summary

LSP:

- `lua_ls` with `vim` added as a recognized global
- `ts_ls` enabled
- `ruff` enabled

Formatting via `conform.nvim`:

- all filetypes: `trim_whitespace`
- Lua: `stylua`
- TypeScript: `prettier`
- JavaScript: `prettier`
- Python: `black`
- C++: `clang-format`

## Bootstrap

On first startup, [`init.lua`](/home/aftab/.config/nvim/init.lua) checks for `lazy.nvim` under Neovim's data directory. If it is missing, it clones the stable branch from GitHub and exits on failure.

After bootstrap:

1. Start `nvim`.
2. Let `lazy.nvim` install plugins.
3. Ensure required external tools, LSP servers, and formatters are available.

## Maintenance

- Update plugins through `lazy.nvim`.
- Keep external formatters and language servers installed separately from the config as needed.
- Review [`lazy-lock.json`](/home/aftab/.config/nvim/lazy-lock.json) when plugin versions change.
