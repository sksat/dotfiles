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
      {
        'preservim/tagbar',
        init = function()
          -- nnoremap <silent> <Leader>t :TagbarToggle<CR>
          vim.api.nvim_set_keymap('n', '<leader>' .. 't', ':TagbarToggle<CR>', {
            noremap = true, silent = true
          })
        end,
      },
    },
  },
  {
    'simrat39/rust-tools.nvim', -- improve builtin-lsp & Rust experience
    dependencies = {
      'neovim/nvim-lspconfig',
    },
    config = function()
      require('rust-tools').setup({})
    end,
  },
  'rhysd/vim-llvm',

  -- treesitter
  {
    'nvim-treesitter/nvim-treesitter',
    init = function()
      require('nvim-treesitter.configs').setup({
        ensure_installed = 'all',
        highlight = {
          enable = true,
        }
      })
    end,
  },

  -- LSP
  {
    'neovim/nvim-lspconfig',
    init = function()
      require('nvim-lsp') -- load lsp config
    end,
    dependencies = {
      'nvim-lua/lsp-status.nvim',
    }
  },
  {
    'nvimdev/lspsaga.nvim',
    event = 'LspAttach',
    dependencies = { 'neovim/nvim-lspconfig' },
    config = function()
      require('lspsaga').setup({})
    end,
  },
  {
    'folke/trouble.nvim',
    config = function ()
      require('trouble').setup({})
    end,
  },
  {
    'j-hui/fidget.nvim',    -- Standalone UI for nvim-lsp progress
    config = function()
      require('fidget').setup({})
    end,
  },
}
