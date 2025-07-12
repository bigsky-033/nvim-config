# Minimal Neovim Configuration

A clean, minimal Neovim setup focused on essential features for Python, JavaScript, TypeScript, Java, C, and C++ development.

## Features

- 🚀 **LSP Support**: Intelligent code completion, diagnostics, and navigation
- 🔍 **Fuzzy Finding**: Quick file and text search with Telescope
- 📁 **File Explorer**: Tree-style file navigation with NvimTree
- 🎨 **Syntax Highlighting**: Enhanced with Treesitter
- 📦 **Auto-installation**: Plugins and language servers install automatically
- 🔧 **Auto-formatting**: Format on save with language-specific formatters
- 💾 **Portable**: Easy to sync across machines via Git

## Prerequisites

- **Neovim** >= 0.8.0
- **Git**
- **Node.js** and npm (for JavaScript/TypeScript)
- **Python** 3.x (for Python development)
- **JDK** 11 or higher (for Java development)
- **C/C++ compiler** (gcc/g++ or clang/clang++)
- **ripgrep** (for Telescope live grep)
- A [Nerd Font](https://www.nerdfonts.com/) (optional, for icons)

## Quick Install

### On a New Machine

```bash
# Backup existing config (if any)
mv ~/.config/nvim ~/.config/nvim.bak

# Clone this configuration
git clone https://github.com/YOUR_USERNAME/nvim-config.git ~/.config/nvim

# Install additional tools
pip install black isort flake8  # Python formatters
npm install -g prettier          # JS/TS formatter

# C/C++ formatter (choose based on your OS)
# Ubuntu/Debian:
sudo apt install clang-format
# macOS:
brew install clang-format
# Arch:
sudo pacman -S clang

# Open Neovim (plugins will auto-install)
nvim
```

Wait for all plugins to install (this happens automatically on first launch).

### First Time Setup

1. Clone this repository to your Neovim config location
2. Open Neovim - it will automatically:
   - Install the plugin manager (lazy.nvim)
   - Download and install all plugins
   - Install LSP servers via Mason
3. Restart Neovim after the initial setup completes

## Key Bindings

### Leader Key
- `Space` - Leader key (most commands start with this)

### General
- `jk` - Exit insert mode (alternative to ESC)
- `<leader>nh` - Clear search highlights

### File Navigation (Telescope)
- `<leader>ff` - Find files in project
- `<leader>fr` - Recent files
- `<leader>fs` - Search text in project (requires ripgrep)
- `<leader>fc` - Find word under cursor in project

### File Explorer (NvimTree)
- `<leader>ee` - Toggle file explorer
- `<leader>ef` - Find current file in explorer
- `<leader>ec` - Collapse all folders
- `<leader>er` - Refresh file explorer

**Inside NvimTree:**
- `a` - Create file/folder (end with `/` for folder)
- `d` - Delete
- `r` - Rename
- `x` - Cut
- `c` - Copy
- `p` - Paste
- `<CR>` or `o` - Open file/folder
- `v` - Open in vertical split
- `h` - Open in horizontal split
- `R` - Refresh
- `H` - Toggle hidden files
- `g?` - Help

### Code Navigation (LSP)
- `gd` - Go to definition
- `K` - Show hover documentation
- `<leader>vrr` - Find references
- `<leader>vrn` - Rename symbol
- `<leader>vca` - Code actions (fixes, refactors)
- `<leader>vd` - Show diagnostics float
- `[d` - Go to previous diagnostic
- `]d` - Go to next diagnostic
- `<leader>f` - Format current file

### Window Management
- `<leader>sv` - Split window vertically
- `<leader>sh` - Split window horizontally
- `<leader>se` - Make splits equal size
- `<leader>sx` - Close current split
- `<C-h/j/k/l>` - Navigate between splits

### Completion (Insert Mode)
- `<C-j>` - Trigger completion
- `<Tab>` - Next completion item
- `<S-Tab>` - Previous completion item
- `<CR>` - Confirm completion
- `<C-e>` - Cancel completion

## Project Structure

```
~/.config/nvim/
├── init.lua                 # Entry point
├── lua/
│   ├── core/
│   │   ├── options.lua     # Vim options
│   │   └── keymaps.lua     # Key mappings
│   └── plugins/
│       ├── init.lua        # Plugin declarations
│       ├── lsp.lua         # LSP configuration
│       ├── telescope.lua   # Fuzzy finder setup
│       ├── treesitter.lua  # Syntax highlighting
│       ├── java.lua        # Java-specific config
│       └── formatting.lua  # Auto-formatting setup
```

## Supported Languages

### Python
- **LSP**: Pyright (type checking, completion)
- **Formatting**: Black, isort
- **Linting**: Flake8

### JavaScript/TypeScript
- **LSP**: tsserver
- **Linting**: ESLint
- **Formatting**: Prettier
- **Supports**: JSX, TSX

### Java
- **LSP**: jdtls (Eclipse JDT Language Server)
- **Formatting**: Google Java Format
- **Supports**: Maven, Gradle projects

### C/C++
- **LSP**: clangd (fast, feature-rich)
- **Formatting**: clang-format
- **Features**: IntelliSense, diagnostics, code actions
- **Supports**: CMake, Make, compile_commands.json

### Additional
- Lua, HTML, CSS, JSON, Markdown

## Managing Your Configuration

### Update Plugins
```vim
:Lazy update
```

### Check Plugin Status
```vim
:Lazy
```

### Install LSP Servers
```vim
:Mason
```

### View Installed LSP Servers
```vim
:LspInfo
```

## Adding to Your Config

### Install a New Plugin
Add the plugin specification to `lua/plugins/init.lua`:
```lua
{
  "plugin/name",
  config = function()
    -- plugin configuration
  end,
}
```

### Add Support for a New Language
1. Add the Treesitter parser in `lua/plugins/treesitter.lua`
2. Add the LSP server in `lua/plugins/lsp.lua`
3. Add any formatters in `lua/plugins/formatting.lua`
4. Restart Neovim

## Troubleshooting

### Plugins Not Loading
- Run `:Lazy` to check plugin status
- Try `:Lazy restore` to reinstall plugins

### LSP Not Working
- Check `:LspInfo` when in a code file
- Ensure language servers are installed: `:Mason`
- Check prerequisites (Node.js for JS/TS, Python for Python files)

### Formatting Not Working
- Ensure formatters are installed:
  ```bash
  pip install black isort flake8
  npm install -g prettier
  # For C/C++:
  which clang-format  # Should show the path
  ```
- Check `:LspInfo` for active formatters

### C/C++ Specific Issues
- **Clangd not starting**: Ensure you have a C++ compiler installed
- **No code completion**: Create a `compile_commands.json` file:
  ```bash
  # For CMake projects:
  cmake -DCMAKE_EXPORT_COMPILE_COMMANDS=ON .
  
  # For Make projects, use bear:
  bear -- make
  ```
- **Custom formatting**: Create a `.clang-format` file in your project root

## Customization Tips

### Change Color Scheme
Edit `lua/plugins/init.lua` and replace the colorscheme plugin:
```lua
{
  "folke/tokyonight.nvim",  -- Change this
  priority = 1000,
  config = function()
    vim.cmd([[colorscheme tokyonight]])  -- And this
  end,
}
```

### Modify Options
Edit `lua/core/options.lua` to change editor behavior (tabs, line numbers, etc.)

### Add Custom Keymaps
Add your keybindings to `lua/core/keymaps.lua`

## Philosophy

This configuration follows these principles:
- **Minimal**: Only essential features, no bloat
- **Fast**: Quick startup and responsive editing
- **Portable**: Easy to move between machines
- **Maintainable**: Clear structure, well-commented

## Resources

- [Neovim Documentation](https://neovim.io/doc/)
- [LSP Configuration](https://github.com/neovim/nvim-lspconfig)
- [Telescope](https://github.com/nvim-telescope/telescope.nvim)
- [Treesitter](https://github.com/nvim-treesitter/nvim-treesitter)

