# Cheatsheet

A practical reference for this config: a short vim refresher first, then every
keybinding this setup adds, then a one-line note on what each plugin is for.
The leader key is Space (the localleader is `\`). which-key also shows the
available leader mappings as you type, so you can discover most of this without
leaving the editor.

## Part 1: Vim essentials

If you are new to vim, this is the minimum that makes the rest make sense.

### Modes

| Mode | How you get there | What it is |
| --- | --- | --- |
| Normal | `<Esc>`, or `jk` from insert | The home base. Keys are commands, not text. |
| Insert | `i a o` (and friends) | Type text. Leave with `<Esc>` or `jk`. |
| Visual | `v`, `V`, `<C-v>` | Select a range, then act on it. |
| Command-line | `:`, `/`, `?` | Run a command or a search. |

### Moving around

| Keys | Moves to |
| --- | --- |
| `h j k l` | Left, down, up, right |
| `w` / `b` / `e` | Start of next word / start of previous word / end of word |
| `0` / `^` / `$` | Start of line / first non-blank / end of line |
| `gg` / `G` | First line / last line of the file |
| `{` / `}` | Previous / next blank-line paragraph |
| `%` | Matching bracket of the pair under the cursor |
| `f{char}` / `t{char}` | Jump to / up to the next `{char}` on the line |
| `<C-u>` / `<C-d>` | Scroll half a page up / down |

### Editing

| Keys | Does |
| --- | --- |
| `i` / `a` | Insert before / after the cursor |
| `I` / `A` | Insert at first non-blank / end of line |
| `o` / `O` | Open a new line below / above |
| `d` / `c` / `y` | Delete / change / yank (operators; pair with a motion) |
| `p` / `P` | Paste after / before the cursor |
| `dd` / `yy` / `cc` | Delete / yank / change the whole line |
| `x` / `r` | Delete the character / replace one character |
| `u` / `<C-r>` | Undo / redo |
| `.` | Repeat the last change |

### Visual mode

Start a selection with `v` (charwise), `V` (linewise), or `<C-v>` (block), then
act on it: `d` delete, `c` change, `y` yank, `>` / `<` indent. In this config
`gc` comments the selection and `<leader>cf` formats it.

### Search

| Keys | Does |
| --- | --- |
| `/pattern` | Search forward |
| `?pattern` | Search backward |
| `n` / `N` | Next / previous match |
| `*` | Search for the word under the cursor |
| `<Esc>` | Clear the search highlight (this config) |

Substitute across the file with `:%s/old/new/g` (drop the `g` to change only the
first match on each line).

### Operators and motions

The real power of vim is combining an operator (`d c y`) with a motion or a text
object. Text objects come in `i` (inner) and `a` (around) flavours: `iw`/`aw`
word, `i(`/`a(` parentheses, `i"`/`a"` quotes, `ip`/`ap` paragraph, `it`/`at`
tag.

| Example | Reads as |
| --- | --- |
| `ciw` | Change inner word |
| `di(` | Delete inside parentheses |
| `yap` | Yank a paragraph |
| `dt)` | Delete up to the next `)` |
| `ci"` | Change inside the quotes |

### Windows, tabs, save and quit

| Command | Does |
| --- | --- |
| `:split` / `:vsplit` | Split the window horizontally / vertically |
| `<C-w>w` / `<C-w>q` | Cycle to the next window / close the window |
| `:tabnew` / `gt` / `gT` | New tab / next tab / previous tab |
| `:w` | Write (save) the file |
| `:q` / `:q!` | Quit / quit without saving |
| `:wq` (or `:x`) | Write and quit |
| `:wa` / `:qa` | Write all / quit all |

This config adds friendlier window and buffer maps; see Part 2.

## Part 2: This config's keybindings

Leader is Space, so `<leader>ff` means Space then `f` then `f`. The groups below
match the which-key menu: find, git, code, explorer, buffers, windows.

### Insert mode

| Key | Action |
| --- | --- |
| `jk` | Exit insert mode (same as `<Esc>`) |

### General (normal mode)

| Key | Action |
| --- | --- |
| `<Esc>` | Clear the search highlight |

### find (`<leader>f`) - Telescope

| Key | Action |
| --- | --- |
| `<leader>ff` | Find files |
| `<leader>fg` | Search project text (live grep) |
| `<leader>fb` | List open buffers |
| `<leader>fr` | Recent files |
| `<leader>fh` | Help tags |
| `<leader>fk` | Keymaps |
| `<leader>fd` | Diagnostics (project list) |
| `<leader>fw` | Word under the cursor |
| `<leader>fs` | Document symbols |

### git (`<leader>g`) - gitsigns

| Key | Action |
| --- | --- |
| `]h` / `[h` | Next / previous hunk |
| `<leader>gs` | Stage hunk |
| `<leader>gr` | Reset hunk |
| `<leader>gp` | Preview hunk |
| `<leader>gb` | Blame the current line |
| `<leader>gd` | Diff the file against the index |

### code (`<leader>c`) - LSP and formatting

These attach when a language server is running (formatting comes from conform):

| Key | Action |
| --- | --- |
| `gd` | Go to definition |
| `gD` | Go to declaration |
| `<leader>ca` | Code action |
| `<leader>cr` | Rename symbol |
| `<leader>cd` | Line diagnostics in a float |
| `<leader>cf` | Format the buffer or the selection |

Neovim 0.11+ ships these LSP maps in core, so they work too:

| Key | Action |
| --- | --- |
| `K` | Hover documentation |
| `grn` | Rename symbol |
| `gra` | Code action |
| `grr` | List references |
| `gri` | Go to implementation |
| `[d` / `]d` | Previous / next diagnostic |

### explorer (`<leader>e`) - nvim-tree

| Key | Action |
| --- | --- |
| `<leader>ee` | Toggle the file explorer |
| `<leader>ef` | Reveal the current file in the tree |

### buffers (`<leader>b`)

| Key | Action |
| --- | --- |
| `]b` / `[b` | Next / previous buffer |
| `<leader>bd` | Delete (close) the buffer |

### windows (`<leader>w`)

| Key | Action |
| --- | --- |
| `<C-h>` / `<C-j>` / `<C-k>` / `<C-l>` | Move to the left / lower / upper / right window |
| `<leader>wv` | Split window vertically |
| `<leader>ws` | Split window horizontally |
| `<leader>wq` | Close window |
| `<leader>w=` | Equalize window sizes |

### Completion (insert mode) - nvim-cmp

| Key | Action |
| --- | --- |
| `<C-Space>` | Trigger completion |
| `<C-n>` / `<C-p>` | Next / previous item |
| `<CR>` | Confirm the selected item |
| `<C-e>` | Abort completion |
| `<C-b>` / `<C-f>` | Scroll the docs popup up / down |

### Comments and pairs

Commenting is the Neovim built-in, no plugin needed:

| Key | Action |
| --- | --- |
| `gcc` | Comment or uncomment the current line |
| `gc{motion}` | Comment over a motion, e.g. `gcap` for a paragraph |
| `gc` (visual) | Comment the selection |

Autopairs closes brackets and quotes for you as you type; there is nothing to
press.

## Part 3: Plugins, what and why

| Plugin | What it is and why it is here |
| --- | --- |
| lazy.nvim | Plugin manager. Installs and lazy-loads everything, and pins versions in `lazy-lock.json`. |
| nvim-treesitter | Installs language parsers. The highlighting itself comes from Neovim core, started per buffer. |
| mason + mason-lspconfig + nvim-lspconfig | Install language servers and enable them through Neovim's native LSP. |
| nvim-cmp + LuaSnip | Insert-mode completion, with LuaSnip expanding snippets. |
| conform.nvim + mason-tool-installer | Format on save, using external formatters that Mason installs per machine. |
| telescope + fzf-native | Fuzzy finder for files, text, buffers, and more; fzf-native makes the matching fast. |
| nvim-tree | The file explorer sidebar. |
| gitsigns | Shows added, changed, and removed lines in the sign column, and provides the hunk actions above. |
| which-key | Pops up the available leader mappings as you type. |
| lualine | The statusline. |
| nvim-autopairs | Closes brackets and quotes automatically. |
| indent-blankline | Draws indentation guide lines. |
| tokyonight | The colorscheme. |
