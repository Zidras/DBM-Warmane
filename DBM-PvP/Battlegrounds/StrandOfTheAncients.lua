local mod	= DBM:NewMod("StrandoftheAncients", "DBM-PvP")
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
		if not bgzone and zoneID == 513 then
			bgzone = true
			local generalMod = DBM:GetModByName("PvPGeneral")
			generalMod:SubscribeAssault(zoneID, 0)
			generalMod:TrackHealth(59650, "GreenEmerald", 11000)
			generalMod:TrackHealth(59652, "BlueSapphire", 11000)
			generalMod:TrackHealth(59651, "PurpleAmethyst", 13000)
			generalMod:TrackHealth(59654, "RedSun", 13000)
			generalMod:TrackHealth(59655, "YellowMoon", 14000)
			generalMod:TrackHealth(61477, "ChamberAncientRelics", 10000)
		elseif bgzone and zoneID ~= 513 then
			bgzone = false
			DBM:GetModByName("PvPGeneral"):StopTrackHealth()
		end
	end

	function mod:ZONE_CHANGED_NEW_AREA()
		Init()
	end
	mod.PLAYER_ENTERING_WORLD	= mod.ZONE_CHANGED_NEW_AREA
	mod.OnInitialize			= mod.ZONE_CHANGED_NEW_AREA
end