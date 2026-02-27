#!/bin/bash
# Vim 离线安装快捷脚本
# 用法：bash ~/.vim/install.sh

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PARENT_DIR="$(dirname "$SCRIPT_DIR")"

if [ -f "$PARENT_DIR/install.sh" ]; then
    exec bash "$PARENT_DIR/install.sh"
else
    echo "错误：找不到主安装脚本 $PARENT_DIR/install.sh"
    exit 1
fi
