vim.g.mapleader = ","

vim.keymap.set("n", "<leader>nh", ":nohl<CR>", { desc = "Clear search highlights" })

vim.wo.wrap = true
vim.wo.linebreak = true

vim.opt.mouse = ''
vim.opt.clipboard:append("unnamedplus")

vim.cmd([[colorscheme desert]])

-- this buffer is always throwaway scrollback — never save, never prompt
vim.keymap.set("n", "qq", "<cmd>qa!<CR>", { desc = "Force quit without saving" })
vim.keymap.set("n", "<leader>q", "<cmd>qa!<CR>", { desc = "Force quit without saving" })

vim.cmd([[
  cnoreabbrev <expr> q  (getcmdtype() == ':' && getcmdline() == 'q')  ? 'qa!' : 'q'
  cnoreabbrev <expr> wq (getcmdtype() == ':' && getcmdline() == 'wq') ? 'qa!' : 'wq'
]])
