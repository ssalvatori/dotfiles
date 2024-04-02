-- Pull in the wezterm API
local wezterm = require("wezterm")

-- This will hold the configuration.
local config = wezterm.config_builder()

-- This is where you actually apply your config choices

config.font = wezterm.font("MonaspiceKr Nerd Font Mono")
config.harfbuzz_features = { "calt=0", "clig=0", "liga=0" }
config.font_size = 12.5
-- config.font = wezterm.font("JetBrains Mono")
--
-- config.harfbuzz_features = { "calt=0", "clig=0", "liga=0" }
-- For example, changing the color scheme:
config.color_scheme = "Tokyo Night"

config.initial_cols = 200
config.initial_rows = 80
config.macos_window_background_blur = 20

config.window_close_confirmation = "NeverPrompt"

config.enable_scroll_bar = true

-- Tab Bar
config.use_fancy_tab_bar = true
config.hide_tab_bar_if_only_one_tab = true
config.tab_bar_at_bottom = true

-- Window
config.window_decorations = "RESIZE | MACOS_FORCE_ENABLE_SHADOW"

config.allow_square_glyphs_to_overflow_width = "Never"
config.adjust_window_size_when_changing_font_size = false
-- config.window_padding = {
-- 	left = 0,
-- 	right = 0,
-- 	top = 0,
-- 	bottom = 0,
-- }

-- config.font = wezterm.font({
-- 	family = "JetBrains Mono",
-- 	harfbuzz_features = { "calt=0", "clig=0", "liga=0" },
-- })
--
config.disable_default_mouse_bindings = true
config.window_background_opacity = 0.95

config.debug_key_events = true
config.keys = {
	-- Make Option-Left equivalent to Alt-b which many line editors interpret as backward-word
	{ key = "LeftArrow", mods = "OPT", action = wezterm.action({ SendString = "\x1bb" }) },
	-- Make Option-Right equivalent to Alt-f; forward-word
	{ key = "RightArrow", mods = "OPT", action = wezterm.action({ SendString = "\x1bf" }) },
}

-- and finally, return the configuration to wezterm
return config
