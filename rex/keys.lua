rex.bind("ctrl+a>b", "keymap_float") -- Show all keybinds in a float popup

rex.bind("ctrl+a>g", "lazygit_float")
rex.bind("ctrl+a>e", "open_in_finder")

rex.bind("ctrl+a>d", "open_dotfiles") -- Open ~/.dotfiles in a new session
rex.bind("ctrl+a>w", "session.switch")
rex.bind("ctrl+a>f", "sessionizer") -- fzf over ~/Source/MB-GHE/HELIOS, open a session for the pick (tmux: leader+f)

-- Split panes
rex.bind("ctrl+a>\\", "pane.split", { direction = "right" })
rex.bind("ctrl+a>-", "pane.split", { direction = "down" })

-- Zoom current pane
rex.bind("cmd+z", "pane.zoom") -- Zoom current pane (tmux: bind z resize-pane -Z)
rex.bind("ctrl+a>x", "pane.close") -- Close current pane (tmux: bind x kill-pane)
rex.bind("ctrl+a>,", "session.rename") -- Rename current session (tmux: bind , command-prompt -I "#S" "rename-session '%%'")

-- Sessions
rex.bind("ctrl+a>h", "home_session")

rex.action({
	name = "scratch",
	title = "Open Scratch Window",
	run = function()
		rex.session.new_window({
			layout = rex.layout.block({
				flavor = "com.superlogical.terminal.shell",
			}),
		})
	end,
})
rex.bind("shift+cmd+n", "scratch")
