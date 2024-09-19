-- Pull in the wezterm API
local wezterm = require("wezterm")

-- This will hold the configuration.
local config = wezterm.config_builder()

local colors = require("lua/rose-pine").colors()
local window_frame = require("lua/rose-pine").window_frame()

-- This is where you actually apply your config choices

config.font = wezterm.font("MonaspiceKr Nerd Font Mono")
config.harfbuzz_features = { "calt=0", "clig=0", "liga=0" }
config.font_size = 13.5

config.colors = colors
config.window_frame = window_frame

config.initial_cols = 200
config.initial_rows = 80
config.macos_window_background_blur = 20

config.window_close_confirmation = "NeverPrompt"

-- scroll lines per wheel click
config.scrollback_lines = 30000

config.enable_scroll_bar = true

-- Tab Bar
config.use_fancy_tab_bar = false
config.tab_bar_at_bottom = false

-- Window
-- config.window_decorations = "RESIZE | MACOS_FORCE_ENABLE_SHADOW"

-- Set title buttons position
-- config.window_decorations = "INTEGRATED_BUTTONS|RESIZE"
-- config.integrated_title_button_style = "Windows"
-- config.integrated_title_buttons = { "Close", "Hide", "Maximize" }
-- config.integrated_title_button_alignment = "Left"

config.allow_square_glyphs_to_overflow_width = "Never"
config.adjust_window_size_when_changing_font_size = false
config.window_padding = {
	left = 10,
	right = 10,
	top = 10,
	bottom = 10,
}

-- config.disable_default_mouse_bindings = true
config.window_background_opacity = 0.95

-- Dim inactive panes
config.inactive_pane_hsb = {
	saturation = 0.92,
	brightness = 0.5,
}

config.default_workspace = "main"
config.leader = { key = "a", mods = "CTRL", timeout_milliseconds = 1000 }

config.keys = {
	-- Make Option-Left equivalent to Alt-b which many line editors interpret as backward-word
	{ key = "LeftArrow", mods = "OPT", action = wezterm.action({ SendString = "\x1bb" }) },
	-- -- Make Option-Right equivalent to Alt-f; forward-word
	{ key = "RightArrow", mods = "OPT", action = wezterm.action({ SendString = "\x1bf" }) },

	-- TMUX migration
	{ key = "c", mods = "LEADER", action = wezterm.action.SpawnTab("CurrentPaneDomain") },
	{ key = "C", mods = "LEADER", action = wezterm.action.SpawnTab("DefaultDomain") },
	{ key = "x", mods = "LEADER", action = wezterm.action.CloseCurrentPane({ confirm = true }) },
	{ key = "|", mods = "LEADER", action = wezterm.action.SplitHorizontal({ domain = "CurrentPaneDomain" }) },
	{ key = "=", mods = "LEADER", action = wezterm.action.SplitVertical({ domain = "CurrentPaneDomain" }) },
	{ key = "m", mods = "LEADER", action = wezterm.action.TogglePaneZoomState },
	{ key = "w", mods = "LEADER", action = wezterm.action.ShowTabNavigator },
	{ key = "h", mods = "LEADER", action = wezterm.action({ ActivatePaneDirection = "Left" }) },
	{ key = "j", mods = "LEADER", action = wezterm.action({ ActivatePaneDirection = "Down" }) },
	{ key = "k", mods = "LEADER", action = wezterm.action({ ActivatePaneDirection = "Up" }) },
	{ key = "l", mods = "LEADER", action = wezterm.action({ ActivatePaneDirection = "Right" }) },
	{ key = "n", mods = "LEADER", action = wezterm.action.ActivateTabRelative(1) },
	{ key = "p", mods = "LEADER", action = wezterm.action.ActivateTabRelative(-1) },
	{
		key = ",",
		mods = "LEADER",
		action = wezterm.action.PromptInputLine({
			description = "Enter new name for tab",
			action = wezterm.action_callback(function(window, pane, line)
				if line then
					window:active_tab():set_title(line)
				end
			end),
		}),
	},

	{
		key = "!",
		mods = "LEADER",
		action = wezterm.action_callback(function(win, pane)
			local tab, window = pane:move_to_new_tab()
		end),
	},
}

for i = 1, 9 do
	table.insert(config.keys, {
		key = tostring(i),
		mods = "LEADER",
		action = wezterm.action.ActivateTab(i - 1),
	})
end

return config
