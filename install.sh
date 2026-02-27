#!/bin/bash

# Vim 配置安装脚本 - 支持在线/离线模式
set -e

# 定义颜色
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m'

# 备份目录
BACKUP_DIR="$HOME/vimbackup_$(date +%Y%m%d_%H%M%S)"

# 错误处理
handle_error() {
    echo -e "${RED}错误：$1${NC}"
    exit 1
}

info() {
    echo -e "${GREEN}$1${NC}"
}

warn() {
    echo -e "${YELLOW}$1${NC}"
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
        warn "缺少编译依赖：${missing[*]}"
        warn "安装 ctags 需要执行：sudo apt-get install build-essential autoconf"
        return 1
    fi
    return 0
}

# 备份现有配置
backup_existing() {
    local files=(".vim" ".vimrc" ".viminfo")
    local need_backup=0

    for file in "${files[@]}"; do
        if [ -e "$HOME/$file" ]; then
            need_backup=1
            break
        fi
    done

    if [ $need_backup -eq 1 ]; then
        info "创建备份目录：$BACKUP_DIR"
        mkdir -p "$BACKUP_DIR" || handle_error "无法创建备份目录"

        for file in "${files[@]}"; do
            if [ -e "$HOME/$file" ]; then
                mv "$HOME/$file" "$BACKUP_DIR/"
                info "已备份：$file"
            fi
        done
    fi
}

# 安装 ctags
install_ctags() {
    if command -v ctags &> /dev/null; then
        info "ctags 已安装，跳过"
        return 0
    fi

    info "安装 ctags..."

    # 离线模式：使用 tools/ctags-6.1.0.zip
    if [ -f "./vim-offline-package/.vim/tools/ctags-6.1.0.zip" ]; then
        info "[离线模式] 从本地包安装 ctags"
        local TOOLS_DIR="$HOME/.vim/tools"
        mkdir -p "$TOOLS_DIR"
        cp "./vim-offline-package/.vim/tools/ctags-6.1.0.zip" "$TOOLS_DIR/"
        cd "$TOOLS_DIR"

        if check_build_deps; then
            unzip -q ctags-6.1.0.zip
            cd ctags-6.1.0
            ./autogen.sh && ./configure --prefix="$TOOLS_DIR/ctags" && make && make install
            mkdir -p "$HOME/.local/bin"
            ln -sf "$TOOLS_DIR/ctags/bin/ctags" "$HOME/.local/bin/ctags"

            if ! grep -q "PATH=\$HOME/.local/bin:\$PATH" ~/.bashrc; then
                echo 'export PATH=$HOME/.local/bin:$PATH' >> ~/.bashrc
                info "已将 ~/.local/bin 添加到 PATH，请执行 source ~/.bashrc 或重新登录"
            fi
            info "ctags 安装完成"
        else
            warn "无法编译 ctags，请手动安装：sudo apt-get install exuberant-ctags"
        fi
        cd - > /dev/null
    # 在线模式：尝试使用系统包管理器
    else
        info "[在线模式] 尝试使用系统包管理器安装 ctags"
        if command -v apt-get &> /dev/null; then
            sudo apt-get install -y exuberant-ctags && info "ctags 安装完成" || warn "ctags 安装失败，请手动安装"
        elif command -v yum &> /dev/null; then
            sudo yum install -y ctags && info "ctags 安装完成" || warn "ctags 安装失败，请手动安装"
        else
            warn "不支持的包管理器，请手动安装 ctags"
        fi
    fi
}

# 主安装流程
main() {
    echo "================================"
    echo "  Vim 配置安装"
    echo "================================"

    # 判断安装模式
    local MODE="online"
    if [ -d "./vim-offline-package/.vim" ]; then
        MODE="offline"
    fi

    if [ "$MODE" = "offline" ]; then
        info "检测到离线包，使用离线安装模式"

        # 复制 .vim 目录
        info "复制配置文件..."
        cp -r "./vim-offline-package/.vim" "$HOME/.vim"

        # 复制 .vimrc
        if [ -f "./vim-offline-package/.vim/vimrc" ]; then
            cp "$HOME/.vim/vimrc" "$HOME/.vimrc"
            info "已创建 .vimrc"
        fi

        # 创建必要目录
        mkdir -p "$HOME/.vim/undo"
        mkdir -p "$HOME/.vim/data"

        # 安装 ctags
        install_ctags

        info "================================"
        info "  离线安装完成！"
        info "================================"
        echo ""
        info "后续步骤:"
        echo "  1. 重启终端或执行：source ~/.bashrc"
        echo "  2. 启动 vim 自动加载插件"
        echo "  3. (可选) 安装 Powerline 字体：bash ~/.vim/fonts/install-fonts.sh"

    else
        info "使用在线安装模式"

        # 备份现有配置
        backup_existing

        # 复制 .vim 和 .vimrc
        info "复制配置文件..."
        for file in ".vim" ".vimrc"; do
            if [ -d "./$file" ] || [ -f "./$file" ]; then
                cp -r "./$file" "$HOME/"
                info "已安装：$file"
            fi
        done

        # 创建必要目录
        mkdir -p "$HOME/.vim/undo"
        mkdir -p "$HOME/.vim/data"

        # 安装 ctags
        install_ctags

        info "================================"
        info "  在线安装完成！"
        info "================================"
        echo ""
        info "后续步骤:"
        echo "  1. 启动 vim"
        echo "  2. 执行 :PluginInstall 安装插件"
        echo "  3. 安装 ctags (如未自动安装): sudo apt-get install exuberant-ctags"
    fi
}

main "$@"
