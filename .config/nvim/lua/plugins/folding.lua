local general = vim.api.nvim_create_augroup("Folding", { clear = true })

-- use comments for fold expression
-- use comments for fold expression
-- use comments for fold expression
-- use comments for fold expression
_G.CommentFoldExpr = function()
  local line = vim.fn.getline(vim.v.lnum)
  local ft = vim.bo.filetype
  local cs = vim.bo.commentstring:gsub("%%s", ""):gsub(" ", ""):gsub("([^%w])", "%%%1")
  local should_fold = line:match("^%s*" .. cs) or _G.in_docstring
  -- python docstrings
  if ft == "python" then
    if line:match('""".*"""') then
      return "0"
    end
    if line:match('"""') then
      if _G.in_docstring then
        _G.in_docstring = false
      else
        _G.in_docstring = true
        should_fold = true
      end
    end
  end
  -- lua docstrings
  if ft == "lua" then
    if line:match("--%[%[") then
      _G.in_docstring = true
      -- should_fold = true
    end
    if line:match("--%]%]") and _G.in_docstring then
      _G.in_docstring = false
    end
  end
  if should_fold then
    return 1
  end
  return 0
end
local foldexpr = "v:lua.CommentFoldExpr()"
vim.api.nvim_create_user_command("UseFoldTreesitter", function()
  vim.opt_local.foldexpr = foldexpr
end, { desc = "Set fold expression to treesitter" })
vim.api.nvim_create_user_command("UseFoldComment", function()
  foldexpr = "v:lua.CommentFoldExpr()"
  vim.opt_local.foldexpr = foldexpr
end, { desc = "Set foldexpr to comments" })
vim.api.nvim_create_autocmd({ "BufReadPost", "FileType" }, {
  group = general,
  pattern = "*",
  callback = function()
    vim.opt_local.foldmethod = "expr"
    vim.opt_local.foldexpr = foldexpr
  end,
})

return {}
