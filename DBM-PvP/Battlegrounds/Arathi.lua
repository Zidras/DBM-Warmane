local mod	= DBM:NewMod("ArathiBasin", "DBM-PvP")
local L		= mod:GetLocalizedStrings()

local GetCurrentMapAreaID = GetCurrentMapAreaID

mod:SetRevision("20220518110528")
mod:SetZone(DBM_DISABLE_ZONE_DETECTION)

mod:RemoveOption("HealthFrame")

mod:RegisterEvents(
	"ZONE_CHANGED_NEW_AREA"
)

do
	local bgzone = false

	local function Init()
		local zoneID = GetCurrentMapAreaID()
		if not bgzone and zoneID == 462 then
			bgzone = true
			DBM:GetModByName("PvPGeneral"):SubscribeAssault(zoneID, 5)
		elseif bgzone and zoneID ~= 462 then
			bgzone = false
		end
	end

	function mod:ZONE_CHANGED_NEW_AREA()
		Init()
	end
	mod.PLAYER_ENTERING_WORLD	= mod.ZONE_CHANGED_NEW_AREA
	mod.OnInitialize			= mod.ZONE_CHANGED_NEW_AREA
end
