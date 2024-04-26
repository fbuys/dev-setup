local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)
require("lazy").setup("fbuys.plugins")

-- local plugins = {
--   { "rose-pine/neovim", name = "rose-pine", priority = 999 }, -- Color theme
--   { 'nvim-telescope/telescope.nvim', branch = '0.1.x', dependencies = { 'nvim-lua/plenary.nvim' } }, -- Fuzzy Finder (files, lsp, etc)
--   { 'nvim-telescope/telescope-fzf-native.nvim', build = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build' }, -- to significantly improve telescope sorting performance
--   { -- Highlight, edit, and navigate code
--     'nvim-treesitter/nvim-treesitter',
--     init = function()
--       pcall(require('nvim-treesitter.install').update { with_sync = true })
--     end,
--   },
--   { 'nvim-treesitter/nvim-treesitter-textobjects' }, -- Additional text objects via treesitter
--   { 'tpope/vim-fugitive' }, -- Use Git from the neovim
--   { 'tpope/vim-rhubarb' }, -- Open GitHub URLs
--   { 'lewis6991/gitsigns.nvim' }, -- Git signs for added, removed, and changed lines
--   { 'numToStr/Comment.nvim' }, -- "gc" to comment visual regions/lines
--   { 'christoomey/vim-sort-motion' }, -- Add mapping for sorting for sorting a range of text
--   { 'j-hui/fidget.nvim' }, -- Notifications and LSP progress messages in right corner
--   { -- Easily install and manage LSP servers, DAP servers, linters, and formatters
--     'williamboman/mason.nvim',
--     init = function()
--       pcall(vim.cmd, 'MasonUpdate')
--     end,
--   },
--   {'williamboman/mason-lspconfig.nvim'}, -- makes it easier to use lspconfig
--   {'VonHeikemen/lsp-zero.nvim', branch = 'v3.x'}, -- help you setup Neovim's LSP client
--   {'neovim/nvim-lspconfig'}, -- Quickstart configs for Nvim LSP
--   {'hrsh7th/cmp-nvim-lsp'}, -- nvim-cmp source for neovim's built-in language server client
--   {'hrsh7th/nvim-cmp'}, -- A completion plugin for neovim coded in Lua.
--   {'L3MON4D3/LuaSnip'}, -- Snippet Engine for Neovim written in Lua. 
--   { 'f3fora/cmp-spell' }, -- Autocompletion spellsuggest.
--   { 'hrsh7th/cmp-buffer' }, -- Autocompletion for buffer words.
--   { 'hrsh7th/cmp-path' }, -- Autocompletion for path.
--   { 'onsails/lspkind.nvim' }, -- icons next to autocomplete list items
--   { 'saadparwaiz1/cmp_luasnip' }, -- Lua specific autocomplete.
--   { 'hrsh7th/cmp-nvim-lua' },     -- Autocompletion for neovim Lua API.
--   {
--     -- Autocompletion tags sources for nvim-cmp.
--     'quangnguyen30192/cmp-nvim-tags',
--     -- if you want the sources is available for some file types
--     ft = {
--       'markdown',
--       'ruby',
--     }
--   },
--   { 'rafamadriz/friendly-snippets' }, -- Set of preconfigured snippets for different languages.
--   { 'folke/neodev.nvim' }, -- Additional lua configuration, makes nvim stuff amazing
--   { 'mfussenegger/nvim-lint' },
--   {
--     -- Add/change/delete surrounding delimiter pairs with ease
--     "kylechui/nvim-surround",
--     event = "VeryLazy",
--     config = function()
--       require("nvim-surround").setup({})
--     end
--   },
--   { 'tpope/vim-sleuth' }, -- Detect tabstop and shiftwidth automatically
--   { 'adelarsq/vim-matchit' }, -- extended matching for the % operator
--   { 'akinsho/toggleterm.nvim' }, -- Manage multiple terminal windows
--   { 'lukas-reineke/indent-blankline.nvim' }, -- Add indentation guides even on blank lines
--   { -- Visualise and resolve merge conflicts
--     'akinsho/git-conflict.nvim',
--     config = function ()
--       require('git-conflict').setup()
--     end
--   },
--   { 'Pocco81/auto-save.nvim' }, -- Auto save after insert or text changes
--   { 'michaeljsmith/vim-indent-object' }, -- add ii for managing indented parts
--   { 'vim-test/vim-test' }, -- Run your tests at the speed of thought
--   { -- LUA port of tpope's famous vim-unimpaired plugin
--     'Tummetott/unimpaired.nvim',
--     config = function()
--       require('unimpaired').setup { }
--     end
--   },
--   { -- Add color highlights to hex values
--     'norcalli/nvim-colorizer.lua',
--     config = function()
--       require('colorizer').setup {
--       }
--     end
--   },
--   { 'nvimdev/guard.nvim' }, -- async fast minimalist plugin make format easy in neovim
--   { "nvimdev/guard-collection" }, -- required by nvimdev/guard.nvim
--
--
--
--   --     -- Additional diagnostics
--   --     { 'jose-elias-alvarez/null-ls.nvim' },
--   --     { 'jay-babu/mason-null-ls.nvim' },
--
-- }
