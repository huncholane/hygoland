-- bootstrap lazy.nvim, LazyVim and your plugins
if vim.o.readonly then
  require("config.vr")
else
  require("config.lazy")
end
