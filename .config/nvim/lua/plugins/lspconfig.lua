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
              analysis = {
                typeCheckingMode = "basic",
                diagnosticMode = "workspace",
              },
            },
            python = {},
          },
        },
        pyright = {
          enabled = false,
          settings = {
            python = {
              analysis = {},
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
  },
}
