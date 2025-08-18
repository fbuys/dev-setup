return {
  -- Add/change/delete surrounding delimiter pairs with ease
  "kylechui/nvim-surround",
  event = "VeryLazy",
  config = function()
    require("nvim-surround").setup({})
  end
}
