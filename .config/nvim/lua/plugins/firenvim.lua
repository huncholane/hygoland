return {
  -- enable firenvim
  {
    "glacambre/firenvim",
    build = ":call firenvim#install(0)",
    config = function()
      if vim.g.started_by_firenvim then
        vim.cmd("colorscheme tokyonight-day")
      end
      vim.g.firenvim_config = {
        globalSettings = { alt = "all" },
        localSettings = {
          [".*"] = {
            takeover = "never",
          },
        },
      }
    end,
  },
  -- disable extnsions based on firenvim
  {
    "folke/noice.nvim",
    enabled = not vim.g.started_by_firenvim,
  },
}
