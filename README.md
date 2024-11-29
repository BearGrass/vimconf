# vimconf
## work
```
mkdir ~/vimbackup
mv ~/.vim ~/.viminfo ~/.vimrc ~/vimbackup
cp -r .vim  .viminfo  .vimrc ~/

# install plugin in vim
:PluginInstall

# install ctags
sudo apt-get install exuberant-ctags
# or
unzip ctags-6.1.0.zip
cd ctags-6.1.0/
./autogen.sh
./configure
make
sudo make install
```

## install node
```
# https://blog.csdn.net/xiangxianghehe/article/details/136529419
sudo apt-get install -y nodejs
sudo apt install npm

npm --registry https://registry.npmmirror.com install
cd ~/.vim/bundle/coc.nvim
npm ci
npm config set registry https://registry.npmmirror.com
vim
```

## ctags example
```
ctags -R --kinds-C=+defgmpstuvx --fields=+iaS --extras=+q dir1 dir2 dir3
```


## other
```
sudo apt-get install powerline
```
