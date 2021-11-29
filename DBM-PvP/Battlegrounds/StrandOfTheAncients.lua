local mod	= DBM:NewMod("StrandoftheAncients", "DBM-PvP")
local L		= mod:GetLocalizedStrings()

local GetCurrentMapAreaID, SetMapToCurrentZone = GetCurrentMapAreaID, SetMapToCurrentZone

mod:SetRevision("20210519214524")
mod:SetZone(DBM_DISABLE_ZONE_DETECTION)

mod:RemoveOption("HealthFrame")

mod:RegisterEvents(
	"ZONE_CHANGED_NEW_AREA"
)

do
	local bgzone = false

	local function Init()
		SetMapToCurrentZone()
		local zoneID = GetCurrentMapAreaID()
		if not bgzone and zoneID == 513 then
			bgzone = true
			local generalMod = DBM:GetModByName("PvPGeneral")
			generalMod:SubscribeAssault(zoneID, 0)
			-- TODO: Add gate health
		elseif bgzone and zoneID ~= 513 then
			bgzone = false
		end
	end

	function mod:ZONE_CHANGED_NEW_AREA()
		Init()
	end
	mod.PLAYER_ENTERING_WORLD	= mod.ZONE_CHANGED_NEW_AREA
	mod.OnInitialize			= mod.ZONE_CHANGED_NEW_AREA
end