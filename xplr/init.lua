version = "0.21.3"

local home = os.getenv("HOME")
package.path = home
.. "/.config/xplr/plugins/?/init.lua;"
.. home
.. "/.config/xplr/plugins/?.lua;"
.. package.path

xplr.config.modes.custom.open_file = {
  name = "open_file",
  key_bindings = xplr.config.modes.builtin.default.key_bindings,
  extra_help = "Open File"
}

xplr.config.modes.custom.open_files = {
  name = "open_files",
  key_bindings = xplr.config.modes.builtin.default.key_bindings,
  extra_help = "Open Files"
}

xplr.config.modes.custom.open_folder = {
  name = "open_folder",
  key_bindings = xplr.config.modes.builtin.default.key_bindings,
  extra_help = "Open Folder"
}

xplr.config.modes.custom.save_file = {
  name = "save_file",
  key_bindings = xplr.config.modes.builtin.default.key_bindings,
  extra_help = "Save File"
}

require"icons".setup()

require("scp").setup{
  mode = "selection_ops",  -- or `xplr.config.modes.builtin.selection_ops`
  key = "S",
  scp_command = "scp -r",
  non_interactive = false,
  keep_selection = false,
}
