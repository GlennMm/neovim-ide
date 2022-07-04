local autosave = require("autosave")

autosave.setup({
  enabled = true,
  events = { "InsertLeave", "TextChanged" },
  execution_message = "Autosave: saved at " .. vim.fn.strftime("%H:%M:%S"),
  conditions = {
    exits = true,
    filename_is_not = {},
    filetype_is_not = {},
    modifiable = true
  },
  write_all_buffers = true,
  on_off_command = true,
  clean_command_line_internal = 0,
  debounce_delay = 500
})
