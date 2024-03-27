" Disable vi compat
set nocompatible

" Enable filetype detection
filetype on

" Enable plugins and load plugins for filetype
filetype plugin on

" Load an indent file for filetype
filetype indent on

" Syntax highlight
syntax on

" spell check
set spell"
set spelllang=en_us

" Line nos
set relativenumber

" Highlight cursor line
set cursorline


set shiftwidth=4
set tabstop=4
set expandtab

set nobackup
set scrolloff=10

set nowrap
set incsearch
set ignorecase
set smartcase
set showcmd

set showmode
set showmatch

set hlsearch
set history=1000

set wildmenu
set wildmode=list:longest

set wildignore=*.docx,*.jpg,*.png,*.gif,*.pdf,*.pyc,*.exe,*.flv,*.img,*.xlsx

colorscheme molokai

" PLUGINS ---------------------------------------------------------------- {{{
call plug#begin()
Plug 'tpope/vim-sensible'
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'preservim/nerdcommenter'
Plug 'lervag/vimtex'
Plug 'matze/vim-tex-fold'
call plug#end()

" UltiSnips {{{
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsListSnipepts="<c-tab>"
let g:UltiSnipsJumpForwardTrigger="<c-j>"
let g:UltiSnipsJumpBackwardTrigger="<c-k>"
let g:UltiSnipsEditSplit="vertical"
" }}}
"
" VimTex {{{
let g:tex_flavor = "latex"
let g:vimtex_view_method = 'sioyek'
let g:vimtex_compiler_latexmk = {
        \ 'executable' : 'latexmk',
        \ 'options' : [
        \   '-lualatex',
        \   '-file-line-error',
        \   '-synctex=1',
        \   '-interaction=nonstopmode',
        \ ],
        \}
let g:tex_fold_enabled = 0
let g:vimtex_fold_enabled = 1
let g:vimtex_fold_types = {
        \ 'preamble' : {'enabled':1},
        \ 'comments' : {'enabled' : 1},
        \ 'envs' : {
        \   'blacklist' : [],
        \   'whitelist' : [],
        \ },
        \ 'env_options' : {},
        \ 'markers' : {},
        \ 'sections' : {
        \   'parse_levels' : 1,
        \   'sections' : [
        \     'part',
        \     'chapter',
        \     'section',
        \     'subsection',
        \     'subsubsection',
        \   ],
        \   'parts' : [
        \     'appendix',
        \     'frontmatter',
        \     'mainmatter',
        \     'backmatter',
        \   ],
        \ }
        \}
let g:vimtex_fold_manual = 1

" NerdComment{{{

" Add spaces after comment delimiters by default
let g:NERDSpaceDelims = 1

" Use compact syntax for prettified multi-line comments
let g:NERDCompactSexyComs = 1

" Align line-wise comment delimiters left instead of code indentation
let g:NERDDefaultAlign = 'left'

" Set a language to use its alternate delimiters by default
let g:NERDAltDelims_java = 1

" Add your own custom formats or override the defaults
let g:NERDCustomDelimiters = { 'c': { 'left': '/**','right': '*/' } }

" Allow commenting and inverting empty lines (when commenting a region)
let g:NERDCommentEmptyLines = 1

" Enable trimming of trailing whitespace when uncommenting
let g:NERDTrimTrailingWhitespace = 1

" }}}

" }}}

" MAPPINGS --------------------------------------------------------------- {{{

" Mappings code goes here.
inoremap jk <esc>
let mapleader = ","
nnoremap <leader><leader> :nohlsearch<CR>

" Press the space bar to type the : character in command mode.
nnoremap <space> :

" Pressing the letter o will open a new line below the current one.
" Exit insert mode after creating a new line above or below the current line.
nnoremap o o<esc>
nnoremap O O<esc>

" Center the cursor vertically when moving to the next word during a search.
nnoremap n nzz
nnoremap N Nzz

" Yank from cursor to the end of line.
nnoremap Y y$

nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <c-h> <c-w>h
nnoremap <c-l> <c-w>l

noremap <c-up> <c-w>+
noremap <c-down> <c-w>-
noremap <c-left> <c-w>>
noremap <c-right> <c-w><

" }}}


" VIMSCRIPT -------------------------------------------------------------- {{{

" This will enable code folding.
" Use the marker method of folding.
augroup filetype_vim
    autocmd!
    autocmd FileType vim setlocal foldmethod=marker
augroup END

" More Vimscripts code goes here.

" }}}


" STATUS LINE ------------------------------------------------------------ {{{

" Status bar code goes here.

" }}}
