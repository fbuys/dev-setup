-- [[ Setting options ]]
-- See `:help vim.o`

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
-- vim.opt.fileencoding = "utf-8"                  -- encoding
vim.opt.guifont = "monospace:h17"               -- the font used in graphical neovim applications
vim.opt.hlsearch = false                         -- highlight all matches
vim.opt.incsearch = true                         -- highlight all matches
vim.opt.ignorecase = true                       -- ignore case in search patterns
vim.o.smartcase = true                          -- honour cße when /C or capital in search
vim.o.breakindent = true                        -- Enable break indent
vim.opt.iskeyword:append "-"                    -- words with - treated as one word
vim.opt.list = true                             -- show whitespace
vim.wo.number = true                            -- Make line numbers default
vim.opt.relativenumber = true                   -- set relative numbered lines
vim.o.mouse = ''                                -- Disable mouse mode
vim.opt.numberwidth = 5                         -- set number column width to 2 {default 4}
vim.opt.path:append "**"                        -- include subfolders
vim.opt.pumheight = 10                          -- pop up menu height
vim.opt.scrolloff = 8                           -- like vertical screen padding
vim.opt.shortmess:append "c"
vim.opt.showmode = false                        -- no need for -- INSERT -- anymore
vim.opt.showtabline = 2                         -- always show tabs
vim.opt.sidescrolloff = 8                       -- like horizontal screen padding
vim.opt.signcolumn = "yes"                      -- always show the sign column, otherwise it would shift the text each time
vim.opt.smartindent = true                      -- make indenting smarter again
vim.opt.splitbelow = true                       -- force all horizontal splits to go below current window
vim.opt.splitright = true                       -- force all vertical splits to go to the right of current window
vim.opt.swapfile = false                        -- creates a swapfile
vim.opt.termguicolors = true                    -- set term gui colors (most terminals support this)
vim.opt.timeoutlen = 500                       -- time to wait for a mapped sequence to complete (in milliseconds)
vim.opt.undodir = vim.fn.stdpath('config') ..'undo'     -- where to save undo files
vim.opt.undofile = true                         -- enable persistent undo
vim.opt.updatetime = 300                        -- faster completion (4000ms default)
vim.opt.whichwrap:append "<,>,[,],h,l"
vim.opt.wildmode = "list:longest"               -- bash-like tab completion
vim.opt.wrap = false                            -- display lines as one long line
vim.opt.writebackup = false                     -- prevent overwriting changes made by another program
vim.cmd "syntax enable"                         -- enable syntax highlighting
vim.opt.shell = "/bin/zsh"

-- Tabs and spaces
vim.opt.shiftwidth = 2                          -- the number of spaces inserted for each indentation
vim.opt.softtabstop = 2                         -- spaces per tab while editing
vim.opt.tabstop = 2                            -- insert 2 spaces for a tab

-- [[ Highlight on yank ]]
-- See `:help vim.highlight.on_yank()`
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = '*',
})

-- -- Statusline
-- vim.opt.laststatus = 2 -- Or 3 for global statusline
-- vim.opt.statusline = " %r%m %{FugitiveStatusline()} %t %= %l:%c %p%% %Y ♥ "
--
-- --
-- -- pip install pynvim neovim for python to work
-- -- vim.g.python3_host_prog = "~/.venv/nvim3-11-1/bin/python"
-- -- vim.g.python3_host_prog = "~/.venv/pecas-dragon/bin/python"
-- vim.g.python3_host_prog = "~/git/github.com/ombulabs/pecas-genie/venv/bin/python"

