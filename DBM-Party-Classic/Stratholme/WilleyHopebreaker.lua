local mod	= DBM:NewMod(446, "DBM-Party-Classic", 16, 236)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("20250929220131")
mod:SetCreatureID(10997)
mod:SetEncounterID(475)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_SUCCESS 17279"
)

--TODO, see if adds are actually every 5 seconds, if so, leave announce off by default
local warningSummonRisenRifleman		= mod:NewSpellAnnounce(17279, 2, nil, false)

local timerSummonRisenRiflemanCD		= mod:NewAITimer(180, 17279, nil, nil, nil, 1)

function mod:OnCombatStart(delay)
	timerSummonRisenRiflemanCD:Start(1-delay)
end

function mod:SPELL_CAST_SUCCESS(args)
	if args.spellId == 17279 then
		warningSummonRisenRifleman:Show()
		timerSummonRisenRiflemanCD:Start()
	end
end
