-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")
local general = vim.api.nvim_create_augroup("autosave_group", { clear = true })

vim.api.nvim_create_autocmd({ "FocusLost", "BufLeave", "CmdlineEnter", "QuitPre" }, {
  group = general,
  callback = function(opts)
    local ignore_ft = {
      "neo-tree",
      "lazy",
      "TelescopePrompt",
      "gitcommit",
      "help",
      "qf",
      "dashboard",
      "jq",
    }

    local ft = vim.bo.filetype
    if vim.bo.modifiable and not vim.bo.readonly and vim.bo.modified and not vim.tbl_contains(ignore_ft, ft) then
      local file = vim.fn.expand("%t")
      vim.cmd("LazyFormat")
      vim.cmd("silent! write")
      vim.notify("Autosaved " .. file .. "\nSource " .. opts.event)
    end
  end,
})

-- tmux files as bash filetype
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = "*.tmux",
  callback = function()
    vim.bo.filetype = "bash"
  end,
})

-- stop making comments on new lines
vim.opt.formatoptions:remove({ "c", "r", "o" })
vim.api.nvim_create_autocmd("FileType", {
  pattern = "*",
  callback = function()
    -- Disable comment on new line
    vim.opt.formatoptions:remove({ "c", "r", "o" })
  end,
  group = general,
  desc = "Disable New Line Comment",
})

-- disable mouse dynamically
vim.api.nvim_create_autocmd({ "FocusGained" }, {
  group = general,
  callback = function()
    vim.opt.mouse = "a"
  end,
})
vim.api.nvim_create_autocmd({ "FocusLost" }, {
  group = general,
  callback = function()
    vim.opt.mouse = ""
  end,
})

-- disable guicursor in terminal
local guicursor = vim.opt.guicursor
vim.api.nvim_create_autocmd("TermEnter", {
  group = general,
  callback = function()
    vim.opt.guicursor = ""
  end,
})
vim.api.nvim_create_autocmd("TermLeave", {
  group = general,
  callback = function()
    vim.opt.guicursor = guicursor
  end,
})

-- vim command for setting tabs
vim.api.nvim_create_user_command("SetTabs", function(opts)
  local length = tonumber(opts.args)
  if length then
    require("utils.formatting").set_tabs(length)
    vim.notify("Set tabs to " .. length)
  else
    vim.notify("Invalid number", vim.log.levels.ERROR)
  end
end, { desc = "Set tab width for current buffer.", nargs = 1 })
