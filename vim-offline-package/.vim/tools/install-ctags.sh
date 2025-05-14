#!/bin/bash
# 解压并编译安装ctags
cd ~/.vim/tools
unzip -q ctags-6.1.0.zip
cd ctags-6.1.0
./autogen.sh
./configure --prefix=$HOME/.vim/tools/ctags
make
make install
# 创建符号链接到可访问的目录
mkdir -p $HOME/.local/bin
ln -sf $HOME/.vim/tools/ctags/bin/ctags $HOME/.local/bin/ctags
echo "ctags安装完成，请确保 $HOME/.local/bin 在PATH中"
