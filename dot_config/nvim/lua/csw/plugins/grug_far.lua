return  {
  enabled = false,
  'MagicDuck/grug-far.nvim',
  config = function()
    require('grug-far').setup({
      preview = {
        border = 'rounded',
      },
    });
  end,
  keys = {
    { "\\", "<cmd>GrugFar<CR>", { noremap = true } },
    {
      "{",
      function()
        local grug = require('grug-far')
        grug.open({
          prefills = {
            -- search = "word"
            search = vim.fn.expand("<cword>")
          }
        })
      end,
      mode = { "n", "v" },
      desc = "Search for word under cursor",
    },
  }
}
