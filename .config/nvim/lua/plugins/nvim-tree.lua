return {
  "nvim-tree/nvim-tree.lua",
  enabled = false,
  config = function()
    local nvim_tree = require("nvim-tree")
    local api = require("nvim-tree.api")

    -- Setup first
    nvim_tree.setup()

    -- Track last known root
    local last_root = vim.fn.getcwd()
    vim.api.nvim_create_autocmd("BufEnter", {
      pattern = "NvimTree_*",
      callback = function()
        local root = api.tree.get_root()
        if root and root.absolute_path then
          last_root = root.absolute_path
          vim.notify("move root to " .. last_root)
        end
      end,
    })
    -- -- Smart toggle with saved root
    -- vim.keymap.set("n", "<leader>e", function()
    --   if api.tree.is_visible() then
    --     api.tree.close()
    --   else
    --     api.tree.open({ path = last_root })
    --   end
    -- end, { desc = "Toggle Nvim-Tree at last location" })
  end,
}
