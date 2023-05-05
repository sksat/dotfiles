return {
  -- colorscheme
  {
    "otyn0308/otynium",
    lazy = false,
    priority = 1000, -- load before all the other start plugins
    config = function()
      vim.cmd([[colorscheme otynium]])
    end,
  },
}
