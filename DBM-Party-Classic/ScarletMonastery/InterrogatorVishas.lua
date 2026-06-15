local mod	= DBM:NewMod("InterrogatorVishas", "DBM-Party-Classic", 12)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("20220518110528")
mod:SetCreatureID(3983)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_SUCCESS 9034",
	"SPELL_AURA_APPLIED 9034"
)

local warningImmolate				= mod:NewTargetNoFilterAnnounce(9034, 2)

local timerImmolateCD				= mod:NewAITimer(180, 9034, nil, nil, nil, 3, nil, DBM_COMMON_L.MAGIC_ICON)

function mod:OnCombatStart(delay)
	timerImmolateCD:Start(1-delay)
end

function mod:SPELL_CAST_SUCCESS(args)
	if args.spellId == 9034 and args:IsSrcTypeHostile() then
		timerImmolateCD:Start()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 9034 and args:IsDestTypePlayer() then
		warningImmolate:Show(args.destName)
	end
end
