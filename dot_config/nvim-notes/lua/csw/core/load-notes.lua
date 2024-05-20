vim.api.nvim_command('cd ~/repos/notes')
vim.api.nvim_command('e README.md')

function create_and_open_file()
  vim.api.nvim_command('NvimTreeOpen')
  local filename = vim.fn.input('Enter filename: ')
  if filename ~= '' then
    vim.api.nvim_command('edit ' .. filename)
    vim.api.nvim_command('write')
  end
end

vim.api.nvim_set_keymap('n', '<leader>nn', ':lua create_and_open_file()<CR>', {noremap = true, silent = true})
