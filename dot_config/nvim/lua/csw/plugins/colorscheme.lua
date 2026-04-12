return {
  {
    "bluz71/vim-nightfly-guicolors",
    priority = 1000, -- make sure to load this before all the other start plugins
    config = function()
      local flag = vim.fn.expand("~/.config/nvim/.light-theme")

      vim.cmd([[colorscheme nightfly]])

      -- Apply persisted theme preference on startup
      if vim.fn.filereadable(flag) == 1 then
        vim.cmd([[set background=light]])
      end

      -- Toggle commands that persist the preference
      vim.cmd([[command! Lighttheme lua vim.cmd('set background=light'); vim.fn.writefile({}, vim.fn.expand('~/.config/nvim/.light-theme'))]])
      vim.cmd([[command! Darktheme lua vim.cmd('set background=dark'); vim.fn.delete(vim.fn.expand('~/.config/nvim/.light-theme'))]])
    end,
  }
}
