local wezterm = require("wezterm")
local config = wezterm.config_builder()
local act = wezterm.action

local opacity = 1

--if package.config:sub(1, 1) == "\\" then
--	config.default_prog = { "C:\\Program Files\\Git\\bin\\sh.exe", "--login" }
--	opacity = 0.8
--else
--	opacity = 0.7
--	config.macos_window_background_blur = 10
--end

local wez_tmux = wezterm.plugin.require("https://github.com/sei40kr/wez-tmux")
wez_tmux.apply_to_config(config, {})

-- Resurrect
local resurrect = wezterm.plugin.require("https://github.com/MLFlexer/resurrect.wezterm")
table.insert(config.keys, {
	key = "r",
	mods = "LEADER",
	action = wezterm.action_callback(function(win, pane)
		resurrect.fuzzy_load(win, pane, function(id, label)
			local type = string.match(id, "^([^/]+)") -- match before '/'
			id = string.match(id, "([^/]+)$") -- match after '/'
			id = string.match(id, "(.+)%..+$") -- remove file extention
			local opts = {
				relative = true,
				restore_text = true,
				on_pane_restore = resurrect.tab_state.default_on_pane_restore,
			}
			if type == "workspace" then
				local state = resurrect.load_state(id, "workspace")
				resurrect.workspace_state.restore_workspace(state, opts)
			elseif type == "window" then
				local state = resurrect.load_state(id, "window")
				resurrect.window_state.restore_window(pane:window(), state, opts)
			elseif type == "tab" then
				local state = resurrect.load_state(id, "tab")
				resurrect.tab_state.restore_tab(pane:tab(), state, opts)
			end
		end)
	end),
})

-- Save workspace and windows
table.insert(config.keys, {
	key = "w",
	mods = "LEADER",
	action = wezterm.action_callback(function(win, pane)
		resurrect.save_state(resurrect.workspace_state.get_workspace_state())
		resurrect.window_state.save_window_action()
	end),
})

-- Delete workspaces in resurrect
table.insert(config.keys, {
	key = "d",
	mods = "LEADER",
	action = wezterm.action_callback(function(win, pane)
		resurrect.fuzzy_load(win, pane, function(id)
			resurrect.delete_state(id)
		end, {
			title = "Delete State",
			description = "Select State to Delete and press Enter = accept, Esc = cancel, / = filter",
			fuzzy_description = "Search State to Delete: ",
			is_fuzzy = true,
		})
	end),
})

-- loads the state whenever I create a new workspace
wezterm.on("smart_workspace_switcher.workspace_switcher.created", function(window, path, label)
	local workspace_state = resurrect.workspace_state

	workspace_state.restore_workspace(resurrect.load_state(label, "workspace"), {
		window = window,
		relative = true,
		restore_text = true,
		on_pane_restore = resurrect.tab_state.default_on_pane_restore,
	})
end)

-- Saves the state whenever I select a workspace
wezterm.on("smart_workspace_switcher.workspace_switcher.selected", function(window, path, label)
	local workspace_state = resurrect.workspace_state
	resurrect.save_state(workspace_state.get_workspace_state())
end)

-- Workspace namer
table.insert(config.keys, {
	key = "m",
	mods = "LEADER",
	action = wezterm.action.PromptInputLine({
		description = "Enter new name for workspace",
		action = wezterm.action_callback(function(window, pane, line)
			if line then
				wezterm.mux.rename_workspace(wezterm.mux.get_active_workspace(), line)
				resurrect.save_state(workspace_state.get_workspace_state())
			end
		end),
	}),
})

-- Workspace swither
local workspace_switcher = wezterm.plugin.require("https://github.com/MLFlexer/smart_workspace_switcher.wezterm")
workspace_switcher.apply_to_config(config)

table.insert(config.keys, {
	key = "s",
	mods = "LEADER",
	action = workspace_switcher.switch_workspace(),
})
table.insert(config.keys, {
	key = "S",
	mods = "LEADER",
	action = workspace_switcher.switch_to_prev_workspace(),
})

wezterm.on("augment-command-palette", function(window, pane)
	local workspace_state = resurrect.workspace_state
	return {
		{
			brief = "Window | Workspace: Switch Workspace",
			icon = "md_briefcase_arrow_up_down",
			action = workspace_switcher.switch_workspace(),
		},
		{
			brief = "Window | Workspace: Rename Workspace",
			icon = "md_briefcase_edit",
			action = wezterm.action.PromptInputLine({
				description = "Enter new name for workspace",
				action = wezterm.action_callback(function(window, pane, line)
					if line then
						wezterm.mux.rename_workspace(wezterm.mux.get_active_workspace(), line)
						resurrect.save_state(workspace_state.get_workspace_state())
					end
				end),
			}),
		},
	}
end)

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

-- Text

-- Padding
config.window_padding = {
	left = 0,
	right = 0,
	top = 0,
	bottom = 0,
}

function hex_to_rgb_string(hex)
	-- Remove the hash (#) if it exists
	hex = hex:gsub("#", "")

	-- Convert the hex to RGB values
	local r = tonumber(hex:sub(1, 2), 16)
	local g = tonumber(hex:sub(3, 4), 16)
	local b = tonumber(hex:sub(5, 6), 16)

	-- Return as a comma-separated string
	return string.format("%d,%d,%d", r, g, b)
end

-- Colors
local my_scheme = wezterm.color.get_builtin_schemes()["Github Dark (Gogh)"]
config.color_schemes = {
	["My Scheme"] = my_scheme,
}
config.color_scheme = "My Scheme"

config.colors = {
	tab_bar = {
		background = "rgba(" .. hex_to_rgb_string(my_scheme.background) .. "," .. opacity .. ")",
		inactive_tab_edge = "rgba(" .. hex_to_rgb_string(my_scheme.background) .. "," .. opacity .. ")",
		active_tab = {
			-- The color of the background area for the tab
			bg_color = "rgba(" .. hex_to_rgb_string(my_scheme.background) .. "," .. opacity .. ")",
			fg_color = "rgba(" .. hex_to_rgb_string(my_scheme.cursor_bg) .. "," .. opacity .. ")",
			underline = "Single",
		},
		inactive_tab = {
			-- The color of the background area for the tab
			bg_color = "rgba(" .. hex_to_rgb_string(my_scheme.background) .. "," .. opacity .. ")",
			-- The color of the text for the tab
			fg_color = "rgba(" .. hex_to_rgb_string(my_scheme.cursor_bg) .. "," .. opacity .. ")",
		},
		new_tab = {
			bg_color = "rgba(" .. hex_to_rgb_string(my_scheme.background) .. "," .. opacity .. ")",
			fg_color = "rgba(" .. hex_to_rgb_string(my_scheme.cursor_bg) .. "," .. opacity .. ")",

			-- The same options that were listed under the `active_tab` section above
			-- can also be used for `new_tab`.
		},
	},
}

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
