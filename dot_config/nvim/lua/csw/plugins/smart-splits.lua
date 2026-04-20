return {
  "mrjones2014/smart-splits.nvim",
  config = function()
    require("smart-splits").setup()
    vim.keymap.set("n", "<C-h>", require("smart-splits").move_cursor_left)
    vim.keymap.set("n", "<C-j>", require("smart-splits").move_cursor_down)
    vim.keymap.set("n", "<C-k>", require("smart-splits").move_cursor_up)
    vim.keymap.set("n", "<C-l>", require("smart-splits").move_cursor_right)

    -- Ctrl+n/p: delegate tab switching to zellij instead of nvim's default
    -- (nvim default: Ctrl+n = keyword completion nav, Ctrl+p = keyword completion nav)
    -- To revert: remove these two keymaps and nvim's defaults return automatically
    if vim.env.ZELLIJ then
      vim.keymap.set("n", "<C-n>", function() vim.fn.system("zellij action go-to-next-tab") end, { desc = "Next zellij tab" })
      vim.keymap.set("n", "<C-p>", function() vim.fn.system("zellij action go-to-previous-tab") end, { desc = "Previous zellij tab" })
    end
  end,
}
