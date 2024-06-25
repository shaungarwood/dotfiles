return {
  "knubie/vim-kitty-navigator",

  config = function()
    -- set keymaps
    local keymap = vim.keymap -- for conciseness
    keymap.set("n", "<leader>l", ":KittyNavigateLeft<cr>", { desc = "Navigate left" })
    keymap.set("n", "<leader>j", ":KittyNavigateDown<cr>", { desc = "Navigate down" })
    keymap.set("n", "<leader>k", ":KittyNavigateUp<cr>", { desc = "Navigate up" })
    keymap.set("n", "<leader>r", ":KittyNavigateRight<cr>", { desc = "Navigate right" })
  end
}
