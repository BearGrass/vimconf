#!/bin/bash
# Vim 配置一键安装脚本 - 在线/离线自动检测
# 用法：bash <(curl -sL https://raw.githubusercontent.com/BearGrass/vimconf/master/install.sh)

set -e

GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
BLUE='\033[0;34m'
NC='\033[0m'

info() { echo -e "${GREEN}✓ $1${NC}"; }
warn() { echo -e "${YELLOW}! $1${NC}"; }
error() { echo -e "${RED}✗ $1${NC}"; exit 1; }
step() { echo -e "${BLUE}▶ $1${NC}"; }

REPO_URL="https://github.com/BearGrass/vimconf.git"
BACKUP_DIR="$HOME/vimbackup_$(date +%Y%m%d_%H%M%S)"
TMP_DIR="/tmp/vimconf_install_$$"

# 清理函数
cleanup() {
    rm -rf "$TMP_DIR" 2>/dev/null || true
}
trap cleanup EXIT

# 检查依赖
check_deps() {
    step "检查系统依赖..."
    local missing=()
    for cmd in git unzip; do
        if ! command -v "$cmd" &> /dev/null; then
            missing+=("$cmd")
        fi
    done

    if [ ${#missing[@]} -gt 0 ]; then
        warn "缺少依赖：${missing[*]}"
        if command -v apt-get &> /dev/null; then
            info "正在安装依赖..."
            sudo apt-get update && sudo apt-get install -y "${missing[@]}" || error "安装依赖失败"
        else
            error "请手动安装缺失的依赖"
        fi
    fi
    info "系统依赖检查通过"
}

# 检查编译依赖
check_build_deps() {
    local missing=()
    for cmd in gcc make autoconf; do
        if ! command -v "$cmd" &> /dev/null; then
            missing+=("$cmd")
        fi
    done

    if [ ${#missing[@]} -gt 0 ]; then
        return 1
    fi
    return 0
}

# 备份现有配置
backup_existing() {
    step "备份现有配置..."
    local files=(".vim" ".vimrc")
    local need_backup=0

    for file in "${files[@]}"; do
        if [ -e "$HOME/$file" ]; then
            need_backup=1
            break
        fi
    done

    if [ $need_backup -eq 1 ]; then
        mkdir -p "$BACKUP_DIR" || error "无法创建备份目录"
        for file in "${files[@]}"; do
            if [ -e "$HOME/$file" ]; then
                mv "$HOME/$file" "$BACKUP_DIR/"
                info "已备份：$file → $BACKUP_DIR/"
            fi
        done
    else
        info "无需备份"
    fi
}

# 安装 ctags
install_ctags() {
    step "检查 ctags..."

    if command -v ctags &> /dev/null; then
        info "ctags 已存在，跳过"
        return 0
    fi

    info "正在安装 ctags..."

    # 离线模式
    if [ -f "./vim-offline-package/.vim/tools/ctags-6.1.0.zip" ]; then
        info "[离线模式] 编译安装 ctags"
        local TOOLS_DIR="$HOME/.vim/tools"
        mkdir -p "$TOOLS_DIR"
        cp "./vim-offline-package/.vim/tools/ctags-6.1.0.zip" "$TOOLS_DIR/"
        cd "$TOOLS_DIR"

        if check_build_deps; then
            unzip -q ctags-6.1.0.zip
            cd ctags-6.1.0
            ./autogen.sh --silent && ./configure --prefix="$TOOLS_DIR/ctags" --silent && make --silent && make install --silent
            mkdir -p "$HOME/.local/bin"
            ln -sf "$TOOLS_DIR/ctags/bin/ctags" "$HOME/.local/bin/ctags"

            if ! grep -q "PATH=\$HOME/.local/bin:\$PATH" ~/.bashrc; then
                echo 'export PATH=$HOME/.local/bin:$PATH' >> ~/.bashrc
            fi
            info "ctags 已安装到 ~/.local/bin/ctags"
            info "请执行 source ~/.bashrc 或重新登录"
        else
            warn "缺少编译工具，请执行：sudo apt-get install build-essential autoconf"
            return 1
        fi
        cd - > /dev/null

    # 在线模式 - 系统包管理器
    else
        info "[在线模式] 使用包管理器安装 ctags"
        if command -v apt-get &> /dev/null; then
            sudo apt-get install -y exuberant-ctags && info "ctags 安装成功" || warn "ctags 安装失败"
        elif command -v yum &> /dev/null; then
            sudo yum install -y ctags && info "ctags 安装成功" || warn "ctags 安装失败"
        else
            warn "无法自动安装 ctags，请手动安装"
        fi
    fi
}

# 安装插件
install_plugins() {
    step "安装 Vim 插件..."

    if [ -f "$HOME/.vim/bundle/Vundle.vim/autoload/vundle.vim" ]; then
        info "Vundle 已存在"
    else
        info "正在克隆 Vundle..."
        git clone --depth 1 https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
    fi

    info "正在安装插件 (首次安装可能需要几分钟)..."
    # 使用 Vim 非交互式安装插件
    vim +PluginInstall +qall 2>/dev/null || warn "插件安装失败，可在 Vim 中执行 :PluginInstall"
    info "插件安装完成"
}

# 主安装流程
main() {
    echo ""
    echo "╔══════════════════════════════════════╗"
    echo "║     Vim 配置一键安装脚本             ║"
    echo "║     GitHub: BearGrass/vimconf        ║"
    echo "╚══════════════════════════════════════╝"
    echo ""

    # 判断安装模式
    local MODE="online"
    local SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

    if [ -d "$SCRIPT_DIR/vim-offline-package/.vim" ]; then
        MODE="offline"
        info "检测到离线包，使用离线安装模式"
        cd "$SCRIPT_DIR"
    elif [ -d "./vim-offline-package/.vim" ]; then
        MODE="offline"
        info "检测到离线包，使用离线安装模式"
    else
        info "使用在线安装模式"

        # 在线模式：先下载
        step "下载配置..."
        mkdir -p "$TMP_DIR"
        cd "$TMP_DIR"
        git clone --depth 1 "$REPO_URL" . || error "下载失败，请检查网络连接"
    fi

    echo ""

    # 备份
    backup_existing

    # 复制配置
    step "复制配置文件..."
    if [ -d "./vim-offline-package/.vim" ]; then
        cp -r "./vim-offline-package/.vim" "$HOME/.vim"
        cp "./vim-offline-package/.vim/vimrc" "$HOME/.vimrc"
        info "已复制 .vim/"
        info "已复制 .vimrc"
    else
        cp -r "./.vim" "$HOME/.vim" 2>/dev/null && info "已复制 .vim/" || true
        cp "./.vimrc" "$HOME/.vimrc" 2>/dev/null && info "已复制 .vimrc" || true
    fi

    # 创建目录
    mkdir -p "$HOME/.vim/undo"
    mkdir -p "$HOME/.vim/data"
    info "已创建必要目录"

    # 安装 ctags
    echo ""
    install_ctags

    # 在线模式安装插件
    if [ "$MODE" = "online" ]; then
        echo ""
        install_plugins
    fi

    # 完成信息
    echo ""
    echo "╔══════════════════════════════════════╗"
    if [ "$MODE" = "offline" ]; then
        echo "║         离线安装完成！                ║"
    else
        echo "║         在线安装完成！                ║"
    fi
    echo "╚══════════════════════════════════════╝"
    echo ""
    echo "后续步骤:"
    echo "  • 重启终端 或执行：source ~/.bashrc"
    echo "  • 启动 Vim 即可使用"
    if [ "$MODE" = "online" ]; then
        echo "  • (可选) 安装 Powerline 字体美化状态栏"
    else
        echo "  • (可选) 安装字体：bash ~/.vim/fonts/install-fonts.sh"
    fi
    echo ""
}

main "$@"
