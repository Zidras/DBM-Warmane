local mod	= DBM:NewMod(427, "DBM-Party-Classic", 8, 232)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 7007 $"):sub(12, -3))
mod:SetCreatureID(12236)


mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_SUCCESS 7964"
)

--TODO, smokebomb health based or this timer accurate?
local warningSmokeBomb				= mod:NewSpellAnnounce(7964, 2)

local timerSmokeBombCD				= mod:NewCDTimer(14.6, 7964, nil, nil, nil, 3)

function mod:OnCombatStart(delay)
--	timerSmokeBombCD:Start(1-delay)--Used near instant on pull
end

function mod:SPELL_CAST_SUCCESS(args)
	if args.spellId == 7964 and args:IsSrcTypeHostile() then
		warningSmokeBomb:Show()
		timerSmokeBombCD:Start()
	end
end
