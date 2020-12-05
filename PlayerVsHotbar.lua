PlayerVsHotbar = select(2, ...)
local PVH = PlayerVsHotbar

--[[
  Utility methods and variables
  ]]
function PVH:Print(message)
  DEFAULT_CHAT_FRAME:AddMessage(message)
end


--[[ 
  Event: "ADDON_LOADED"
]]
function PVH:OnAddonLoaded()
  -- Load saved variable or defaults
  PVHStore = PVHStore or {
    firstRun = true,
    selectedProfile = "PvE",
    profiles = {},
    specialization = nil
  }

  self.store = PVHStore
end


--[[ 
  Event: "PLAYER_LOGIN"
]]
function PVH:OnPlayerLogin()
  self.store.specialization = GetSpecialization()

  if (self.store.firstRun) then
    self:StoreHotbarsAndTalents()
  end
end

-- Initial storage of hotbars and talents
function PVH:StoreHotbarsAndTalents()
  self.store.firstRun = false
  -- self.store.profiles[self.store.specialization] = true
  -- self:Print(self.store.profiles[self.store.specialization])
end



--[[
  Event registration and delegation
]]
local frame = CreateFrame("Frame")
frame:RegisterEvent("ADDON_LOADED")
frame:RegisterEvent("PLAYER_LOGIN")

frame:SetScript("OnEvent", function(self, event, arg1)
  if (event == "ADDON_LOADED" and arg1 == "PlayerVsHotbar") then
    PVH:OnAddonLoaded()
    self:UnregisterEvent("ADDON_LOADED")
  end

  if (event == "PLAYER_LOGIN") then
    PVH:OnPlayerLogin()
    self:UnregisterEvent("PLAYER_LOGIN")
  end
end)