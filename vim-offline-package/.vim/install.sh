#!/bin/bash
echo "开始部署Vim离线配置..."

# 复制.vimrc
cp ~/.vim/vimrc ~/.vimrc
echo ".vimrc已创建"

# 检查并安装ctags
if command -v ctags &> /dev/null; then
    echo "系统中已存在ctags，跳过安装"
else
    echo "未检测到ctags，开始安装..."
    if [ -f ~/.vim/tools/install-ctags.sh ]; then
        bash ~/.vim/tools/install-ctags.sh
        # 添加PATH到.bashrc（如果没有）
        if ! grep -q "PATH=\$HOME/.local/bin:\$PATH" ~/.bashrc; then
            echo 'export PATH=$HOME/.local/bin:$PATH' >> ~/.bashrc
            echo "已将 ~/.local/bin 添加到PATH"
            echo "请运行 'source ~/.bashrc' 或重新登录以使PATH生效"
        fi
    else
        echo "未找到ctags安装脚本，请手动安装ctags"
    fi
fi

# 创建需要的目录
mkdir -p ~/.vim/undo
mkdir -p ~/.vim/data

echo "Vim配置部署完成！"
echo "请确保安装了合适的字体以支持airline/powerline图标"
