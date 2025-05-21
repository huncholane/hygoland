-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

-- disable completions with ai
vim.g.ai_cmp = false

-- disable swap files, not needed with autosession
vim.opt.swapfile = false

-- wayland settings
if vim.fn.getenv("WAYLAND_DISPLAY") ~= vim.NIL then
  -- vim.notify("Wayland detected")

  vim.g.clipboard = {
    name = "wl-clipboard",
    copy = {
      ["+"] = "wl-copy --foreground --type text/plain",
      ["*"] = "wl-copy --foreground --primary --type text/plain",
    },
    paste = {
      ["+"] = "wl-paste --no-newline",
      ["*"] = "xclip -selection primary -o",
    },
    cache_enabled = 1,
  }
end

-- disable animations
vim.g.snacks_animate = false

-- set normal numbers
vim.cmd("set norelativenumber")

-- fold basic comments
-- vim.opt.foldmethod = "expr"
-- vim.opt.foldopen = ""
-- vim.opt.foldexpr = "v:lua.CommentFoldExpr()"

-- add suggested options for autosession
vim.o.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"
