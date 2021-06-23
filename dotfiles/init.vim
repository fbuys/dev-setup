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
  Plug 'christoomey/vim-sort-motion'
  Plug 'dense-analysis/ale'
  Plug 'dracula/vim', { 'as': 'dracula' }
  Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
  Plug 'junegunn/fzf.vim'
  Plug 'michaeljsmith/vim-indent-object'
  Plug 'neoclide/coc.nvim', {'branch': 'release'}
  Plug 'pangloss/vim-javascript'    " JavaScript support
  Plug 'leafgarland/typescript-vim' " TypeScript syntax
  Plug 'maxmellon/vim-jsx-pretty'   " JS and JSX syntax
  Plug 'jparise/vim-graphql'        " GraphQL syntax
  Plug 'prettier/vim-prettier', { 'do': 'yarn install' }
  Plug 'tpope/vim-commentary'
  Plug 'tpope/vim-eunuch',
  Plug 'tpope/vim-fugitive'
  Plug 'tpope/vim-surround'
call plug#end()

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

" AUTOSAVE

set autowrite " Automatically :write before running commands
set autowriteall " Save when doing various buffer-switching things.
autocmd BufLeave,FocusLost * silent! wall  " Save anytime we leave a buffer or MacVim loses focus.

" #####################
" LINTING AND AUTOFORMATTING
" #####################
" Disable auto-comment new line after existing comment
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o
nmap <localleader>p <Plug>(Prettier)

nnoremap <leader>p :ALEFix<CR>
let g:ale_fixers = {
\   '*': ['remove_trailing_lines', 'trim_whitespace'],
\   'javascript': ['prettier', 'prettier_standard', 'eslint'],
\   'json': ['prettier', 'prettier_standard', 'eslint'],
\   'ruby': ['rubocop'],
\   'typescript': ['prettier', 'prettier_standard', 'eslint'],
\   'typescriptreact': ['prettier', 'prettier_standard', 'eslint'],
\}

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

" leader key
let mapleader = ","
let maplocalleader = ";"

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
inoremap <localleader>w <Esc>:w<CR>a
noremap <localleader>wq :wq<CR>
inoremap <localleader>wq <Esc>:wq<CR>a
noremap <localleader>q :q<CR>
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

" #####################
" CTags
" #####################
nnoremap <leader>tt :silent !ctags -R . <CR>:redraw!<CR>

" #####################
" COC
" #####################
set wildmode=list:longest       " Bash-like tab completion
let g:coc_global_extensions = [
    \ 'coc-tsserver',
  \ ]
inoremap <expr> <Tab> pumvisible() ? coc#_select_confirm() : "<Tab>"
" Remap keys for applying codeAction to the current line.
inoremap <leader>ca  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
inoremap <leader>cf  <Plug>(coc-fix-current)
" GoTo code navigation.
inoremap <leader>cd <Plug>(coc-definition)
inoremap <leader>ct <Plug>(coc-type-definition)
inoremap <leader>ci <Plug>(coc-implementation)
inoremap <leader>cr <Plug>(coc-references)

" #####################
" Zettelkasten
" #####################
let g:zettelfolder = "/Users/Francois/git/gitlab.com/buysfran/francois/Zettelkasten/"
function! XNewZettel(file)
  let filename = fnameescape(a:file)
  let filename = tolower(filename)
  let filename = substitute(filename, " ", "_", "g")
  execute ":e" g:zettelfolder . strftime("%Y%m%d%H%M") . "_" . filename . ".md"
endfunction
command! -nargs=1 NewZettel :call XNewZettel(<f-args>)
" command! -nargs=1 NewZettel :execute ":e" zettelfolder . strftime("%Y%m%d%H%M") . "-<args>.md"

function! HandleFZF(file)
    "let filename = fnameescape(fnamemodify(a:file, ":t"))
    let filename = fnameescape(a:file)
    let filename_wo_timestamp = fnameescape(fnamemodify(a:file, ":t:s/^[0-9]*-//"))
    let mdlink = "[ ".filename_wo_timestamp." ]( ".filename." )"
    put=mdlink
endfunction
command! -nargs=1 HandleFZF :call HandleFZF(<f-args>)

nnoremap <leader>nz :NewZettel 
nnoremap <leader>lz :call fzf#run({'sink': 'HandleFZF'})<CR>
inoremap <C-L> <ESC>:call fzf#run({'sink': 'HandleFZF'})<CR>
