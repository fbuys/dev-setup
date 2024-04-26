return {
  -- "gc" to comment visual regions/lines
  'numToStr/Comment.nvim',
  config = function ()
    -- Enable Comment.nvim
    require('Comment').setup()
  end
}

