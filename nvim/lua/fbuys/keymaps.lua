-- Shorten function name
local keymap = vim.api.nvim_set_keymap

-- Default keymπ options
local opts = { noremap = true, silent = true }

-- Set <space> as the leader key
-- See `:help mapleader`
--  NOTE: Must happen before plugins are required (otherwise wrong leader will be used)
vim.g.mapleader = " "                                     -- Use space as leader
vim.g.maplocalleader = ","                                -- Use , as local leader
keymap("", "<Space>", "<Nop>", opts)                      -- Better user experience with space leader

-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",

-- [ NORMAL MODE ]
keymap("n", "<leader>e", ":Lex 30<cr>", opts)             -- open explorer
keymap("n", ",,", "<C-^>", opts)                          -- Alternate buffers

-- Move line down
keymap("n", "∆", ":m .+1<CR>", opts)
keymap("v", "∆", ":m '>+1<CR>gv=gv", opts)

-- Move line up
keymap("n", "˚", ":m .-2<CR>", opts)
keymap("v", "˚", ":m '<-2<CR>gv=gv", opts)

keymap("n", ";w", ":w<CR>", opts)                         -- Save
keymap("n", ";q", ":q<CR>", opts) -- Quit
keymap("n", ";wq", ":wq<CR>", opts) -- Save and quite
keymap("n", "<leader>ho", ":nohlsearch<Bar>:echo<cr>", opts) -- turn off highlighting

-- indentation
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

-- Paste without yanking
keymap("v", "p", '"_dp', opts)
keymap("v", "P", '"_dP', opts)

-- Remap for dealing with word wrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

