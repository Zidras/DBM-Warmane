local mod	= DBM:NewMod("RhahkZor", "DBM-Party-Classic", 5)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 7007 $"):sub(12, -3))
mod:SetCreatureID(644)
--

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_SUCCESS 6304",
	"SPELL_AURA_APPLIED 6304"
)

local warningSlam			= mod:NewTargetNoFilterAnnounce(6304, 2)

local timerSlamCD			= mod:NewAITimer(180, 6304, nil, nil, nil, 5, nil, DBM_CORE_L.TANK_ICON)

function mod:OnCombatStart(delay)
	timerSlamCD:Start(1-delay)
end

function mod:SPELL_CAST_SUCCESS(args)
	if args.spellId == 6304 then
		timerSlamCD:Start()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 6304 then
		warningSlam:Show(args.destName)
	end
end
