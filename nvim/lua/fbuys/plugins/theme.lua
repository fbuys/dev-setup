-- Color theme

function ColorMyPencils(color)
  color = color or "rose-pine"
  vim.cmd.colorscheme(color)

  vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
  vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" });
end

return {
  { -- Theme
  "rose-pine/neovim",
  name = "rose-pine",
  priority = 999,
  config = function()
    require("rose-pine").setup({
      variant = "moon",
      styles = {
        bold = true,
        italic = true,
        transparency = true,
      },
      highlight_groups = {
        -- StatusLine
        StatusLine = { fg = "pine", bg = "pine", blend = 10 },
        StatusLineNC = { fg = "subtle", bg = "surface" },

        -- Telescope
        TelescopeBorder = { fg = "highlight_high", bg = "none" },
        TelescopeNormal = { bg = "none" },
        TelescopePromptNormal = { bg = "base" },
        TelescopeResultsNormal = { fg = "subtle", bg = "none" },
        TelescopeSelection = { fg = "text", bg = "base" },
        TelescopeSelectionCaret = { fg = "rose", bg = "rose" },
      },
    })

    ColorMyPencils()
  end,
  },
  { -- Remove all background colors to make nvim transparent
    "xiyaowong/transparent.nvim",
    config = function ()
      require("transparent").setup({ -- Optional, you don't have to run setup.
        groups = { -- table: default groups
          'Normal', 'NormalNC', 'Comment', 'Constant', 'Special', 'Identifier',
          'Statement', 'PreProc', 'Type', 'Underlined', 'Todo', 'String', 'Function',
          'Conditional', 'Repeat', 'Operator', 'Structure', 'LineNr', 'NonText',
          'SignColumn', 'CursorLine', 'CursorLineNr', 'StatusLine', 'StatusLineNC',
          'EndOfBuffer',
        },
      extra_groups = {}, -- table: additional groups that should be cleared
      exclude_groups = {}, -- table: groups you don't want to clear
    })
    end,
  },
}
