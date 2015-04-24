set nocompatible               " be iMproved
filetype off                   " required!

" git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim
" Open vim :PluginInstall
set rtp+=~/.vim/bundle/Vundle.vim/
call vundle#rc()
"------------------------------
Bundle 'gmarik/vundle'
Bundle 'rkulla/pydiction'
Bundle 'Lokaltog/vim-powerline'
Bundle 'sickill/vim-monokai'
Bundle 'scrooloose/nerdtree'
Bundle 'kien/ctrlp.vim'
Bundle 'vim-scripts/YankRing.vim'
Bundle 'tpope/vim-pathogen'
Bundle 'nvie/vim-flake8'
Bundle 'walm/jshint.vim'
Bundle 'majutsushi/tagbar'
Bundle 'rizzatti/funcoo.vim'
Bundle 'rizzatti/dash.vim'
Bundle 'edsono/vim-matchit'
Bundle 'mileszs/ack.vim'
Bundle 'SirVer/ultisnips'
Bundle 'honza/vim-snippets'
Bundle 'groenewege/vim-less'

"------------------------------
filetype plugin indent on     " required!


"常规配置
"========================================================================
"Leader Key
let mapleader = ","
let g:mapleader = ","

" Sets how many lines of history VIM has to remember
set history=700

" Set to auto read when a file is changed from the outside
set autoread

" Fast saving
nmap <leader>w :w!<cr>

" :W sudo saves the file 
" (useful for handling the permission-denied error)
"command W w !sudo tee % > /dev/null
command W w
command Wq wq
command Q q

" Configure backspace so it acts as it should act
set backspace=eol,start,indent
set whichwrap+=<,>,h,l

" Ignore case when searching
set ignorecase

" When searching try to be smart about cases 
set smartcase

" Makes search act like search in modern browsers
set incsearch 

"lazyredraw" / "lz"   
"如果置位本选项,执行宏,寄存器和其它不通过输入的命令时屏
"幕不会重画.另外,窗口标题的刷新也被推迟.要强迫刷新,使用
set lz

" For regular expressions turn magic on
set magic

" Turn backup off, since most stuff is in SVN, git et.c anyway...
set nobackup
set nowb
set noswapfile


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => VIM user interface
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" scrolloff/so  光标上下两侧最少保留的屏幕行数
set so=7

" Height of the command bar
set cmdheight=2

" nu/number 显示行号
set nu

" Highlight search results
set hlsearch

"show matching brackets when text indicator is over them
"插入括号时,短暂地跳转到匹配的对应括号.
set showmatch 

" How many tenths of a second to blink when matching brackets
set mat=2

" No annoying sound on errors
set noerrorbells
set novisualbell
set t_vb=
set tm=500

" Add a bit extra margin to the left
set foldcolumn=1

" Disable highlight when <leader><cr> is pressed
map <silent> <leader><cr> :noh<cr>

" 显示结尾符
set list

"显示指针水平线
set cursorline
highlight CursorLine cterm=underline

"高亮超出第120列的字符， 防止python代码超出第120列
set colorcolumn=120
highlight OverLength ctermbg=red ctermfg=white guibg=#592929
match OverLength /\%81v.\+/

" Disable highlight when <leader><cr> is pressed
map <silent> <leader><cr> :noh<cr>


""""""""""""""""""""""""""""""
" => Colors and Fonts
""""""""""""""""""""""""""""""
" Enable syntax highlighting
syntax enable 


set background=dark
set t_Co=256
colorscheme monokai

"set extra options when running in GUI mode
if has("gui_running")
    set guioptions-=T
    set guioptions-=e
    set t_Co=256
    set guitablabel=%M\ %t
endif

" Set utf8 as standard encoding and en_US as the standard language
set encoding=utf8

" Use Unix as the standard file type
set ffs=unix,dos,mac


""""""""""""""""""""""""""""""
"Status line
""""""""""""""""""""""""""""""
" Always show the status line
set laststatus=2

" Format the status line
set statusline=\ %{HasPaste()}%F%m%r%h\ %w\ \ CWD:\ %r%{getcwd()}%h\ \ \ Line:\ %l


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Text, tab and indent related
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


" Linebreak on 500 characters
set lbr
set tw=500

set ai "Auto indent
set si "Smart indent
set wrap "Wrap lines


""""""""""""""""""""""""""""""
" => Visual mode related
""""""""""""""""""""""""""""""
" Visual mode pressing * or # searches for the current selection
"真的非常有用, #查找上一个， *查找下一个
vnoremap <silent> # :call VisualSelection('b', '')<CR>
vnoremap <silent> * :call VisualSelection('f', '')<CR>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Moving around, tabs, windows and buffers
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Treat long lines as break lines (useful when moving around in them)
map j gj
map k gk

" Smart way to move between windows
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

" Useful mappings for managing tabs
map <leader>tn :tabnew<cr>
map <leader>to :tabonly<cr>
map <leader>tc :tabclose<cr>
map <leader>tm :tabmove 
map <leader>t<leader> :tabnext 

" Opens a new tab with the current buffer's path
" Super useful when editing files in the same directory
map <leader>te :tabedit <c-r>=expand("%:p:h")<cr>/

" Return to last edit position when opening files (You want this!)
autocmd BufReadPost *
     \ if line("'\"") > 0 && line("'\"") <= line("$") |
     \   exe "normal! g`\"" |
     \ endif
