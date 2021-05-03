" #####################
"
" Vim Config
"
" #####################

" #####################
"
" Vim Plug Setup
"
" #####################
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" Initialize plugin system
call plug#begin('~/.vim/plugged')
  Plug 'christoomey/vim-conflicted'
  Plug 'christoomey/vim-sort-motion'
  Plug 'christoomey/vim-system-copy'
  Plug 'christoomey/vim-tmux-runner'
  Plug 'dense-analysis/ale'
  Plug 'dracula/vim', { 'as': 'dracula' }
  Plug 'jeetsukumaran/vim-buffergator'
  Plug 'jparise/vim-graphql'
  Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
  Plug 'junegunn/fzf.vim'
  Plug 'leafgarland/typescript-vim'
  Plug 'leafoftree/vim-vue-plugin'
  Plug 'michaeljsmith/vim-indent-object'
  Plug 'mustache/vim-mustache-handlebars'
  Plug 'neoclide/coc.nvim', {'branch': 'release'}
  Plug 'pangloss/vim-javascript'
  Plug 'prettier/vim-prettier', { 'do': 'yarn install' }
  Plug 'storyn26383/vim-vue'
  Plug 'thoughtbot/vim-rspec'
  Plug 'tpope/vim-commentary'
  Plug 'tpope/vim-eunuch',
  Plug 'tpope/vim-fugitive', { 'tag': 'v3.1' }
  Plug 'tpope/vim-surround'
call plug#end()

" #####################
"
" VIM CONFIG INDEX
"
"   AUTORESIZE
"   AUTOSAVE
"   AUTO_COMPLETE
"   SPACING AND INDENTATION
"   SWAPFILES
"   SYNTAX HIGHLIGHTING
"
" ERRORS
"
" FILES
"
" FUNCTIONS
"
" DISPLAY
"   SIDEBAR
"   STATUSBAR
"   ZOOM
"
" KEYBINDINGS
"   ALE
"   LINEDIFF
"   PRETTIER
"
" LINTING AND AUTOFORMATTING
"
" LANGUAGE SPECIFIC
"   RUBY
"
" PLUGINS
"   COMMENTARY
"   EMMET
"   FLOG
"   LINEDIFF
"   SWITCH
"   VTR
"
" SEARCH
"
" SNIPPETS
"
" THEME
"
" #####################


" #####################
"
" EDITOR
"
" #####################
"

set showmatch                   " Show matching brackets
set scrolloff=3                 " Scroll when the cursor is 3 lines from edge
set iskeyword+=-                " Treat hyphenated words as text object


  "
  " AUTO_COMPLETE
  "
  set wildmode=list:longest       " Bash-like tab completion
  let g:coc_global_extensions = [
    \ 'coc-tsserver',
    \ 'coc-vetur'
    \ ]

  "
  " AUTOSAVE
  "
  set autowrite                   " Automatically :write before running commands
  set autowriteall                " Save when doing various buffer-switching things.
  autocmd BufLeave,FocusLost * silent! wall  " Save anytime we leave a buffer or MacVim loses focus.

  "
  " AUTORESIZE
  "
  autocmd VimResized * :wincmd =

  "
  " BUFFERS
  "
  set hidden                      " Allow hidden, unsaved buffers

  " SPACING AND INDENTATION
  "
  set tabstop=2               " number of visual spaces per TAB
  set softtabstop=2           " number of spaces in tab when editing
  set expandtab               " tabs are spaces
  set shiftwidth=2            " '>' use 2 spaces for indenting
  set autoindent
  set smarttab                " Use shiftwidth to tab at line beginning
  set nowrap                  " No wrapping
  set list                    " Show whitespace
  set listchars=tab:»·,trail:·,nbsp:·    " Display extra whitespace
  set nojoinspaces            " Use one space, not two, after punctuation.
  

  "
  " SCREEN SPLITTING
  "
  set splitright                  " Add new windows towards the right
  set splitbelow                  " ... and bottom

  "
  " SWAPFILES
  "
  set swapfile                    " Keep swapfiles
  set undofile                    " Keep undo history
  set directory=~/.vim-tmp,~/tmp,/var/tmp,/tmp
  set backupdir=~/.vim-tmp,~/tmp,/var/tmp,/tmp
  set undodir=~/.vim-tmp,~/tmp,/var/tmp,/tmp
  set history=1024                " History size

  "
  " SYNTAX HIGHLIGHTING
  "
  autocmd BufEnter *.{js,jsx,ts,tsx,vue} :syntax sync fromstart
  autocmd BufLeave *.{js,jsx,ts,tsx,vue} :syntax sync clear

