-- Always use tabs of width 4 for indentation.
buffer.use_tabs = true
buffer.tab_width = 4

-- Disable code folding, and hide the fold margin.
buffer.property['fold'] = '0'
buffer.margin_width_n[2] = 0

-- Hide indentation guides.
buffer.indentation_guides = 0

-- Disable character autopairing with typeover.
textadept.editing.auto_pairs = nil
textadept.editing.typeover_chars = nil

-- Strip trailing whitespace on save.
textadept.editing.strip_trailing_spaces = true

-- Per-language settings
events.connect(events.LEXER_LOADED, function (lang)
	if lang == "ansi_c" then
		buffer.tab_width = 4 
	elseif lang == "ruby" then
		buffer.tab_width = 2
	end
end)

