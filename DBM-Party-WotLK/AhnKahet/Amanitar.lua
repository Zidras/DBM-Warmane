local mod	= DBM:NewMod("Amanitar", "DBM-Party-WotLK", 1)
local L		= mod:GetLocalizedStrings()

mod.statTypes = "heroic"

mod:SetRevision(("$Revision: 2250 $"):sub(12, -3))
mod:SetCreatureID(30258)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 57055"
)

local warningMini	= mod:NewSpellAnnounce(57055, 3)

local timerMiniCD	= mod:NewCDTimer(30, 57055, nil, nil, nil, 2)

function mod:SPELL_CAST_START(args)
	if args.spellId == 57055 then
		warningMini:Show()
		timerMiniCD:Start()
	end
end