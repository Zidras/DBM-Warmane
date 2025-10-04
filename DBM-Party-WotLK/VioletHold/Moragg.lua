local mod	= DBM:NewMod("Moragg", "DBM-Party-WotLK", 12)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("20250929220131")
mod:SetCreatureID(29316)
mod:SetEncounterID(2659)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_AURA_APPLIED 54396"
)

local warningLink	= mod:NewTargetNoFilterAnnounce(54396, 2)

local timerLink		= mod:NewTargetTimer(12, 54396, nil, nil, nil, 5, nil, DBM_COMMON_L.HEALER_ICON)
local timerLinkCD	= mod:NewCDTimer(45, 54396, nil, nil, nil, 3)

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 54396 then
		warningLink:Show(args.destName)
		timerLink:Start(args.destName)
		timerLinkCD:Cancel()
		timerLinkCD:Start()
	end
end
