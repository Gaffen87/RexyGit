-- Settings of rex-lazygit. install.sh wrote this file and never overwrites it.
-- To change a setting, edit it, then run "rex config reload".
local settings = {
  -- key = "cmd+l", -- the key of the toggle, or false for none
  -- placement = "split", -- split, zoomed, tab, or overlay
  -- direction = "right", -- of the split: right or down
  -- ratio = 0.5, -- the share of the split that lazygit gets
}

local loaded, load_error = pcall(function() require("lazygit_toggle")(settings) end)
if not loaded then
  rex.action{ name = "lazygit_toggle", title = "Toggle lazygit",
    run = function() error("rex-lazygit: " .. tostring(load_error), 0) end }
  local key = type(settings) == "table" and settings.key
  if key == nil then key = "cmd+l" end
  if key then rex.bind(key, "lazygit_toggle") end
end
