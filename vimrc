"set shell=\"C:\Program\ Files\Git\bin\sh.exe\"
set shell=cmd.exe

" Allow pathogen to be a git submodule
"exe 'set rtp+=' . expand('C:/Users/nikos/vimfiles/bundle/vim-pathogen/autoload')

runtime bundle/vim-pathogen/autoload/pathogen.vim"
execute pathogen#infect()

"# Editor functional settings
set backspace=indent,eol,start
set expandtab
set shiftwidth=4
set softtabstop=4
set encoding=utf-8
"## Auto indent
set ai
"## sets working directory to current file location
set autochdir
"## Use hidden buffers
set hidden
"## Use closest ancestor tagfile
set tags=./tags;/

"# Editor visual setting
set t_vb=
set number
"## Highlight search matches
set hlsearch
set cc=80
hi ColorColumn ctermbg=black guibg=#222222
set laststatus=2
set showmatch
set vb
set ruler
set clipboard=unnamed
syntax enable
set background=dark
colorscheme solarized
if has('gui_running')
    set lines=70
    set columns=100
    "colorscheme slate
    "set guifont=Meslo\ LG\ S\ for\ Powerline
    "set guifont=Inconsolata-g\ for\ Powerline
    set guifont=Roboto\ Mono\ for\ Powerline
    let g:airline_powerline_fonts = 1
else
    "colorscheme peachpuff
endif

"# Plugin settings
"let g:tagbar_ctags_bin='C:\Users\nikos\bin\ctags.exe'
let NERDTreeIgnore = ['\.pyc$', '\.pyd$', '\.zip$', '\.png$']
"## Close vim if NERDTree is the only window
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
"## Open NERDTree automatically if directory given to vim
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | set columns=140 | endif
map <silent> <F3> :call BufferList()<CR>a

"# Tagbar
set updatetime=2000
let g:airline#extensions#tagbar#flags = 'f'  " show full tag hierarchy

" File type options
autocmd BufNewFile,BufReadPost *.md set filetype=markdown
au BufRead,BufNewFile *.bs set filetype=html

" Key mappings
map <A-left> :bp<CR>
map <A-Right> :bn<CR>
nmap <C-h> :bp<CR>
nmap <C-l> :bn<CR>
noremap <F5> :buffers<CR>:buffer<Space>
imap jj <ESC>
nmap <F8> :TagbarToggle<CR>
let g:ctrlp_map='<c-p>'
let g:ctrlp_cmd= 'CtrlP'
noremap <space> i<space><esc>
" Custom commands
command Bd bp|bd #
