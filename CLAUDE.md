# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

A Vim configuration repository supporting both online and offline installation. The main configuration is `.vimrc` with Vundle for plugin management and airline for the statusline.

## Installation

### One-Click Install (Recommended)
```bash
# Online
bash <(curl -sL https://raw.githubusercontent.com/BearGrass/vimconf/master/install.sh)

# Offline (copy repo to target machine first)
cd vimconf && bash install.sh
```

### Manual Install
```bash
git clone https://github.com/BearGrass/vimconf.git ~/vimconf
cd ~/vimconf && bash install.sh
```

The installer:
- Auto-detects online/offline mode
- Backs up existing config to `~/vimbackup_YYYYMMDD_HHMMSS`
- Auto-installs dependencies (git, unzip, ctags)
- Clones Vundle and runs `:PluginInstall` (online mode)

## Key Bindings

| Key | Action |
|-----|--------|
| `,1` - `,9` | Switch to buffer 1-9 |
| `<F2>` | BufExplorer (open/close buffer list) |
| `<F3>` | Toggle NERDTree |
| `<F4>` | Toggle Tagbar |
| `<F10>` | NERDTreeFind (locate current file) |
| `<F12>` | Generate ctags |
| `<Tab>` / `<C-i>` | Show function list |
| `mapleader` | Comma `,` |

## Plugins

| Plugin | Purpose |
|--------|---------|
| Vundle.vim | Plugin manager |
| vim-airline | Statusline |
| NERDTree | File explorer |
| Tagbar | Code structure sidebar |
| CtrlP | Fuzzy file finder |
| vim-fugitive | Git integration |
| BufExplorer | Buffer management |
| molokai | Colorscheme |

## Architecture

```
vimconf/
├── .vimrc                   # Main Vim config (unified for online/offline)
├── .vim/                    # Runtime directory
│   ├── autoload/            # Autoload functions
│   ├── bundle/              # Vundle plugins
│   ├── colors/              # Colorschemes (molokai)
│   └── plugin/              # Plugin configurations
├── vim-offline-package/     # Offline distribution
│   └── .vim/
│       ├── bundle/          # Pre-bundled plugins (including BufExplorer)
│       ├── fonts/           # Powerline fonts
│       └── tools/           # ctags-6.1.0.zip for offline build
├── install.sh               # One-click installer
├── download.sh              # Download helper
└── README.md
```

## Development Notes

- **Unified config**: `.vimrc` and `vim-offline-package/.vim/vimrc` are synchronized
- **Offline ready**: All plugins pre-bundled in `vim-offline-package/.vim/bundle/`
- **ctags**: Available in `vim-offline-package/.vim/tools/ctags-6.1.0.zip`
- **No coc.nvim**: Removed dependency on nodejs/npm

## Common Commands

```bash
# Install ctags (if installer fails)
sudo apt-get install exuberant-ctags

# Install Powerline fonts (for airline symbols)
bash ~/.vim/fonts/install-fonts.sh

# Update plugins (inside Vim)
:PluginUpdate

# Generate tags
ctags -R .
```
