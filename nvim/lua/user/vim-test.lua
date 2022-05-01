local status_ok, tt = pcall(require, "toggleterm")
if not status_ok then
  return
end
local ttt = require "toggleterm.terminal"

vim.g["test#custom_strategies"] = {
  tterm = function(cmd)
    tt.exec(cmd)
  end,

  tterm_close = function(cmd)
    local term_id = 0
    tt.exec(cmd, term_id)
    ttt.get_or_create_term(term_id):close()
  end,
}

vim.g["test#strategy"] = "tterm"

local opts = { noremap = true, silent = true }
local keymap = vim.api.nvim_set_keymap

keymap("n", ",rs", ":TestNearest<CR>", opts)
keymap("n", ",rt", ":TestFile<CR>", opts)
keymap("n", ",ra", ":TestSuite<CR>", opts)
keymap("n", ",rl", ":TestLast<CR>", opts)
keymap("n", ",rg", ":TestVisit<CR>", opts)
keymap("n", ",rf", ":TestSuite --only-failures<CR>", opts)
keymap("n", ";rs", "<cmd>TestNearest -strategy=tterm_close<cr>", opts)
keymap("n", ";rt", "<cmd>TestFile --strategy=tterm_close<cr>", opts)
