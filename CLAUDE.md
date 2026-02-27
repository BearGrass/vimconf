# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

This repository contains a Vim configuration setup for offline installation. The main configuration files are in the root directory (`.vimrc`, `.vim/`), with a complete offline package available in `vim-offline-package/`.

## Installation

### Quick Install (from root directory)
```bash
bash install.sh
```
This backs up existing Vim config to `~/vimbackup_YYYYMMDD_HHMMSS` and installs new files.

### Offline Package Install
```bash
tar -xzvf vim-offline-config.tar.gz
cp -r vim-offline-package/.vim ~/
bash ~/.vim/install.sh
```

### Dependencies
- **Vundle**: Plugin manager (included in bundle)
- **ctags**: Code navigation (`sudo apt-get install exuberant-ctags` or build from `vim-offline-package/.vim/tools/ctags-6.1.0.zip`)
- **nodejs/npm**: Required for coc.nvim
- **Powerline fonts**: Optional, for airline statusline (`bash ~/.vim/fonts/install-fonts.sh`)

## Key Bindings

| Key | Action |
|-----|--------|
| `<leader>,` | Leader key (comma) |
| `<F2>` | BufExplorer |
| `<F3>` | Toggle NERDTree |
| `<F4>` | Toggle Tagbar |
| `<F10>` | NERDTreeFind |
| `<F12>` | Generate tags |
| `<leader>1-9` | Switch to buffer 1-9 |
| `<Tab>` | Show function call list |

## Plugins

- **Vundle**: Plugin management
- **lightline.vim**: Statusline (replaced airline)
- **NERDTree**: File explorer
- **Tagbar**: Tag display
- **ctrlp.vim**: Fuzzy file finder
- **vim-fugitive**: Git integration
- **bufexplorer**: Buffer switcher
- **molokai**: Colorscheme

## ctags Usage

Generate tags recursively:
```bash
ctags -R --kinds-C=+defgmpstuvx --fields=+iaS --extras=+q dir1 dir2 dir3
```

## Architecture

```
.
├── .vimrc              # Main Vim configuration
├── .vim/               # Runtime directory
│   ├── autoload/       # Autoload functions (lightline, etc.)
│   ├── bundle/         # Vundle plugins
│   ├── colors/         # Color schemes
│   ├── plugin/         # Plugin configs
│   └── pack/           # Native packages
├── vim-offline-package/    # Complete offline distribution
└── install.sh          # Installation script
```

The `.vimrc` uses Vundle for plugin management with lightline.vim for statusline. The repo also includes `old/.vimrc` which has a previous configuration (airline instead of lightline).
