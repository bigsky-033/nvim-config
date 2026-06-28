# Agent and maintainer guide

Guidance for AI agents and maintainers working on this Neovim configuration. Read this before changing anything.

This is the decision record. It captures not just what the config does but why, including options that were considered and rejected, so you can make a correct change without re-deriving the reasoning from scratch.

## Target and philosophy

- Neovim 0.12.x stable only. Never nightly. The config assumes the modern 0.11/0.12 APIs are present and uses them directly.
- Stability is the top priority. "Minimal" here means a small configuration and cognitive surface, not the fewest possible plugins. A well-known plugin that removes config is preferred over hand-rolled code.
- Pragmatic hybrid: Neovim-native LSP plus a small set of dominant, large-community plugins. Use core features wherever core is solid, and reach for a plugin only where it clearly wins.
- Only add widely adopted, actively maintained plugins. Avoid fancy or unproven ones, however appealing.

## Decision record

- Plugin manager: lazy.nvim. `lazy-lock.json` is committed so every machine resolves the same commits. Updates are deliberate: run `:Lazy update`, review the result, and commit the new lock. Automatic update checks are off (`checker.enabled = false`).
- LSP: Neovim-native `vim.lsp.config` / `vim.lsp.enable`. The legacy `require('lspconfig').setup{}` framework is deprecated and must not be used. Servers are installed and enabled through `mason-org/mason` and `mason-lspconfig` (v2, with `automatic_enable = true`). Per-server overrides go in `after/lsp/<server>.lua`, which core merges over the defaults. Note the org move: it is `mason-org/*` now, not the old `williamboman/*`.
- Treesitter: `nvim-treesitter` on its `main` branch, used only as a parser installer (`require("nvim-treesitter").install({...})`). Highlighting itself comes from Neovim core, started per buffer by `vim.treesitter.start()` in `lua/config/autocmds.lua`. Rejected alternatives:
  - The classic `master` API (the old `configs.setup` with `highlight.enable`). It is legacy and locked to a 0.11-era design; the project is moving off it.
  - Pure core with no plugin. Core bundles only five parsers and ships no installer, so the primary languages would have no parser and therefore no Treesitter highlighting.
  - Caveat: the nvim-treesitter repo is archived/frozen. Revisit this choice if a maintained successor or a core parser installer appears.
- Completion: nvim-cmp, the most proven option with the widest source ecosystem. blink.cmp is the obvious future alternative and is noted here on purpose, but it is not used yet.
- Python LSP: pyright, the most widely used server. If you want stricter checking, basedpyright is a one-line swap: change the name in `ensure_installed` (and optionally add `after/lsp/basedpyright.lua`).
- Formatting: conform.nvim with format-on-save. Formatter binaries are installed by mason-tool-installer, so they come down per machine via Mason.
- Explorer and colorscheme: nvim-tree and tokyonight. Both are intentionally generic and easy to swap; nothing else depends on them.
- Excluded on purpose: surround, session/auto-restore, dashboard/bufferline/notification UI, and distribution frameworks (LazyVim, kickstart). They add surface or magic without earning their keep here. Add them only with a concrete reason.
- Language scope: only Lua, Python, JavaScript/TypeScript, and the common text formats (JSON, YAML, TOML, Bash, Markdown) are wired up. Anything else is added on demand using the recipe below; the config does not try to support every language up front.

## Verified ecosystem facts (as of 2026-06; may change)

These are the moving facts the decisions above depend on. Re-check them before any large change:

- The `lspconfig` framework setup is deprecated. Native `vim.lsp.config` / `vim.lsp.enable` is the supported path.
- Mason moved to the `mason-org` GitHub org. `williamboman/mason*` is the old location.
- Treesitter is mid-transition: the `main` branch is the future, `master` is legacy, and Neovim core bundles only five parsers and ships no parser installer.

## Repository layout

