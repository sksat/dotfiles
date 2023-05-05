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

  -- utils
  'cohama/lexima.vim',

  -- CVS
  'mhinz/vim-signify',
  'rhysd/git-messenger.vim',

  -- programming language
  'dag/vim-fish',
  {
    'rust-lang/rust.vim',
    init = function()
      vim.g.rustfmt_autosave = 1
    end,
    dependencies = {
      'preservim/tagbar',
    },
  },
  'rhysd/vim-llvm',
}
