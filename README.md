# Neovim configuration

A small, stability-first Neovim configuration for Neovim 0.12. It is meant for
general editing and Markdown, with worked-out language support for Python and
JavaScript/TypeScript (plus Lua and the common config formats: JSON, YAML, TOML,
and Bash). The idea is a setup that stays out of the way: LSP and Treesitter
highlighting come from Neovim core, and a short list of well-known plugins is
managed by lazy.nvim. It runs the same on Linux and macOS. Anything
machine-specific (language servers, formatters, parsers) is installed on first
launch rather than committed, so a fresh checkout is enough to get going.

## Requirements

Neovim 0.12 or newer, plus a few command-line tools:

- git, curl, and tar to bootstrap plugins and fetch Mason tools.
- A C compiler (gcc or clang) and make, to build Treesitter parsers.
- ripgrep and fd for Telescope's file and text search.
- Node.js for the TypeScript server and the prettier formatter.
- A Nerd Font, for the icons in the file explorer and statusline.
- A clipboard tool so the system clipboard works: wl-clipboard or xclip on
  Linux; macOS has this built in.

Language servers and formatters are not prerequisites. Mason installs them per
machine on first launch.

## Install

On a new machine, install the prerequisites, back up any existing config, then
clone this repo into place.

Fedora:

```bash
sudo dnf install git curl tar gcc make ripgrep fd-find nodejs
```

macOS (Homebrew):

```bash
brew install git curl ripgrep fd node
brew install --cask font-jetbrains-mono-nerd-font
```

On Wayland you also want a clipboard tool (`sudo dnf install wl-clipboard`, or
`xclip` on X11). On Fedora, install a Nerd Font by hand from nerdfonts.com.

Then back up and clone:

```bash
# Back up an existing config, if you have one.
mv ~/.config/nvim ~/.config/nvim.bak

git clone https://github.com/bigsky-033/nvim-config.git ~/.config/nvim
```

Launch Neovim once and let it set itself up:

```bash
nvim
```

On the first launch, lazy.nvim installs the plugins and Mason installs the
language servers, formatters, and Treesitter parsers. Wait for that to finish,
then quit and start Neovim again so everything loads cleanly. If anything looks
off, `:checkhealth` is the place to start.

## Usage and maintenance

A handful of commands cover day-to-day upkeep:

- `:Lazy` shows plugin status and opens the manager UI.
- `:Lazy update` updates plugins and refreshes `lazy-lock.json`. Commit the
  updated lockfile so your other machines resolve the same commits.
- `:Mason` manages language servers, formatters, and other tools.
- `:TSUpdate` installs or updates Treesitter parsers.
- `:checkhealth` runs overall diagnostics; `:checkhealth vim.lsp` shows which
  servers attached to the current buffer.

## Layout

```
init.lua              Entry point; loads lua/config/lazy.lua.
lazy-lock.json        Pinned plugin commits (committed).
lua/config/           Core editor settings.
  lazy.lua            Leader keys, core requires, lazy.nvim bootstrap.
  options.lua         Editor options.
  keymaps.lua         Non-plugin keymaps.
  autocmds.lua        Yank highlight; start Treesitter highlight per buffer.
lua/plugins/          One file per concern, each returning a lazy spec.
after/lsp/            Per-server LSP overrides (lua_ls.lua is the example).
docs/cheatsheet.md    Keymap and vim cheatsheet.
AGENTS.md             Decision record and maintenance guide.
```

## Keybindings

The leader key is Space. The full keymap, along with a short vim refresher,
lives in [docs/cheatsheet.md](docs/cheatsheet.md) instead of being duplicated
here. which-key also pops up the available leader mappings as you type, so you
can discover most of them without leaving the editor.

## Customizing

- Colorscheme: edit `lua/plugins/colorscheme.lua`. It uses tokyonight; change
  the style there, or swap in a different colorscheme plugin.
- Adding a language: follow the recipe in `AGENTS.md`. In short, add the
  Treesitter parser, the Mason LSP server, and a formatter, each in its own
  plugin file under `lua/plugins/`.
- Per-server LSP settings: add `after/lsp/<server>.lua` returning a settings
  table, which is merged over the defaults. See `after/lsp/lua_ls.lua`.

`AGENTS.md` has the fuller picture: what each plugin is, why it was chosen, and
what was deliberately left out.
