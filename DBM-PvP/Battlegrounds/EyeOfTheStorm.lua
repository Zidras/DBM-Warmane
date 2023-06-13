local mod	= DBM:NewMod("EyeoftheStorm", "DBM-PvP")
local L		= mod:GetLocalizedStrings()

local GetCurrentMapAreaID = GetCurrentMapAreaID

mod:SetRevision("20220518110528")
mod:SetZone(DBM_DISABLE_ZONE_DETECTION)

mod:RegisterEvents(
	"ZONE_CHANGED_NEW_AREA"
)
mod:RemoveOption("HealthFrame")

do
	local bgzone = false

	local function Init()
		local zoneID = GetCurrentMapAreaID()
		if not bgzone and zoneID == 483 then
			bgzone = true
			local generalMod = DBM:GetModByName("PvPGeneral")
			generalMod:SubscribeAssault(zoneID, 4)
			generalMod:SubscribeFlags()
		elseif bgzone and zoneID ~= 483 then
			bgzone = false
		end
	end

	function mod:ZONE_CHANGED_NEW_AREA()
		Init()
	end
	mod.PLAYER_ENTERING_WORLD	= mod.ZONE_CHANGED_NEW_AREA
	mod.OnInitialize			= mod.ZONE_CHANGED_NEW_AREA
end
