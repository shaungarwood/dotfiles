vim.api.nvim_command('cd ~/repos/notes')
vim.api.nvim_command('e README.md')

function create_new_note()
  vim.api.nvim_command('NvimTreeFindFile')
  require('nvim-tree.api').fs.create()
end

vim.api.nvim_set_keymap('n', '<leader>nn', ':lua create_new_note()<CR>', {noremap = true, silent = true})
