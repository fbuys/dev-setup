" #####################
"
" Vim Config
"
" #####################

" #####################
" Pluggins (Vim Plug)
" #####################
"
" Taken from: https://github.com/junegunn/vim-plug/wiki/tips#tips
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs 
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin(stdpath('data') . '/plugged')
  Plug 'christoomey/vim-conflicted' " helps resolve merge conflicts
  Plug 'christoomey/vim-sort-motion' " adds gss for sorting
  Plug 'dense-analysis/ale' " adds code linting and fixing
  Plug 'dracula/vim', { 'as': 'dracula' } " nice colorscheme
  Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' } " file search
  Plug 'junegunn/fzf.vim' " file search
  Plug 'kassio/neoterm' " makes it easy to use the nvim terminal
  Plug 'michaeljsmith/vim-indent-object' " add ii for managing indented parts
  Plug 'neoclide/coc.nvim', {'branch': 'release'} " coc
  Plug 'pangloss/vim-javascript'    " JavaScript support
  Plug 'prettier/vim-prettier', { 'do': 'yarn install' }
  Plug 'tpope/vim-commentary' " gcc for commenting
  Plug 'tpope/vim-eunuch',
  Plug 'tpope/vim-fugitive'
  Plug 'tpope/vim-rails'
  Plug 'tpope/vim-surround'
  Plug 'vim-crystal/vim-crystal' " support crystal lang
  Plug 'vim-ruby/vim-ruby'
  Plug 'vim-test/vim-test'
  Plug 'tyru/open-browser.vim' " Open URI from VIM
  Plug 'tyru/open-browser-github.vim' " Lauch github from VIM
  Plug 'tpope/vim-endwise' " adds end in ruby
call plug#end()
" call plug#begin(stdpath('data') . '/plugged')
"   Plug 'jparise/vim-graphql'        " GraphQL syntax
"   Plug 'leafgarland/typescript-vim' " TypeScript syntax
"   Plug 'maxmellon/vim-jsx-pretty'   " JS and JSX syntax
" call plug#end()

" #####################
" Settings
" #####################

" leader key
let mapleader = ","
let maplocalleader = ";"

" #####################
" Buffers
" #####################
" Alternate buffers
nnoremap <Leader><Leader> <C-^>

" #####################
" Appearance
" #####################
syntax enable
set t_Co=256
let g:dracula_italic = 0
colorscheme dracula
highlight Normal ctermbg=None
set re=0

" #####################
" EDITOR
" #####################
set path+=**                " Include subfolders
highlight OverLength ctermbg=red ctermfg=white guibg=blue
match OverLength /\%91v.\+/ " warn when length > 90
set colorcolumn=90          " Highlight max column
set number relativenumber   " line numbers
set numberwidth=5           " line numbers padding
set tabstop=2               " number of visual spaces per TAB
set softtabstop=2           " number of spaces in tab when editing
set expandtab               " tabs are spaces
set shiftwidth=2            " '>' use 2 spaces for indenting
set autoindent
set smarttab                " Use shiftwidth to tab at line beginning
set nowrap                  " No wrapping
set list                    " Show whitespace
set nojoinspaces            " Use one space, not two, after punctuation.
map <F6> :setlocal spell! spelllang=en_gb<CR>
set cursorline
set cursorcolumn

" AUTOSAVE

set autowrite " Automatically :write before running commands
set autowriteall " Save when doing various buffer-switching things.
autocmd BufLeave,FocusLost * silent! wall  " Save anytime we leave a buffer or MacVim loses focus.

" #####################
" Terminal
" #####################
set nocompatible
filetype off

" let &runtimepath.=',~/.vim/bundle/neoterm'

filetype plugin indent on

let g:neoterm_default_mod = 'botright vertical'
nmap <silent> <leader>to :Topen<CR>
nmap <silent> <leader>tc :Tclose<CR>

if has('nvim')
  tnoremap <Esc> <C-\><C-n>
  tnoremap <C-w>h <C-\><C-n><C-w>h
  tnoremap <C-w>j <C-\><C-n><C-w>j
  tnoremap <C-w>k <C-\><C-n><C-w>k
  tnoremap <C-w>l <C-\><C-n><C-w>l
endif

" #####################
" LINTING AND AUTOFORMATTING
" #####################
" Disable auto-comment new line after existing comment
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

nnoremap <leader>p :ALEFix<CR>
nmap <localleader>p <Plug>(Prettier)

" when to lint
let g:ale_lint_on_text_changed = 0
let g:ale_lint_on_enter = 1
let g:ale_lint_on_save = 1
let g:ale_lint_on_filetype_changed = 1

nmap <silent> <leader>aj :ALENext<cr>
nmap <silent> <leader>ak :ALEPrevious<cr>

let g:ale_sign_error = '❌'
let g:ale_sign_warning = '⚠️ '

let g:ale_linters = {
\   'crystal': ['ameba'],
\   'ruby': ['rubocop', 'standardrb'],
\   'javascript': ['flow', 'eslint'],
\   'python': ['flake8', 'pylint'],
\}

let g:ale_fixers = {
\   '*': ['remove_trailing_lines', 'trim_whitespace'],
\   'crystal': ['crystal_format'],
\   'css': ['prettier'],
\   'javascript': ['prettier', 'prettier_standard', 'eslint'],
\   'json': ['prettier', 'prettier_standard', 'eslint'],
\   'ruby': ['rubocop', 'standardrb'],
\   'typescript': ['prettier', 'prettier_standard', 'eslint'],
\   'typescriptreact': ['prettier', 'prettier_standard', 'eslint'],
\}

