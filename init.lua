require "buffer_preferences"
require "ta_as_commit_editor"

if not CURSES then
	require "init_gui"
else
	require "init_curses"
end
