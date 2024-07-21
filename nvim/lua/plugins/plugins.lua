local plugins = {
  {
    "neovim/nvim-lspconfig",
    config = function()
      local lspconfig = require("lspconfig")

      local on_attach = function(client, bufnr)
        -- Mappings.
        local bufopts = { noremap=true, silent=true, buffer=bufnr }
        vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
        vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
        vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
        vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
        vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
        vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, bufopts)
        vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
        vim.keymap.set('n', '<space>wl', function()
          print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
        end, bufopts)
        vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, bufopts)
        vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, bufopts)
        vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, bufopts)
        vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
        vim.keymap.set('n', '<space>f', function() vim.lsp.buf.format { async = true } end, bufopts)
      end

      lspconfig.clangd.setup {
        on_attach = on_attach,
        flags = {
          debounce_text_changes = 150,
        },
        init_options = {
          clangdFileStatus = true,
        },
        cmd = { "clangd", "--clang-tidy", "--completion-style=detailed", "--header-insertion=never", "--suggest-missing-includes" }
      }
    end,
  },

  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "lua-language-server",
        "stylua",
        "clangd",
        "clang-format"
      },
    },
  },

  {
    "jay-babu/mason-null-ls.nvim",
    requires = {
      "jose-elias-alvarez/null-ls.nvim",
      "williamboman/mason.nvim",
    },
    config = function()
      require("mason-null-ls").setup({
        ensure_installed = { "clang-format" },
        automatic_installation = true,
      })
      local null_ls = require("null-ls")
      null_ls.setup({
        sources = {
          null_ls.builtins.formatting.clang_format.with({
            command = "//usr/bin/clang-format",  -- Replace this with the actual path
            extra_args = { "--style=file", "--style=/home/qwistys/src/5thD/.clang-format" }
          }),
          null_ls.builtins.diagnostics.clang_check.with({
            extra_args = { "--std=c++17" },
          }),
        },
      })
    end,
  },

  {
    "Civitasv/cmake-tools.nvim",
    lazy = false,
    config = function()
      require("cmake-tools").setup {
        cmake_command = "cmake",
        cmake_build_directory = "build",
        cmake_build_type = "Debug",
        cmake_generate_options = {},
        cmake_build_options = {},
        cmake_console_size = 10,
        cmake_show_console = "always"
      }

      vim.api.nvim_set_keymap('n', '<leader>cg', ':CMakeGenerate<CR>', { noremap = true, silent = true })
      vim.api.nvim_set_keymap('n', '<leader>cb', ':CMakeBuild<CR>', { noremap = true, silent = true })
      vim.api.nvim_set_keymap('n', '<leader>cc', ':CMakeClean<CR>', { noremap = true, silent = true })
      vim.api.nvim_set_keymap('n', '<leader>cr', ':CMakeRun<CR>', { noremap = true, silent = true })
    end,
  },

  {
    "nvim-telescope/telescope.nvim",
    lazy = false,
    requires = { "nvim-lua/plenary.nvim" }
  },

  {
    "tami5/sqlite.lua",
    module = "sqlite",
    lazy = false,
  },

  {
    "AckslD/nvim-neoclip.lua",
    lazy = false,
    requires = {
      {'nvim-telescope/telescope.nvim'},
      {'tami5/sqlite.lua', module = 'sqlite'},
    },
    config = function()
      require('neoclip').setup({
        history = 1000,
        enable_persistent_history = true,
        length_limit = 1048576,
        continuous_sync = true,
        db_path = vim.fn.stdpath("data") .. "/databases/neoclip.sqlite3",
        filter = nil,
        preview = true,
        default_register = '+',
        default_register_macros = 'q',
        enable_macro_history = true,
        content_spec_column = false,
        on_paste = {
          set_reg = false,
        },
        on_replay = {
          set_reg = false,
        },
        keys = {
          telescope = {
            i = {
              select = '<cr>',
              paste = '<c-p>',
              paste_behind = '<c-k>',
              replay = '<c-q>',
              delete = '<c-d>',
              custom = {},
            },
            n = {
              select = '<cr>',
              paste = 'p',
              paste_behind = 'P',
              replay = 'q',
              delete = 'd',
              custom = {},
            },
          },
        },
      })
      require('telescope').load_extension('neoclip')
    end,
  },
}

return plugins

