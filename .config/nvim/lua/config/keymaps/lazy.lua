local function telescope_config(path)
  require("telescope.builtin").find_files({
    cwd = vim.fn.stdpath("config") .. path,
  })
end

-- open lazy extra
vim.keymap.set("n", "<leader>le", function()
  vim.cmd("LazyExtra")
end, { desc = "Extras" })

-- reload current file as plugin
vim.keymap.set("n", "<leader>lr", function()
  vim.cmd("silent! write")
  local file = vim.fn.expand("%:p")
  local result = dofile(file)
  local plugins = {}
  -- add plugin to table
  local function handleplugin(plugin)
    local name = plugin[1] or plugin.name
    local _, repo = (plugin[1] or plugin.name):match("([^/]+)/([^/]+)")
    if repo then
      plugin = repo
    else
      plugin = name
    end
    table.insert(plugins, plugin)
  end
  -- add all the plugins to table
  if type(result[1]) == "table" then
    for _, plugin in ipairs(result) do
      handleplugin(plugin)
    end
  else
    handleplugin(result)
  end
  -- reload each plugin
  for _, plugin in ipairs(plugins) do
    vim.cmd("Lazy reload " .. plugin)
  end
end, { desc = "Reload File Plugins" })

-- edit keymaps
vim.keymap.set("n", "<leader>lk", function()
  telescope_config("/lua/config/keymaps")
end, { desc = "Browse Keymaps" })

-- edit options
vim.keymap.set("n", "<leader>lo", function()
  vim.cmd("e ~/.config/nvim/lua/config/options.lua")
end, { desc = "Edit Options" })

-- telescope user defined plugins
vim.keymap.set("n", "<leader>lp", function()
  telescope_config("/lua/plugins")
end, { desc = "Browse Plugins" })

-- source the current file
vim.keymap.set("n", "<leader>ls", function()
  vim.cmd("silent! write")
  local filename = vim.api.nvim_buf_get_name(0)
  vim.notify("Source " .. filename)
  vim.cmd.source(filename)
end, { desc = "Source Current File (:so %)" })
