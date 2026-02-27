# Vim 配置 - 离线/在线可用

一套完整的 Vim 配置方案，支持离线和在线两种安装方式。

## 特性

- **离线可用**: 所有插件和依赖打包，无网络环境也能安装
- **在线可用**: 支持通过 Vundle 在线更新插件
- **一键安装**: 自动检测环境，自动备份，自动安装依赖
- **功能齐全**: NERDTree, Tagbar, CtrlP, Airline, BufExplorer 等常用插件

## 快速安装

### 方式一：一键安装（推荐）

**在线环境：**
```bash
bash <(curl -sL https://raw.githubusercontent.com/BearGrass/vimconf/master/install.sh)
```

**离线环境：**
```bash
# 1. 将 vimconf 目录复制到目标机器
cp -r vimconf /target/path/

# 2. 运行安装脚本
cd /target/path/vimconf
bash install.sh
```

### 方式二：分步安装

```bash
# 1. 克隆仓库
git clone https://github.com/BearGrass/vimconf.git ~/vimconf
cd ~/vimconf

# 2. 运行安装脚本
bash install.sh

# 3. 等待插件安装完成（首次需要几分钟）
```

### 方式三：完全离线

```bash
# 1. 复制离线配置
cp -r vim-offline-package/.vim ~/

# 2. 运行安装脚本
bash ~/.vim/install.sh

# 3. (可选) 安装 Powerline 字体（GUI 环境）
bash ~/.vim/fonts/install-fonts.sh
```

## 快捷键

| 按键 | 功能 |
|------|------|
| `,1` - `,9` | 切换到缓冲区 1-9 |
| `<F2>` | BufExplorer (打开/关闭缓冲区列表) |
| `<F3>` | 切换 NERDTree 文件树 |
| `<F4>` | 切换 Tagbar 标签栏 |
| `<F10>` | NERDTree 定位当前文件 |
| `<F12>` | 生成 ctags |
| `<Tab>` | 显示函数调用列表 |
| `<leader>` | 逗号 `,` |

## 插件列表

| 插件 | 说明 |
|------|------|
| Vundle.vim | 插件管理器 |
| vim-airline | 轻量级状态栏 |
| NERDTree | 文件资源管理器 |
| Tagbar | 代码结构标签栏 |
| CtrlP | 模糊文件搜索 |
| vim-fugitive | Git 集成 |
| BufExplorer | 缓冲区管理 |

## 目录结构

```
vimconf/
├── .vimrc                   # Vim 主配置
├── .vim/                    # 运行时目录
│   ├── autoload/            # 自动加载函数
│   ├── bundle/              # Vundle 插件
│   ├── colors/              # 配色方案
│   ├── plugin/              # 插件配置
│   └── syntax/              # 语法高亮
├── vim-offline-package/     # 离线包
│   └── .vim/
│       ├── bundle/          # 离线插件 (含 BufExplorer)
│       ├── fonts/           # Powerline 字体
│       └── tools/           # 工具 (ctags 源码)
├── install.sh               # 一键安装脚本
├── download.sh              # 下载脚本
└── README.md
```

## 卸载与恢复

安装脚本会自动备份原有配置到 `~/vimbackup_YYYYMMDD_HHMMSS` 目录。

**恢复旧配置：**
```bash
mv ~/vimbackup_YYYYMMDD_HHMMSS/.vim ~/.vim
mv ~/vimbackup_YYYYMMDD_HHMMSS/.vimrc ~/.vimrc
```

**卸载：**
```bash
rm -rf ~/.vim ~/.vimrc
```

## 常见问题

### ctags 安装失败
```bash
# Ubuntu/Debian
sudo apt-get install exuberant-ctags

# CentOS/RHEL
sudo yum install ctags

# 或从源码编译
cd ~/.vim/tools/ctags-6.1.0
./autogen.sh && ./configure && make && sudo make install
```

### 状态栏显示方块/乱码
安装 Powerline 字体：
```bash
bash ~/.vim/fonts/install-fonts.sh
```

### 插件更新
```vim
" 在 Vim 中执行
:PluginUpdate
```

## 配置定制

编辑 `~/.vimrc` 文件，常用定制：

```vim
" 修改主题
colorscheme molokai

" 修改行号显示
set number          " 显示行号
set relativenumber  " 相对行号

" 修改缩进
set ts=4            " tab 宽度
set sw=4            " 缩进宽度
set et              " tab 转空格
```
