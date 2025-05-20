local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node

return {
  -- Simple triple-quote docstring
  s("ds", {
    t({ '"""' }),
    t({ "", "" }),
    i(1, "Summary."),
    t({ "", '"""' }),
  }),
}
