vim.g.mapleader = ","

vim.keymap.set("n", "<leader>nh", ":nohl<CR>", { desc = "Clear search highlights" })

vim.opt.mouse = ''                      -- disable mouse
vim.opt.clipboard:append("unnamedplus") -- use system clipboard as default register

vim.cmd([[colorscheme desert]])

vim.opt.runtimepath:append(vim.fn.stdpath('data') .. '/lazy/kitty-scrollback.nvim')
require('kitty-scrollback').setup({})
