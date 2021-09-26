local mod	= DBM:NewMod("GhamooRa", "DBM-Party-Classic", 1)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 7007 $"):sub(12, -3))
mod:SetCreatureID(4887)
--

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_SUCCESS 5568"
)

local warningTrample			= mod:NewSpellAnnounce(5568, 2)

local timerTrampleCD			= mod:NewAITimer(180, 5568, nil, nil, nil, 3)

function mod:OnCombatStart(delay)
	timerTrampleCD:Start(1-delay)
end

function mod:SPELL_CAST_SUCCESS(args)
	if args.spellId == 5568 then
		warningTrample:Show()
		timerTrampleCD:Start()
	end
end
