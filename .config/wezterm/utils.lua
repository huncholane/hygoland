local wezterm = require("wezterm")
local mux = wezterm.mux
local M = {}

--- Spawns a new maximized window and executes the specified command.
--
-- This function creates a new window in WezTerm, executes the given command,
-- and maximizes the window.
--
-- Parameters:
--	args (table): A table containing the command and its arguments to be executed in the new window.
--
-- Returns:
--	wezterm.action_callback: A callback function that, when executed, spawns a new maximized window with the specified command.
function M.SpawnMaximizedCommandInNewWindow(args)
	return wezterm.action_callback(function(win, pane)
		local cwd_uri = pane:get_current_working_dir()
		local cwd = cwd_uri and cwd_uri.file_path or nil
		_, _, win = mux.spawn_window({ args = args, cwd = cwd })
		win:gui_window():maximize()
	end)
end

return M
