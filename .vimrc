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
let g:user_emmet_leader_key='<c-e>'

"CoffeeScriptシンタックス"
NeoBundle 'kchmck/vim-coffee-script'

" Sassシンタックス
NeoBundle 'cakebaker/scss-syntax.vim'

"Rails補完"
NeoBundle 'tpope/vim-rails'

"Ruby補完"
NeoBundle 'tpope/vim-endwise'

"シングルクオートとダブルクオートの入れ替え等
NeoBundle 'tpope/vim-surround'

" 閉じカッコを自動化
NeoBundle 'Townk/vim-autoclose'

"インデント可視化
NeoBundle 'nathanaelkane/vim-indent-guides'
let g:indent_guides_enable_on_vim_startup = 1

"行末の半角スペースを可視化
NeoBundle 'bronson/vim-trailing-whitespace'

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
colorscheme molokai
set cursorline
hi clear CursorLine

""""""""""""""""""""""""""""""
"挿入モード時、ステータスラインの色を変更
""""""""""""""""""""""""""""""
let g:hi_insert = 'highlight StatusLine guifg=darkblue guibg=darkyellow gui=none ctermfg=blue ctermbg=yellow cterm=none'

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
inoremap <silent> jj <ESC>
noremap <CR> o<ESC>

nnoremap j gj
xnoremap j gj
nnoremap k gk
xnoremap k gk
nnoremap gj j
xnoremap gj j
nnoremap gk k
xnoremap gk k

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
