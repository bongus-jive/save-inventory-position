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
