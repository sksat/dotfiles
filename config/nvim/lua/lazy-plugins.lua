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

  -- statusline
  {
    'nvim-lualine/lualine.nvim',
    init = function()
      require('lualine').setup()
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
  'nvim-treesitter/nvim-treesitter-context',

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

  -- completion with LSP
  {
    'hrsh7th/vim-vsnip',
    dependencies = {
      'hrsh7th/cmp-vsnip',
      'hrsh7th/nvim-cmp',
      'hrsh7th/cmp-cmdline',
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-nvim-lsp',
      'onsails/lspkind.nvim',
    },
    init = function()
      local cmp = require('cmp')
      local lspkind = require('lspkind')
      cmp.setup({
        snippet = {
          -- REQUIRED - you must specify a snippet engine
          expand = function(args)
            vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
            -- require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
            -- require('snippy').expand_snippet(args.body) -- For `snippy` users.
            -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
          end,
        },
        mapping = cmp.mapping.preset.insert({
          ['<C-k>'] = cmp.mapping.scroll_docs(-4),
          ['<C-j>'] = cmp.mapping.scroll_docs(4),
          ['<Tab>'] = cmp.mapping.select_next_item(),
          ['<C-Space>'] = cmp.mapping.complete(),
          ['<C-e>'] = cmp.mapping.abort(),
          ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
        }),
        formatting = {
          format = lspkind.cmp_format({})
        },
        sources = cmp.config.sources({
          { name = 'nvim_lsp' },
          { name = 'vsnip' }, -- For vsnip users.
          -- { name = 'luasnip' }, -- For luasnip users.
          -- { name = 'ultisnips' }, -- For ultisnips users.
          -- { name = 'snippy' }, -- For snippy users.
        }, {
          { name = 'buffer' },
        })
      })
    end,
  },
}
