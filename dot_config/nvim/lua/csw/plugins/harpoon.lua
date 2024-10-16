return {
  "ThePrimeagen/harpoon",
  disable = true,
  branch = "harpoon2",
  dependencies = { "nvim-lua/plenary.nvim", "nvim-telescope/telescope.nvim" },
  config = function()
    local harpoon = require("harpoon")
    harpoon.setup({})

    -- set keymaps
    local keymap = vim.keymap -- for conciseness

    keymap.set("n", "<leader>a", function() harpoon:list():add() end)
    keymap.set("n", "<leader>h", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)

    -- keymap.set("n", "<C-h>", function() harpoon:list():select(1) end)
    -- keymap.set("n", "<C-t>", function() harpoon:list():select(2) end)
    -- keymap.set("n", "<C-n>", function() harpoon:list():select(3) end)
    -- keymap.set("n", "<C-s>", function() harpoon:list():select(4) end)

    -- Toggle previous & next buffers stored within Harpoon list
    -- keymap.set("n", "<C-S-P>", function() harpoon:list():prev() end)
    -- keymap.set("n", "<C-S-N>", function() harpoon:list():next() end)
  end,
}


