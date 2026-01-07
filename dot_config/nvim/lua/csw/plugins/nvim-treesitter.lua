return {
  {
    "nvim-treesitter/nvim-treesitter",
    event = { "BufReadPre", "BufNewFile" },
    build = ":TSUpdate",
    dependencies = {
      "nvim-treesitter/nvim-treesitter-textobjects", -- syntax aware text-object (i think you can select a method)
      "windwp/nvim-ts-autotag",                      -- tag autocloser (ip - inner paragraph, ap - paragraph)
      "RRethy/nvim-treesitter-endwise",              -- auto-add 'end' in Ruby, Lua, etc.
    },
    config = function()
      -- import nvim-treesitter plugin
      local treesitter = require("nvim-treesitter.configs")

      -- configure treesitter
      treesitter.setup({ -- enable syntax highlighting
        highlight = {
          enable = true,
        },
        -- enable indentation
        indent = { enable = true },
        -- enable autotagging (w/ nvim-ts-autotag plugin)
        autotag = {
          enable = true,
        },
        -- enable auto-ending (w/ nvim-treesitter-endwise plugin)
        endwise = {
          enable = true,
        },
        -- ensure these language parsers are installed
        ensure_installed = {
          "bash",
          "css",
          "dockerfile",
          "diff",
          "git_config",
          "gitignore",
          "graphql",
          "html",
          "http",
          "javascript",
          "lua",
          "markdown",
          "markdown_inline",
          "python",
          "ruby",
          "regex",
          "json",
          "sql",
          "terraform",
          "vim",
          "vimdoc",
          "yaml",
        },
        incremental_selection = {
          enable = true,
          keymaps = {
            init_selection = "<C-space>",
            node_incremental = "<C-space>",
            scope_incremental = false,
            node_decremental = "<bs>",
          },
        },
      })
    end,
  },
}
