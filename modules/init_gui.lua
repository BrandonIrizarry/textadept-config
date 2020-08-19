view:set_theme("light", {font="Iosevka Fixed Slab", size=20})

-- Open a terminal where the current buffer's file resides.
keys["ctrl+t"] = function ()
	local directory = buffer.filename:match("(.-)[^/]*$")
	os.spawn("desktop-defaults-run -t", directory)
end