```
init.lua                    Entry point; requires config.lazy and nothing else.
lazy-lock.json              Pinned plugin commits. Committed.
lua/config/
  lazy.lua                  Leader keys, core requires, lazy bootstrap and setup.
  options.lua               Editor options.
  keymaps.lua               Non-plugin keymaps (windows, buffers, misc).
  autocmds.lua              Yank highlight; start core Treesitter highlight on FileType.
lua/plugins/                One file per concern; each returns a lazy spec or a list of specs.
  colorscheme.lua           tokyonight.
  treesitter.lua            nvim-treesitter (main) as a parser installer.
  lsp.lua                   mason, mason-lspconfig, diagnostics, LspAttach keymaps.
  completion.lua            nvim-cmp and LuaSnip.
  formatting.lua            conform.nvim and mason-tool-installer.
  telescope.lua             Fuzzy finder.
  explorer.lua              nvim-tree.
  gitsigns.lua              Git signs and hunk keymaps.
  whichkey.lua              which-key leader-group labels.
  statusline.lua            lualine.
  editing.lua               autopairs and indent guides.
after/lsp/
  lua_ls.lua                Per-server settings for lua_ls; the pattern for overrides.
README.md                   User-facing setup, prerequisites, and keymaps.
docs/cheatsheet.md          Keymap cheatsheet.
AGENTS.md                   This file.
```

## Conventions

- One concern per file. Each `lua/plugins/*.lua` returns a lazy spec, or a list of specs when two small plugins clearly belong together (see `editing.lua`).
- Core settings live in `lua/config/options.lua`, `keymaps.lua`, and `autocmds.lua`. Leader keys are set in `lua/config/lazy.lua` before any plugin loads. `mapleader` and `maplocalleader` must be set first, or per-plugin `keys` specs bind against the wrong leader.
- Per-server LSP settings go in `after/lsp/<server>.lua`, returning a table that core merges over the defaults. Keep shared LSP setup (capabilities, diagnostics, the LspAttach maps, `ensure_installed`) in `lua/plugins/lsp.lua`.
- Prefer lazy-loading via `event` / `keys` / `cmd`. Things that must exist at startup (the colorscheme, the Treesitter installer) use `lazy = false`.
- Documentation: no emojis; natural, concise tone. Whenever you change the config, update `README.md` and `docs/cheatsheet.md` in the same change so they do not drift.

## Recipe: add a language

1. Add the Treesitter parser to the `install({ ... })` list in `lua/plugins/treesitter.lua`, then run `:TSUpdate`.
2. Add the LSP server name to `ensure_installed` in `lua/plugins/lsp.lua`. With `automatic_enable`, Mason enables it for you and native config picks it up. Add per-server settings in `after/lsp/<server>.lua` if needed.
3. Add a formatter to `formatters_by_ft` in `lua/plugins/formatting.lua`, and add its binary to mason-tool-installer's `ensure_installed` in the same file.
4. Update `docs/cheatsheet.md` and `README.md` if anything is user-facing.

## Recipe: add a plugin

Create `lua/plugins/<name>.lua` returning a lazy spec. Lazy-load it with `event` / `keys` / `cmd` where possible. Run `:Lazy sync`, then commit the updated `lazy-lock.json`. Document any new keymaps in `docs/cheatsheet.md`.

## Maintenance commands

- `:Lazy` for plugin status; `:Lazy update` to update plugins and refresh the lock.
- `:Mason` to manage LSP servers, formatters, and other tools.
- `:TSUpdate` to install or update Treesitter parsers.
- `:checkhealth` for overall diagnostics.
- `:checkhealth vim.lsp` for LSP-specific health, including which servers attached.

## Cross-platform

Targets Linux (Fedora, and likely others) and macOS on Apple Silicon. Keep it path-agnostic: never hardcode paths, always go through `vim.fn.stdpath(...)` as the lazy bootstrap and the Treesitter `install_dir` already do. External tools, the language servers and formatters, are installed per machine by Mason and are not committed, so a fresh checkout plus a first `nvim` launch is enough to come up. List any non-Mason prerequisites in README (Node.js for prettierd and ts_ls, a C compiler for building Treesitter parsers, ripgrep for Telescope live grep).
