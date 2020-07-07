-- Correct a mistake in sml's line-comment syntax (SML/NJ v110.79)
textadept.editing.comment_string.sml = "(*|*)"

-- Correct a mistake in sml's run-command.
textadept.run.run_commands.sml = "sml %f"

-- Have Guile be the default Scheme runner.
textadept.run.run_commands.scheme = "guile --no-auto-compile -l %f"



	
-- C-l selects a line.
local select_line = keys.cN
keys.cl = function ()
	select_line()
end

-- Easy page-up, page-down.
keys.cN = function ()
	for i = 1, 10 do
		buffer:line_scroll_down()
	end
end

keys.cP = function ()
	for i = 1, 10 do
		buffer:line_scroll_up()
	end
end

-- Set up facilities for easy command-launching.
C = {}
C.beginning_goto = buffer.document_start
C.end_goto = buffer.document_end
C.config = keys.cu
C.reset = function () io.save_file(); reset() end
C.select_all = keys.ca
C.snippets = keys.ck
C.copy = keys.cc
C.cut = keys.cx
C.paste = keys.cv
C.command = keys.ce
C.quit = keys.cq
C.whitespace = function () keys.caS(); keys["ca\n"]() end
C.buffers = keys.cb
C.alert = function (message)
	return ui.dialogs.ok_msgbox {
		title = "Alert!",
		text = message,
		string_output = true,
	}
end
C.line_no = function ()
	return buffer:line_from_position(buffer.current_pos) + 1
end
		
-- Right now, can only handle single selections.
-- Also, cursor has to be next to the selection.
C.replace = function (old, new)
	buffer:begin_undo_action()
	local text = buffer:get_sel_text()
	buffer:cut()
	text = text:gsub(old, new)
	buffer:add_text(text)
	buffer:end_undo_action()
end
			

keys.cn = function () buffer:line_down() end
keys.cp = function () buffer:line_up() end
keys.cb = function () buffer:char_left() end
keys.cf = function () buffer:char_right() end

keys.cq = function () 
	C.whitespace()
end

--[[
	TODO: C.help: list a popup window describing commands,
and what they do: e.g. beginning_goto: Go to the beginning of the buffer.
]]

-- Do display versions work better than non-display?
keys.cu = function () buffer:home_display_extend() end
keys.ck = function () buffer:line_end_display_extend() end
keys.ca = function () buffer:vc_home_display() end
keys.ce = function () buffer:line_end_display() end

-- The new command-launcher.
keys.ac = function ()
	local real_buffer = _G.buffer
	buffer = ui.command_entry
	C.command()
	buffer:set_text("C.")
	buffer:line_end()
	_G.buffer = real_buffer
end

--[[
	Implement: Quick Reference page 40, Example 8:
	Find the next instance of the current word.
	- But our own spin.
]]


local function find_next (query, wrap, init) -- 'init' should be zero-based, like TA
	init = init or buffer.current_pos + 1
	local found = buffer:get_text():find(query, init + 1)
	
	if found then	
		buffer:goto_pos(found - 1)
		buffer:word_right_end()
		C.query = query
		
		if wrap then
			--C.alert("Search wrapped")
			ui.statusbar_text = "Search wrapped"
		end
	else
		if wrap then
			C.alert("Text not found")
		else
			find_next(query, true, 0)
		end
	end
end
	

C.find = find_next
	
keys.cg = function ()
	if not C.query then
		C.alert "No text to search for"
	else
		C.find(C.query, false, buffer.current_pos + 1)
	end
end