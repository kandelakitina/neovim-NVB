local status_ok, leap = pcall(require, "leap")
if not status_ok then
  return
end

-- Load Leap's default bindings
require("leap").set_default_keymaps()