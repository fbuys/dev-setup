local fn = vim.fn
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'

-- Automatically install packer
if fn.empty(fn.glob(install_path)) > 0 then
  packer_bootstrap = fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd [[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]]

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

return require('packer').startup(function(use)
  -- My plugins here
  use "nvim-lua/plenary.nvim"           -- Useful lua functions used ny lots of plugins
  use "nvim-lua/popup.nvim"             -- An implementation of the Popup API from vim in Neovim
  use 'christoomey/vim-conflicted'      -- helps resolve merge conflicts
  use 'christoomey/vim-sort-motion'     -- adds gss for sorting
  use 'michaeljsmith/vim-indent-object' -- add ii for managing indented parts
  use 'wbthomason/packer.nvim'          -- packer manager
  use 'tpope/vim-commentary'            -- gcc to toggle comments
  use 'Mofiqul/dracula.nvim'            -- colorscheme

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if packer_bootstrap then
    require('packer').sync()
  end
end)
