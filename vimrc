
" TODO when installing:
" * install packages for flake8, python-autopep8


set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'
" custom plugins
Plugin 'tmhedberg/SimpylFold'
Plugin 'vim-scripts/indentpython.vim'
" Plugin 'vim-syntastic/syntastic'
" Plugin 'nvie/vim-flake8'
" Plugin 'W0rp/ale'
Plugin 'scrooloose/nerdtree'
Plugin 'Xuyuanp/nerdtree-git-plugin'
Plugin 'tpope/vim-fugitive'
Plugin 'vim-gitgutter'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'davidhalter/jedi-vim'
Plugin 'tpope/vim-commentary'
Plugin 'christoomey/vim-tmux-navigator'
Plugin 'qpkorr/vim-bufkill'

" color schemes
Plugin 'jnurmine/Zenburn'
Plugin 'altercation/vim-colors-solarized'
Plugin 'joshdick/onedark.vim'
Plugin 'sonph/onehalf', {'rtp': 'vim/'}
Plugin 'chriskempson/base16-vim'
Plugin 'jacoborus/tender.vim'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line

" filetype plugin indent on
syntax enable

" If you want to install not installed plugins on startup.
"if dein#check_install()
"  call dein#install()
"endif

"""""""""""""""
" custom config
"""""""""""""""

" plugin config
""""""""""""""""

" python highlighting
let python_highlight_all=1
syntax on

" let g:ale_completion_enabled = 1
" let g:ale_linters = {'python': ['flake8']}
" let g:ale_fixers = {'python': ['remove_trailing_lines', 'trim_whitespace', 'autopep8']}

" autocompletion
" let g:ycm_path_to_python_interpreter = '/usr/bin/python3'
" let g:ycm_autoclose_preview_window_after_completion=1
" map <leader>g  :YcmCompleter GoToDefinitionElseDeclaration<CR>

" configure nerdtree
let NERDTreeIgnore=['\.pyc$', '\~$'] "ignore files in NERDTree
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

" configure powerline
" let g:powerline_pycmd = 'py3'

" configure airline
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#virtualenv#enabled = 1
let g:airline#extensions#whitespace#enabled = 1
let g:airline#extensions#branch#enabled = 1
let g:airline#extensions#syntastic#enabled = 1
if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif
let g:airline_theme='onedark'

" configure jedi auto completion
let g:jedi#popup_on_dot=0
let g:jedi#popup_select_first=1
let g:jedi#show_call_signatures=2
let g:jedi#force_py_version=3
let g:jedi#smart_auto_mappings=0

" configure python-mode
" let g:pymode_python = 'python3'

" configure ctrlp
let g:ctrlp_custom_ignore = '\v[\/]\.(git|hg|svn)$'
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v([\/]\.(git|hg|svn))|(machinel_datasets)$',
  \ 'file': '\v\.(exe|so|dll|html)$',
  \ 'link': 'some_bad_symbolic_links',
  \ }

" vim editor config
"""""""""""""""""""

" if using an old terminal emulator, this fixes the command line mode
if has("nvim")
    set guicursor=
endif

" Enable folding
set foldmethod=indent
set foldlevel=9

" Enable folding with the spacebar
" nnoremap <space> za
let g:SimpylFold_docstring_preview=1

" python indentation
au BufNewFile,BufRead *.py set tabstop=4
au BufNewFile,BufRead *.py set softtabstop=4
au BufNewFile,BufRead *.py set shiftwidth=4
" au BufNewFile,BufRead *.py set textwidth=80
au BufNewFile,BufRead *.py set expandtab
au BufNewFile,BufRead *.py set autoindent
au BufNewFile,BufRead *.py set fileformat=unix

" c indentation
au BufNewFile,BufRead *.c set tabstop=4
au BufNewFile,BufRead *.c set softtabstop=4
au BufNewFile,BufRead *.c set shiftwidth=4
au BufNewFile,BufRead *.c set textwidth=79
au BufNewFile,BufRead *.c set expandtab
au BufNewFile,BufRead *.c set autoindent
au BufNewFile,BufRead *.c set fileformat=unix

" other indentation
au BufNewFile,BufRead *.js, *.html, *.css, *.yaml
au BufNewFile,BufRead *.js, *.html, *.css, *.yaml set tabstop=2
au BufNewFile,BufRead *.js, *.html, *.css, *.yaml set softtabstop=2
au BufNewFile,BufRead *.js, *.html, *.css, *.yaml set shiftwidth=2

" flag uneccessary whitespace
highlight BadWhitespace ctermbg=red guibg=darkred
au BufRead,BufNewFile *.py,*.pyw,*.c,*.h match BadWhitespace /\s\+$/

" encoding
set encoding=utf-8

" Function to activate a virtualenv in the embedded interpreter for
" omnicomplete and other things like that.
function LoadVirtualEnv(path)
    let activate_this = a:path . '/bin/activate_this.py'
    if getftype(a:path) == "dir" && filereadable(activate_this)
        python << EOF
import vim
activate_this = vim.eval('l:activate_this')
execfile(activate_this, dict(__file__=activate_this))
EOF
    endif
endfunction

" Load up a 'stable' virtualenv if one exists in ~/.virtualenv
let defaultvirtualenv = $HOME . "/.virtualenvs/stable"

" Only attempt to load this virtualenv if the defaultvirtualenv
" actually exists, and we aren't running with a virtualenv active.
if has("python")
    if empty($VIRTUAL_ENV) && getftype(defaultvirtualenv) == "dir"
        call LoadVirtualEnv(defaultvirtualenv)
    endif
endif


" color scheme
set background=dark
colorscheme onedark

" use sytem clipboard
set clipboard=unnamedplus
" set clipboard=unnamed

" line numbers
set rnu
set nu

" enable mouse conroles
set mouse=n

" allow virtual editing of 1 char behind end
:set virtualedit=onemore

" keymapping config
"""""""""""""""""""

" remap escape
" :imap <leader>j <Esc>

" change leader key
" map <SPACE> <leader>
" map , <leader>
map ; <leader>
" map <ESC> <leader>
set timeoutlen=300

" configure splitting
set splitbelow
set splitright
nnoremap <leader>wv :vsp<CR>
nnoremap <leader>wh :sp<CR>

" navigation
" map <C-w> <up>
" map <C-s> <down>
" map <C-a> <left>
" map <C-d> <right>

" editing 
inoremap <leader>w dw

" split navigations
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>
nnoremap <leader>ww <C-W><C-W>
nnoremap <leader>wd :hide<CR>

" commenting
map <leader>; gc
nmap <leader>; gcc

" configure buffer commands
map <leader><SPACE>n :new<CR>
map <leader><SPACE>s :w<CR>
map <leader><SPACE><SPACE> :CtrlPBuff<CR>
map <leader><SPACE>d :BD<CR>

" configure file commands
" map <leader>ff :CtrlP<CR>
map <leader>ff :CtrlPMRUFiles<CR>
map <leader>fr :so %<CR>
map <leader>fe :e ~/.vimrc<CR>

" configure nerdtree
" map <leader>N :NERDTreeToggle<CR>
" map <leader>n :NERDTree<CR>
map <leader>t :NERDTree<CR>

" configure fugitive git plugin
nmap <leader>gs :Gstatus<CR>
nmap <leader>gl :Glog --format=oneline --<CR>
nmap <leader>gp :Gpull<CR>

" copy and paste a word
nmap <leader>c  viw"xy
nmap <leader>v  viw"xp
