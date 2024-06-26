vim.g.mapleader = ","

vim.keymap.set("n", "<leader>nh", ":nohl<CR>", { desc = "Clear search highlights" })

vim.opt.mouse = ''        -- disable mouse
vim.opt.clipboard:append("unnamedplus") -- use system clipboard as default register

-- add kitty-scrollback.nvim to the runtimepath to allow us to require the kitty-scrollback module
-- pick a runtimepath that corresponds with your package manager, if you are not sure leave them all it will not cause any issues
vim.opt.runtimepath:append(vim.fn.stdpath('data') .. '/lazy/kitty-scrollback.nvim') -- lazy.nvim
require('kitty-scrollback').setup({
  -- put your kitty-scrollback.nvim configurations here
})
