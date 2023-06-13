local mod	= DBM:NewMod("FenrustheDevourer", "DBM-Party-Classic", 14)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("20220925180445")
mod:SetCreatureID(4274)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_SUCCESS 7125",
	"SPELL_AURA_APPLIED 7125"
)

local warningToxicSaliva				= mod:NewTargetNoFilterAnnounce(7125, 2, nil, "RemovePoison")

local timerToxicSalivaCD				= mod:NewAITimer(180, 7125, nil, nil, nil, 3, nil, DBM_COMMON_L.POISON_ICON)

function mod:OnCombatStart(delay)
	timerToxicSalivaCD:Start(1-delay)
end

function mod:SPELL_CAST_SUCCESS(args)
	if args.spellId == 7125 then
		timerToxicSalivaCD:Start()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 7125 and self:CheckDispelFilter("poison") then
		warningToxicSaliva:Show(args.destName)
	end
end
