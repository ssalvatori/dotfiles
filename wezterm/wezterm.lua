-- Pull in the wezterm API
local wezterm = require("wezterm")

-- This will hold the configuration.
local config = wezterm.config_builder()

config.keys = require("keys")

-- local colors = require("lua/rose-pine").colors()
-- local window_frame = require("lua/rose-pine").window_frame()

config.color_scheme = "Catppuccin Mocha"

-- This is where you actually apply your config choices

config.font = wezterm.font("MonaspiceKr Nerd Font Mono")
config.harfbuzz_features = { "calt=0", "clig=0", "liga=0" }
config.font_size = 13.5

-- config.colors = colors
-- config.window_frame = window_frame

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

-- Plugin
local domains = wezterm.plugin.require("https://github.com/DavidRR-F/quick_domains.wezterm")
domains.apply_to_config(config)

domains.formatter = function(icon, name, _)
	return wezterm.format({
		{ Text = icon .. " " .. string.lower(name) },
	})
end

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

-- config.ssh_domains = require("lua/ssh-domains")

require("events")
return config
