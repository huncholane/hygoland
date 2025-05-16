return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      diagnostics = {
        underline = true,
      },
      servers = {
        swift_mesonls = {
          enabled = true,
        },
        basedpyright = {
          enabled = true,
          settings = {
            basedpyright = {
              analysis = {
                typeCheckingMode = "strict",
                -- diagnosticMode = "workspace",
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
