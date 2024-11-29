#!/bin/bash

# 定义颜色
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

# 定义备份目录和时间戳
BACKUP_DIR="$HOME/vimbackup"
TIMESTAMP=$(date +%Y%m%d_%H%M%S)
BACKUP_DIR_WITH_TIME="${BACKUP_DIR}_${TIMESTAMP}"

# vim 相关文件
VIM_FILES=(".vim" ".viminfo" ".vimrc")

# 错误处理函数
handle_error() {
    echo -e "${RED}Error: $1${NC}"
    exit 1
}

# 检查是否有root权限（如果需要的话）
#if [ "$EUID" -ne 0 ]; then 
#    handle_error "Please run as root"
#fi

# 创建备份目录
if [ ! -d "$BACKUP_DIR_WITH_TIME" ]; then
    mkdir -p "$BACKUP_DIR_WITH_TIME" || handle_error "Cannot create backup directory"
    echo -e "${GREEN}Created backup directory: $BACKUP_DIR_WITH_TIME${NC}"
fi

# 备份现有文件
for file in "${VIM_FILES[@]}"; do
    if [ -e "$HOME/$file" ]; then
        mv "$HOME/$file" "$BACKUP_DIR_WITH_TIME/" || handle_error "Cannot backup $file"
        echo -e "${GREEN}Backed up: $file${NC}"
    else
        echo -e "${YELLOW}Notice: $file does not exist in home directory${NC}"
    fi
done

# 复制新配置文件
for file in "${VIM_FILES[@]}"; do
    if [ -e "./$file" ]; then
        cp -r "./$file" "$HOME/" || handle_error "Cannot copy $file"
        echo -e "${GREEN}Installed: $file${NC}"
    else
        echo -e "${YELLOW}Warning: $file not found in current directory${NC}"
    fi
done

echo -e "${GREEN}Installation completed successfully!${NC}"
