local wezterm = require("wezterm")
local act = wezterm.action
local mux = wezterm.mux
local config = wezterm.config_builder()

-- basic config
config.default_domain = "WSL:Ubuntu"

-- window config
config.font = wezterm.font("Hack Nerd Font")
config.font_size = 11.0
config.window_decorations = "RESIZE"
config.window_background_opacity = 0.85
config.enable_scroll_bar = true
config.colors = {
  scrollbar_thumb = "grey",
}
config.color_scheme = "Tokyo Night Storm"

-- keymap
config.keys = {
  -- vim-like pane movement
  { key = "h", mods = "CTRL|SHIFT", action = act.ActivatePaneDirection("Left") },
  { key = "j", mods = "CTRL|SHIFT", action = act.ActivatePaneDirection("Down") },
  { key = "k", mods = "CTRL|SHIFT", action = act.ActivatePaneDirection("Up") },
  { key = "l", mods = "CTRL|SHIFT", action = act.ActivatePaneDirection("Right") },
  { key = "h", mods = "CTRL|SHIFT|ALT", action = act.AdjustPaneSize({ "Left", 3 }) },
  { key = "j", mods = "CTRL|SHIFT|ALT", action = act.AdjustPaneSize({ "Down", 3 }) },
  { key = "k", mods = "CTRL|SHIFT|ALT", action = act.AdjustPaneSize({ "Up", 3 }) },
  { key = "l", mods = "CTRL|SHIFT|ALT", action = act.AdjustPaneSize({ "Right", 3 }) },

  -- debug
  { key = "d", mods = "CTRL|SHIFT", action = act.ShowDebugOverlay },

  -- quit all
  { key = "q", mods = "CTRL|SHIFT", action = act.QuitApplication },

  -- Show the launcher in fuzzy selection mode and have it list all workspaces
  -- and allow activating one.
  {
    key = "9",
    mods = "ALT",
    action = act.ShowLauncherArgs({
      flags = "FUZZY|WORKSPACES",
    }),
  },
  { key = "n", mods = "ALT", action = act.SwitchWorkspaceRelative(1) },
  { key = "p", mods = "ALT", action = act.SwitchWorkspaceRelative(-1) },
  -- Prompt for a name to use for a new workspace and switch to it.
  {
    key = "w",
    mods = "CTRL|SHIFT",
    action = act.PromptInputLine({
      description = wezterm.format({
        { Attribute = { Intensity = "Bold" } },
        { Foreground = { AnsiColor = "Fuchsia" } },
        { Text = "Enter name for new workspace" },
      }),
      action = wezterm.action_callback(function(window, pane, line)
        -- line will be `nil` if they hit escape without entering anything
        -- An empty string if they just hit enter
        -- Or the actual line of text they wrote
        if line then
          window:perform_action(
            act.SwitchToWorkspace({
              name = line,
            }),
            pane
          )
        end
      end),
    }),
  },

  -- open lazygit
  {
    key = "g",
    mods = "CTRL|SHIFT",
    action = act.SpawnCommandInNewWindow({ args = { "lazygit" } }),
  },
}

-- plugins
local tabline = wezterm.plugin.require("https://github.com/michaelbrusegard/tabline.wez")
tabline.setup()
tabline.apply_to_config(config)

-- log success on reload
wezterm.on("window-config-reloaded", function(_, _)
  wezterm.log_info("Successfully loaded config")
end)

require("workspaces")

return config
