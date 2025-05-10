-- wipes all the keys for the given startswith after leader
local function wipe_leader_keys(startswith)
  local m = vim.api.nvim_get_keymap("n")
  local leader = vim.g.mapleader

  for _, k in ipairs(m) do
    if k.lhs:find("^" .. leader .. startswith) then
      vim.api.nvim_del_keymap("n", k.lhs)
    end
  end
end

return {
  {
    "kawre/leetcode.nvim",
    event = "VeryLazy",
    dependencies = {
      "nvim-telescope/telescope.nvim",
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
    },
    opts = {
      lang = "python3",
    },
    config = function(_, opts)
      vim.api.nvim_create_autocmd("BufEnter", {
        callback = function()
          local has_leetcode = false
          for _, buf in ipairs(vim.api.nvim_list_bufs()) do
            if vim.bo[buf].filetype == "leetcode.nvim" then
              has_leetcode = true
            end
          end

          if has_leetcode then
            wipe_leader_keys("l")
            vim.api.nvim_set_keymap("n", "<leader>l", "", { desc = "LeetCode" })
            vim.api.nvim_set_keymap("n", "<leader>ls", "<cmd>Leet submit<cr>", { desc = "Submit" })
            vim.api.nvim_set_keymap("n", "<leader>lt", "<cmd>Leet test<cr>", { desc = "Test" })
            vim.api.nvim_set_keymap("n", "<Leader>ll", "<cmd>Leet list<cr>", { desc = "List" })
            vim.api.nvim_set_keymap("n", "<leader>lc", "<cmd>Leet console<cr>", { desc = "Console" })
            vim.api.nvim_set_keymap("n", "<leader>ly", "<cmd>Leet yank<cr>", { desc = "Yank" })
            vim.api.nvim_set_keymap("n", "<leader>lo", "<cmd>Leet open<cr>", { desc = "Open" })
          end
        end,
      })
      require("leetcode").setup(opts)
    end,
  },
}
