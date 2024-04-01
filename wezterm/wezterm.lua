local wezterm = require("wezterm")
local config = wezterm.config_builder()
local act = wezterm.action

if package.config:sub(1, 1) == "\\" then
	config.default_prog = { "C:\\Program Files\\Git\\bin\\sh.exe", "--login" }
	config.window_background_opacity = 0.8
else
	config.window_background_opacity = 0.7
	config.macos_window_background_blur = 10
end

local wez_tmux = wezterm.plugin.require("https://github.com/sei40kr/wez-tmux")
wez_tmux.apply_to_config(config, {})

local smart_splits = wezterm.plugin.require("https://github.com/mrjones2014/smart-splits.nvim")
-- you can put the rest of your Wezterm config here
smart_splits.apply_to_config(config, {
	direction_keys = { "h", "j", "k", "l" },
	-- modifier keys to combine with direction_keys
	modifiers = {
		move = "CTRL", -- modifier to use for pane movement, e.g. CTRL+h to move left
		resize = "META", -- modifier to use for pane resize, e.g. META+h to resize to the left
	},
})

config.leader = {
	key = "a",
	mods = "CTRL",
	timeout_milliseconds = math.maxinteger,
}

table.insert(config.keys, { key = "i", mods = "LEADER", action = act.SwitchToWorkspace })
table.insert(
	config.keys,
	{ key = "-", mods = "LEADER", action = wezterm.action.SplitVertical({ domain = "CurrentPaneDomain" }) }
)
table.insert(
	config.keys,
	{ key = "\\", mods = "LEADER", action = wezterm.action.SplitHorizontal({ domain = "CurrentPaneDomain" }) }
)

config.send_composed_key_when_left_alt_is_pressed = true
config.send_composed_key_when_right_alt_is_pressed = true

-- Background
config.window_decorations = "RESIZE"

-- Tab bar
config.tab_bar_at_bottom = false
config.use_fancy_tab_bar = false
config.status_update_interval = 1000

wezterm.on("update-status", function(window, pane)
	-- Time
	local time = wezterm.strftime("%H:%M")

	-- Current working directory
	local basename = function(s)
		-- Nothing a little regex can't fix
		return string.gsub(s, "(.*[/\\])(.*)", "%2")
		-- return s
	end

	-- CWD and CMD could be nil (e.g. viewing log using Ctrl-Alt-l). Not a big deal, but check in case
	local cwd = pane:get_current_working_dir()
	cwd = basename(cwd.path) or ""
	-- Current command
	local cmd = basename(pane:get_foreground_process_name()) or ""

	window:set_left_status(wezterm.format({
		{ Text = " " .. wezterm.mux.get_active_workspace() },
		{ Text = " | " },
	}))

	-- Right status
	window:set_right_status(wezterm.format({
		{ Text = wezterm.nerdfonts.md_folder .. "  " .. cwd },
		{ Text = " | " },
		{ Foreground = { Color = "#e0af68" } },
		{ Text = wezterm.nerdfonts.fa_code .. "  " .. cmd },
		"ResetAttributes",
		{ Text = " | " },
		{ Text = wezterm.nerdfonts.md_clock .. "  " .. time },
		{ Text = "  " },
	}))
end)

return config
