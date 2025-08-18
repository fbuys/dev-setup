return { -- Run your tests at the speed of thought
  'vim-test/vim-test',
  dependencies = {
    { 'preservim/vimux' },
  },
  config = function()
    local opts = { noremap = true, silent = true }

    vim.api.nvim_set_keymap("n", "<leader>tt", ":TestNearest<CR>", opts)
    vim.api.nvim_set_keymap("n", "<leader>tf", ":TestFile<CR>", opts)
    vim.api.nvim_set_keymap("n", "<leader>ta", ":TestSuite<CR>", opts)
    vim.api.nvim_set_keymap("n", "<leader>tl", ":TestLast<CR>", opts)
    vim.api.nvim_set_keymap("n", "<leader>tg", ":TestVisit<CR>", opts)

    vim.cmd('let test#strategy = "vimux"')
  end,
}
