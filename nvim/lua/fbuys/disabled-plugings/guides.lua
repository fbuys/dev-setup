return { -- Add indentation guides even on blank lines
  'lukas-reineke/indent-blankline.nvim',
  config = function ()
    -- Enable `lukas-reineke/indent-blankline.nvim`
    -- See `:help ibl.setup()`
    require("ibl").setup()
  end
}
