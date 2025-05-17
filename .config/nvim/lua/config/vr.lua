vim.keymap.set("n", "q", "<cmd>qa!<CR>", { noremap = true, silent = true })
vim.keymap.set("v", "q", "<cmd>qa!<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<C-c>", "<cmd>qa!<CR>", { noremap = true, silent = true })
vim.keymap.set("v", "<C-c>", "<cmd>qa!<CR>", { noremap = true, silent = true })
vim.o.number = true
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
      ["*"] = "wl-paste --primary --no-newline",
    },
    cache_enabled = 1,
  }
end
vim.o.clipboard = "unnamedplus"
