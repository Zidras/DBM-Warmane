local mod = DBM:NewMod(565, "DBM-Party-BC", 13, 258)
local L = mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 7007 $"):sub(12, -3))
mod:SetCreatureID(19220)

mod:SetModelID(20033)
mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_AURA_APPLIED 35280",
	"SPELL_AURA_REMOVED 35280"
)

local warnMC      = mod:NewTargetNoFilterAnnounce(35280, 3)

local timerMC     = mod:NewTargetTimer(10, 35280, nil, nil, nil, 3)

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 35280 then
		warnMC:Show(args.destName)
		timerMC:Start(args.destName)
	end
end

function mod:SPELL_AURA_REMOVED(args)
	if args.spellId == 35280 then
		timerMC:Stop(args.destName)
	end
end
