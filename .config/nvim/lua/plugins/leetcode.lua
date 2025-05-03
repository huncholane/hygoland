return {
  {
    "kawre/leetcode.nvim",
    event = "VeryLazy",
    dependencies = {
      "nvim-telescope/telescope.nvim",
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
    },
    keys = {
      {
        "<leader>zt",
        function()
          vim.cmd("Leet test")
        end,
        desc = "Test",
      },
      {
        "<leader>za",
        function()
          vim.cmd("Leet submit")
        end,
        desc = "Submit",
      },
      {
        "<leader>zc",
        function()
          vim.cmd("Leet console")
        end,
        desc = "Console",
      },
    },
    opts = {
      lang = "golang",
    },
    config = function(_, opts)
      require("which-key").add({
        { "<leader>z", group = "LeetCode" },
      })
      require("leetcode").setup(opts)
    end,
  },
}