" Remember info about open buffers on close
set viminfo^=%


" insert 模式下的移动
inoremap <silent><C-H> <Left>
inoremap <silent><C-L> <Right>
inoremap <silent><C-J> <Down>
inoremap <silent><C-K> <Up>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Editing mappings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Remap VIM 0 to first non-blank character
map 0 ^


" Delete trailing white space on save, useful for Python and CoffeeScript ;)
func! DeleteTrailingWS()
  exe "normal mz"
  %s/\s\+$//ge
  exe "normal `z"
endfunc
autocmd BufWrite *.py,*.js,*.css,*.coffee  :call DeleteTrailingWS()


" Run syntax check for python, javascript
autocmd BufWrite *.py :call Flake8()
autocmd BufWrite *.js :JSHint


" Use spaces instead of tabs
set expandtab

" Be smart when using tabs ;)
set smarttab

" Set the tab width default 1tab = 4 spaces
set shiftwidth=4 tabstop=4
autocmd BufRead *.js   :set shiftwidth=2 tabstop=2
autocmd BufRead *.css  :set shiftwidth=2 tabstop=2
autocmd BufRead *.html :set shiftwidth=2 tabstop=2


"插件配置
"========================================================================
""""""""""""""""""""""""""""""
" => YankRing
""""""""""""""""""""""""""""""
if has("win16") || has("win32")
    " Don't do anything
else
    let g:yankring_history_dir = '~/.vim/temp_dirs'
endif

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Nerd Tree
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
map <leader>nn :NERDTreeToggle<cr>
map <leader>nb :NERDTreeFromBookmark 
map <leader>nf :NERDTreeFind<cr>


""""""""""""""""""""""""""""""
" => CTRL-P
""""""""""""""""""""""""""""""
let g:ctrlp_working_path_mode = 0

let g:ctrlp_map = '<c-f>'
map <c-b> :CtrlPBuffer<cr>

let g:ctrlp_max_height = 20
let g:ctrlp_custom_ignore = 'node_modules\|^\.DS_Store\|^\.git\|^\.coffee|^\.pyc'


""""""""""""""""""""""""""""""
" => Tagbar
""""""""""""""""""""""""""""""
nmap <F9> :TagbarToggle<CR>


""""""""""""""""""""""""""""""
" => Dash
""""""""""""""""""""""""""""""
map <leader>da :Dash <cword> all<cr>
map <leader>dw :Dash <cword> web<cr>
map <leader>dp :Dash <cword> python2<cr>

""""""""""""""""""""""""""""""
" => autopep8 
""""""""""""""""""""""""""""""
map <F8> :call FormartSrc()<CR>

func FormartSrc()
exec "w"
if &filetype == 'c'
exec "!astyle --style=ansi --one-line=keep-statements -a --suffix=none %"
elseif &filetype == 'cpp' || &filetype == 'hpp'
exec "r !astyle --style=ansi --one-line=keep-statements -a --suffix=none %> /dev/null 2>&1"
elseif &filetype == 'perl'
exec "!astyle --style=gnu --suffix=none %"
elseif &filetype == 'py'||&filetype == 'python'
exec "r !autopep8 -i --aggressive %"
elseif &filetype == 'java'
exec "!astyle --style=java --suffix=none %"
elseif &filetype == 'jsp'
exec "!astyle --style=gnu --suffix=none %"
elseif &filetype == 'xml'
exec "!astyle --style=gnu --suffix=none %"
endif
exec "e! %"
endfunc
"结束定义FormartSrc


""""""""""""""""""""""""""""""
" => Pydiction 
""""""""""""""""""""""""""""""
let g:pydiction_location = '/Users/lvyaojia/.vim/pydiction/complete-dict.txt'


" Trigger configuration. Do not use <tab> if you use https://github.com/Valloric/YouCompleteMe.
let g:UltiSnipsSnippetDirectories=["UltiSnips", "~/.vim/bundle/vim-snippets"]
let g:UltiSnipsExpandTrigger=";<tab>"
let g:UltiSnipsListSnippets=";l"
let g:UltiSnipsJumpForwardTrigger=";f"
let g:UltiSnipsJumpBackwardTrigger=";b"


""""""""""""""""""""""""""""""
" => T2S: change tab to space 
" => S2T: change space to tab 
" => S2S: change space to space
""""""""""""""""""""""""""""""
func T2S(spacewidth)
    execute 'set shiftwidth='.a:spacewidth
    execute 'set tabstop='.a:spacewidth
    execute 'set expandtab'
    execute '%retab!'
    execute 'set list'
endfunc

func S2T(spacewidth, tabwidth)
    execute 'set shiftwidth='.a:spacewidth
    execute 'set tabstop='.a:spacewidth
    execute 'set noexpandtab'
    execute '%retab!'
    execute 'set shiftwidth='.a:tabwidth
    execute 'set tabstop='.a:tabwidth
    execute 'set list'
endfunc

func S2S(spacewidth_src, spacewidth_tar)
    call S2T(a:spacewidth_src, a:spacewidth_tar)
    call T2S(a:spacewidth_tar)
endfunc


""""""""""""""""""""""""""""
" Convert fileformat tool
""""""""""""""""""""""""""""
func ChangeDosFormatTo(format)
    execute 'update'
    execute 'e ++ff=dos'
    execute 'setlocal ff='.a:format
endfunc
