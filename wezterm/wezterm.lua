-- Pull in the wezterm API
local wezterm = require("wezterm")
local act = wezterm.action

-- This will hold the configuration.
-- local config = wezterm.config_builder()
local config = {}

if wezterm.config_builder then
	config = wezterm.config_builder()
end

config.max_fps = 120

config.color_scheme = "Catppuccin Mocha"

-- This is where you actually apply your config choices

config.font = wezterm.font("FiraCode Nerd Font")
config.font_size = 13.5

-- config.initial_cols = 200
-- config.initial_rows = 80
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
	left = 15,
	right = 15,
	top = 15,
	bottom = 15,
}

-- config.disable_default_mouse_bindings = true
config.window_background_opacity = 0.95

-- Dim inactive panes
config.inactive_pane_hsb = {
	saturation = 0.92,
	brightness = 0.5,
}

config.set_environment_variables = {
	-- prepend the path to your utility and include the rest of the PATH
	PATH = "/opt/homebrew/bin:" .. os.getenv("PATH"),
}

config.default_workspace = "main"
config.leader = { key = "a", mods = "CTRL", timeout_milliseconds = 1000 }

-- wezterm.plugin.require("https://github.com/nekowinston/wezterm-bar").apply_to_config(config, {
-- 	position = "top",
-- 	max_width = 32,
-- 	dividers = "slant_right", -- or "slant_left", "arrows", "rounded", false
-- 	indicator = {
-- 		leader = {
-- 			enabled = true,
-- 			off = " ",
-- 			on = " ",
-- 		},
-- 		mode = {
-- 			enabled = true,
-- 			names = {
-- 				resize_mode = "RESIZE",
-- 				copy_mode = "VISUAL",
-- 				search_mode = "SEARCH",
-- 			},
-- 		},
-- 	},
-- 	tabs = {
-- 		numerals = "arabic", -- or "roman"
-- 		pane_count = "superscript", -- or "subscript", false
-- 		brackets = {
-- 			active = { "", ":" },
-- 			inactive = { "", ":" },
-- 		},
-- 	},
-- 	clock = { -- note that this overrides the whole set_right_status
-- 		enabled = false,
-- 		format = "%H:%M", -- use https://wezfurlong.org/wezterm/config/lua/wezterm.time/Time/format.html
-- 	},
-- })

local tabline = wezterm.plugin.require("https://github.com/michaelbrusegard/tabline.wez")
-- tabline.setup({
-- 	sections = { tabline_b = {}, tabline_x = {}, tabline_y = {}, tabline_z = { "workspace" } },
-- })

tabline.setup({
	options = {
		icons_enabled = true,
		theme = "Catppuccin Mocha",
		color_overrides = {},
		section_separators = {
			left = wezterm.nerdfonts.pl_left_hard_divider,
			right = wezterm.nerdfonts.pl_right_hard_divider,
		},
		component_separators = {
			left = wezterm.nerdfonts.pl_left_soft_divider,
			right = wezterm.nerdfonts.pl_right_soft_divider,
		},
		tab_separators = {
			left = wezterm.nerdfonts.pl_left_hard_divider,
			right = wezterm.nerdfonts.pl_right_hard_divider,
		},
	},
	sections = {
		tabline_a = { "mode" },
		tabline_b = { "" },
		tabline_c = { " " },
		tab_active = {
			"index",
			{ "parent", padding = 0 },
			"/",
			{ "cwd", padding = { left = 0, right = 1 } },
			{ "zoomed", padding = 0 },
		},
		tab_inactive = { "index", { "process", padding = { left = 0, right = 1 } } },
		tabline_x = {},
		tabline_y = {},
		tabline_z = { "workspace" },
	},
	extensions = {},
})

local workspace_switcher = wezterm.plugin.require("https://github.com/MLFlexer/smart_workspace_switcher.wezterm")
workspace_switcher.apply_to_config(config)

workspace_switcher.get_choices = function(opts)
	-- this will ONLY show the workspace elements, NOT the Zoxide results
	return workspace_switcher.choices.get_workspace_elements({})
end
workspace_switcher.zoxide_path = "/opt/homebrew/bin/zoxide"

workspace_switcher.workspace_formatter = function(label)
	return wezterm.format({
		-- { Attribute = { Italic = true } },
		-- { Foreground = { Color = "green" } },
		-- { Background = { Color = "black" } },
		{ Text = "󱂬: " .. label },
	})
end

workspace_switcher.apply_to_config(config)

local sessionizer = wezterm.plugin.require("https://github.com/mikkasendke/sessionizer.wezterm")

sessionizer.config = {
	paths = {
		"/Users/stefano/Source/MB/HELIOS",
		"/Users/stefano/Source/MB/SIP",
		"/Users/stefano/Stuff",
	},
	experimental_branches = false,
}
sessionizer.apply_to_config(config, true)

local cmd_sender = wezterm.plugin.require("https://github.com/aureolebigben/wezterm-cmd-sender")

cmd_sender.apply_to_config(config, {
	key = "mapped:]",
	mods = "CMD",
	description = "Enter command to send to all panes of active tab",
})

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
		key = "'",
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
	{
		key = "k",
		mods = "CMD",
		action = sessionizer.show,
	},
	{
		key = "m",
		mods = "CMD",
		action = sessionizer.switch_to_most_recent,
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
