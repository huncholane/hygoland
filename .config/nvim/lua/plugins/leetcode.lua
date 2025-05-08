-- wipes all the keys for the given regex
local function wipe_keys_for(regex)
  for _, key in ipairs(vim.api.nvim_get_keymap("n")) do
    if key.lhs:find(regex) then
      vim.noptify("removing" .. key.lhs)
      vim.api.nvim_del_keymap("n", key.lhs)
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
            -- wipe_keys_for("l")
            vim.api.nvim_del_keymap("n", "<leader>l")
            vim.api.nvim_set_keymap("n", "<leader>l", "", { desc = "LeetCode" })
            vim.api.nvim_set_keymap("n", "<leader>ls", "<cmd>Leet submit<cr>", { desc = "Submit" })
            vim.api.nvim_set_keymap("n", "<leader>lt", "<cmd>Leet test<cr>", { desc = "Test" })
            vim.api.nvim_set_keymap("n", "<Leader>ll", "<cmd>Leet list<cr>", { desc = "List" })
          end
        end,
      })
      require("leetcode").setup(opts)
    end,
  },
}
