inoremap <silent> jj <ESC>
set clipboard+=unnamed
" yank then copy to clipboard for WSL
if system('uname -a | grep Linux | grep Microsoft') != ''
  augroup myYank
    autocmd!
    autocmd TextYankPost * :call system('clip.exe', @")
  augroup END
endif

" Basic Settings
set encoding=utf-8               " UTF-8
set noswapfile                   " .swp を作らない（vimが強制終了してしまってもデータを復元できる）
set nobackup                     " .~ を作らない（ファイル変更後に保存されるファイル編集前のバックアップ）
set noundofile                   " .un~ を作らない（ファイルを閉じて開いた後でもundoができる）
set nowrap                       " 画面端で折り返さない
set autoread                     " 更新時自動再読み込み
set hlsearch                     " 検索結果ハイライト
set laststatus=2                 " 常にステータスラインを表示
set number                       " Show line number
set nrformats=                   " 0前置の数値でも 8進 -> 10進扱い

" Split window
nmap ss :split<Return><C-w>w
nmap sv :vsplit<Return><C-w>w
" Move window
nmap <Space> <C-w>w
map s<left> <C-w>h
map s<up> <C-w>k
map s<down> <C-w>j
map s<right> <C-w>l
map sh <C-w>h
map sk <C-w>k
map sj <C-w>j
map sl <C-w>l
" Resize window
nmap <C-w><left> <C-w><
nmap <C-w><right> <C-w>>
nmap <C-w><up> <C-w>+
nmap <C-w><down> <C-w>-

" Indent
set autoindent    " 自動でインデント
set smartindent   " 新しい行を開始したときに、新しい行のインデントを現在行と同じ量にする。
set expandtab     " tabをspaceに置換しない
set cindent       " Cプログラムファイルの自動インデントを始める
set tabstop=2     " Tabの幅
set softtabstop=0 " Tabを押した時の幅(0だとtabstopと同じ)
set shiftwidth=2  " 自動インデントの各段階に使われる空白の数

