return {
  'nvim-lualine/lualine.nvim',
  config = function()
    require('lualine').setup {
      options = {
        globalstatus = true, -- one statusline for all splits, so the path gets real estate
      },
      sections = {
        lualine_c = {
          {
            'filename',
            path = 1,          -- relative path from cwd, e.g. app/models/company.rb
            shorting_target = 60, -- shrink parent dirs before truncating when the line is tight
            symbols = { modified = ' ●', readonly = ' ' },
          },
        },
      },
      inactive_sections = {
        lualine_c = { { 'filename', path = 1 } },
      },
    }
  end
}
