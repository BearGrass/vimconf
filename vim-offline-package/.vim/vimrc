" =============================================================================
" Vim 配置文件 - 统一在线/离线版本
" =============================================================================

" --- 基础设置 ---------------------------------------------------------------
syntax on
set nocompatible
filetype off

" --- 插件管理 (Vundle) ------------------------------------------------------
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'       " 插件管理器
Plugin 'tpope/vim-fugitive'         " Git 集成
Plugin 'vim-airline/vim-airline'    " 状态栏
Plugin 'preservim/tagbar'           " 代码结构标签
Plugin 'scrooloose/nerdtree'        " 文件树
Plugin 'ctrlpvim/ctrlp.vim'         " 模糊搜索

call vundle#end()
filetype plugin indent on

" --- 配色方案 ---------------------------------------------------------------
colorscheme molokai

" --- 视觉优化 ---------------------------------------------------------------
set number relativenumber           " 行号 + 相对行号
set cursorline                      " 高亮当前行
set laststatus=2                    " 总是显示状态栏
set cmdheight=1                     " 命令行高度
set t_Co=256                        " 256 色支持
set list                            " 显示不可见字符
set listchars=tab:»·,trail:·        " tab 和尾随空格样式

" --- 编辑体验 ---------------------------------------------------------------
set et ts=4 sw=4                    " tab 转 4 空格
set smartindent                     " 智能缩进
set backspace=indent,eol,start      " 退格键增强
set splitbelow splitright           " 优化窗口分割

" --- 搜索优化 ---------------------------------------------------------------
set hlsearch incsearch              " 高亮搜索 + 即时搜索
set ignorecase smartcase            " 智能大小写

" --- 编码设置 ---------------------------------------------------------------
set fileencodings=utf-8,gbk,gb2312,ascii
set termencoding=utf-8
set fileformats=unix,dos,mac

" --- 持久化功能 ------------------------------------------------------------
if has('persistent_undo')
    set undofile
    set undodir=~/.vim/undo
endif

" --- 标签设置 ---------------------------------------------------------------
set tags=./tags;                    " 递归查找 tags

" --- 快捷键映射 -------------------------------------------------------------
let mapleader = ","

" Buffer 切换
noremap <leader>1 :b 1<CR>
noremap <leader>2 :b 2<CR>
noremap <leader>3 :b 3<CR>
noremap <leader>4 :b 4<CR>
noremap <leader>5 :b 5<CR>
noremap <leader>6 :b 6<CR>
noremap <leader>7 :b 7<CR>
noremap <leader>8 :b 8<CR>
noremap <leader>9 :b 9<CR>

" 功能键
noremap <F2> :BufExplorer<CR>       " Buffer 浏览器 (需额外插件)
noremap <F3> :NERDTreeToggle<CR>    " 文件树开关
noremap <F4> :TagbarToggle<CR>      " 标签栏开关
noremap <F10> :NERDTreeFind<CR>     " 在文件树定位当前文件
noremap <F12> :!ctags -R .<CR>      " 生成 tags

" 其他
noremap <Tab> [I                    " 显示函数列表
noremap <C-i> [I                    " 同上，兼容习惯

" --- Airline 状态栏配置 -----------------------------------------------------
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#buffer_nr_show = 1
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = '|'
let g:airline#extensions#tabline#formatter = 'default'
let g:airline#extensions#disable_rtp_load = 1

if !exists('g:airline_extensions')
    let g:airline_extensions = []
endif
let g:airline_extensions += ['tabline', 'branch', 'wordcount']

" --- NERDTree 配置 ----------------------------------------------------------
let g:NERDChristmasTree = 1
let g:NERDTreeAutoCenter = 1
let g:NERDTreeBookmarksFile = $HOME . '/.vim/data/NerdBookmarks.txt'
let g:NERDTreeMouseMode = 2           " 单击打开文件，双击打开目录
let g:NERDTreeShowBookmarks = 1
let g:NERDTreeShowFiles = 1
let g:NERDTreeShowHidden = 1
let g:NERDTreeShowLineNumbers = 1
let g:NERDTreeWinPos = 'left'
let g:NERDTreeWinSize = 28
let g:NERDTreeDirArrows = 1
let g:NERDTreeGlyphReadOnly = 'RO'
let g:NERDTreeDirArrowExpandable = '+'
let g:NERDTreeDirArrowCollapsible = '-'

" 启动时打开 NERDTree (仅当打开目录时)
autocmd StdinReadPre * let s:std_in = 1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists('s:std_in') |
    \ execute 'NERDTree' argv()[0] | wincmd p | ene | endif
" 最后一个窗口是 NERDTree 则退出
autocmd bufenter * if (winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree()) | q | endif

" --- Tagbar 配置 ------------------------------------------------------------
let g:tagbar_ctags_bin = 'ctags'
let g:tagbar_width = 30
let g:tagbar_sort = 0                 " 按代码出现顺序排序
let g:tagbar_autofocus = 1
let g:tagbar_right = 1                " 右侧显示
let g:tagbar_autoclose = 0

" --- CtrlP 配置 -------------------------------------------------------------
set runtimepath+=~/.vim/bundle/ctrlp.vim
let g:ctrlp_custom_ignore = '\v[\/](\.git|\.hg|\.svn|node_modules|target|dist)[\/]'

" --- 自动创建目录 -----------------------------------------------------------
augroup AutoCreateDir
    autocmd!
    autocmd BufWritePre * if expand('<afile>') !~# '^\w\+:' &&
        \ !isdirectory(expand('%:h')) |
        \ execute 'silent! !mkdir -p ' . shellescape(expand('%:h'), 1) |
        \ redraw! |
        \ endif
augroup END

" --- 记忆光标位置 -----------------------------------------------------------
if has('autocmd')
    autocmd BufReadPost * if line("''\"") > 1 && line("''\"") <= line('$') |
        \ execute "normal! g''\"" |
        \ endif
endif

" --- 终端光标形状 (Tmux 支持) -----------------------------------------------
if exists('$TMUX')
    let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
    let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"
else
    let &t_SI = "\<Esc>]50;CursorShape=1\x7"
    let &t_EI = "\<Esc>]50;CursorShape=0\x7"
endif
