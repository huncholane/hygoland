return {
  -- copilot
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    build = ":Copilot auth",
    event = "BufReadPost",
    opts = {
      suggestion = {
        enabled = not vim.g.ai_cmp,
        auto_trigger = false,
        hide_during_completion = vim.g.ai_cmp,
        keymap = {
          accept = false, -- handled by nvim-cmp / blink.cmp
          next = "<M-]>",
          prev = "<M-[>",
        },
      },
      panel = { enabled = false },
      filetypes = {
        markdown = true,
        help = true,
      },
    },
  },

  -- chat config
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    branch = "main",
    cmd = "CopilotChat",
    opts = function()
      local user = vim.env.USER or "User"
      user = user:sub(1, 1):upper() .. user:sub(2)
      return {
        prompts = {
          Docs = {
            prompt = "Add docstrings that clearly explain parameters and returns with the correct format.",
            system = "You write good docs.",
            description = "Add structured, language-aware documentation",
          },
        },
        auto_insert_mode = true,
        question_header = "  " .. user .. " ",
        answer_header = "  Copilot ",
        model = "gpt-4o",
        window = {
          width = 0.4,
        },
      }
    end,
    keys = {
      { "<c-s>", "<CR>", ft = "copilot-chat", desc = "Submit Prompt", remap = true },
      { "<leader>a", "", desc = "+ai", mode = { "n", "v" } },
      {
        "<leader>af",
        function()
          local cpc = require("CopilotChat")
          vim.cmd("normal vaf")
          cpc.open({ include_contexts_in_prompt = true })
        end,
        desc = "Query function",
      },
      {
        "<leader>ad",
        function()
          local cpc = require("CopilotChat")
          vim.cmd("normal vaf")
          cpc.ask(
            "Add docstrings that clearly explain parameters and returns with the correct indentations using tabs and newlines."
          )
        end,
        desc = "Add docs to function",
        mode = "n",
      },
      {
        "<leader>aa",
        function()
          return require("CopilotChat").toggle()
        end,
        desc = "Toggle (CopilotChat)",
        mode = { "n", "v" },
      },
      {
        "<leader>ax",
        function()
          return require("CopilotChat").reset()
        end,
        desc = "Clear (CopilotChat)",
        mode = { "n", "v" },
      },
      {
        "<leader>aq",
        function()
          vim.ui.input({
            prompt = "Quick Chat: ",
          }, function(input)
            if input ~= "" then
              require("CopilotChat").ask(input)
            end
          end)
        end,
        desc = "Quick Chat (CopilotChat)",
        mode = { "n", "v" },
      },
      {
        "<leader>ap",
        function()
          require("CopilotChat").select_prompt()
        end,
        desc = "Prompt Actions (CopilotChat)",
        mode = { "n", "v" },
      },
      {
        "<C-a>",
        "<Esc><C-y>q",
        ft = "copilot-chat",
        desc = "Submit and close",
        mode = { "n", "i" },
        remap = true,
      },
    },
    config = function(_, opts)
      vim.env.OPENAI_API_KEY = os.getenv("OPENAI_API_KEY")
      local chat = require("CopilotChat")

      vim.api.nvim_create_autocmd("BufEnter", {
        pattern = "copilot-chat",
        callback = function()
          vim.opt_local.relativenumber = false
          vim.opt_local.number = false
        end,
      })

      chat.setup(opts)
    end,
  },
}
