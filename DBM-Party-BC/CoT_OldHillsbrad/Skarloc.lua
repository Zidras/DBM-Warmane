local mod	= DBM:NewMod(539, "DBM-Party-BC", 11, 251)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 7007 $"):sub(12, -3))
mod:SetCreatureID(17862)

mod:SetModelID(17387)
mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 29427",
	"SPELL_AURA_APPLIED 13005",
	"SPELL_AURA_REMOVED 13005",
	"SPELL_PERIODIC_DAMAGE 38385",
	"SPELL_PERIODIC_MISSED 38385"
)

local warnHammer				= mod:NewTargetNoFilterAnnounce(13005, 2)

local specWarnHeal				= mod:NewSpecialWarningInterrupt(29427, "HasInterrupt", nil, nil, 1, 2)
local specWarnConsecration		= mod:NewSpecialWarningMove(38385, nil, nil, nil, 1, 2)

local timerHammer				= mod:NewTargetTimer(6, 13005, nil, nil, nil, 3)

function mod:SPELL_CAST_START(args)
	if args.spellId == 29427 and self:CheckInterruptFilter(args.sourceGUID, false, true) then
		specWarnHeal:Show(args.sourceName)
		specWarnHeal:Play("kickcast")
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 13005 then
		warnHammer:Show(args.destName)
		timerHammer:Start(args.destName)
	end
end

function mod:SPELL_AURA_REMOVED(args)
	if args.spellId == 13005 then
		timerHammer:Stop(args.destName)
	end
end

function mod:SPELL_PERIODIC_DAMAGE(_, _, _, destGUID, _, _, spellId)
	if spellId == 38385 and destGUID == UnitGUID("player") and self:AntiSpam() then
		specWarnConsecration:Show()
		specWarnConsecration:Play("runaway")
	end
end
mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE
