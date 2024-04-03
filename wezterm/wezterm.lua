local wezterm = require("wezterm")
local config = wezterm.config_builder()
local act = wezterm.action

local opacity = 0.0

if package.config:sub(1, 1) == "\\" then
	config.default_prog = { "C:\\Program Files\\Git\\bin\\sh.exe", "--login" }
	opacity = 0.8
else
	opacity = 0.7
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
config.window_background_opacity = opacity

-- Text
config.colors = {
	tab_bar = {
		background = "rgba(0,0,0," .. opacity .. ")",
		inactive_tab_edge = "rgba(0,0,0," .. opacity .. ")",
		active_tab = {
			-- The color of the background area for the tab
			bg_color = "rgba(0,0,0,1)",
			-- The color of the text for the tab
			fg_color = "#ffffff",
			underline = "Single",
		},
		inactive_tab = {
			-- The color of the background area for the tab
			bg_color = "rgba(0,0,0," .. opacity .. ")",
			-- The color of the text for the tab
			fg_color = "#c0c0c0",
		},
		new_tab = {
			bg_color = "rgba(0,0,0," .. opacity .. ")",
			fg_color = "#c0c0c0",

			-- The same options that were listed under the `active_tab` section above
			-- can also be used for `new_tab`.
		},
	},
}

-- Colors

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
		{ Text = "  " .. wezterm.mux.get_active_workspace() },
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
