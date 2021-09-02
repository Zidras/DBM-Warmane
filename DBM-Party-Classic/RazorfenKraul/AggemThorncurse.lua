local mod	= DBM:NewMod("AggemThorncurse", "DBM-Party-Classic", 11)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 7007 $"):sub(12, -3))
mod:SetCreatureID(4424)
--

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 14900",
	"SPELL_CAST_SUCCESS 8286"
)

local warningSummonBoar		= mod:NewSpellAnnounce(8286, 2)

local specWarnHeal			= mod:NewSpecialWarningInterrupt(14900, "HasInterrupt", nil, nil, 1, 2)

local timerSummonBoarCD		= mod:NewAITimer(180, 8286, nil, nil, nil, 1, nil, DBM_CORE_L.DAMAGE_ICON)
local timerHealCD			= mod:NewAITimer(180, 14900, nil, nil, nil, 4, nil, DBM_CORE_L.INTERRUPT_ICON)

function mod:OnCombatStart(delay)
	--timerSummonBoarCD:Start(7-delay)
	--timerHealCD:Start(9.5-delay)
end

function mod:SPELL_CAST_START(args)
	if args.spellId == 14900 and args:IsSrcTypeHostile() then
		timerHealCD:Start()
		if self:CheckInterruptFilter(args.sourceGUID, false, true) then
			specWarnHeal:Show(args.sourceName)
			specWarnHeal:Play("kickcast")
		end
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if args.spellId == 8286 then
		warningSummonBoar:Show()
		timerSummonBoarCD:Start()
	end
end
