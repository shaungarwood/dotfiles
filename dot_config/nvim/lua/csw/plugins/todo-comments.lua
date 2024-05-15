return {
  "folke/todo-comments.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },

  opts = {
    signs = true,
    merge_keywords = false,
    keywords = {
      GOABOUT = { icon = '', color = 'info' }
    }
  }
}
