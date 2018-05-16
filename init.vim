if &compatible
  set nocompatible
endif

" Add the dein installation directory into runtimepath
set runtimepath+=/home/jarig/.cache/dein/repos/github.com/Shougo/dein.vim

if dein#load_state('/home/jarig/.cache/dein')
  call dein#begin('/home/jarig/.cache/dein')

  " Let dein manage dein
  call dein#add('/home/jarig/.cache/dein/repos/github.com/Shougo/dein.vim')

  " Add or remove your plugins here:
  call dein#add('Shougo/neosnippet.vim')
  call dein#add('Shougo/neosnippet-snippets')

  " You can specify revision/branch/tag.
  call dein#add('Shougo/deol.nvim', { 'rev': 'a1b5108fd' })
  " call dein#add('Shougo/deoplete.nvim')

  " custom plugins
  call dein#add('tmhedberg/SimpylFold')
  call dein#add('vim-scripts/indentpython.vim')
  " call dein#add('Valloric/YouCompleteMe', {'merged': 0})
  call dein#add('vim-syntastic/syntastic')
  call dein#add('nvie/vim-flake8')
  call dein#add('jnurmine/Zenburn')
  call dein#add('altercation/vim-colors-solarized')
  call dein#add('scrooloose/nerdtree')
  call dein#add('Xuyuanp/nerdtree-git-plugin')
  call dein#add('tpope/vim-fugitive')
  call dein#add('Lokaltog/powerline')
  call dein#add('Shougo/denite.nvim')
  call dein#add('python-mode/python-mode', { 'branch': 'develop' })
  call dein#add('davidhalter/jedi-vim')
  call dein#add('tpope/vim-commentary') 

  call dein#end()
  call dein#save_state()
endif

filetype plugin indent on
syntax enable

" If you want to install not installed plugins on startup.
"if dein#check_install()
"  call dein#install()
"endif

" custom config
"""""""""""""""

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
au BufNewFile,BufRead *.py set textwidth=79
au BufNewFile,BufRead *.py set expandtab
au BufNewFile,BufRead *.py set autoindent
au BufNewFile,BufRead *.py set fileformat=unix

" other indentation
au BufNewFile,BufRead *.js, *.html, *.css
au BufNewFile,BufRead *.js, *.html, *.css set tabstop=2
au BufNewFile,BufRead *.js, *.html, *.css set softtabstop=2
au BufNewFile,BufRead *.js, *.html, *.css set shiftwidth=2

" flag uneccessary whitespace
highlight BadWhitespace ctermbg=red guibg=darkred
au BufRead,BufNewFile *.py,*.pyw,*.c,*.h match BadWhitespace /\s\+$/

" encoding
set encoding=utf-8

" autocompletion
" let g:ycm_path_to_python_interpreter = '/usr/bin/python3'
" let g:ycm_autoclose_preview_window_after_completion=1
" map <leader>g  :YcmCompleter GoToDefinitionElseDeclaration<CR>

"python with virtualenv support
py << EOF
import os
import sys
if 'VIRTUAL_ENV' in os.environ:
  project_base_dir = os.environ['VIRTUAL_ENV']
  activate_this = os.path.join(project_base_dir, 'bin/activate_this.py')
  execfile(activate_this, dict(__file__=activate_this))
EOF

" python highlighting
let python_highlight_all=1
syntax on

" configure schemes
if has('gui_running')
  set background=dark
  colorscheme solarized
else
  colorscheme zenburn
endif
call togglebg#map("<F5>")

" configure nerdtree
let NERDTreeIgnore=['\.pyc$', '\~$'] "ignore files in NERDTree
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
map <leader>n :NERDTreeToggle<CR>

" configure powerline
let g:powerline_pycmd = 'py3'

" configure jedi auto completion
let g:jedi#popup_select_first=1

" configure fugitive git plugin
nmap <leader>gs :Gstatus<CR>
nmap <leader>gl :Glog --format=oneline --<CR>

" use sytem clipboard
set clipboard=unnamed

" line numbers
set rnu

" enable mouse conroles
set mouse=n

" allow virtual editing of 1 char behind end
:set virtualedit=onemore

" remap escape
:imap <SPACE>j <Esc>

" change leader key
map <SPACE> <leader>
set timeoutlen=300

" configure splitting
set splitbelow
set splitright
nnoremap <leader>wv :vsp<CR>
nnoremap <leader>wh :sp<CR>

" split navigations
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>
nnoremap <leader>ww <C-W><C-W>
nnoremap <leader>wd :hide<CR>

" commenting
vmap <leader>; gc
nmap <leader>; gcc

" configure buffer commands
map <leader>bn :new<CR>
map <leader>bs :w<CR>
map <leader>bb :Denite buffer<CR>
map <leader>bd :b#<bar>bd#<CR>

" configure file commands
map <leader>ff :Denite file/rec<CR> 
map <leader>fr :so %<CR>
map <leader>fe :e $HOME/.config/nvim/init.vim<CR>

" configure python-mode
let g:pymode_python = 'python3'

