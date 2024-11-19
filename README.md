# vimconf
## work
```
tar -xf Gzz_settings-2017-07-26.tar -C ~/
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
