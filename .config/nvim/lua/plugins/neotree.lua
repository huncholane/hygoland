return {
  -- https://github.com/nvim-neo-tree/neo-tree.nvim/wiki/Recipes#open-with-system-viewer
  "nvim-neo-tree/neo-tree.nvim",
  enabled = false,
  opts = {
    filesystem = {
      hijack_netrw_behavior = "disabled",
      window = {
        mappings = {
          ["O"] = "system_open",
        },
      },
    },
    commands = {
      system_open = function(state)
        local node = state.tree:get_node()
        local path = node:get_id()
        vim.fn.jobstart({ "wslview", path }, { detach = true })
      end,
    },
  },
}
