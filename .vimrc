"      ___                       ___           ___           ___
"     /\__\          ___        /\__\         /\  \         /\  \
"    /:/  /         /\  \      /::|  |       /::\  \       /::\  \
"   /:/  /          \:\  \    /:|:|  |      /:/\:\  \     /:/\:\  \
"  /:/__/  ___      /::\__\  /:/|:|__|__   /::\~\:\  \   /:/  \:\  \
"  |:|  | /\__\  __/:/\/__/ /:/ |::::\__\ /:/\:\ \:\__\ /:/__/ \:\__\
"  |:|  |/:/  / /\/:/  /    \/__/~~/:/  / \/_|::\/:/  / \:\  \  \/__/
"  |:|__/:/  /  \::/__/           /:/  /     |:|::/  /   \:\  \
"   \::::/__/    \:\__\          /:/  /      |:|\/__/     \:\  \
"    ~~~~         \/__/         /:/  /       |:|  |        \:\__\
"                               \/__/         \|__|         \/__/

""""""""""""""""""""""""""""""""""""""""""""""
" dein
""""""""""""""""""""""""""""""""""""""""""""""
"if &compatible
"  set nocompatible
"endif
"
"let s:dein_dir = expand('~/.cache/dein')
"let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'
"
"if &runtimepath !~# '/dein.vim'
"  if !isdirectory(s:dein_repo_dir)
"    execute '!git clone https://github.com/Shougo/dein.vim' s:dein_repo_dir
"  endif
"  execute 'set runtimepath^=' . fnamemodify(s:dein_repo_dir, ':p')
"endif
"
"if !dein#load_state(s:dein_dir)
"  finish
"endif
"
"call dein#begin(s:dein_dir)
"
"call dein#load_toml('~/.vim/rc/dein.toml', {'lazy': 0})
"call dein#load_toml('~/.vim/rc/deinlazy.toml', {'lazy': 1})
"call dein#disable('neobundle.vim')
"
"call dein#end()
"call dein#save_state()
"
"if dein#check_install()
" call dein#install()
"endif
"
"filetype plugin indent on


""""""""""""""""""""""""""""""""""""""""""""""
" NeoBundle
""""""""""""""""""""""""""""""""""""""""""""""
if has('vim_starting')
  set nocompatible            " Be iMproved

  " Required:
  set runtimepath+=~/.vim/bundle/neobundle.vim/
endif

" Required:
call neobundle#begin(expand('~/.vim/bundle/'))

" Let NeoBundle manage NeoBundle
" Required:
NeoBundle 'Shougo/neobundle.vim'

NeoBundle 'Shougo/vimproc.vim', {
\ 'build' : {
\     'windows' : 'tools\\update-dll-mingw',
\     'cygwin' : 'make -f make_cygwin.mak',
\     'mac' : 'make',
\     'linux' : 'make',
\     'unix' : 'gmake',
\    },
\ }

" Search and display information from arbitrary sources
NeoBundle 'Shougo/unite.vim'
NeoBundle 'Shougo/neomru.vim'
let g:unite_enable_start_insert=0
noremap <C-P> :Unite file_mru<CR>

" Tree explorer
NeoBundle 'scrooloose/nerdtree'
noremap <silent><C-e> :NERDTree<Cr>
let NERDTreeIgnore = ['\.pyc$','\~$']

NeoBundle 'Shougo/vimfiler'

" Completion
NeoBundle 'Shougo/neocomplete.vim'
let g:neocomplete#enable_at_startup = 1

" File-type sensible comments
NeoBundle 'tomtom/tcomment_vim'

" Ansi escape sequences concealed, but highlighted as specified (conceal)
NeoBundle 'vim-scripts/AnsiEsc.vim'

" Check syntax error
NeoBundle 'scrooloose/syntastic'

" Multiple cursors
NeoBundle 'terryma/vim-multiple-cursors'

" Syntax for CoffeeScript
NeoBundle 'kchmck/vim-coffee-script'

" Syntax for jsx
NeoBundle 'pangloss/vim-javascript'
NeoBundle 'mxw/vim-jsx'
let g:jsx_ext_required = 0

" Syntax for Sass
NeoBundle 'cakebaker/scss-syntax.vim'

" Syntax for Slim
NeoBundle 'slim-template/vim-slim'

" Emmet
NeoBundle 'mattn/emmet-vim'
let g:user_emmet_leader_key='<C-T>'

" Rails
NeoBundle 'tpope/vim-rails'

" Ruby
NeoBundle 'tpope/vim-endwise'

" Mappings to easily delete, change and add such surroundings in pairs
NeoBundle 'tpope/vim-surround'

