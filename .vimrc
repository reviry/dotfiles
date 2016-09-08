"""""""""""""""""""""""""""""
" プラグインのセットアップ
"""""""""""""""""""""""""""""
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
NeoBundle 'Shougo/unite.vim'
NeoBundle 'Shougo/neomru.vim'

" Unite.vimの設定
""""""""""""""""""""""""""""""""""
let g:unite_enable_start_insert=0
" カレントディレクトリ以下のファイル一覧
noremap <C-N> :Unite -buffer-name=file file<CR>
" 最近開いたファイル一覧
noremap <C-P> :Unite file_mru<CR>
""""""""""""""""""""""""""""""""""

NeoBundle 'scrooloose/nerdtree'
noremap <silent><C-e> :NERDTree<Cr>
let NERDTreeIgnore = ['\.pyc$','\~$']

" 一括コメントのON/OFF
NeoBundle 'tomtom/tcomment_vim'

" ログの内容を色付け
NeoBundle 'vim-scripts/AnsiEsc.vim'

"シンタックスチェック"
NeoBundle 'scrooloose/syntastic'

"複数カーソル"
NeoBundle 'terryma/vim-multiple-cursors'

"カラースキーム"
NeoBundle 'nanotech/jellybeans.vim'

"emmet"
NeoBundle 'mattn/emmet-vim'
let g:user_emmet_leader_key='<C-T>'

"CoffeeScriptシンタックス"
NeoBundle 'kchmck/vim-coffee-script'

" Sassシンタックス
NeoBundle 'cakebaker/scss-syntax.vim'

" slimシンタックス
NeoBundle 'slim-template/vim-slim'

"Rails補完"
NeoBundle 'tpope/vim-rails'

"Ruby補完"
NeoBundle 'tpope/vim-endwise'

" jsx syntax highlight
NeoBundle 'pangloss/vim-javascript'
NeoBundle 'mxw/vim-jsx'
let g:jsx_ext_required = 0

"シングルクオートとダブルクオートの入れ替え等
NeoBundle 'tpope/vim-surround'

NeoBundle 'tpope/vim-fugitive'
NeoBundle 'tpope/vim-unimpaired'

" 閉じカッコを自動化
NeoBundle 'Townk/vim-autoclose'

"インデント可視化
NeoBundle 'nathanaelkane/vim-indent-guides'
let g:indent_guides_auto_colors=0
autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd   guibg=#333333 ctermbg=235
autocmd VimEnter,Colorscheme * :hi IndentGuidesEven  guibg=#4a4a4a ctermbg=238
let g:indent_guides_enable_on_vim_startup=1

"行末の半角スペースを可視化
NeoBundle 'bronson/vim-trailing-whitespace'

"latex
NeoBundle 'lervag/vimtex'
let g:vimtex_view_general_viewer = '/Applications/Skim.app/Contents/SharedSupport/displayline'
let g:vimtex_view_general_options = '-r @line @pdf @tex'
let g:vimtex_view_general_options_latexmk = '-r 1'
let g:latex_latexmk_continuous = 1

"vim-quickrun"
NeoBundle 'thinca/vim-quickrun'

" LaTeX Quickrun
let g:quickrun_config = {}
let g:quickrun_config['tex'] = {
\ 'command' : 'latexmk',
\ 'outputter' : 'error',
\ 'outputter/error/success' : 'null',
\ 'outputter/error/error' : 'quickfix',
\ 'srcfile' : expand("%"),
\ 'cmdopt': '-pdfdvi',
\ 'hook/sweep/files' : [
\                      '%S:p:r.aux',
\                      '%S:p:r.bbl',
\                      '%S:p:r.blg',
\                      '%S:p:r.dvi',
\                      '%S:p:r.fdb_latexmk',
\                      '%S:p:r.fls',
\                      '%S:p:r.log',
\                      '%S:p:r.out'
\                      ],
\ 'exec': '%c %o %a %s',
\}

let g:quickrun_config.tmptex = {
\   'exec': [
\           'mv %s %a/tmptex.latex',
\           'latexmk -pdfdvi -pv -output-directory=%a %a/tmptex.latex',
\           ],
\   'args' : expand("%:p:h:gs?\\\\?/?"),
\   'outputter' : 'error',
\   'outputter/error/error' : 'quickfix',
\
\   'hook/eval/enable' : 1,
\   'hook/eval/cd' : "%s:r",
\
\   'hook/eval/template' : '\documentclass{jreport}'
\                         .'\usepackage[dvipdfmx]{graphicx, hyperref}'
\                         .'\usepackage{float}'
\                         .'\usepackage{amsmath,amssymb,amsthm,ascmac,mathrsfs}'
\                         .'\allowdisplaybreaks[1]'
\                         .'\theoremstyle{definition}'
\                         .'\newtheorem{theorem}{定理}'
\                         .'\newtheorem*{theorem*}{定理}'
\                         .'\newtheorem{definition}[theorem]{定義}'
\                         .'\newtheorem*{definition*}{定義}'
\                         .'\renewcommand\vector[1]{\mbox{\boldmath{\$#1\$}}}'
\                         .'\begin{document}'
\                         .'%s'
\                         .'\end{document}',
\
\   'hook/sweep/files' : [
\                        '%a/tmptex.latex',
\                        '%a/tmptex.out',
\                        '%a/tmptex.fdb_latexmk',
\                        '%a/tmptex.log',
\                        '%a/tmptex.aux',
\                        '%a/tmptex.dvi'
\                        ],
\}

