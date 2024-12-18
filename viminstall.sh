#!/bin/bash

# install_vim_config.sh

# 输出颜色设置
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# 打印带颜色的信息
print_message() {
    echo -e "${GREEN}[INFO] $1${NC}"
}

print_warning() {
    echo -e "${YELLOW}[WARN] $1${NC}"
}

print_error() {
    echo -e "${RED}[ERROR] $1${NC}"
}

# 检查命令是否存在
check_command() {
    if ! command -v $1 &> /dev/null; then
        print_error "$1 命令未找到，尝试安装..."
        return 1
    fi
    return 0
}

# 安装依赖
install_dependencies() {
    print_message "正在安装依赖..."
    
    # 检测包管理器
    if command -v apt-get &> /dev/null; then
        sudo apt-get update
        sudo apt-get install -y git vim curl universal-ctags
    elif command -v yum &> /dev/null; then
        sudo yum update -y
        sudo yum install -y git vim curl ctags
    else
        print_error "未支持的包管理器!"
        exit 1
    fi
}

# 创建配置文件
create_vimrc() {
    cat > ~/.vimrc << 'EOL'
syntax on
filetype off

set nocompatible

" Vundle配置
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'
Plugin 'tpope/vim-fugitive'
Plugin 'vim-airline/vim-airline'
Plugin 'preservim/tagbar'
Plugin 'itchyny/lightline.vim'
Plugin 'scrooloose/nerdtree'
Plugin 'ctrlpvim/ctrlp.vim'

call vundle#end()
filetype plugin indent on

" 配色方案
colorscheme molokai

" airline配置
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#buffer_nr_show = 1
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = '|'
let g:airline#extensions#tabline#formatter = 'default'

" 快捷键映射
let mapleader = ","
map <leader>1 :b 1<CR>
map <leader>2 :b 2<CR>
map <leader>3 :b 3<CR>
map <leader>4 :b 4<CR>
map <leader>5 :b 5<CR>
map <leader>6 :b 6<CR>
map <leader>7 :b 7<CR>
map <leader>8 :b 8<CR>
map <leader>9 :b 9<CR>
map <F2> :BufExplorer<CR>

" 基本设置
set laststatus=2
set cmdheight=1
set t_Co=256
set backspace=indent,eol,start
set list
set listchars=tab:>-,trail:-
set nu
set et
set ts=4
set shiftwidth=4
set autoindent
set smartindent
set hlsearch
set fileencodings=utf-8,gbk,ascii
set termencoding=utf-8

nnoremap <tab> [I
set runtimepath^=~/.vim/bundle/ctrlp.vim

" NERDTree配置
let g:NERDTreeGlyphReadOnly = "RO"
let g:NERDTreeDirArrowExpandable = '+'
let g:NERDTreeDirArrowCollapsible = '-'
let g:NERDTreeNodeDelimiter = "\u00a0"

let NERDChristmasTree=1
let NERDTreeAutoCenter=1
let NERDTreeBookmarksFile=$HOME.'/.vim/data/NerdBookmarks.txt'
let NERDTreeMouseMode=2
let NERDTreeShowBookmarks=1
let NERDTreeShowFiles=1
let NERDTreeShowHidden=1
let NERDTreeShowLineNumbers=1
let NERDTreeWinPos='left'
let NERDTreeWinSize=28
let NERDTreeDirArrows=1
map <F3> :NERDTreeToggle<CR>
map <F10> :NERDTreeFind<CR>

autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | endif
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" ctags配置
set tags=./tags;
set autochdir
map <F12> :!ctags -R .<CR>

" Tagbar配置
let g:tagbar_ctags_bin = 'ctags'
let g:tagbar_width = 30
let g:tagbar_sort = 0
let g:tagbar_autofocus = 1
let g:tagbar_right = 1
let g:tagbar_autoclose = 0
nmap <silent> <F4> :TagbarToggle<CR>

" Lightline配置
let g:lightline = {
      \ 'colorscheme': 'landscape',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'gitbranch', 'readonly', 'filename', 'modified' ] ]
      \ },
      \ 'component_function': {
      \   'gitbranch': 'fugitive#head'
      \ }
      \ }

" 自动创建目录
augroup BWCCreateDir
    autocmd!
    autocmd BufWritePre * if expand("<afile>")!~#'^\w\+:/' && !isdirectory(expand("%:h")) | execute "silent! !mkdir -p ".shellescape(expand('%:h'), 1) | redraw! | endif
augroup END

if has("autocmd")
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif

if exists('$TMUX')
  let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
  let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"
else
  let &t_SI = "\<Esc>]50;CursorShape=1\x7"
  let &t_EI = "\<Esc>]50;CursorShape=0\x7"
endif

if has('persistent_undo')
    set undofile
    set undodir=$HOME/.vim/undo
endif
EOL
}

# 创建目录结构
create_directories() {
    print_message "创建必要的目录..."
    mkdir -p ~/.vim/undo
    mkdir -p ~/.vim/colors
    mkdir -p ~/.vim/data
    mkdir -p ~/.vim/bundle
}

# 安装Vundle
install_vundle() {
    print_message "安装Vundle..."
    if [ -d ~/.vim/bundle/Vundle.vim ]; then
        rm -rf ~/.vim/bundle/Vundle.vim
    fi
    git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
}

# 下载配色方案
download_colorscheme() {
    print_message "下载molokai配色方案..."
    curl -o ~/.vim/colors/molokai.vim https://raw.githubusercontent.com/tomasr/molokai/master/colors/molokai.vim
}

# 安装插件
install_plugins() {
    print_message "安装vim插件..."
    vim +PluginInstall +qall
}

# 主函数
main() {
    print_message "开始安装vim配置..."
    
    # 检查并安装依赖
    check_command git || install_dependencies
    check_command vim || install_dependencies
    check_command curl || install_dependencies
    check_command ctags || install_dependencies
    
    # 备份现有的vim配置
    if [ -f ~/.vimrc ]; then
        print_warning "备份现有的.vimrc到.vimrc.backup..."
        mv ~/.vimrc ~/.vimrc.backup
    fi
    
    if [ -d ~/.vim ]; then
        print_warning "备份现有的.vim目录到.vim.backup..."
        mv ~/.vim ~/.vim.backup
    fi
    
    # 创建目录结构
    create_directories
    
    # 安装Vundle
    install_vundle
    
    # 创建vimrc
    create_vimrc
    
    # 下载配色方案
    download_colorscheme
    
    # 安装插件
    install_plugins
    
    print_message "vim配置安装完成!"
    print_message "快捷键说明:"
    print_message "F3: 切换文件树"
    print_message "F4: 切换Tagbar"
    print_message "F12: 生成ctags"
    print_message "F2: 打开buffer浏览器"
    print_message "F10: 在文件树中定位当前文件"
    print_message ",1-9: 切换buffer"
}

# 执行主函数
main