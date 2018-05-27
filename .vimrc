:set clipboard+=unnamed
inoremap <silent> jj <ESC>

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

if has('vim_starting')
   set nocompatible               " Be iMproved
   set runtimepath+=~/.vim/bundle/neobundle.vim/
 endif

 call neobundle#rc(expand('~/.vim/bundle/'))

 " Let NeoBundle manage NeoBundle
 NeoBundleFetch 'Shougo/neobundle.vim'

 " Recommended to install
 "NeoBundle 'Shougo/vimproc', {
 " \ 'build' : {
 " \     'windows' : 'make -f make_mingw32.mak',
 " \     'cygwin' : 'make -f make_cygwin.mak',
 " \     'mac' : 'make -f make_mac.mak',
 " \     'unix' : 'make -f make_unix.mak',
 " \    },
 " \ }

 " My Bundles here:
 " Refer to |:NeoBundle-examples|.
 "
 " Note: You don't set neobundle setting in .gvimrc!

 " ...
 NeoBundle 'tpope/vim-rails'
 NeoBundle 'scrooloose/nerdtree'

 filetype plugin indent on     " Required!
 "
 " Brief help
 " :NeoBundleList          - list configured bundles
 " :NeoBundleInstall(!)    - install(update) bundles
 " :NeoBundleClean(!)      - confirm(or auto-approve) removal of unused bundles

 " Installation check.
 NeoBundleCheck

 " 8進→10進
 set nrformats=
