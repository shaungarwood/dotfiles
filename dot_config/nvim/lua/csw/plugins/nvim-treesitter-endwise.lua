return {
  'RRethy/nvim-treesitter-endwise',
  config = function()
    local endwise = require('nvim-treesitter.configs')

    endwise.setup({
      endwise = {
        enable = true
      }
    })
  end
}
