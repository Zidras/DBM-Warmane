local mod	= DBM:NewMod("Azuregos", "DBM-Azeroth")
local L		= mod:GetLocalizedStrings()

mod:SetRevision("20220518110528")
mod:SetCreatureID(6109)--121820 TW ID, 6109 classic ID
--mod:SetModelID(17887)
mod:EnableWBEngageSync()--Enable syncing engage in outdoors

mod:RegisterCombat("yell", L.Pull)

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 21099",
	"SPELL_CAST_SUCCESS 22067 21147"
)

local warningFrostBreath		= mod:NewSpellAnnounce(21099, 3)

local specWarnArcaneVacuum		= mod:NewSpecialWarningSpell(21147, nil, nil, nil, 2, 5)
local specWarnReflection		= mod:NewSpecialWarningSpell(22067, "CasterDps", nil, nil, 1, 2)

--Timers too variable, if the max is more than double the min time, a timer for min time is more misleading than helpful
--local timerReflectionCD		= mod:NewCDTimer(15.7, 22067, nil, "CasterDps", nil, 5, nil, DBM_CORE_L.DAMAGER_ICON)--15.7-33
--local timerFrostBreathCD		= mod:NewCDTimer(10, 21099, nil, nil, nil, 3)--10-40 (lovely)
--local timerArcaneVacuumCD		= mod:NewCDTimer(16, 21147, nil, nil, nil, 2)--16-35

--mod:AddReadyCheckOption(48620, false)

function mod:OnCombatStart(_, yellTriggered)
	if yellTriggered then
		--timerFrostBreathCD:Start(5.8-delay)
		--timerArcaneVacuumCD:Start(5.7-delay)--5.7-12
		--timerReflectionCD:Start(24.4-delay)--Recheck
	end
end

function mod:SPELL_CAST_START(args)
	if args.spellId == 21099 and self:AntiSpam(3, 2) then
		warningFrostBreath:Show()
		--timerFrostBreathCD:Start()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if args.spellId == 22067 then
		specWarnReflection:Show()
		specWarnReflection:Play("stilldanger")
		--pull:176.7, 31.3, 23.1, 20.8, 30.6, 26.2, 25.5, 15.7, 33.1, 30.1
		--timerReflectionCD:Start()
	elseif args.spellId == 21147 and self:AntiSpam(5, 1) then
		specWarnArcaneVacuum:Show()
		specWarnArcaneVacuum:Play("teleyou")
		--timerArcaneVacuumCD:Start()
	end
end
