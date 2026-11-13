local terminal = "com.superlogical.terminal"
-- local projects_dir = os.getenv("HOME") .. os.getenv("PROJECTS_PATH")
local projects_dir = os.getenv("PROJECTS_PATH")

-- the scripts next to this file, and the float sizes they use
local picker = { 0.25, 0.2, 0.5, 0.5 }

-- the focused pane's foreground process, with its name, pid and cwd
local function foreground(ctx)
	local proc = rex.block.call(terminal, "process", { block_id = ctx.block_id })
	return proc and proc.foreground
end

-- the focused pane's directory, from what the shell last reported or else its foreground process
local function focused_cwd(ctx)
	local pwd = rex.block.call(terminal, "pwd", { block_id = ctx.block_id })
	if pwd and pwd.pwd then
		return (pwd.pwd:gsub("^file://[^/]*", ""))
	end
	local fg = foreground(ctx)
	return fg and fg.cwd
end

-- a terminal pane layout running command, or a shell if command is nil, in cwd
local function shell(command, cwd)
	return rex.layout.block({ flavor = terminal .. ".shell", options = { command = command, cwd = cwd } })
end

-- a palette action that opens a floating pane in the focused pane's directory, running command or a shell
-- bounds is x, y, w, h as fractions of the window, nearly full-window by default
local function float(spec)
	rex.action({
		name = spec.name,
		title = spec.title,
		keywords = spec.keywords,
		run = function(ctx)
			local _, err = rex.session.new_layer({
				bounds = spec.bounds or { 0.05, 0.05, 0.9, 0.9 },
				layout = shell(spec.command, focused_cwd(ctx)),
				focus = true,
			})
			if err then
				error(err)
			end
		end,
	})
end

float({
	name = "lazygit_float",
	title = "Lazygit",
	keywords = "git lazygit float",
	command = { "lazygit" },
})

-- All keybinds from the rex config in a floating pane, paged so it stays open
float({
	name = "keymap_float",
	title = "Keymap",
	keywords = "keymap keybinds keys bindings list float",
	command = { "sh", "-c", "rex keymap | less -R" },
	bounds = { 0.15, 0.1, 0.7, 0.8 },
})

rex.action({
	name = "open_in_finder",
	title = "Open in Finder",
	keywords = "finder reveal open directory",
	run = function(ctx)
		local dir = focused_cwd(ctx)
		if not dir then
			error("no directory for the focused pane")
		end
		rex.exec({ "open", dir })
	end,
})

-- Ask the Rex app to show a session. Key/palette actions queue it on their own
-- client; from the CLI (e.g. the sessionizer float) ask connected apps, which
-- requires Remote Control on (Rex -> Settings -> Rex Server).
local function show_session(ctx, session_id)
	if ctx and (ctx.origin == "key" or ctx.origin == "palette") then
		rex.client.queue("session.select", { session_id = session_id })
		return
	end
	local apps = rex.call("client.list", { kinds = { "app" }, session_id = ctx and ctx.session_id })
	if apps == nil or #(apps.clients or {}) == 0 then
		apps = rex.call("client.list", { kinds = { "app" } })
	end
	local last_err
	for _, c in ipairs(apps and apps.clients or {}) do
		local _, err = rex.call("client.perform", {
			client_id = c.client_id,
			action = "session.select",
			args = { session_id = session_id },
			origin = ctx and ctx.origin,
		})
		if err == nil then
			return
		end
		last_err = err
	end
	error(last_err or "no Rex app is connected", 0)
end

-- Switch to the session for a directory, creating it with a shell in that
-- directory when missing. Sessions are labelled after the directory's basename.
local function session_for_dir(ctx, label, path)
	local list, err = rex.call("session.list")
	if list == nil then
		error(tostring(err), 0)
	end
	for _, s in ipairs(list.sessions or {}) do
		if s.label == label then
			show_session(ctx, s.session_id)
			return { session_id = s.session_id, created = false }
		end
	end
	local created, cerr = rex.call("session.create", {
		label = label,
		initial_windows = {
			{ layout = shell(nil, path) },
		},
	})
	if created == nil then
		error(tostring(cerr), 0)
	end
	show_session(ctx, created.session_id)
	return { session_id = created.session_id, created = true }
end

local function basename(path)
	return (path:gsub("/+$", ""):match("([^/]+)$"))
end

-- Switch to the "home" session, creating it with a shell in $HOME if missing
rex.action({
	name = "home_session",
	title = "Home",
	keywords = "home session switch",
	run = function(ctx)
		return session_for_dir(ctx, "home", os.getenv("HOME"))
	end,
})

rex.action({
	name = "open_dotfiles",
	title = "Dotfiles",
	keywords = "dotfiles session switch",
	run = function(ctx)
		return session_for_dir(ctx, "dotfiles", os.getenv("HOME") .. "/.dotfiles")
	end,
})

-- Sessionizer: fzf over the project folders under work_dir in a floating
-- terminal; the pick is handed back with `rex do project_session path=...`,
-- which switches the app to the session for that folder (Remote Control on).

rex.action({
	name = "sessionizer",
	title = "Switch Project…",
	description = "Pick a folder under " .. projects_dir .. " with fzf and switch to its session.",
	keywords = "project fzf sessionizer directory",
	run = function(ctx)
		local pick = table.concat({
			'dir=$(find "' .. projects_dir .. '" -mindepth 1 -maxdepth 1 -type d | fzf)',
			'[ -n "$dir" ] && rex do project_session "path=$dir"',
		}, "; ")
		local _, err = rex.session.new_layer({
			bounds = picker,
			focus = true,
			layout = shell({ "sh", "-c", pick }, projects_dir),
		})
		if err then
			error(err, 0)
		end
	end,
})

-- The target of the sessionizer pick: `rex do project_session path=...`
-- switches the app to the session for that folder, creating it if missing.
rex.action({
	name = "project_session",
	title = "Project Session",
	args = { path = "string" },
	run = function(ctx, args)
		return session_for_dir(ctx, basename(args.path), args.path)
	end,
})
