-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

-- disable completions with ai
vim.g.ai_cmp = false

-- disable swap files, not needed with autosession
vim.opt.swapfile = false

-- wsl settings
---@diagnostic disable-next-line
if vim.loop.os_uname().release:match("WSL") then
  vim.notify("User is on wsl")

  -- open files in windows
  ---@diagnostic disable-next-line
  vim.ui.open = function(url)
    local cmd = { "wslview", url }
    vim.fn.jobstart(cmd, { detach = true })
  end

  -- Fix the clipboard
  local paste = "powershell.exe -NoProfile -Command Get-Clipboard"
  paste = 'sh -c "' .. paste .. '"'
  vim.g.clipboard = {
    name = "clip-wsl",
    copy = {
      ["+"] = "/mnt/c/tools/win32yank.exe -i --crlf",
      ["*"] = "/mnt/c/tools/win32yank.exe -i --crlf",
    },
    paste = {
      ["+"] = "/mnt/c/tools/win32yank.exe -o --lf",
      ["*"] = "/mnt/c/tools/win32yank.exe -o --lf",
    },
  }
end

-- wayland settings
if vim.fn.getenv("WAYLAND_DISPLAY") ~= vim.NIL then
  vim.notify("Wayland detected")

  vim.g.clipboard = {
    name = "wl-clipboard",
    copy = {
      ["+"] = "wl-copy",
      ["*"] = "wl-copy",
    },
    paste = {
      ["+"] = "wl-paste --no-newline",
      ["*"] = "wl-paste --no-newline",
    },
    cache_enabled = 1,
  }
end

-- disable animations
vim.g.snacks_animate = false

-- set normal numbers
vim.cmd("set norelativenumber")

-- fold basic comments
-- fold basic comments
-- fold basic comments
-- fold basic comments
vim.opt.foldmethod = "expr"
vim.opt.foldopen = ""
vim.opt.foldexpr = "v:lua.CommentFoldExpr()"
