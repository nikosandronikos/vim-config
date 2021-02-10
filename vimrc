if !has('unix')
    "set shell=\"C:\Program\ Files\Git\bin\sh.exe\"
    set shell=cmd.exe
endif

" If using nvm, a specific node executable must be pointed to for coc to
" function
"let g:coc_node_path = '/home/nikos/.nvm/versions/node/v14.15.1/bin/node'

" Allow pathogen to be a git submodule
runtime bundle/vim-pathogen/autoload/pathogen.vim"
execute pathogen#infect()

"# Required by vimwiki
set nocompatible
filetype plugin on

let g:vimwiki_list = [{ 'path':'~/Dropbox/vimwiki', 'path_html': '~/Documents/vimwikiHtml' }]

"# Editor functional settings
set backspace=indent,eol,start
set expandtab
set shiftwidth=4
set softtabstop=4
set encoding=utf-8

set fileformat=unix

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
set cursorline
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
    set guifont=Meslo\ LG\ S\ DZ\ for\ Powerline
else
    set guifont=Roboto\ Mono\ for\ Powerline
endif
endif

"highlight unwanted spaces
autocmd Syntax * syn match ExtraWhiteSpace /\s\+$\| \+\ze\t/ containedin=ALL

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

highlight Cursor guibg=magenta
highlight CursorLineNr guifg=magenta

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
"let g:airline#extensions#tagbar#flags = 'f'  " show full tag hierarchy

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
noremap <Space> <Nop>
let mapleader=' '
nnoremap <leader>w :w<cr>   " save current buffer
nnoremap <leader>k :Bd<cr>   " close current buffer

noremap <leader>h :MBEbp<cr>
noremap <leader>l :MBEbf<cr>

" Custom commands
command Bd bp|bd #

function! WinMove(key)
  let t:curwin = winnr()
  exec "wincmd ".a:key
  if (t:curwin == winnr())
    if (match(a:key,'[jk]'))
      wincmd v
    else
      wincmd s
    endif
    exec "wincmd ".a:key
  endif
endfunction

" Highlight some common typos
autocmd Syntax * syn keyword Error attribites

" https://thoughtbot.com/blog/faster-grepping-in-vim
if executable('ag')
    set grepprg=ag\ --nogroup\ --nocolor
    let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
    let g:ctrlp_use_caching = 0
endif

let g:ctrlp_working_path_mode='r'

" Search for word under cursor - from above link
nnoremap K :grep! <C-R><C-W><CR>:cw<CR><CR>

" Set up ack.vim to use ag instead of grep
let g:ackprg = 'ag --vimgrep --smart-case'
cnoreabbrev ag Ack
cnoreabbrev aG Ack
cnoreabbrev Ag Ack
cnoreabbrev AG Ack

" Set NERDTree to set working directory on load
" This is required for ack.vim as it searches in the cwd, also required
" for NERDTree git icons to work
let g:NERDTreeChDirMode=1

" yaml config
au! BufNewFile,BufReadPost *.{yaml,yml} set filetype=yaml foldmethod=indent
autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab

" Coc.vim
" TextEdit might fail if hidden is not set.
set hidden

" Some servers have issues with backup files, see #649.
set nobackup
set nowritebackup

" Give more space for displaying messages.
set cmdheight=2

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
if has("patch-8.1.1564")
  " Recently vim can merge signcolumn and number column into one
  set signcolumn=number
else
  set signcolumn=yes
endif

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Make <CR> auto-select the first completion item and notify coc.nvim to
" format on enter, <cr> could be remapped by other vim plugin
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current buffer.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" Remap <C-f> and <C-b> for scroll float windows/popups.
if has('nvim-0.4.0') || has('patch-8.2.0750')
  nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
  inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
  inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
  vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
endif

" Use CTRL-S for selections ranges.
" Requires 'textDocument/selectionRange' support of language server.
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Mappings for CoCList
" Show all diagnostics.
nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions.
nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<cr>
" Show commands.
nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document.
nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols.
nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list.
nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>