" #####################
"
" ERRORS
"
" #####################

highlight link sensibleWhitespaceError Error
autocmd Syntax * syntax match sensibleWhitespaceError excludenl /\s\+\%#\@<!$\| \+\ze\t/ display containedin=ALL


" #####################
"
" FILES
"
" #####################

" Tweaks for browsing
let g:netrw_banner=0         " disable annoying banner
let g:netrw_browse_split=0   " open in current window
let g:netrw_altv=1           " open splits to the right
let g:netrw_liststyle=3      " tree view
let g:netrw_list_hide=netrw_gitignore#Hide()
let g:netrw_list_hide.=',/(^\/\s\s\)\zs\.\S\+'
let g:netrw_sizestyle="H"
let g:netrw_keepdir=0        " Copying files on Mac OS

" Fuzzy Finder
set rtp+=~/.fzf
nnoremap <C-p> :Files<CR>
nnoremap <Leader>b :Buffers<CR>
nnoremap <Leader>h :History<CR>
nnoremap <Leader>t :BTags<CR>
nnoremap <Leader>T :Tags<CR>
" Search using word under cursor
nnoremap g* :Rg <C-R><C-W><CR>
let g:fzf_layout = { 'down': '~40%' }

augroup vimrcEx
  autocmd!
  " When editing a file, always jump to the last known cursor position.
  " Don't do it for commit messages, when the position is invalid, or
  " when inside an event handler (happens when dropping a file on gvim).
  autocmd BufReadPost *
    \ if &ft != 'gitcommit' && line("'\"") > 0 && line("'\"") <= line("$") |
      \   exe "normal g`\"" |
    \ endif
augroup END

" #####################
"
" FUNCTIONS
"
" #####################

" User with something like this: :%s/subscriber_\zs\d\+/\=Incremental()/g
fu! Incremental()
  let g:index = g:index + 1
  return g:index
endfu

" #####################
"
" DISPLAY
"
" #####################

set guioptions-=T               " Remove GUI toolbar
set guioptions-=e               " Use text tab bar, not GUI
set guioptions-=rL              " Remove scrollbars
set visualbell                  " Suppress audio/visual error bell

