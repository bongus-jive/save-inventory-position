local PaneName = "Inventory"
local ConfigPath = "pat_inventoryPosition"
local InvPane

function init()
  script.setUpdateDelta(0)

  InvPane = interface.bindRegisteredPane(PaneName)

  message.setHandler("/resetinventoryposition", function(_, isLocal)
    if isLocal then
      InvPane.setPosition({0, 0})
    end
  end)

  local pos = root.getConfigurationPath(ConfigPath)
  if not pos then return end

  local clamp = function(n, min, max) return math.max(min, math.min(n, max)) end
  
  local size = InvPane.getSize()
  local bounds = interface.bindCanvas("voice"):size()
  pos[1] = clamp(pos[1], 0, bounds[1] - size[1])
  pos[2] = clamp(pos[2], 0, bounds[2] - size[2])

  local isDisplayed = InvPane.isDisplayed()

  interface.displayRegisteredPane(PaneName)
  InvPane.setPosition(pos)

  if not isDisplayed then
    InvPane.dismiss()
  end
end

function uninit()
  root.setConfigurationPath(ConfigPath, InvPane.getPosition())
end
