local mod	= DBM:NewMod("MalGanis", "DBM-Party-WotLK", 3)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("20220518110528")
mod:SetCreatureID(26533)

mod:RegisterCombat("combat")
mod:RegisterKill("yell", L.Outro)

mod:RegisterEventsInCombat(
	"SPELL_AURA_APPLIED 52721 58849",
	"SPELL_AURA_REMOVED 52721 58849"
)

local warningSleep	= mod:NewTargetNoFilterAnnounce(52721, 2)

local timerSleep	= mod:NewTargetTimer(10, 52721, nil, nil, nil, 5, nil, DBM_COMMON_L.MAGIC_ICON)
local timerSleepCD	= mod:NewCDTimer(20, 52721, nil, nil, nil, 3)

function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpellID(52721, 58849) then
		warningSleep:Show(args.destName)
		timerSleep:Start(args.destName)
		timerSleepCD:Start()
	end
end

function mod:SPELL_AURA_REMOVED(args)
	if args:IsSpellID(52721, 58849) then
		timerSleep:Cancel()
	end
end
