local wezterm = require("wezterm")
local config = {}

if package.config:sub(1, 1) == "\\" then
	config.default_prog = { "powershell.exe", "-NoLogo" }
end

local wez_tmux = wezterm.plugin.require("https://github.com/sei40kr/wez-tmux")
wez_tmux.apply_to_config(config, {})

config.leader = {
	key = "a",
	mods = "CTRL",
	timeout_milliseconds = math.maxinteger,
}

-- Background
config.window_background_opacity = 0.8

return config
