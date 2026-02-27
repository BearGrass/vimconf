# Vim 配置 - 离线/在线可用

一套完整的 Vim 配置方案，支持离线和在线两种安装方式。

## 特性

- **离线可用**: 所有插件和依赖打包，无网络环境也能安装
- **在线可用**: 支持通过 Vundle 在线更新插件
- **开箱即用**: 一键安装，自动备份原有配置
- **功能齐全**: NERDTree, Tagbar, CtrlP, Airline 等常用插件

## 快速安装

### 方式一：在线安装（推荐）

```bash
# 1. 克隆仓库
git clone https://github.com/BearGrass/vimconf.git ~/vimconf
cd ~/vimconf

# 2. 运行安装脚本
bash install.sh

# 3. 安装 ctags（二选一）
#   - 系统包管理器
sudo apt-get install exuberant-ctags
#   - 或从源码编译
unzip ctags-6.1.0.zip
cd ctags-6.1.0 && ./autogen.sh && ./configure && make && sudo make install

# 4. 启动 Vim 安装插件
vim
:PluginInstall
```

### 方式二：离线安装

```bash
# 1. 复制离线配置
cp -r vim-offline-package/.vim ~/

# 2. 运行安装脚本
bash ~/.vim/install.sh

# 3. 安装 Powerline 字体（可选，GUI 环境）
bash ~/.vim/fonts/install-fonts.sh

# 4. 启动 Vim
vim
```

## 快捷键

| 按键 | 功能 |
|------|------|
| `,1` - `,9` | 切换到缓冲区 1-9 |
| `<F2>` | 缓冲区浏览器 (BufExplorer) |
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
| vim-airline | 状态栏 |
| NERDTree | 文件资源管理器 |
| Tagbar | 代码结构标签栏 |
| CtrlP | 模糊文件搜索 |
| vim-fugitive | Git 集成 |

## 目录结构

```
vimconf/
├── .vimrc              # Vim 主配置
├── .vim/               # 运行时目录
│   ├── autoload/       # 自动加载函数
│   ├── bundle/         # Vundle 插件
│   ├── colors/         # 配色方案
│   ├── plugin/         # 插件配置
│   └── syntax/         # 语法高亮
├── vim-offline-package/ # 离线包
│   └── .vim/
│       ├── bundle/     # 离线插件
│       ├── fonts/      # Powerline 字体
│       └── tools/      # 工具（ctags 源码）
├── install.sh          # 安装脚本
├── ctags-6.1.0.zip     # ctags 源码包
└── README.md
```

## 卸载与恢复

安装脚本会自动备份原有配置到 `~/vimbackup_YYYYMMDD_HHMMSS` 目录。

如需恢复：
```bash
mv ~/vimbackup_YYYYMMDD_HHMMSS/.vim ~
mv ~/vimbackup_YYYYMMDD_HHMMSS/.vimrc ~
```

## 其他

### ctags 示例

```bash
ctags -R --kinds-C=+defgmpstuvx --fields=+iaS --extras=+q dir1 dir2 dir3
```

### npm 镜像加速（国内）

```bash
npm config set registry https://registry.npmmirror.com
```
