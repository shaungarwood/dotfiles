return {
  "voldikss/vim-floaterm",
  config = function()
    local function new_floaterm(keymap, cmd, wait_for_input)
      cmd = cmd or '' -- If no command is provided, use an empty string
      local command = ':FloatermNew --height=0.9 --width=0.9 --wintype=float --autoclose=2 ' .. cmd
      if wait_for_input then
        command = command .. '; read'
      end
      command = command .. '<CR>'
      vim.api.nvim_set_keymap('n', keymap, command, {noremap = true, silent = true})
    end

    -- Lazygit
    new_floaterm('<leader>lg', 'lazygit')

    -- Just a generic terminal
    new_floaterm('<leader>tn')
  end,
}
