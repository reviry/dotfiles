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


if &compatible
 set nocompatible
endif

augroup MyAutoCmd
  autocmd!
augroup END


""""""""""""""""""""""""""""""""""""""""""""""
" Initialize
""""""""""""""""""""""""""""""""""""""""""""""
let $CACHE = expand('~/.cache')

if !isdirectory(expand($CACHE))
  call mkdir(expand($CACHE), 'p')
endif

" Load dein.
let s:dein_dir = finddir('dein.vim', '.;')
if s:dein_dir != '' || &runtimepath !~ '/dein.vim'
  if s:dein_dir == '' && &runtimepath !~ '/dein.vim'
    let s:dein_dir = expand('$CACHE/dein')
          \. '/repos/github.com/Shougo/dein.vim'
    if !isdirectory(s:dein_dir)
      execute '!git clone https://github.com/Shougo/dein.vim' s:dein_dir
    endif
  endif
  execute 'set runtimepath^=' . substitute(
        \ fnamemodify(s:dein_dir, ':p') , '/$', '', '')
endif

let g:dein#install_progress_type = 'title'
let g:dein#enable_notification = 1
let g:dein#install_log_filename = '~/dein.log'

let s:path = expand('$CACHE/dein')
if dein#load_state(s:path)
  call dein#begin(s:path)

  call dein#load_toml('~/.vim/rc/dein.toml', {'lazy': 0})
  call dein#load_toml('~/.vim/rc/deinlazy.toml', {'lazy' : 1})

  call dein#end()
  call dein#save_state()
endif

if dein#check_install()
  call dein#install()
endif

" Required:
silent! filetype plugin indent on
syntax enable
filetype detect


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
set clipboard+=unnamed,autoselect

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

augroup fileTypeIndent
    autocmd!
    autocmd BufNewFile,BufRead *.go setlocal noexpandtab tabstop=2 shiftwidth=2
    autocmd BufNewFile,BufRead *.slim setlocal filetype=slim
augroup END

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

" Enable undo
set undofile
set undodir=~/.vim/undo

" md as markdown instead of modula2
autocmd BufNewFile,BufRead *.{md,mdwn,mkd,mkdn,mark*} set filetype=markdown

" ddl, dml as sql
autocmd BufNewFile,BufRead *.{ddl,dml} set filetype=sql

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

" Visualize multibyte space
function! MultibyteSpace()
  highlight MultibyteSpace cterm=underline ctermfg=lightblue guibg=darkgray
endfunction

if has('syntax')
  augroup MultibyteSpace
    autocmd!
    autocmd! ColorScheme * call MultibyteSpace()
    autocmd! VimEnter,WinEnter,BufRead * let w:m1=matchadd('MultibyteSpace', '　')
  augroup END
  call MultibyteSpace()
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

" Switch ; : in normal mode and visual mode
nnoremap ; :
nnoremap : ;
vnoremap ; :
vnoremap : ;

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

" Move like emacs in command line mode
cnoremap <C-f> <Right>
cnoremap <C-b> <Left>
cnoremap <C-a> <Home>
cnoremap <C-e> <End>
cnoremap <C-d> <Del>

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

nnoremap <silent> <Leader>s :call fzf#run({
      \    'source': reverse(<sid>all_files()),
      \    'sink': 'e',
      \    'down': '40%'
      \  })<CR>

command! -nargs=+ -complete=file AgRaw call fzf#vim#ag_raw(<q-args>)

command! -nargs=* -complete=file AgPreview :call fzf#vim#ag_raw(<q-args>, fzf#wrap('ag-raw',
      \ {'options': "--preview 'coderay $(cut -d: -f1 <<< {}) 2> /dev/null | sed -n $(cut -d: -f2 <<< {}),\\$p | head -".&lines."'"}))

" easymotion
nmap <Leader>e <Plug>(easymotion-s2)
nmap <Leader>l <Plug>(easymotion-lineforward)
nmap <Leader>j <Plug>(easymotion-j)
nmap <Leader>k <Plug>(easymotion-k)
nmap <Leader>h <Plug>(easymotion-linebackward)
