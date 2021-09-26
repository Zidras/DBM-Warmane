local mod	= DBM:NewMod(455, "DBM-Party-Classic", 16, 236)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 7007 $"):sub(12, -3))
mod:SetCreatureID(10439)


mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_SUCCESS 17307 5568"
)

local warningKnockout			= mod:NewSpellAnnounce(17307, 2)
local warningTrample			= mod:NewSpellAnnounce(5568, 2)

local timerKnockoutCD			= mod:NewAITimer(180, 17307, nil, nil, nil, 5, nil, DBM_CORE_L.TANK_ICON)
local timerTrampleCD			= mod:NewAITimer(180, 5568, nil, nil, nil, 2)

mod:AddBoolOption("TimerGuards", true, "timer", nil, 1)

function mod:OnCombatStart(delay)
	timerKnockoutCD:Start(1-delay)
	timerTrampleCD:Start(1-delay)
end

function mod:OnCombatEnd(wipe, isSecondRun)
	if not wipe and not isSecondRun and self.Options.TimerGuards then
		-- Custom bar that's bound to core so timer doesn't stop when mod stops its own timers
		DBT:CreateBar(91, self.localization.timers.TimerGuards, 136187, nil, nil, nil, nil, self.Options.TimerGuardsTColor, nil, nil, nil, self.Options.TimerGuardsCVoice)
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if args.spellId == 17307 and args:IsSrcTypeHostile() then
		warningKnockout:Show()
		timerKnockoutCD:Start()
	elseif args.spellId == 5568 and args:IsSrcTypeHostile() then
		warningTrample:Show()
		timerTrampleCD:Start()
	end
end
