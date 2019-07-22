
" TODO when installing:
" * install pip packages for flake8 and yapf


if &compatible
    set nocompatible
endif

" Load packager only when you need it
function! PackagerInit() abort
    packadd vim-packager
    call packager#init()
    call packager#add('kristijanhusak/vim-packager', { 'type': 'opt' })

    """"
    " packages that should always be active
    """"
    call packager#add('tmhedberg/SimpylFold')
    call packager#add('W0rp/ale')
    " call packager#add('vim-vdebug/vdebug')
    call packager#add('scrooloose/nerdtree')
    call packager#add('Xuyuanp/nerdtree-git-plugin')
    call packager#add('airblade/vim-gitgutter')
    call packager#add('vim-airline/vim-airline')
    call packager#add('vim-airline/vim-airline-themes')
    call packager#add('ctrlpvim/ctrlp.vim')
    call packager#add('tpope/vim-commentary')
    " call packager#add('christoomey/vim-tmux-navigator')
    call packager#add('qpkorr/vim-bufkill')

    """"
    " packages that should be loaded on demand
    """"
    " colortheme
    call packager#add('joshdick/onedark.vim', {'type': 'opt'})
    " python packages
    call packager#add('davidhalter/jedi-vim', { 'type': 'opt'})
    call packager#add('vim-scripts/indentpython.vim', { 'type': 'opt'})

endfunction

command! PackagerInstall call PackagerInit() | call packager#install()
command! -bang PackagerUpdate call PackagerInit() | call packager#update({ 'force_hooks': '<bang>' })
command! PackagerClean call PackagerInit() | call packager#clean()
command! PackagerStatus call PackagerInit() | call packager#status()

"Load plugins only for specific filetype
augroup packager_filetype
    autocmd!
    autocmd FileType python packadd jedi-vim
    autocmd FileType python packadd indentpython.vim
augroup END


"""""""""""""""
" custom config
"""""""""""""""

" plugin config
""""""""""""""""

" python highlighting
let python_highlight_all=1
syntax on

" let g:ale_completion_enabled = 1
let g:ale_python_yapf_executable = 'yapf3'
let g:ale_linters = {'python': ['flake8']}
let g:ale_fixers = {'python': ['remove_trailing_lines', 'trim_whitespace', 'yapf']}
let g:ale_lint_on_save = 1
"
" configure nerdtree
let NERDTreeIgnore=['\.pyc$', '\~$'] "ignore files in NERDTree
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

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

" configure ctrlp
let g:ctrlp_custom_ignore = '\v[\/]\.(git|hg|svn)$'
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v([\/]\.(git|hg|svn))|(machinel_datasets)$',
  \ 'file': '\v\.(exe|so|dll|html)$',
  \ 'link': 'some_bad_symbolic_links',
  \ }


" vim editor config
"""""""""""""""""""

" change cursor shapes
let $NVIM_TUI_ENABLE_CURSOR_SHAPE = 1
let &t_SI = "\<esc>[5 q"
let &t_SR = "\<esc>[3 q"
let &t_EI = "\<esc>[2 q"

" color scheme
set background=dark
packadd onedark.vim
colorscheme onedark

filetype plugin indent on
syntax enable

set expandtab
set autoindent
set fileformat=unix
set encoding=utf-8
" system clipboard plus
set clipboard=unnamedplus
" line numbers
set nu
" enable mouse conroles
set mouse=n

" Enable folding
set foldmethod=indent
set foldlevel=9
let g:SimpylFold_docstring_preview=1
" Enable folding with the spacebar
" nnoremap <space> za

" flag uneccessary whitespace
highlight BadWhitespace ctermbg=red guibg=darkred
au BufRead,BufNewFile *.py,*.pyw,*.c,*.h match BadWhitespace /\s\+$/

" remove trailing whitespace on save
autocmd BufWritePre * :%s/\s\+$//e


" keymapping config
"""""""""""""""""""

" change leader key
map ; <leader>
set timeoutlen=300

" configure splitting
set splitbelow
set splitright
nnoremap <leader>wv :vsp<CR>
nnoremap <leader>wh :sp<CR>

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
map <leader>t :NERDTreeToggle<CR>

" copy and paste a word
nmap <leader>c  viw"xy
nmap <leader>v  viw"xp

" copy and paste a line
nmap <leader>C V"ly
nmap <leader>V V"lp

" map ale commands
nmap <leader>af :ALEFix<CR>
