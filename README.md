# vimconf
## work
```
mkdir ~/vimbackup
mv ~/.vim ~/.viminfo ~/.vimrc ~/vimbackup
cp -r .vim  .viminfo  .vimrc ~/

# install ctags
sudo apt-get install ctags
# or
unzip ctags-6.1.0.zip
cd ctags-6.1.0/
./autogen.sh
./configure
make
sudo make install
```

## ctags example
```
ctags -R --kinds-C=+defgmpstuvx --fields=+iaS --extras=+q dir1 dir2 dir3
```
