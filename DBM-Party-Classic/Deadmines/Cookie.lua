local mod	= DBM:NewMod("Cookie", "DBM-Party-Classic", 5)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("20250929220131")
mod:SetCreatureID(645)
mod:SetEncounterID(165)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 5174"
)

local specWarnHeal			= mod:NewSpecialWarningInterrupt(5174, "HasInterrupt", nil, nil, 1, 2)

local timerHealCD			= mod:NewAITimer(180, 5174, nil, nil, nil, 4, nil, DBM_COMMON_L.INTERRUPT_ICON)

function mod:OnCombatStart(delay)
	timerHealCD:Start(1-delay)
end

function mod:SPELL_CAST_START(args)
	if args.spellId == 5174 then
		timerHealCD:Start()
		if self:CheckInterruptFilter(args.sourceGUID, false, true) then
			specWarnHeal:Show(args.sourceName)
			specWarnHeal:Play("kickcast")
		end
	end
end
