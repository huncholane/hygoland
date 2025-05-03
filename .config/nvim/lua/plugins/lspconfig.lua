return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      diagnostics = {
        underline = true,
      },
      servers = {
        basedpyright = {
          enabled = true,
          settings = {
            basedpyright = {
              analysis = {},
            },
            python = {
              pythonPath = "/home/huncho/anaconda3/bin/python",
            },
          },
        },
        pyright = {
          enabled = false,
          settings = {
            python = {
              pythonPath = "/home/huncho/anaconda3/bin/python",
              analysis = {
                autoSearchPaths = true,
                useLibraryCodeForTypes = true,
                typeCheckingMode = "basic",
                diagnosticMode = "workspace",
              },
            },
          },
        },
      },
      inlay_hints = {
        enabled = false,
      },
    },
  },
  {
    "nvimtools/none-ls.nvim",
    opts = function(_, opts)
      local nls = require("null-ls")
      opts.sources = opts.sources or {}
      vim.list_extend(opts.sources, {
        -- nls.builtins.diagnostics.mypy.with({
        --   command = "mypy",
        --   extra_args = { "--config-file", vim.fn.getcwd() .. "/mypy.ini" },
        -- }),
      })
    end,
  },
}
