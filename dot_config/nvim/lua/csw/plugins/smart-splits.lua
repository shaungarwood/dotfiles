return {
  "mrjones2014/smart-splits.nvim",
  config = function()
    require("smart-splits").setup()

    if vim.env.ZELLIJ then
      -- Use wincmd within nvim first; at the edge, call zellij directly.
      local function move(wincmd_dir, zellij_dir)
        local before = vim.fn.winnr()
        vim.cmd("wincmd " .. wincmd_dir)
        if vim.fn.winnr() == before then
          vim.fn.system("zellij action move-focus " .. zellij_dir)
        end
      end
      vim.keymap.set("n", "<C-h>", function() move("h", "left") end)
      vim.keymap.set("n", "<C-j>", function() move("j", "down") end)
      vim.keymap.set("n", "<C-k>", function() move("k", "up") end)
      vim.keymap.set("n", "<C-l>", function() move("l", "right") end)
      vim.keymap.set("n", "<C-n>", function() vim.fn.system("zellij action go-to-next-tab") end, { desc = "Next zellij tab" })
      vim.keymap.set("n", "<C-p>", function() vim.fn.system("zellij action go-to-previous-tab") end, { desc = "Previous zellij tab" })
    else
      vim.keymap.set("n", "<C-h>", require("smart-splits").move_cursor_left)
      vim.keymap.set("n", "<C-j>", require("smart-splits").move_cursor_down)
      vim.keymap.set("n", "<C-k>", require("smart-splits").move_cursor_up)
      vim.keymap.set("n", "<C-l>", require("smart-splits").move_cursor_right)
    end
  end,
}
