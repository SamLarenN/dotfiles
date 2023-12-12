local wezterm = require("wezterm")
local config = wezterm.config_builder()
local act = wezterm.action

local opacity = 1.0

local wez_tmux = wezterm.plugin.require("https://github.com/sei40kr/wez-tmux")
wez_tmux.apply_to_config(config, {})

-- Workspace namer
table.insert(config.keys, {
	key = "m",
	mods = "LEADER",
	action = wezterm.action.PromptInputLine({
		description = "Enter new name for workspace",
		action = wezterm.action_callback(function(window, pane, line)
			if line then
				wezterm.mux.rename_workspace(wezterm.mux.get_active_workspace(), line)
			end
		end),
	}),
})

-- Workspace switcher
local workspace_switcher = wezterm.plugin.require("https://github.com/MLFlexer/smart_workspace_switcher.wezterm")
workspace_switcher.apply_to_config(config)

table.insert(config.keys, {
	key = "s",
	mods = "LEADER",
	action = workspace_switcher.switch_workspace(),
})

-- Smart splits
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
config.window_background_opacity = opacity

-- Padding
config.window_padding = {
	left = 0,
	right = 0,
	top = 0,
	bottom = 0,
}

-- Colors
config.color_scheme = "zenbones"

-- Tab bar
config.tab_bar_at_bottom = false
config.use_fancy_tab_bar = false

-- config.window_frame = {
-- 	active_titlebar_bg = "rgba(0 0 0 0)",
-- }

return config
