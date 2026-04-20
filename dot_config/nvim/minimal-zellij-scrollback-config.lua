vim.g.mapleader = ","

vim.keymap.set("n", "<leader>nh", ":nohl<CR>", { desc = "Clear search highlights" })

vim.wo.wrap = true
vim.wo.linebreak = true

vim.opt.mouse = ''
vim.opt.clipboard:append("unnamedplus")

vim.cmd([[colorscheme desert]])