" Git wrapper
NeoBundle 'tpope/vim-fugitive'

" Pairs of handy bracket mappings
NeoBundle 'tpope/vim-unimpaired'

" Auto Closing for Branckets and Quotations
NeoBundle 'Townk/vim-autoclose'

" Visualize indent
NeoBundle 'nathanaelkane/vim-indent-guides'
let g:indent_guides_enable_on_vim_startup=1
let g:indent_guides_guide_size=1
let g:indent_guides_auto_colors=0
autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  guibg=#2D3632 ctermbg=black
autocmd VimEnter,Colorscheme * :hi IndentGuidesEven guibg=#2D3632 ctermbg=black

" Highlights trailing whitespace in red
NeoBundle 'bronson/vim-trailing-whitespace'

" Run commands quickly
NeoBundle 'thinca/vim-quickrun'
let g:quickrun_config = get(g:, 'quickrun_config', {})
let g:quickrun_config._ = {
      \ 'runner'    : 'vimproc',
      \ 'runner/vimproc/updatetime' : 60,
      \ 'outputter' : 'error',
      \ 'outputter/error/success' : 'buffer',
      \ 'outputter/error/error'   : 'quickfix',
      \ 'outputter/buffer/split'  : ':rightbelow 8sp',
      \ 'outputter/buffer/close_on_empty' : 1,
      \ }
nnoremap <silent><Space>s :QuickRun -mode n<CR>
vnoremap <silent><Space>s :QuickRun -mode v<CR>

" Seamless navigation between tmux panes and vim splits
NeoBundle 'christoomey/vim-tmux-navigator'

" Colorscheme
NeoBundle 'altercation/vim-colors-solarized'

" A light configurable statusline and tabline
NeoBundle 'itchyny/lightline.vim'

" ag
NeoBundle 'rking/ag.vim'

" fzf
NeoBundle 'junegunn/fzf'
NeoBundle 'junegunn/fzf.vim'

call neobundle#end()

" Required:
filetype plugin indent on

NeoBundleCheck


""""""""""""""""""""""""""""""""""""""""""""""
" Basic settings
""""""""""""""""""""""""""""""""""""""""""""""
" Encoding utf-8
set encoding=utf-8

" Use English
language C

" Enable backspace
set backspace=indent,eol,start

"Not create swap file
set noswapfile

" Use clipboard
set clipboard=unnamed,autoselect

"Minimal number of screen lines to keep above and below the cursor
set scrolloff=5

" When starting a new line, copy the indentation from the previous line
set autoindent

" When you create a new line, perform advanced automatic indentation
set smartindent

" Use tabs instead of spaces. 1 tab == 2 spaces
set expandtab
set tabstop=2
set shiftwidth=2

" Emphasize the matching parenthesis
set showmatch

" Fast terminal connection
set ttyfast
set ttyscroll=3

" Add '-' to word
set iskeyword+=-

" Ignore case
set ignorecase

" Smart ignore case
set smartcase

" Enable the incremental search
set incsearch

" Emphasize the search pattern
set hlsearch

" Do not use visualbell
set novisualbell
set vb t_vb=

" Delete parenthesis and quotations when left one was deleted
function! DeleteParenthesesAdjoin()
  let pos = col(".") - 1
  let str = getline(".")
  let parentLList = ["(", "[", "{", "\'", "\""]
  let parentRList = [")", "]", "}", "\'", "\""]
  let cnt = 0
  let output = ""

  if pos == strlen(str)
    return "\b"
  endif
  for c in parentLList
    if str[pos-1] == c && str[pos] == parentRList[cnt]
      call cursor(line("."), pos + 2)
      let output = "\b"
      break
    endif
    let cnt += 1
  endfor
  return output."\b"
endfunction
inoremap <silent> <C-h> <C-R>=DeleteParenthesesAdjoin()<CR>

" Auto indent when starting a new line in adjacent parenthesis
function! IndentBraces()
  let pos = col(".") - 1
  let str = getline(".")
  let parentLList = ["(", "[", "{"]
  let parentRList = [")", "]", "}"]
  let cnt = 0
  let output = ""

  for c in parentLList
    if str[pos-1] == c && str[pos] == parentRList[cnt]
      let output = "\n\t\n\<UP>\<RIGHT>\<RIGHT>"
      break
    else
      let output = "\n"
    endif
    let cnt += 1
  endfor
  return output
endfunction
inoremap <silent> <Enter> <C-R>=IndentBraces()<CR>


""""""""""""""""""""""""""""""""""""""""""""""
" Appearance
""""""""""""""""""""""""""""""""""""""""""""""
"Enable Syntax hilight
syntax enable

" Show row number
set number

" Colorscheme
set background=dark
colorscheme solarized

