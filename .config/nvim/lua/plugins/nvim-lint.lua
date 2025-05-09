return {
  "mfussenegger/nvim-lint",
  opts = function()
    local lint = require("lint")
    lint.linters.markdownlint.args = {
      "--disable",
      "MD013",
      "MD007",
      "--",
    }
  end,
}