highlight OverLength ctermbg=red ctermfg=white guibg=blue
match OverLength /\%101v.\+/
set colorcolumn=90
set cursorline                  " Highlight current line
set cursorcolumn                " Highlight current column

  "
  " SIDEBAR
  "
  set number relativenumber
  set numberwidth=5

  "
  " STATUSBAR
  "
  set ruler
  set showcmd                     " Show typed command prefixes while waiting for operator
  set statusline=[%n]\ %f\ %m\ %y
  set statusline+=%{fugitive#statusline()} " Show git details"
  set statusline+=%w              " [Preview]
  set statusline+=%=              " Left/right separator
  set statusline+=%c,             " Cursor column
  set statusline+=%l/%L           " Cursor line/total lines
  set statusline+=\ %P            " Percent through file
  set laststatus=2                " Always show statusline

  " ZOOM
  nnoremap <localleader>- :wincmd _<cr>:wincmd \|<cr>
  nnoremap <localleader>= :wincmd _<cr>:wincmd =<cr>


" #####################
"
" HELP
"
" #####################

" Load all plugins now.
" Plugins need to be added to runtimepath before helptags can be generated.
packloadall
" Load all of the helptags now, after plugins have been loaded.
" All messages and errors will be ignored.
silent! helptags ALL


" #####################
"
" KEYBINDINGS
"
" #####################


let mapleader = ","
let maplocalleader = ";"
" Make Y consistent with D and C
map Y           y$
" Insert a single character in normal mode
nnoremap <C-I> i_<Esc>r

" Search
nmap <localleader>s  :%s/
vmap <localleader>s  :s/

" Use  for saving, also in Insert mode
noremap <localleader>w :w<CR>
inoremap <localleader>w <Esc>:w<CR>a
noremap <localleader>wq :wq<CR>
inoremap <localleader>wq <Esc>:wq<CR>a
noremap <localleader>q :q<CR>
inoremap <localleader>q <Esc>:q

" Use CTRL-S for saving, also in Insert mode
noremap <C-s> :update<CR>
vnoremap <C-s> <C-C>:update<CR>
inoremap <C-s> <C-o>:update<CR>

" Split screen
map <leader>v   :vsp<CR>
map <leader>h   :split<CR>

" Move between screens
map <leader>w   <C-w>w
map <leader>=   ^W=
map <leader>j   ^Wj
map <leader>k   ^Wk
nmap <C-j>      <C-w>j
nmap <C-k>      <C-w>k
nmap <C-h>      <C-w>h
nmap <C-l>      <C-w>l

" Open .vimrc file in new tab. Think Command + , [Preferences...] but with Shift.
map <D-<>       :tabedit ~/.vimrc<CR>

" Reload .vimrc
map <leader>rv  :source ~/.vimrc<CR>

" Git commit message settings
autocmd Filetype gitcommit setlocal spell textwidth=72

" Auto-indent whole file
nmap <leader>=  gg=G``
map <silent> <F7> gg=G``:echo "Reformatted."<CR>

" Fast scrolling
nnoremap <C-e>  3<C-e>
nnoremap <C-y>  3<C-y>


" Previous/next quickfix file listings (e.g. search results)
map <M-D-Down>  :cn<CR>
map <M-D-Up>    :cp<CR>

" Previous/next buffers
map <M-D-Left>  :bp<CR>
map <M-D-Right> :bn<CR>

"indent/unindent visual mode selection with tab/shift+tab
vmap <tab> >gv
vmap <S-tab> <gv

" FuzzyFinder and switchback commands
map <leader>e   :e#<CR>
map <leader>b   :FufBuffer<CR>
map <leader><C-N> :FufFile **/<CR>
map <D-e> :FufBuffer<CR>
map <leader>n :FufFile **/<CR>
map <D-N> :FufFile **/<CR>

" refresh the FuzzyFinder cache
map <leader>rf :FufRenewCache<CR>

" Command-T
map <D-N>       :CommandTFlush<CR>:CommandT<CR>
map <leader>f   :CommandTFlush<CR>:CommandT<CR>

" Normal Mode
" ------------- Mappings to move lines ------------- "
nnoremap <C-j> :m .+1<CR>==
nnoremap <C-k> :m .-2<CR>==

" Insert mode
inoremap <C-j> <ESC>:m .+1<CR>==gi
inoremap <C-k> <ESC>:m .-2<CR>==gi

" Visual mode
vnoremap <C-j> :m '>+1<CR>gv=gv
vnoremap <C-k> :m '<-2<CR>gv=gv


" ctags with rails load path
map <leader>rt  :!rails runner 'puts $LOAD_PATH.join(" ")' \| xargs /usr/local/bin/ctags -R public/javascripts<CR>
map <leader>T   :!rails runner 'puts $LOAD_PATH.join(" ")' \| xargs rdoc -f tags<CR>

" Git blame
map <leader>g   :Gblame<CR>

set backspace=indent,eol,start  " Let backspace work over anybhing.

" Switch between the last two files
nnoremap <Leader><Leader> <C-^>

" Get off my lawn
nnoremap <Left> :echoe "Use h"<CR>
nnoremap <Right> :echoe "Use l"<CR>
nnoremap <Up> :echoe "Use k"<CR>
nnoremap <Down> :echoe "Use j"<CR>

" COC - Use <Tab> and <S-Tab> to navigate the completion list
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" COC - Use <cr> to confirm completion
" inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm() : "\<C-g>u\<CR>"

" COC - " use <c-space>for trigger completion
inoremap <silent><expr> <c-space> coc#refresh()

" SPELL-CHECK CONFIGURATION
map <F6> :setlocal spell! spelllang=en_us<CR>

  "
  " ALE
  "
  nnoremap <leader>p :ALEFix<CR>
  nnoremap ]r :ALENextWrap<CR>
  nnoremap [r :ALEPreviousWrap<CR>
   
  "
  " LINEDIFF
  "
  noremap <localleader>ldt :Linediff<CR>
  noremap <localleader>ldo :LinediffReset<CR>

  "
  " PRETTIER
  "
  nmap <localleader>p <Plug>(Prettier)

  "
  " SWITCH
  "
  let g:switch_mapping = "gt"

  "
  " VTR
  "
  nnoremap <leader>irb :VtrOpenRunner {'orientation': 'h', 'percentage': 50, 'cmd': 'irb'}<cr>
  nnoremap <leader>rc :VtrOpenRunner {'orientation': 'h', 'percentage': 50, 'cmd': 'rails console'}<cr>
  let g:rspec_command = "VtrSendCommandToRunner! bundle exec rspec --format documentation {spec}"
  map <leader>rt :call RunCurrentSpecFile()<CR>
  map <leader>rs :call RunNearestSpec()<CR>
  map <leader>rl :call RunLastSpec()<CR>
  map <leader>ra :call RunAllSpecs()<CR>
  nnoremap <leader>rf :VtrSendCommandToRunner! bundle exec rspec --format documentation --tag focus <cr>

  " #####################
  "
  " LINTING AND AUTOFORMATTING
  "
  " #####################

" Disable auto-comment new line after existing comment
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

" Ale Configuration
let g:ale_sign_warning = '.'
let g:ale_lint_on_enter = 0 " Less distracting when opening a new file

" Specify what text should be used for signs
let g:ale_sign_error = '✘'
let g:ale_sign_warning = '⚠'
highlight ALEErrorSign ctermbg=NONE ctermfg=red
highlight ALEWarningSign ctermbg=NONE ctermfg=yellow

" Colors can be customised, or even removed completely
" highlight clear ALEErrorSign
" highlight clear ALEWarningSign

" Show errors or warnings in my statusline
let g:airline#extensions#ale#enabled = 1

" Specific linters and aliases
let g:ale_linters = {'html': ['tidy']}
let g:ale_linters = {'javascript': ['eslint']}
let g:ale_linter_aliases = {'vue': ['vue', 'javascript']}
let g:ale_linters = {'vue': ['eslint', 'vls']}
let g:ale_linter_aliases = {'svelte': ['css', 'javascript']}
let g:ale_linters = {'svelte': ['stylelint', 'eslint']}

let g:ale_html_tidy_executable = "/usr/local/bin/tidy"

let g:ale_fixers = {
\   'css' : ['prettier'],
\   'scss' : ['prettier'],
\   'html' : ['tidy', 'prettier'],
\   'javascript': ['prettier_standard', 'eslint'],
\   'json': ['prettier_standard', 'eslint'],
\   'ruby': ['rubocop'],
\   'svelte': ['prettier_standard', 'eslint'],
\   'vue': ['prettier_standard', 'eslint'],
\   '*': ['remove_trailing_lines', 'trim_whitespace'],
\}

" Configure LanguageClient to use vls
let g:LanguageClient_serverCommands = {
\ 'vue': ['vls']
\ }

" Testing settings
let g:jsc_ext_required = 0
let g:ale_lint_on_enter = 0
let g:ale_lint_on_text_changed = 'never'

" #####################
"
" LANGUAGE SPECIFIC
"
" #####################

  "
  "   RUBY
  " Turn off ri tooltips that don't work with Ruby 1.9 yet
  " http://code.google.com/p/macvim/issues/detail?id=342
  if has("gui_running")
    set noballooneval
  endif

  runtime macros/matchit.vim


" #####################
"
" PLUGINS
"
" #####################

  "
  " COMMENTARY
  "
  autocmd FileType blade setlocal commentstring={{--  %s --}}
  autocmd FileType blade setlocal commentstring={{#  %s #}}

  "
  " EMMET
  "
  let user_emmet_expandabbr_key = '<c-e>'

  "
  " FLOG
  "

  "
  " LINEDIFF
  "
     let g:linediff_further_buffer_command = 'new'


" #####################
"
" SEARCH
"
" #####################

set ignorecase                  " So search is only case sensistive when uppercase is provided
set incsearch                   " Incremental search
set smartcase                   " Smart case-sensitivity when searching (overrides ignorecase)
set hlsearch

" Space to turn off highlighting
nnoremap <silent> <Space> :nohlsearch<Bar>:echo<CR>""

" #####################
"
" SNIPPETS
"
" #####################


" #####################
"
" THEME
"
" #####################

" syntax on
syntax enable
set t_Co=256
let g:dracula_italic = 0
colorscheme dracula
highlight Normal ctermbg=None






" Machine-local vim settings - keep this at the end
" ---------------------------
silent! source ~/.vimrc.local

