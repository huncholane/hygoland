-- https://github.com/akinsho/toggleterm.nvim
return {
  {
    "akinsho/toggleterm.nvim",
    event = "VeryLazy",
    name = "Toggleterm",
    keys = {
      -- Creates a new floating terminal
      {
        "<leader>tf",
        "<cmd>TermNew direction=float<cr>",
        desc = "Create New Floating Terminal",
      },
      -- Creates a new tabbed terminal
      {
        "<leader>tt",
        "<cmd>TermNew direction=tab<cr>",
        desc = "Create New Tabbed Terminal",
      },
      -- Selects a terminal
      {
        "<leader>ts",
        "<cmd>TermSelect<cr>",
        desc = "Select Terminal",
      },
      -- Normal mode
      {
        mode = "t",
        "<C-]>",
        [[<C-\><C-n>]],
        desc = "Terminal mode to normal mode",
      },
    },
    -- opts
    opts = {
      direction = "float",
      open_mapping = [[<c-\>]],
      start_in_insert = true,
      float_opts = {
        border = "curved",
        winblend = 3,
        highlights = {
          border = "Normal",
          background = "Normal",
        },
      },
    },
    -- config
    config = function(_, opts)
      require("which-key").add({
        { "<leader>t", group = "Toggleterm" },
      })
      require("toggleterm").setup(opts)
    end,
  },
}