" Emphasize current row
set cursorline
highlight CursorLine ctermfg=NONE ctermbg=0

" Command line's height
set cmdheight=1

set laststatus=2

" lightline
let g:lightline = {
      \ 'colorscheme': 'solarized',
      \ 'mode_map': { 'c': 'NORMAL' },
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ], [ 'fugitive', 'filename' ] ]
      \ },
      \ 'component_function': {
      \   'modified': 'LightLineModified',
      \   'readonly': 'LightLineReadonly',
      \   'fugitive': 'LightLineFugitive',
      \   'filename': 'LightLineFilename',
      \   'fileformat': 'LightLineFileformat',
      \   'filetype': 'LightLineFiletype',
      \   'fileencoding': 'LightLineFileencoding',
      \   'mode': 'LightLineMode',
      \ },
      \ 'separator': { 'left': '⮀', 'right': '⮂' },
      \ 'subseparator': { 'left': '⮁', 'right': '⮃' }
      \ }

function! LightLineModified()
  return &ft =~ 'help\|vimfiler\|gundo' ? '' : &modified ? '+' : &modifiable ? '' : '-'
endfunction

function! LightLineReadonly()
  return &ft !~? 'help\|vimfiler\|gundo' && &readonly ? '⭤' : ''
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
  if &ft !~? 'vimfiler\|gundo' && exists("*fugitive#head")
    let branch = fugitive#head()
    return branch !=# '' ? '⭠ '.branch : ''
  endif
  return ''
endfunction

function! LightLineFileformat()
  return winwidth(0) > 70 ? &fileformat : ''
endfunction