augroup markdown
  au!
  au FileType markdown set wrap
augroup END

" --- Mappings to move lines --- "
nnoremap <C-j> :m .+1<CR>==
nnoremap <C-k> :m .-2<CR>==
inoremap <C-j> <ESC>:m .+1<CR>==gi
inoremap <C-k> <ESC>:m .-2<CR>==gi
vnoremap <C-j> :m '>+1<CR>gv=gv
vnoremap <C-k> :m '<-2<CR>gv=gv
" ------------------------------ "

" #####################
" SEARCH
" #####################
set ignorecase
set incsearch
set smartcase
set hlsearch

" Space to turn off highlighting
nnoremap <silent> <Space> :nohlsearch<Bar>:echo<CR>""

" Undo 
set undofile
set undodir=~/.config/nvim/undo
set undolevels=10000

" hjkl for the win
noremap <Up> :echo "Use k"<CR>
noremap <Down> :echo "Use j"<CR>
noremap <Left> :echo "Use h"<CR>
noremap <Right> :echo "Use l"<CR>

" use system clipboard
set clipboard+=unnamedplus

" open file under cursor
nnoremap gX :silent :execute
            \ "!open" expand('%:p:h') . "/" . expand("<cfile>") " &"<cr>
" Use  for saving, also in Insert mode
noremap <localleader>w :w<CR>
noremap <localleader>wq :wq<CR>
noremap <localleader>q :q<CR>
inoremap <localleader>w <Esc>:w<CR>a
inoremap <localleader>wq <Esc>:wq<CR>a
inoremap <localleader>q <Esc>:q

" Fuzzy Finder
set rtp+=~/.fzf
nnoremap <C-p> :Files<CR>
nnoremap <Leader>f :Files<CR>
nnoremap <Leader>b :Buffers<CR>
nnoremap <Leader>h :History<CR>
nnoremap <Leader>t :BTags<CR>
nnoremap <Leader>T :Tags<CR>
let g:fzf_layout = { 'down': '~40%' }

" search word under cursor
nnoremap g* :Rg <C-R><C-W><CR> 

" CRTL-A to select all
let $FZF_DEFAULT_OPTS = '--bind ctrl-A:select-all'

" #####################
" CTags
" #####################
nnoremap <leader>tt :silent !ctags -R . <CR>:redraw!<CR>

" #####################
" COC
" #####################
set wildmode=list:longest       " Bash-like tab completion
set updatetime=300
set shortmess+=c

let g:coc_global_extensions = [
    \ 'coc-flow',
    \ 'coc-solargraph',
    \ 'coc-tsserver',
  \ ]

inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()

inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use leader T to show documentation in preview window
nnoremap <leader>cp :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['nvim','help'], &filetype) >= 0)
    execute 'h '.expand('&lt;cword&gt;')
  else
    call CocAction('doHover')
  endif
endfunction

" inoremap <expr> <Tab> pumvisible() ? coc#_select_confirm() : "<Tab>"
" Remap keys for applying codeAction to the current line.
inoremap <leader>ca  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
inoremap <leader>cf  <Plug>(coc-fix-current)
" GoTo code navigation.
inoremap <leader>cd <Plug>(coc-definition)
inoremap <leader>ci <Plug>(coc-implementation)
inoremap <leader>ct <Plug>(coc-type-definition)
inoremap <leader>cr <Plug>(coc-references)

" #####################
" TESTS
" #####################
let test#strategy = "neovim"
let test#neovim#term_position = "vert botright 50"
nmap <silent> <leader>rs :TestNearest<CR>
nmap <silent> <leader>rt :TestFile<CR>
nmap <silent> <leader>ra :TestSuite<CR>
nmap <silent> <leader>rl :TestLast<CR>
nmap <silent> <leader>rg :TestVisit<CR>
nmap <silent> <leader>rf :TestSuite --only-failures<CR>
let g:test#runner_commands = ['RSpec']

" #####################
" Zettelkasten
" #####################
let g:zettelfolder = "$HOME/git/github.com/buys-fran/francois/Zettelkasten/"
function! XNewZettel(file)
  let filename = fnameescape(a:file)
  let filename = tolower(filename)
  let filename = substitute(filename, " ", "_", "g")
  execute ":e" g:zettelfolder . strftime("%Y%m%d%H%M") . "_" . filename . ".md"
endfunction
command! -nargs=1 NewZettel :call XNewZettel(<f-args>)
command! -nargs=1 NewZettel :execute ":e" zettelfolder . strftime("%Y%m%d%H%M") . "-<args>.md"

function! HandleFZF(file)
    "let filename = fnameescape(fnamemodify(a:file, ":t"))
    let filename = fnameescape(a:file)
    let filename_wo_timestamp = fnameescape(fnamemodify(a:file, ":t:s/^[0-9]*-//"))
    let mdlink = "[ ".filename_wo_timestamp." ]( ".filename." )"
    put=mdlink
endfunction
command! -nargs=1 HandleFZF :call HandleFZF(<f-args>)

nnoremap <leader>zn :NewZettel 
nnoremap <leader>zl:call fzf#run({'sink': 'HandleFZF'})<CR>
inoremap <C-L> <ESC>:call fzf#run({'sink': 'HandleFZF'})<CR>
