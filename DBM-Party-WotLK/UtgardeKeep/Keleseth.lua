local mod	= DBM:NewMod("Keleseth", "DBM-Party-WotLK", 10)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("20220823234921")
mod:SetCreatureID(23953)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_AURA_APPLIED 48400",
	"SPELL_AURA_REMOVED 48400"
)

local warningTomb	= mod:NewTargetNoFilterAnnounce(48400, 4)

local timerTomb		= mod:NewTargetTimer(10, 48400, nil, nil, nil, 3)
local timerTombCD	= mod:NewCDTimer(17, 48400, nil, nil, nil, 3)

function mod:OnCombatStart()
	timerTombCD:Start(17)
end

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 48400 then
		warningTomb:Show(args.destName)
		timerTomb:Start(args.destName)
		timerTombCD:Start()
	end
end

function mod:SPELL_AURA_REMOVED(args)
	if args.spellId == 48400 then
		timerTomb:Cancel()
	end
end