function! LightLineFiletype()
  return winwidth(0) > 70 ? (&filetype !=# '' ? &filetype : 'no ft') : ''
endfunction

function! LightLineFileencoding()
  return winwidth(0) > 70 ? (&fenc !=# '' ? &fenc : &enc) : ''
endfunction

function! LightLineMode()
  return winwidth(0) > 60 ? lightline#mode() : ''
endfunction

" Comment out because lightline.vim
" " Show line and column number
" set ruler
" set rulerformat=%l:%v/%L

" " Active statusline color
" highlight StatusLine ctermfg=21 ctermbg=231
"
" " Emphasize statusline in the insert mode
" let g:hi_insert = 'highlight StatusLine ctermfg=226 ctermbg=21'
"
" if has('syntax')
"   augroup InsertHook
"     autocmd!
"     autocmd InsertEnter * call s:StatusLine('Enter')
"     autocmd InsertLeave * call s:StatusLine('Leave')
"   augroup END
" endif
"
" let s:slhlcmd = ''
" function! s:StatusLine(mode)
"   if a:mode == 'Enter'
"     silent! let s:slhlcmd = 'highlight ' . s:GetHighlight('StatusLine')
"     silent exec g:hi_insert
"   else
"     highlight clear StatusLine
"     silent exec s:slhlcmd
"   endif
" endfunction
"
" function! s:GetHighlight(hi)
"   redir => hl
"   exec 'highlight '.a:hi
"   redir END
"   let hl = substitute(hl, '[\r\n]', '', 'g')
"   let hl = substitute(hl, 'xxx', '', '')
"   return hl
" endfunction

" Visualize zenkaku-space
function! ZenkakuSpace()
  highlight ZenkakuSpace cterm=underline ctermfg=lightblue guibg=darkgray
endfunction

if has('syntax')
  augroup ZenkakuSpace
    autocmd!
    autocmd! ColorScheme * call ZenkakuSpace()
    autocmd! VimEnter,WinEnter,BufRead * let w:m1=matchadd('ZenkakuSpace', '　')
  augroup END
  call ZenkakuSpace()
endif


""""""""""""""""""""""""""""""""""""""""
" Key mappings
""""""""""""""""""""""""""""""""""""""""
" Define mapleader
let mapleader = ','
let maplocalleader = ','

" Smart space mapping
" Notice: when starting other <Space> mappings in noremap, disappeared [Space]
nmap <Space> [Space]
nnoremap [Space] <Nop>

" Simply escape
inoremap jj <ESC><Right>
cnoremap <expr> j getcmdline()[getcmdpos()-2] ==# 'j' ? "\<BS>\<C-c>" : 'j'
vnoremap <C-j><C-j> <ESC>
onoremap jj <ESC>

noremap <CR> o<ESC>

" Easily move in insert mode
inoremap <C-j> <Down>
inoremap <C-k> <Up>
inoremap <C-l> <Right>
inoremap <C-b> <Left>

" Swap jk for gjgk
nnoremap j gj
xnoremap j gj
nnoremap k gk
xnoremap k gk
nnoremap gj j
xnoremap gj j
nnoremap gk k
xnoremap gk k

" Tabpages
nnoremap <silent> tt :<C-u>tabnew<CR>
nnoremap <silent> tq :<C-u>tabclose<CR>
nnoremap <silent> to :<C-u>tabonly<CR>
nnoremap tn gt
nnoremap tp gT

" Windows
nnoremap s <Nop>
nnoremap sp :<C-u>split<CR>
nnoremap vs :<C-u>vsplit<CR>
nnoremap sj <C-w>j
nnoremap sk <C-w>k
nnoremap sl <C-w>l
nnoremap sh <C-w>h
nnoremap s<C-j> <C-w>J
nnoremap s<C-k> <C-w>K
nnoremap s<C-l> <C-w>L
nnoremap s<C-h> <C-w>H

" Resize windows for five rows or 5 columns
let g:size = 5
function! ResizeWindow(type)
  let behavior = s:getResizeBehavior()
  if a:type == 'left' || a:type == 'right'
    exec ':vertical resize ' . behavior[a:type] . g:size
  else
    exec ':resize ' . behavior[a:type] . g:size
  endif
endfunction

" Decide behavior of up, down, left and right key
" to increase or decrease window size
function! s:getResizeBehavior()
  let signs = {'left':'-', 'down':'+', 'up':'-', 'right':'+'}
  let ei = s:getEdgeInfo()
  if !ei['left'] && ei['right']
    let signs['left'] = '+'
    let signs['right'] = '-'
  endif
  if !ei['up'] && ei['down']
    let signs['up'] = '+'
    let signs['down'] = '-'
  endif
  return signs
endfunction

" When value is 1 in return dictionary,
" current window has edge in direction of dictionary key name
function! s:getEdgeInfo()
  let chk_direct = ['left', 'down', 'up', 'right']
  let result = {}
  for direct in chk_direct
    let result[direct] = !s:checkDestinationPresence(direct)
  endfor
  return result
endfunction

function! s:checkDestinationPresence(direct)
  let map_direct = {'left':'h', 'down':'j', 'up':'k', 'right':'l'}
  if has_key(map_direct, a:direct)
    let direct = map_direct[a:direct]
  elseif index(values(map_direct), a:direct) != -1
    let direct = a:direct
  endif
  let from = winnr()
  exe "wincmd " . direct
  let to = winnr()
  exe from . "wincmd w"
  return from != to
endfunction

nnoremap <silent> sJ :<C-u>call ResizeWindow('down')<CR>
nnoremap <silent> sK :<C-u>call ResizeWindow('up')<CR>
nnoremap <silent> sL :<C-u>call ResizeWindow('right')<CR>
nnoremap <silent> sH :<C-u>call ResizeWindow('left')<CR>

" Seamless move to tmux pane
let g:tmux_navigator_no_mappings = 1
nnoremap <silent> sh :TmuxNavigateLeft<cr>
nnoremap <silent> sj :TmuxNavigateDown<cr>
nnoremap <silent> sk :TmuxNavigateUp<cr>
nnoremap <silent> sl :TmuxNavigateRight<cr>

" Yank a line not including \n
nnoremap Y ^y$

" Easily move to beginning of line and end of line
nnoremap [Space]h ^
nnoremap [Space]l $

" Reset highlight searching
nnoremap <silent> <ESC><ESC> :nohlsearch<CR>

" View file information
nnoremap <C-g> 1<C-g>

" Nop features
nnoremap ZZ <Nop>
nnoremap ZQ <Nop>

" fzf
" Open files at current directory
nnoremap <silent> <Leader>a :call fzf#run({
      \    'sink': 'e',
      \    'down': '40%'
      \  })<CR>

" Search old files
function! s:all_files()
  return extend(
        \  filter(copy(v:oldfiles),
        \    "v:val !~ 'fugitive:\\|NERD_tree\\|^/tmp/\\|.git/'"),
        \  map(filter(range(1, bufnr('$')), 'buflisted(v:val)'), 'bufname(v:val)'))
endfunction

nnoremap <silent> <Leader>e :call fzf#run({
      \    'source': reverse(<sid>all_files()),
      \    'sink': 'e',
      \    'down': '40%'
      \  })<CR>

command! -nargs=+ -complete=file AgRaw call fzf#vim#ag_raw(<q-args>)

command! -nargs=* -complete=file AgPreview :call fzf#vim#ag_raw(<q-args>, fzf#wrap('ag-raw',
      \ {'options': "--preview 'coderay $(cut -d: -f1 <<< {}) 2> /dev/null | sed -n $(cut -d: -f2 <<< {}),\\$p | head -".&lines."'"}))
