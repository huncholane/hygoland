return {
  "yochem/jq-playground.nvim",
  event = "VeryLazy",
  config = function()
    local function toggle_jq_playground()
      local closed_any = false
      for _, win in ipairs(vim.api.nvim_list_wins()) do
        local buf = vim.api.nvim_win_get_buf(win)
        local name = vim.api.nvim_buf_get_name(buf)
        if name:match("jq query editor") or name:match("jq output") then
          closed_any = true
          vim.api.nvim_win_close(win, true)
          vim.api.nvim_buf_delete(buf, { force = true })
        end
      end
      if not closed_any then
        vim.cmd("JqPlayground")
      end
    end

    vim.api.nvim_create_autocmd("BufEnter", {
      pattern = { "jq query editor", "jq output" },
      callback = function() end,
    })

    vim.api.nvim_create_autocmd("FileType", {
      pattern = "jq",
      callback = function()
        vim.keymap.set({ "i", "n" }, "<C-c>", function()
          toggle_jq_playground()
        end, { buffer = true, desc = "Close jq" })
      end,
    })
    vim.keymap.set("n", "<leader>cj", toggle_jq_playground, { desc = "Toggle Jq Playground" })
  end,
}
