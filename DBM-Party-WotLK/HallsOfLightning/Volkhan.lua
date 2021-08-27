local mod	= DBM:NewMod("Volkhan", "DBM-Party-WotLK", 6)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 2250 $"):sub(12, -3))
mod:SetCreatureID(28587)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEvents(
	"SPELL_CAST_START"
)

local warningStomp	= mod:NewSpellAnnounce(52237, 3)

local timerStompCD	= mod:NewCDTimer(30, 52237, nil, nil, nil, 2)

function mod:SPELL_CAST_START(args)
	if args:IsSpellID(59529, 52237) then
		warningStomp:Show()
		timerStompCD:Start()
	end
end