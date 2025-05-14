# Hygo Vim

If you use vim style coding in any editor, this will help you instantly
convert to neovim.

## Prerequisites

- If you are using a mac, you need to use iterm2. The default terminal doesn't support true color, so all the colorschemes will look terrible and unreadable.
- Kitty terminal works best with neovim.
- Install a [NerdFont Font](https://www.nerdfonts.com/font-downloads)
- [FD-Find](https://github.com/sharkdp/fd)

```bash
sudo apt install fd-find
```

- [ripgrep](https://github.com/BurntSushi/ripgrep)

```bash
sudo apt install ripgrep
```

- Install Neovim
  - Download for linux

```bash
curl -L -o ~/nvim.appimage https://github.com/neovim/neovim/releases/download/v0.11.0/nvim-linux-x86_64.appimage
```

- Add this to bashrc

```bash
alias nvim='~/nvim.appimage'
alias nv=nvim
alias vim=nvim
```

- Set up win32yank for wsl to paste like an absolute gangster
  - Note use yanky `<leader>p` to paste if you delete before pasting cuz we use unnamedplus default keyboard

```bash
curl -o win32yank.zip https://github.com/equalsraf/win32yank/releases/download/v0.1.1/win32yank-x86.zip -L
unzip win32yank.zip
chmod +x win32yank.exe
sudo mkdir /mnt/c/tools/
sudo cp win32yank.exe /mnt/c/tools/
rm win32yank*
```

## Tmux like a pro

- Add this to .tmux.conf

```conf
source-file ~/.config/nvim/tmux.conf
```

## Setup toggle term `~/.config/nvim/lua/plugins/toggleterm.lua`

```lua
return {
  "akinsho/toggleterm.nvim",
  keys = {
    -- Creates name group for which-key
    {
      "<leader>t",
      desc = "toggleterm",
    },
    -- Creates a new floating terminal
    {
      "<leader>tf",
      "<cmd>TermNew direction=float<cr>",
      desc = "Create New Floating Terminal",
    },
    -- Creates a new tabbed terminal
    {
      "<leader>tt",
      "<cmd>TermNew direction=tab<cr>",
      desc = "Create New Tabbed Terminal",
    },
    -- Selects a terminal
    {
      "<leader>ts",
      "<cmd>TermSelect<cr>",
      desc = "Select Terminal",
    },
  },
  opts = {
    open_mapping = [[<c-\>]],
  },
}
```

## Setup autosave `~/.config/nvim/lua/config/autocmds.lua`

- Add this to autocmd

````lua
-- autosave on focus lost and buffer change
local group = vim.api.nvim_create_augroup("autosave_group", { clear = true })
vim.api.nvim_create_autocmd({ "FocusLost", "BufLeave" }, {
  group = group,
  callback = function(opts)
    if vim.bo.modifiable and not vim.bo.readonly and vim.bo.modified then
      local file = vim.fn.expand("%t")
      vim.cmd("silent! write")
      vim.notify("Autosaved " .. file .. "\nSource " .. opts.event)
    end
  end,
}) ```

## Vim In Your Browser `~/.config/nvim/lua/plugins/firenvim.lua`

```lua
return {
  -- enable firenvim
  {
    "glacambre/firenvim",
    build = ":call firenvim#install(0)",
    config = function()
      if vim.g.started_by_firenvim then
        vim.cmd("colorscheme tokyonight-day")
      end
      vim.g.firenvim_config = {
        globalSettings = { alt = "all" },
        localSettings = {
          [".*"] = {
            takeover = "never",
          },
        },
      }
    end,
  },
  -- disable extnsions based on firenvim
  {
    "folke/noice.nvim",
    enabled = not vim.g.started_by_firenvim,
  },
}
````
