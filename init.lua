require "buffer_preferences"
require "ta_as_commit_editor"
require("textredux").hijack()

 -- Enable Lua patterns, and set as the default search mode.
 --[[
local tlp = require("lua-pattern-find")
tlp.toggle_lua_patterns()
ui.find.regex = true -- doubles as the Lua pattern option
]]

if not CURSES then
	require "init_gui"
else
	require "init_curses"
end
