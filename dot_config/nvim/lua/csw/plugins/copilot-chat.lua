return {
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    opts = {
      show_help = "yes", -- Show help text for CopilotChatInPlace, default: yes
      debug = false, -- Enable or disable debug mode, the log file will be in ~/.local/state/nvim/CopilotChat.nvim.log
      disable_extra_info = 'no', -- Disable extra information (e.g: system prompt) in the response.
      -- proxy = "socks5://127.0.0.1:3000", -- Proxies requests via https or socks.
      prompts = {
        Explain = "Briefly explain how it works, please.",
        Tests = "Briefly explain how the selected code works, then generate unit tests in rspec, please."
      }
    },
    build = function()
      vim.notify("Please update the remote plugins by running ':UpdateRemotePlugins', then restart Neovim.")
    end,
    event = "VeryLazy",
    keys = {
      { "<leader>cc", ":CopilotChat ", desc = "CopilotChat - chat" },
    },
  },
}

-- had to run this to get it to work on mac
-- python3 -m pip install --user --upgrade python-dotenv requests pynvim==0.5.0 prompt-toolkit
