#!/bin/bash

# Vim 离线包下载脚本
set -e

GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m'

info() { echo -e "${GREEN}$1${NC}"; }
warn() { echo -e "${YELLOW}$1${NC}"; }
error() { echo -e "${RED}$1${NC}"; exit 1; }

REPO_URL="https://github.com/BearGrass/vimconf.git"
TARGET_DIR="${1:-vimconf}"

info "================================"
info "  Vim 离线配置下载"
info "================================"

# 检查 git
if ! command -v git &> /dev/null; then
    error "需要安装 git: sudo apt-get install git"
fi

# 下载
if [ -d "$TARGET_DIR" ]; then
    warn "目录 $TARGET_DIR 已存在"
    echo "是否删除并重新克隆？(y/n): "
    read -r response
    if [[ "$response" =~ ^[Yy]$ ]]; then
        rm -rf "$TARGET_DIR"
    else
        error "操作已取消"
    fi
fi

info "克隆仓库..."
git clone --depth 1 "$REPO_URL" "$TARGET_DIR"

info "下载完成！"
echo ""
info "安装步骤:"
echo "  cd $TARGET_DIR"
echo "  bash install.sh"
echo ""
info "这将:"
echo "  - 备份现有 Vim 配置到 ~/vimbackup_*"
echo "  - 安装 Vim 配置文件"
echo "  - 编译安装 ctags (需要 build-essential)"
echo "  - 配置插件自动加载"
