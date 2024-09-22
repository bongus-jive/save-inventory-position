local PaneName = "Inventory"
local ConfigPath = "pat_inventoryPosition"

function init()
  script.setUpdateDelta(0)

  local inv = interface.bindRegisteredPane(PaneName)

  message.setHandler("/resetinventoryposition", function(_, isLocal)
    if isLocal then
      inv.setPosition({0, 0})
    end
  end)

  local pos = root.getConfigurationPath(ConfigPath)
  if not pos then return end

  local clamp = function(n, min, max) return math.max(min, math.min(n, max)) end
  
  local size = inv:getSize()
  local bounds = interface.bindCanvas("voice"):size()
  pos[1] = clamp(pos[1], 0, bounds[1] - size[1])
  pos[2] = clamp(pos[2], 0, bounds[2] - size[2])

  local isDisplayed = inv.isDisplayed()

  interface.displayRegisteredPane(PaneName)
  inv.setPosition(pos)

  if not isDisplayed then
    inv.dismiss()
  end
end

function uninit()
  local inv = interface.bindRegisteredPane(PaneName)
  root.setConfigurationPath(ConfigPath, inv.getPosition())
end
