-- Prepare TA for use as a commit-editor.
-- Usage: textadept -f -w
args.register('-w', '--wait', 1, function(filename)
  textadept.session.save_on_quit = false
  io.open_file(filename)
  filename = lfs.abspath(filename)
  events.connect(events.BUFFER_DELETED, function()
    local found = false
    for i = 1, #_BUFFERS do
      if _BUFFERS[i].filename == filename then
        found = true
        break
      end
    end
    if not found then quit() end
  end)
end, "Opens the given file and quits after closing that file")