vnoremap <silent><buffer> <Space>s :QuickRun -mode v -type tmptex<CR>

" QuickRun and view compile result quickly (but don't preview pdf file)
nnoremap <silent><Space>s :QuickRun<CR>

" autocmd
"==============================
augroup filetype
  autocmd!
  " tex file (I always use latex)
  autocmd BufRead,BufNewFile *.tex set filetype=tex
augroup END

NeoBundle 'jmcantrell/vim-virtualenv'

call neobundle#end()

" Required:
filetype plugin indent on

NeoBundleCheck
"""""""""""""""""""""""""""""""""

"####表示設定####
set number "行番号を表示
set title "編集中のファイル名を表示
syntax on "コードの色分け
set expandtab "タブの代わりにスペースを使用"
set tabstop=2 "インデントをスペース2つ分に設定
set shiftwidth=2 "インデントの幅
set autoindent "改行時に前の行のインデントを継続する
set showmatch "対応する括弧を表示
autocmd ColorScheme * highlight Comment ctermfg=22 guifg=#008800
autocmd ColorScheme * highlight StatusLine ctermfg=21 guifg=#0000FF
autocmd ColorScheme * highlight  Visual ctermfg=8 ctermbg=7 guifg=Black guibg=#DDDDDD gui=none
autocmd ColorScheme * highlight  Search  guifg=Black guibg=#01A9DB gui=none
colorscheme molokai
set cursorline
hi clear CursorLine

"####検索設定####
set ignorecase "大文字/小文字を区別しない
set smartcase "検索文字列に大文字が含まれている場合は区別する
nnoremap <ESC><ESC> :nohlsearch<CR>

"####その他####
set iskeyword+=-
set clipboard=unnamed,autoselect
inoremap <C-j> <Down>
inoremap <C-k> <Up>
inoremap <C-l> <Right>
inoremap <C-b> <Left>
inoremap <silent> jj <ESC><Right>
noremap <CR> o<ESC>

nnoremap j gj
xnoremap j gj
nnoremap k gk
xnoremap k gk
nnoremap gj j
xnoremap gj j
nnoremap gk k
xnoremap gk k

nnoremap tn gt
nnoremap tp gT

set imdisable
set visualbell

" Jedi for python
" NeoBundleLazy "davidhalter/jedi-vim", {
"   \ "autoload": { "filetypes": [ "python", "python3", "djangohtml"] }}
"
" if ! empty(neobundle#get("jedi-vim"))
"   let g:jedi#auto_initialization = 1
"   let g:jedi#auto_vim_configuration = 0
"
"   nnoremap [jedi] <Nop>
"   xnoremap [jedi] <Nop>
"   nmap <Space>j [jedi]
"   xmap <Space>j [jedi]
"
"   let g:jedi#completions_command = "<Tab>"
"   let g:jedi#goto_assignments_command = "[jedi]g"
"   let g:jedi#goto_definitions_command = "[jedi]d"
"   let g:jedi#documentation_command = "[jedi]k"
"   let g:jedi#rename_command = "[jedi]r"
"   let g:jedi#usages_command = "[jedi]n"
"   let g:jedi#popup_select_first = 0
"   let g:jedi#popup_on_dot = 0
"
"   autocmd FileType python setlocal completeopt-=preview
"
"   " for w/ neocomplete
"   if ! empty(neobundle#get("neocomplete.vim"))
"     autocmd FileType python setlocal omnifunc=jedi#completions
"     let g:jedi#completions_enabled = 0
"     let g:jedi#auto_vim_configuration = 0
"     let g:neocomplete#force_omni_input_patterns.python =
"       \ '\%([^. \t]\.\|^\s*@\|^\s*from\s.\+import \|^\s*from \|^\s*import \)\w*'
"   endif
" endif

""""""""""""""""""""""""""""""
"挿入モード時、ステータスラインの色を変更
""""""""""""""""""""""""""""""
let g:hi_insert = 'highlight StatusLine guifg=darkblue guibg=yellow gui=none ctermfg=blue ctermbg=yellow cterm=none'

if has('syntax')
  augroup InsertHook
    autocmd!
    autocmd InsertEnter * call s:StatusLine('Enter')
    autocmd InsertLeave * call s:StatusLine('Leave')
  augroup END
endif

let s:slhlcmd = ''
function! s:StatusLine(mode)
  if a:mode == 'Enter'
    silent! let s:slhlcmd = 'highlight ' . s:GetHighlight('StatusLine')
    silent exec g:hi_insert
  else
    highlight clear StatusLine
    silent exec s:slhlcmd
  endif
endfunction

function! s:GetHighlight(hi)
  redir => hl
  exec 'highlight '.a:hi
  redir END
  let hl = substitute(hl, '[\r\n]', '', 'g')
  let hl = substitute(hl, 'xxx', '', '')
  return hl
endfunction

"全角スペースの可視化
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

"括弧・クォートの開き記号を削除したとき隣接する閉じ記号も削除
function! DeleteParenthesesAdjoin()
  let pos = col(".") - 1  " カーソルの位置．1からカウント
  let str = getline(".")  " カーソル行の文字列
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

" 隣接した括弧で改行したらインデント
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
