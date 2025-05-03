local M = {}

-- tabs function
function M.set_tabs(length)
  vim.bo.tabstop = length
  vim.bo.shiftwidth = length
  vim.bo.softtabstop = length
  vim.bo.expandtab = true
end

-- configure a language
function M.config_lang(filetype, func)
  if vim.bo.filetype == filetype then
    func()
  end
  local augroup = vim.api.nvim_create_augroup(filetype .. "Options", { clear = true })
  vim.api.nvim_create_autocmd("Filetype", {
    group = augroup,
    callback = func,
  })
end

return M
