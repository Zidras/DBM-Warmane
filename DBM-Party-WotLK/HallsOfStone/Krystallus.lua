local mod	= DBM:NewMod("Krystallus", "DBM-Party-WotLK", 7)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("20250929220131")
mod:SetCreatureID(27977)
mod:SetEncounterID(563)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 61546"
)

local warningShatter	= mod:NewSpellAnnounce(61546, 3)

local timerShatterCD	= mod:NewCDTimer(16, 61546, nil, nil, nil, 2)

function mod:OnCombatStart()
		timerShatterCD:Start(40)
end

function mod:SPELL_CAST_START(args)
	if args.spellId == 61546 then
		warningShatter:Show()	-- Shatter warning when Ground Slam is cast
		timerShatterCD:Start()
	end
end