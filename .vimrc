syntax on

filetype plugin indent on

colorscheme molokai

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()
Bundle 'gmarik/vundle'
Bundle 'tpope/vim-fugitive'

" 安装airline插件
Bundle 'vim-airline/vim-airline'
" 启用 powerline 字体
let g:airline_powerline_fonts = 1
" 启用 tabline
let g:airline#extensions#tabline#enabled = 1   " 添加这行很重要
" 显示 buffer 编号
let g:airline#extensions#tabline#buffer_nr_show = 1
" 设置标签栏的分隔符
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = '|'
" 设置文件路径显示格式
let g:airline#extensions#tabline#formatter = 'default'
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

set laststatus=2      " 总是显示状态栏
set cmdheight=1       " 命令行高度为1行
set t_Co=256         " 启用256色

set backspace=indent,eol,start    " 允许退格键删除缩进、换行和插入点之前的字符
set list                         " 显示不可见字符
set listchars=tab:>-,trail:-     " 用>-显示tab，用-显示尾随空格

set nocompatible     " 不兼容vi模式，使用vim增强特性
set nu               " 显示行号
set et               " expandtab的缩写，将tab转换为空格

set ts=4             " tabstop的缩写，tab宽度为4个空格
set shiftwidth=4     " 缩进宽度为4个空格
set autoindent       " 自动缩进
set smartindent      " 智能缩进

set hlsearch         " 高亮搜索结果

set fileencodings=utf-8,gbk,ascii    " 文件编码顺序
set termencoding=utf-8               " 终端编码

nnoremap <tab> [I
" 修改 tab 为显示函数调用列表


" 与glightline 插件冲突
"" 清空状态栏
"set statusline=
"" 添加文件信息
"set statusline+=%F%m%r%h%w\
"" 添加文件格式
"set statusline+=[FORMAT=%{&ff}]\
"" 添加文件类型
"set statusline+=[TYPE=%Y]\
"" 添加位置信息
"set statusline+=[POS=%l,%v][%p%%]\
"" 添加时间信息
"set statusline+=%{strftime(\"%d/%m/%y\ -\ %H:%M\")}



set runtimepath^=~/.vim/bundle/ctrlp.vim

"NERD Tree
let NERDChristmasTree=1           " 使用彩色显示
let NERDTreeAutoCenter=1          " 自动将光标保持在屏幕中央
let NERDTreeBookmarksFile=$HOME.'/.vim/data/NerdBookmarks.txt'  " 设置书签文件位置
let NERDTreeMouseMode=2           " 鼠标模式：
                                 " 1 = 双击打开文件/目录
                                 " 2 = 单击打开文件/目录
                                 " 3 = 单击打开文件，双击打开目录
let NERDTreeShowBookmarks=1       " 显示书签列表
let NERDTreeShowFiles=1           " 显示文件
let NERDTreeShowHidden=1          " 显示隐藏文件
let NERDTreeShowLineNumbers=1     " 显示行号
let NERDTreeWinPos='left'         " 树窗口显示在左侧
let NERDTreeWinSize=28            " 设置窗口宽度为28个字符
let NERDTreeDirArrows=0           " 不使用箭头样式的目录指示符
" 按F3键切换显示/隐藏文件树
map <F3> :NERDTreeToggle<CR>
map <F10> :NERDTreeFind<CR>

"tag
set tags=./tags;    " 递归向上查找 tags 文件
set autochdir       " 自动切换工作目录
map <F12> :!ctags -R .<CR>
" F12 生成 tags

"TagList
"let Tlist_Use_Right_Window=1        " 在右侧显示窗口
"let Tlist_Sort_Type="ortder"
"" 按名称排序（另一选项是"order"，按出现顺序）
"let Tlist_Exit_OnlyWindow=1        " 如果 TagList 是最后一个窗口，则退出 vim
"let Tlist_File_Fold_Auto_Close=1   " 非当前文件的标签列表折叠起来
"let Tlist_Auto_Open=0              " 不自动打开 TagList 窗口
"let Tlist_Show_One_File=0          " 只显示当前文件的标签列表

"map <silent> <c-l> :Tlist<CR>

Bundle 'majutsushi/tagbar'
" Tagbar 配置
let g:tagbar_ctags_bin = 'ctags'
let g:tagbar_width = 30
let g:tagbar_sort = 0                " 按代码中出现顺序排序（=1按名称排序）
let g:tagbar_autofocus = 1           " 打开 Tagbar 时光标在 Tagbar 窗口
let g:tagbar_right = 1               " 在右侧显示窗口
let g:tagbar_autoclose = 0           " 不自动关闭
nmap <silent> <F4> :TagbarToggle<CR>

function! LightLineModified()
  return &modified ? '+' : ''
endfunction

function! LightLineFilename()
  let filename = expand('%')
  if filename == ''
    return '[No Name]'
  endif

  let modified = LightLineModified()

  " 如果窗口宽度大于 70，显示完整路径
  if winwidth(0) > 70
    return modified . expand('%:p')
  else
    " 否则只显示文件名
    return modified . expand('%:t')
  endif
endfunction

Bundle 'itchyny/lightline.vim'

let g:lightline = {
      \ 'colorscheme': 'landscape',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'fugitive', 'filename' ] ]
      \ },
      \ 'component_function': {
      \   'filename': 'LightLineFilename'
      \ },
      \ 'separator': { 'left': "\ue0b0", 'right': "\ue0b2" },
      \ 'subseparator': { 'left': "\ue0b1", 'right': "\ue0b3" }
      \ }


