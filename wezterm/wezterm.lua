-- Pull in the wezterm API
local wezterm = require("wezterm")
local act = wezterm.action

-- This will hold the configuration.
local config = wezterm.config_builder()

config.color_scheme = "Catppuccin Mocha"

-- This is where you actually apply your config choices

config.font = wezterm.font("FiraCode Nerd Font")
config.font_size = 14

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

wezterm.plugin.require("https://github.com/nekowinston/wezterm-bar").apply_to_config(config, {
	position = "top",
	max_width = 32,
	dividers = "slant_right", -- or "slant_left", "arrows", "rounded", false
	indicator = {
		leader = {
			enabled = true,
			off = " ",
			on = " ",
		},
		mode = {
			enabled = true,
			names = {
				resize_mode = "RESIZE",
				copy_mode = "VISUAL",
				search_mode = "SEARCH",
			},
		},
	},
	tabs = {
		numerals = "arabic", -- or "roman"
		pane_count = "superscript", -- or "subscript", false
		brackets = {
			active = { "", ":" },
			inactive = { "", ":" },
		},
	},
	clock = { -- note that this overrides the whole set_right_status
		enabled = false,
		format = "%H:%M", -- use https://wezfurlong.org/wezterm/config/lua/wezterm.time/Time/format.html
	},
})

local workspace_switcher = wezterm.plugin.require("https://github.com/MLFlexer/smart_workspace_switcher.wezterm")
workspace_switcher.apply_to_config(config)

workspace_switcher.get_choices = function(opts)
	-- this will ONLY show the workspace elements, NOT the Zoxide results
	return workspace_switcher.choices.get_workspace_elements({})
end
workspace_switcher.zoxide_path = "/opt/homebrew/bin/zoxide"

workspace_switcher.apply_to_config(config)

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

	-- create workspace for dotfiles
	{
		key = "d",
		mods = "LEADER",
		action = wezterm.action_callback(function(window, pane)
			window:perform_action(
				act.SwitchToWorkspace({
					name = ".dotfiles",
					spawn = { cwd = wezterm.home_dir .. "/.dotfiles" },
				}),
				pane
			)
			-- window:set_right_status(window:active_workspace())
		end),
	},

	{
		key = "m",
		mods = "LEADER",
		action = wezterm.action_callback(function(window, pane)
			window:perform_action(
				act.SwitchToWorkspace({
					name = "mb-sip",
					spawn = { cwd = wezterm.home_dir .. "/Source/MB/SIP" },
				}),
				pane
			)
			window:spawn_tab({ cmd = "./account-details/" })
			window:spawn_tab({ cmd = "./" })
			-- window:set_right_status(window:active_workspace())
		end),
	},

	{ key = "n", mods = "ALT", action = act.SwitchWorkspaceRelative(1) },
	{ key = "p", mods = "ALT", action = act.SwitchWorkspaceRelative(-1) },

	-- rename tab
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
	-- switch between workspaces
	{
		key = "s",
		mods = "LEADER",
		action = workspace_switcher.switch_workspace(),
	},
	-- create workspaces
	{
		key = "o",
		mods = "LEADER",
		action = act.PromptInputLine({
			description = wezterm.format({
				{ Attribute = { Intensity = "Bold" } },
				{ Foreground = { AnsiColor = "Fuchsia" } },
				{ Text = "Enter name for new workspace" },
			}),
			action = wezterm.action_callback(function(window, pane, line)
				-- `line` will be `nil` if user hits <ESC> without entering anything.
				-- If enter is pressed, line will be the text they wrote; otherwise "".
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
	-- Move current pane to a new tab
	{
		key = "!",
		mods = "LEADER",
		action = wezterm.action_callback(function(_, pane)
			local _, _ = pane:move_to_new_tab()
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

require("events")
return config
