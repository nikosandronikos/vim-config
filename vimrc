if !has('unix')
    "set shell=\"C:\Program\ Files\Git\bin\sh.exe\"
    set shell=cmd.exe
endif

" Allow pathogen to be a git submodule
runtime bundle/vim-pathogen/autoload/pathogen.vim"
execute pathogen#infect()

"# Required by vimwiki
set nocompatible
filetype plugin on

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
" Must be defined as a colorscheme before other colorschemes are initialiesd
" as colorschemes may clear user defined settings.
autocmd ColorScheme * highlight ExtraWhitespace ctermbg=darkgreen guibg=darkgreen
if has('gui_running')
    colorscheme solarized
    set lines=70
    set columns=100
    set guioptions-=T
    let g:airline_powerline_fonts = 1
if has('unix')
    set guifont=Meslo\ LG\ S\ DZ\ Regular\ for\ Powerline
else
    set guifont=Roboto\ Mono\ for\ Powerline
endif
endif

"highlight unwanted spaces
autocmd Syntax * syn match ExtraWhiteSpace /\s\+$\| \+\ze\t/ containedin=ALL

"# Plugin settings
let g:ackprg = 'ag --vimgrep'

" NERDTress File highlighting
function! NERDTreeHighlightFile(extension, fg, bg, guifg, guibg)
 exec 'autocmd FileType nerdtree highlight ' . a:extension .' ctermbg='. a:bg .' ctermfg='. a:fg .' guibg='. a:guibg .' guifg='. a:guifg
 exec 'autocmd FileType nerdtree syn match ' . a:extension .' #^\s\+.*'. a:extension .'$#'
endfunction

let base03=  '#002b36'
let base02=  '#073642'
let base01=  '#586e75'
let base00=  '#657b83'
let base0=   '#839496'
let base1=   '#93a1a1'
let base2=   '#eee8d5'
let base3=   '#fdf6e3'
let yellow=  '#B58900'
let orange=  '#CB4B16'
let red=     '#DC322F'
let magenta= '#D33682'
let violet=  '#6C71C4'
let blue=    '#268BD2'
let cyan=    '#2AA198'
let green=   '#859900'

call NERDTreeHighlightFile('py', 'green', 'NONE', yellow, 'NONE')
call NERDTreeHighlightFile('pyc', 'gray', 'NONE', base01, 'NONE')
call NERDTreeHighlightFile('ini', 'yellow', 'NONE', orange, 'NONE')
call NERDTreeHighlightFile('md', 'blue', 'NONE', blue, 'NONE')
call NERDTreeHighlightFile('config', 'yellow', 'NONE', yellow, 'NONE')
call NERDTreeHighlightFile('conf', 'yellow', 'NONE', yellow, 'NONE')
call NERDTreeHighlightFile('json', 'yellow', 'NONE', violet, 'NONE')
call NERDTreeHighlightFile('html', 'yellow', 'NONE', green, 'NONE')
call NERDTreeHighlightFile('css', 'cyan', 'NONE', magenta, 'NONE')
call NERDTreeHighlightFile('js', 'Red', 'NONE', red, 'NONE')
call NERDTreeHighlightFile('xml', 'cyan', 'NONE', cyan, 'NONE')
call NERDTreeHighlightFile('zip', 'gray', 'NONE', base01, 'NONE')
call NERDTreeHighlightFile('cache', 'gray', 'NONE', base01, 'NONE')
call NERDTreeHighlightFile('log', 'gray', 'NONE', base01, 'NONE')

hi Directory guifg='#2AA198' ctermfg=red

hi MatchParen guifg=orange guibg=NONE

"let g:tagbar_ctags_bin='C:\Users\nikos\bin\ctags.exe'
" Set the filter to only show source files

" Now using vim-nerdtree-ignore so put these in .nerdtreeignore file in project dir
"let NERDTreeIgnore = ['\.pyc$', '\.pyd$', '\.zip$', '\.png$', '\.xml$', '\.json$', '\.cache$']
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
"## Open NERDTree automatically if directory given to vim
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | set columns=140 | endif
map <silent> <F3> :call BufferList()<CR>a

"# Tagbar
set updatetime=2000
let g:airline#extensions#tagbar#flags = 'f'  " show full tag hierarchy

" File type options
autocmd BufNewFile,BufReadPost *.mjs set filetype=javascript
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

" Highlight some common typos
autocmd Syntax * syn keyword Error attribites

