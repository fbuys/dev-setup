-- Color theme
return {
  "rose-pine/neovim",
  name = "rose-pine",
  priority = 999,
  config = function()
    require("rose-pine").setup({
      variant = "moon",
    })

    function ColorMyPencils(color)
      color = color or "rose-pine"
      vim.cmd.colorscheme(color)

      vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
      vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" });
    end

    ColorMyPencils()
  end,
}
