-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
require("config.keymaps.lazy")

-- Toggle markdown
vim.keymap.set("n", "<leader>ch", function()
  if vim.wo.conceallevel > 0 then
    vim.wo.conceallevel = 0
    vim.notify("Conceal ON")
  else
    vim.wo.conceallevel = 2
    vim.notify("Conceal OFF")
  end
end, { desc = "Toggle Markdown Conceal" })

-- Toggle inlay hints
vim.keymap.set({ "n" }, "<leader>ci", function()
  vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
  if vim.lsp.inlay_hint.is_enabled() then
    vim.notify("Enabled inlay hint")
  else
    vim.notify("Disabled inlay hint")
  end
end, { desc = "Toggle Inlay Hints" })

-- Remove carriage
vim.keymap.set("n", "<leader>cu", function()
  vim.cmd(":%s/\r//g")
end, { desc = "Remove carriage return" })

-- restart lsp
vim.keymap.set("n", "<leader>cz", function()
  vim.notify("Running LspRestart")
  vim.cmd("LspRestart")
end, { desc = "Restart lsp" })

-- Telescope document symbols
vim.keymap.set("n", "<leader>cd", function()
  vim.cmd("Telescope lsp_document_symbols")
end, { desc = "Telescope Document Symbols" })

-- Telescope treesitter keymap
vim.keymap.set("n", "<leader>ct", function()
  vim.cmd("Telescope treesitter")
end, { desc = "Telescope Treesitter" })

-- Telescope hidden files
vim.keymap.set("n", "<leader>fi", function()
  vim.cmd("Telescope find_files no_ignore=true")
end, { desc = "Telescope Hidden" })

-- Force comment folding
vim.keymap.set("n", "zk", function()
  _G.in_docstring = false
  vim.cmd("UseFoldComment")
  vim.cmd("normal zx")
  vim.cmd("normal zM")
end, { desc = "Forcefully fold comments" })

-- Main live grep on cwd instead of git root
vim.keymap.set("n", "<leader>/", function()
  require("telescope.builtin").live_grep({ cwd = vim.fn.getcwd() })
end, { desc = "Telescope (cwd)" })

-- Main file telescope cwd instead of git root
vim.keymap.set("n", "<leader><space>", function()
  require("telescope.builtin").find_files({ cwd = vim.fn.getcwd(), hidden = true })
end, { desc = "Find files (cwd)" })

-- Close or open lsp popup
vim.keymap.set({ "n" }, "<leader>cn", "<cmd>NoiceDismiss<cr>", { desc = "Dismiss Noice" })
