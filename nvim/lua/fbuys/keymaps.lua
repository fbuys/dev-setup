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

keymap("n", "<leader>x", ":Lex 30<cr>", opts)             -- open explorer
keymap("n", ",,", "<C-^>", opts)                          -- Alternate buffers

-- Move line down
keymap("n", "∆", ":m .+1<CR>", opts)
keymap("v", "∆", ":m '>+1<CR>gv=gv", opts)

-- Move line up
keymap("n", "˚", ":m .-2<CR>", opts)
keymap("v", "˚", ":m '<-2<CR>gv=gv", opts)

keymap("n", "<leader>w", ":w<CR>", opts)                         -- Save
keymap("n", "<leader>q", ":q<CR>", opts) -- Quit
keymap("n", "<leader>wq", ":wq<CR>", opts) -- Save and quite
keymap("n", "<leader>qq", ":qa<CR>", opts) -- Quite all

-- indentation
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

-- Paste without yanking
keymap("v", "p", '"_dP', opts)
keymap("v", "P", '"_dp', opts)

-- Remap for dealing with word wrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- Copy the current buffer's path to the clipboard
keymap("n", "cp", ":let @+ = expand('%')<CR>", opts)

-- Diagnostic keymaps
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float)
vim.keymap.set('n', '<leader>dl', vim.diagnostic.setloclist)

vim.keymap.set("n", "J", "mzJ`z")

-- Move up and down but keep cursor at zz
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

-- Jump to search but keep cursor at zz
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- Rename word under cursor
vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

-- Remoe current file and buffer
vim.keymap.set("n", "<leader>rm", ":call delete(expand('%')) | bdelete!<CR>")
