return {
  "okuuva/auto-save.nvim",
  cmd = "ASToggle", -- optional for lazy loading on command
  event = { "InsertLeave", "TextChanged" }, -- optional for lazy loading on trigger events
  opts = {
    condition = function(buf)
      local fn = vim.fn

      -- don't save for special-buffers
      if fn.getbufvar(buf, "&buftype") ~= '' then
        return false
      end
      return true
    end
  }
}
