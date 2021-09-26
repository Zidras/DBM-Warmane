local mod	= DBM:NewMod("LadySerevess", "DBM-Party-Classic", 1)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 7007 $"):sub(12, -3))
mod:SetCreatureID(4831)
--

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_SUCCESS 246",
	"SPELL_AURA_APPLIED 246"
)

local warningSlow			= mod:NewTargetNoFilterAnnounce(246, 2)

local timerSlowCD			= mod:NewAITimer(180, 246, nil, nil, nil, 3, nil, DBM_CORE_L.MAGIC_ICON)

function mod:OnCombatStart(delay)
	timerSlowCD:Start(1-delay)
end

function mod:SPELL_CAST_SUCCESS(args)
	if args.spellId == 246 and args:IsSrcTypeHostile() then
		timerSlowCD:Start()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 246 and args:IsDestTypePlayer() then
		warningSlow:Show(args.destName)
	end
end
