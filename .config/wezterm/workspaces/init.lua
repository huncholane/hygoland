local wezterm = require("wezterm")
local mux = wezterm.mux
local act = wezterm.action
local manager = {}

local M = {}

-- Generates a string of environment variable exports for a given workspace.
--
-- Parameters:
-- 	ws (string): The workspace identifier used to retrieve environment variables.
--
-- Returns:
-- 	string: A concatenated string of export statements for the environment variables.
function M.env_text(ws)
	local text = ""
	if manager[ws].env then
		for key, val in pairs(manager[ws].env) do
			text = text .. "export " .. key .. "='" .. val .. "';"
		end
	end
	return text
end

function M.add_env(ws, pane)
	pane:send_text(M.env_text(ws) .. "\n")
end

function M.SplitWithEnv(direction)
	return wezterm.action_callback(function(win, pane)
		pane = pane:split({ direction = direction })
		local ws = win:get_workspace()
		if manager[ws] and manager[ws].env then
			pane.send_text(M.env_text(ws) .. "\n")
		end
	end)
end

function M.add_keys(config)
	table.insert(config.keys, {
		key = '"',
		mods = "CTRL|SHIFT",
		action = M.SplitWithEnv("Bottom"),
	})
	table.insert(config.keys, {
		key = "%",
		mods = "CTRL|SHIFT",
		action = M.SplitWithEnv("Right"),
	})
end

local function load_pane(ws, pane, pane_config)
	M.add_env(ws, pane)
	pane:send_text("clear\n")
	if pane_config.init then
		pane:send_text(table.concat(pane_config.init, ";") .. "\n")
	end
end

local function load_tab(ws, tab, tab_config)
	load_pane(ws, tab:active_pane(), tab_config)
	if tab_config.extra_panes then
		for _, pane_config in ipairs(tab_config.extra_panes) do
			local pane = tab:active_pane():split({ cwd = pane_config.cwd or tab_config.cwd or manager[ws].cwd })
			load_pane(ws, pane, pane_config)
		end
	end
end

local function load_workspace(modname, ws)
	local config = require(modname)
	manager[ws] = config
	local tab, _, window = mux.spawn_window({
		cwd = config.cwd,
		workspace = ws,
	})
	load_tab(ws, tab, config)
	if config.extra_tabs then
		for _, tab_config in ipairs(config.extra_tabs) do
			tab, _, _ = window:spawn_tab({ cwd = tab_config.cwd or config.cwd })
			load_tab(ws, tab, tab_config)
		end
	end
end

local function load_workspaces()
	local wdir = wezterm.home_dir .. "/.config/wezterm/workspaces"
	for _, v in ipairs(wezterm.read_dir(wdir)) do
		-- setup modname agnostic of file system
		local modname = v:match(".*%.config/wezterm/(.*)%.lua"):gsub("/", "."):gsub("\\", ".")
		local wname = modname:match(".*%.(.*)")
		if wname ~= "init" then
			load_workspace(modname, wname)
		end
	end
end

function M.setup(config)
	M.add_keys(config)
	wezterm.on("gui-startup", function()
		load_workspaces()
	end)
end

return M
