-- bootstrap lazy.nvim, LazyVim and your plugins
if vim.o.readonly then
  vim.keymap.set("n", "q", "<cmd>qa!<CR>", { noremap = true, silent = true })
  vim.o.number = true
else
  require("config.lazy")
end
