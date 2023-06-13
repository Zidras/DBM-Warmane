local mod	= DBM:NewMod(555, "DBM-Party-BC", 2, 256)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("20220518110528")
mod:SetCreatureID(17381)

mod:SetModelID(18369)
mod:SetModelOffset(-4, 0, -0.4)
mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_AURA_APPLIED 30923",
	"SPELL_AURA_REMOVED 30923"
)

local warnMindControl	= mod:NewTargetAnnounce(30923, 4)

local timerMindControl	= mod:NewTargetTimer(10, 30923, nil, nil, nil, 3)

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 30923 then
		warnMindControl:Show(args.destName)
		timerMindControl:Start(args.destName)
	end
end

function mod:SPELL_AURA_REMOVED(args)
	if args.spellId == 30923 then
		timerMindControl:Stop(args.destName)
	end
end
