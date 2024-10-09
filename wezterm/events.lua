local wezterm = require("wezterm")

wezterm.on("window-config-reloaded", function(window, _)
	window:toast_notification("Configuration loaded.", "", nil, 5000)
end)
