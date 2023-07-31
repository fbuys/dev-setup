-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Install packer
local install_path = vim.fn.stdpath 'data' .. '/site/pack/packer/start/packer.nvim'
local is_bootstrap = false
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  is_bootstrap = true
  vim.fn.system { 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path }
  vim.cmd [[packadd packer.nvim]]
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
-- vim.cmd [[
--   augroup packer_user_config
--     autocmd!
--     autocmd BufWritePost packer.lua source <afile> | PackerSync
--   augroup end
-- ]]

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
  return
end

-- Have packer use a popup window
packer.init {
  display = {
    open_fn = function()
      return require("packer.util").float { border = "rounded" }
    end,
  },
}

require('packer').startup(function(use)
  -- Package manager
  use 'wbthomason/packer.nvim'

  -- Fuzzy Finder (files, lsp, etc)
  use { 'nvim-telescope/telescope.nvim', branch = '0.1.x', requires = { 'nvim-lua/plenary.nvim' } }
  -- Fuzzy Finder Algorithm which requires local dependencies to be built. Only load if `make` is available
  use { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make', cond = vim.fn.executable 'make' == 1 }

  -- Theme
  use { 'Mofiqul/dracula.nvim',
    config = function()
      vim.cmd('colorscheme dracula')
    end
  }

  use { -- Highlight, edit, and navigate code
    'nvim-treesitter/nvim-treesitter',
    run = function()
      pcall(require('nvim-treesitter.install').update { with_sync = true })
    end,
  }

  use { -- Additional text objects via treesitter
    'nvim-treesitter/nvim-treesitter-textobjects',
    after = 'nvim-treesitter',
  }

  -- Git related plugins
  use 'tpope/vim-fugitive'
  use 'tpope/vim-rhubarb'
  use 'lewis6991/gitsigns.nvim'

  use {
    'VonHeikemen/lsp-zero.nvim',
    branch = 'v2.x',
    requires = {
      -- LSP Support
      {'neovim/nvim-lspconfig'},             -- Required
      {                                      -- Optional
        'williamboman/mason.nvim',
        run = function()
          pcall(vim.cmd, 'MasonUpdate')
        end,
      },
      {'williamboman/mason-lspconfig.nvim'}, -- Optional

      -- Useful status updates for LSP
      {'j-hui/fidget.nvim', tag = 'legacy'},

      -- Autocompletion
      { 'f3fora/cmp-spell' },         -- Optional
      { 'hrsh7th/cmp-buffer' },       -- Optional
      { 'hrsh7th/cmp-nvim-lsp' },     -- Required
      { 'hrsh7th/cmp-nvim-lua' },     -- Optional
      { 'hrsh7th/cmp-path' },         -- Optional
      { 'hrsh7th/nvim-cmp' },         -- Required
      { 'onsails/lspkind.nvim' },     -- icons next to autocomplete list items
      { 'saadparwaiz1/cmp_luasnip' }, -- Optional
      {
        'quangnguyen30192/cmp-nvim-tags',
        -- if you want the sources is available for some file types
        ft = {
          'markdown',
        }
      },

      -- Snippets
      { 'L3MON4D3/LuaSnip' },             -- Required
      { 'rafamadriz/friendly-snippets' }, -- Optional

      -- Additional lua configuration, makes nvim stuff amazing
      'folke/neodev.nvim',

      -- Additional diagnostics
      { 'jose-elias-alvarez/null-ls.nvim' },
      { 'jay-babu/mason-null-ls.nvim' },
      { 'mfussenegger/nvim-lint' },
    }
  }

  -- Neovim plugin for Elixir
  use({ "elixir-tools/elixir-tools.nvim", tag = "stable", requires = { "nvim-lua/plenary.nvim" }})



  use 'nvim-lualine/lualine.nvim' -- Fancier statusline
  use 'numToStr/Comment.nvim'     -- "gc" to comment visual regions/lines
  use 'tpope/vim-sleuth'          -- Detect tabstop and shiftwidth automatically

  -- Add/change/delete surrounding delimiter pairs
  use({
    "kylechui/nvim-surround",
    tag = "*", -- Use for stability; omit to use `main` branch for the latest features
    config = function()
      require("nvim-surround").setup({
        -- Configuration here, or leave empty to use defaults
      })
    end
  })

  -- Manage multiple terminal windows
  use { "akinsho/toggleterm.nvim", tag = '*' }

  -- Add indentation guides even on blank lines
  use 'lukas-reineke/indent-blankline.nvim'

  -- Visualise and resolve merge conflicts
  use { 'akinsho/git-conflict.nvim', tag = "*", config = function ()
    require('git-conflict').setup()
  end}

  -- Jupyter
  -- use { "untitled-ai/jupyter_ascending.vim" }

  -- Auto save after insert or text changes
  use "Pocco81/auto-save.nvim"

  -- Add mapping for sorting for sorting a range of text
  use { 'christoomey/vim-sort-motion' }

  -- add ii for managing indented parts
  use { 'michaeljsmith/vim-indent-object' }

  -- Run your tests at the speed of thought
  use { 'vim-test/vim-test' }

  -- LUA port of tpope's famous vim-unimpaired plugin
  use { 'Tummetott/unimpaired.nvim',
    config = function()
      require('unimpaired').setup {
        -- add any options here or leave empty
      }
    end
  }

  -- Add color highlights to hex values
  use { 'norcalli/nvim-colorizer.lua',
    config = function()
      require('colorizer').setup {
        -- add any options here or leave empty
      }
    end
  }

  -- Show possible keybindings
  -- use {
  --   "folke/which-key.nvim",
  --   config = function()
  --     vim.o.timeout = true
  --     vim.o.timeoutlen = 300
  --     require("which-key").setup {
  --       -- your configuration comes here
  --       -- or leave it empty to use the default settings
  --       -- refer to the configuration section below
  --     }
  --   end
  -- }

  -- Formatting
  -- async fast minimalist plugin make format easy in neovim
  use "nvimdev/guard.nvim"

  use 'ThePrimeagen/harpoon'

  -- Open file or project in GitHub
  use "almo7aya/openingh.nvim"

  -- Add custom plugins to packer from ~/.config/nvim/lua/custom/plugins.lua
  local has_plugins, plugins = pcall(require, 'custom.plugins')
  if has_plugins then
    plugins(use)
  end

  if is_bootstrap then
    require('packer').sync()
  end
end)

vim.api.nvim_set_keymap("n", "<Leader>ps", ":PackerSync <CR>", { silent = true, noremap = true })
vim.api.nvim_set_keymap("v", "<Leader>ps", ":PackerSync <CR>", { silent = true, noremap = true })
