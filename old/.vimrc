syntax on

filetype plugin indent on

colorscheme molokai

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()
Bundle 'gmarik/vundle'
Bundle 'tpope/vim-fugitive'

set laststatus=2
set cmdheight=1
set t_Co=256
set backspace=indent,eol,start
set list
set listchars=tab:>-,trail:-
set nocompatible
set nu
set et
set ts=4
set shiftwidth=4
"set ruler
"set cursorline
set hlsearch
set autoindent
set smartindent
set fileencodings=utf-8,gbk,ascii
set termencoding=utf-8
set runtimepath^=~/.vim/bundle/ctrlp.vim
"set statusline=%F%m%r%h%w\ [FORMAT=%{&ff}]\ [TYPE=%Y]\ [POS=%l,%v][%p%%]\ %{strftime(\"%d/%m/%y\ -\ %H:%M\")}

nnoremap <C-i> [I

map <F2> :BufExplorer<CR>

"NERD Tree
"autocmd VimEnter * NERDTree
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
let NERDTreeDirArrows=0
map <F3> :NERDTreeToggle<CR>
"map <F10> :NERDTreeFind<CR>

"php-doc
"nnoremap <C-m> :call PhpDocSingle()<CR>
"vnoremap <C-m> :call PhpDocRange()<CR>

"tag
set tags=./tags;
set autochdir

"TagList
let Tlist_Use_Right_Window=1
let Tlist_Sort_Type="name"
let Tlist_Exit_OnlyWindow=1
let Tlist_File_Fold_Auto_Close=1
let Tlist_Auto_Open=0
let Tlist_Show_One_File=1
"map <silent> <c-l> :Tlist<CR>

"tagBar
let g:tagbar_ctags_bin = 'ctags'
let g:tagbar_width = 30
nmap <silent> <F4> :TagbarToggle<CR>

"class note
function! AddTitle()
    call append(1,"/**")
    call append(2," *")
    call append(3," *  作者:葛钊志(zhaozhi.gzz@alibaba-inc.com)")
    call append(4," *  创建时间:".strftime("%Y-%m-%d %H:%M:%S"))
    call append(5," *  修改记录:")
    call append(6," *  $Id$")
    call append(7," **/")
endfunction
map <F5> :call AddTitle()<cr>

"lightLine
let g:lightline = {
      \ 'colorscheme': 'landscape',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'fugitive', 'filename' ] ]
      \ },
      \ 'component_function': {
      \   'fugitive': 'LightLineFugitive',
      \   'readonly': 'LightLineReadonly',
      \   'modified': 'LightLineModified',
      \   'filename': 'LightLineFilename'
      \ },
      \ 'separator': { 'left': "\ue0b0", 'right': "\ue0b2" },
      \ 'subseparator': { 'left': "\ue0b1", 'right': "\ue0b3" }
      \ }

function! LightLineModified()
  return &ft =~ 'help\|vimfiler\|gundo' ? '' : &modified ? '+' : &modifiable ? '' : '-'
endfunction

function! LightLineReadonly()
  return &ft !~? 'help\|vimfiler\|gundo' && &readonly ? "\ue0a2" : ''
endfunction

function! LightLineFilename()
  return ('' != LightLineReadonly() ? LightLineReadonly() . ' ' : '') .
        \ (&ft == 'vimfiler' ? vimfiler#get_status_string() : 
        \  &ft == 'unite' ? unite#get_status_string() : 
        \  &ft == 'vimshell' ? vimshell#get_status_string() :
        \ '' != expand('%:t') ? expand('%:t') : '[No Name]') .
        \ ('' != LightLineModified() ? ' ' . LightLineModified() : '')
endfunction

function! LightLineFugitive()
  if exists("*fugitive#head")
    let _ = fugitive#head()
    return strlen(_) ? "\ue0a0"._ : ''
  endif
  return ''
endfunction

function! LightLineFileformat()
  return winwidth(0) > 70 ? &fileformat : ''
endfunction

function! LightLineFiletype()
  return winwidth(0) > 70 ? (strlen(&filetype) ? &filetype : 'no ft') : ''
endfunction

function! LightLineFileencoding()
  return winwidth(0) > 70 ? (strlen(&fenc) ? &fenc : &enc) : ''
endfunction

function! LightLineMode()
  return winwidth(0) > 60 ? lightline#mode() : ''
endfunction
