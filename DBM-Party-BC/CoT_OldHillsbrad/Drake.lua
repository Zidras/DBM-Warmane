local mod	= DBM:NewMod(538, "DBM-Party-BC", 11, 251)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 7007 $"):sub(12, -3))
mod:SetCreatureID(17848)

mod:SetModelID(17386)
mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_SUCCESS 31909",
	"SPELL_AURA_APPLIED 33792",
	"SPELL_AURA_REMOVED 33792"
)

local warnShot				= mod:NewTargetNoFilterAnnounce(33792)
local warningMortalStrike	= mod:NewTargetNoFilterAnnounce(31911, 1, nil, "Tank|Healer")

local specWarnWhirlwind		= mod:NewSpecialWarningRun(31909, nil, nil, nil, 4, 2)

local timerShot				= mod:NewTargetTimer(6, 33792, nil, nil, nil, 3)

function mod:SPELL_CAST_SUCCESS(args)
	if args.spellId == 31909 or args.spellId == 21910 then
		specWarnWhirlwind:Show()
		specWarnWhirlwind:Play("justrun")
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 33792 then
		warnShot:Show(args.destName)
		timerShot:Start(args.destName)
	elseif args.spellId == 31911 then
		warningMortalStrike:Show(args.destName)
	end
end

function mod:SPELL_AURA_REMOVED(args)
	if args.spellId == 33792 then
		timerShot:Stop(args.destName)
	end
end
