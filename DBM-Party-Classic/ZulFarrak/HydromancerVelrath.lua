local mod	= DBM:NewMod("HydromancerVelrath", "DBM-Party-Classic", 20)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("20220518110528")
mod:SetCreatureID(7795)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 12491"
)

local specWarnHealingWave			= mod:NewSpecialWarningInterrupt(12491, "HasInterrupt", nil, nil, 1, 2)

local timerHealingWaveCD			= mod:NewAITimer(180, 12491, nil, nil, nil, 4, nil, DBM_COMMON_L.INTERRUPT_ICON)

function mod:OnCombatStart(delay)
	timerHealingWaveCD:Start(1-delay)
end

function mod:SPELL_CAST_START(args)
	if args.spellId == 12491 and args:IsSrcTypeHostile() then
		timerHealingWaveCD:Start()
		if self:CheckInterruptFilter(args.sourceGUID, false, true) then
			specWarnHealingWave:Show(args.sourceName)
			specWarnHealingWave:Play("kickcast")
		end
	end
end
