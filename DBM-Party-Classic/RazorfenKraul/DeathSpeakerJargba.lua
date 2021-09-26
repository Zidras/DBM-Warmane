local mod	= DBM:NewMod("DeathSpeakerJargba", "DBM-Party-Classic", 11)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 7007 $"):sub(12, -3))
mod:SetCreatureID(4428)
--

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 14515",
	"SPELL_CAST_SUCCESS 14515",
	"SPELL_AURA_APPLIED 14515"
)

local warningMCCast			= mod:NewCastAnnounce(14515, 3)
local warningMC				= mod:NewTargetNoFilterAnnounce(14515, 4, nil, false, 2)--Don't want to announce the MC cast AND the target, 2 second apart warnings for same thing is not agreeable in classic (by default)

local timerMCCD				= mod:NewAITimer(180, 14515, nil, nil, nil, 3)--Uses success, because start can be interrupted by CC, evem though normal interrupts don't work, but boss recasts immediately on CC break

function mod:OnCombatStart(delay)
	--timerMCCD:Start(6-delay)--Cast Start
end

function mod:SPELL_CAST_START(args)
	if args.spellId == 14515 then
		warningMCCast:Show()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if args.spellId == 14515 then
		timerMCCD:Start()--From Success to start when final, but while AI, success to success :\
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 14515 then
		warningMC:Show(args.destName)
	end
end
