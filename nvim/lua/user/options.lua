-- vim.cmd [[set formatoptions-=cro]]           -- TODO: this doesn't seem to work
vim.opt.autowrite = true                        -- auto save before running commands
vim.opt.autowriteall = true                     -- auto save before switching buffers etc.
vim.opt.backup = false                          -- creates a backup file
vim.opt.clipboard = "unnamedplus"               -- use system clipboard
vim.opt.cmdheight = 2                           -- lines used for command line
vim.opt.colorcolumn = "90"                      -- column as max length guide
vim.opt.completeopt = { "menuone", "noselect" } -- completion setting
vim.opt.conceallevel = 0                        -- show `` in markdown files
vim.opt.cursorcolumn = true                     -- highlight current column
vim.opt.cursorline = true                       -- highlight the current line
vim.opt.expandtab = true                        -- convert tabs to spaces
vim.opt.fileencoding = "utf-8"                  -- encoding
vim.opt.guifont = "monospace:h17"               -- the font used in graphical neovim applications
vim.opt.hlsearch = true                         -- highlight all matches
vim.opt.ignorecase = true                       -- ignore case in search patterns
vim.opt.incsearch = true                        -- highlight while searching
vim.opt.iskeyword:append "-"                    -- words with - treated as one word
vim.opt.list = true                             -- show whitespace
vim.opt.number = true                           -- set numbered lines
vim.opt.numberwidth = 5                         -- set number column width to 2 {default 4}
vim.opt.path:append "**"                        -- include subfolders
vim.opt.pumheight = 10                          -- pop up menu height
vim.opt.relativenumber = true                   -- set relative numbered lines
vim.opt.scrolloff = 8                           -- like vertical screen padding
vim.opt.shiftwidth = 2                          -- the number of spaces inserted for each indentation
vim.opt.shortmess:append "c"
vim.opt.showmode = false                        -- no need for -- INSERT -- anymore
vim.opt.showtabline = 2                         -- always show tabs
vim.opt.sidescrolloff = 8                       -- like horizontal screen padding
vim.opt.signcolumn = "yes"                      -- always show the sign column, otherwise it would shift the text each time
vim.opt.smartcase = true                        -- smart case
vim.opt.smartindent = true                      -- make indenting smarter again
vim.opt.softtabstop = 2                         -- spaces per tab while editing
vim.opt.splitbelow = true                       -- force all horizontal splits to go below current window
vim.opt.splitright = true                       -- force all vertical splits to go to the right of current window
vim.opt.swapfile = false                        -- creates a swapfile
vim.opt.tabstop = 2                             -- insert 2 spaces for a tab
vim.opt.termguicolors = true                    -- set term gui colors (most terminals support this)
vim.opt.timeoutlen = 1000                       -- time to wait for a mapped sequence to complete (in milliseconds)
vim.opt.undodir = "~/.config/nvim/undo"         -- where to save undo files
vim.opt.undofile = true                         -- enable persistent undo
vim.opt.updatetime = 300                        -- faster completion (4000ms default)
vim.opt.whichwrap:append "<,>,[,],h,l"
vim.opt.wildmode = "list:longest"               -- bash-like tab completion
vim.opt.wrap = false                            -- display lines as one long line
vim.opt.writebackup = false                     -- prevent overwriting changes made by another program
vim.cmd "syntax enable"                         -- enable syntax highlighting

