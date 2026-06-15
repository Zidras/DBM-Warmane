local mod	= DBM:NewMod("Meathook", "DBM-Party-WotLK", 3)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("20220518110528")
mod:SetCreatureID(26529)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_SUCCESS 52696 58823"
)

local warningChains		= mod:NewTargetNoFilterAnnounce(52696, 4)

local timerChains		= mod:NewTargetTimer(5, 52696, nil, nil, nil, 3)
local timerChainsCD		= mod:NewCDTimer(15, 52696, nil, nil, nil, 3)

function mod:SPELL_CAST_SUCCESS(args)
	if args:IsSpellID(52696, 58823) then
		warningChains:Show(args.destName)
		timerChains:Start(args.destName)
		timerChainsCD:Start()
	end
end
