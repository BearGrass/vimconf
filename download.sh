#!/bin/bash
# Vim 配置下载脚本
# 用法：bash <(curl -sL https://raw.githubusercontent.com/BearGrass/vimconf/master/download.sh)

set -e

GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m'

info() { echo -e "${GREEN}✓ $1${NC}"; }
warn() { echo -e "${YELLOW}! $1${NC}"; }
error() { echo -e "${RED}✗ $1${NC}"; exit 1; }

REPO_URL="https://github.com/BearGrass/vimconf.git"
TARGET_DIR="${1:-$HOME/vimconf}"

echo ""
echo "╔══════════════════════════════════════╗"
echo "║     Vim 配置下载                     ║"
echo "╚══════════════════════════════════════╝"
echo ""

# 检查 git
if ! command -v git &> /dev/null; then
    error "需要安装 git: sudo apt-get install git"
fi

# 检查目录
if [ -d "$TARGET_DIR" ]; then
    warn "目录已存在：$TARGET_DIR"
    echo -n "是否删除并重新克隆？(y/n): "
    read -r response
    if [[ "$response" =~ ^[Yy]$ ]]; then
        rm -rf "$TARGET_DIR"
    else
        error "操作已取消"
    fi
fi

# 克隆
info "正在克隆仓库..."
git clone --depth 1 "$REPO_URL" "$TARGET_DIR"

info "下载完成！"
echo ""
echo "现在进入目录并安装:"
echo "  cd $TARGET_DIR"
echo "  bash install.sh"
echo ""
echo "或者直接运行一键安装:"
echo "  bash <(curl -sL https://raw.githubusercontent.com/BearGrass/vimconf/master/install.sh)"
echo ""
