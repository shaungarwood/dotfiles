-- Custom user commands

-- Copilot autocomplete toggle commands
vim.api.nvim_create_user_command('DisableAutoComplete', function()
  vim.cmd('Copilot disable')
  vim.notify('Copilot autocomplete disabled', vim.log.levels.INFO)
end, {})

vim.api.nvim_create_user_command('EnableAutoComplete', function()
  vim.cmd('Copilot enable')
  vim.notify('Copilot autocomplete enabled', vim.log.levels.INFO)
end, {})
