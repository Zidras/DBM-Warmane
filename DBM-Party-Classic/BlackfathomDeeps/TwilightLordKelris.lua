local mod	= DBM:NewMod("TwilightLordKelris", "DBM-Party-Classic", 1)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("20220518110528")
mod:SetCreatureID(4832)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 8399",
	"SPELL_AURA_APPLIED 8399"
)

--TODO, maybe interrupt warning for mind blast
local warningSleep			= mod:NewTargetNoFilterAnnounce(8399, 2)

local timerSleepCD			= mod:NewAITimer(180, 8399, nil, nil, nil, 3, nil, DBM_COMMON_L.MAGIC_ICON)

function mod:OnCombatStart(delay)
	timerSleepCD:Start(1-delay)
end

function mod:SPELL_CAST_START(args)
	if args.spellId == 8399 and args:IsSrcTypeHostile() then
		timerSleepCD:Start()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 8399 and args:IsDestTypePlayer() then
		warningSleep:Show(args.destName)
	end
end
