local mod	= DBM:NewMod("Arlokk", "DBM-ZG", 1)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("20220518110528")
mod:SetCreatureID(14515)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_AURA_APPLIED 24210 24212",
	"SPELL_AURA_REMOVED 24212"
)

local warnMark		= mod:NewTargetNoFilterAnnounce(24210, 3)
local warnPain		= mod:NewTargetNoFilterAnnounce(24212, 2, nil, "RemoveMagic|Healer")

local specWarnMark	= mod:NewSpecialWarningYou(24210, nil, nil, nil, 1, 2)

local timerPain		= mod:NewTargetTimer(18, 24212, nil, "RemoveMagic|Healer", nil, 3, nil, DBM_COMMON_L.MAGIC_ICON)

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 24210 then
		if args:IsPlayer() then
			specWarnMark:Show()
			specWarnMark:Play("targetyou")
		else
			warnMark:Show(args.destName)
		end
	elseif args.spellId == 24212 and args:IsDestTypePlayer() then
		warnPain:Show(args.destName)
		timerPain:Start(args.destName)
	end
end

function mod:SPELL_AURA_REMOVED(args)
	if args.spellId == 24212 and args:IsDestTypePlayer() then
		timerPain:Stop(args.destName)
	end
end
