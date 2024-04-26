return {
  'tpope/vim-fugitive', -- Use Git from the neovim
  { -- Open GitHub URLs
    'tpope/vim-rhubarb',
    config = function ()
      -- open fugitive
      vim.keymap.set("n", "<leader>gs", vim.cmd.Git)

      -- for repository page
      vim.api.nvim_set_keymap("n", "<Leader>gr", ":OpenInGHRepo <CR>", { silent = true, noremap = true })
      -- for current file page
      vim.api.nvim_set_keymap("n", "<Leader>gf", ":OpenInGHFile <CR>", { silent = true, noremap = true })
      vim.api.nvim_set_keymap("v", "<Leader>gf", ":OpenInGHFile <CR>", { silent = true, noremap = true })

      -- Gitsigns
      -- See `:help gitsigns.txt`
      -- local icons = require("../../lua/fbuys/icons.lua")
      require('gitsigns').setup {
        signs = {
          add = { text = '▎' },
          change = { text = '▎' },
          delete = { text = '_' },
          topdelete = { text = '‾' },
          changedelete = { text = '▎' },
        },
      }
      local opts = { noremap = true, silent = true }
      vim.api.nvim_set_keymap("n", "<leader>gp", ":Gitsigns preview_hunk<CR>", opts)
    end
  },
}

