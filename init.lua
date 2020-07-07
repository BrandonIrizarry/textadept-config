if not CURSES then
	buffer:set_theme("sand", {font="Monospace", fontsize=15})
	return
end

require "buffer_preferences"
require "ta_as_commit_editor"

buffer:set_theme("term")

local function alert (header, ...)
	local inputs = table.pack(...)

	ui.dialogs.msgbox{
		title = "Alert!",
		informative_text = #inputs > 0 and table.concat(inputs, " ") or "no message",
		text = header
	}
end

keys.ch = function () io.quick_open(_USERHOME) end
keys.mh = function () io.quick_open(_HOME) end
keys["m\\"] = function () buffer:document_start() end
keys["m/"] = function () buffer:document_end() end
keys["m3"] = textadept.editing.block_comment
keys.mu = function () buffer:undo() end
keys.cy = function () buffer:page_up() end
keys.cv = function () buffer:page_down() end
keys.mp = function ()
	view.view_ws = view.view_ws == 0 and view.WS_VISIBLEALWAYS or 0
end

keys.cu = function () buffer:paste() end

keys.me = function () buffer:redo() end

keys.ms = function ()
	buffer:home()
	buffer.selection_mode = 0
	buffer:line_end()
end

keys.cg = function () textadept.editing.show_documentation() end
keys.cc = function () buffer:cancel() end


keys.cx = function ()
	if #_BUFFERS == 1 then
		buffer:close()
		quit()
		return
	end

	buffer:close()
end
		--[[
		local choice = ui.dialogs.yesno_msgbox{
			string_output = true,
			text = "Close Textadept?",
			informative_text = "Select 'No' for a new buffer"
		}
		if choice == "Yes" then
			quit()
			return
		else
			buffer:close()
			return
		end
	end
	--]]

keys["m,"] = function () view:goto_buffer(-1) end
keys["m."] = function () view:goto_buffer(1) end

keys.ck = function ()
	if buffer.selection_empty then
		buffer:line_cut()
	else
		buffer:cut()
	end
end

keys.ct = function ()
	buffer:line_end_extend()
	buffer:cut()
end

keys["m6"] = function () buffer:copy_allow_line() end
keys.ma = function () buffer.selection_mode = 0 end


--keys["m_"] = function () keys.mh()  end
--[[
	TODO
	mcx - kill current running process (ok)
	m* - toggle current fold point (ok, but do we use this?)

	cup, cdown - switch views
	cw - select current view (make it only one)
	c^ - sets mark
	c] - exchange point and mark
	m+- - scroll up and down
	m,. - previous/next buffer
	ct - cut to the end of a line (w/o cutting newline)
	cx - kill buffer; if last buffer, kill textadept
	cw,w - quick search literal
	cw,r - quick search regex
	cw,l - quick search lua pattern
	.q.. - like above, but backwards
]]
