return {
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    branch = "main",
    dependencies = {
      { "github/copilot.vim" },
      { "nvim-lua/plenary.nvim" },
    },
    opts = {
      debug = false,
      prompts = {
        Explain = "Briefly explain how it works, please.",
        Tests = "Briefly explain how the selected code works, then generate unit tests in rspec, please.",
        Fix = "There is a problem in this code. Rewrite the code to show it with the bug fixed, please.",
      },
    },
    event = "VeryLazy",
    keys = {
      { "<leader>cc", ":CopilotChat ", desc = "CopilotChat - chat" },
    },
  },
}
