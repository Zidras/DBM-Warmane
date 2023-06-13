local mod	= DBM:NewMod("Krystallus", "DBM-Party-WotLK", 7)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("20220518110528")
mod:SetCreatureID(27977)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_SUCCESS 50833"
)

local warningShatter	= mod:NewSpellAnnounce(50810, 3)

local timerShatterCD	= mod:NewCDTimer(25, 50810, nil, nil, nil, 2)

function mod:SPELL_CAST_SUCCESS(args)
	if args.spellId == 50833 then
		warningShatter:Show()	-- Shatter warning when Ground Slam is cast
		timerShatterCD:Start()
	end
end
