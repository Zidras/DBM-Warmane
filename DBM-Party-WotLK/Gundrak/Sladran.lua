local mod	= DBM:NewMod("Sladran", "DBM-Party-WotLK", 5)
local L		= mod:GetLocalizedStrings()

mod.statTypes = "normal,heroic,mythic"

mod:SetRevision("20220518110528")
mod:SetCreatureID(29304)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START"
)

local warningNova	= mod:NewSpellAnnounce(55081, 3)

local timerNovaCD	= mod:NewCDTimer(24, 55081, nil, nil, nil, 2)

function mod:SPELL_CAST_START(args)
	if args:IsSpellID(55081, 59842) then
		warningNova:Show()
		timerNovaCD:Start()
	end
end
