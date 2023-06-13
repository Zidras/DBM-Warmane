local mod	= DBM:NewMod("ConstructorAndController", "DBM-Party-WotLK", 10)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("20220518110528")
mod:SetCreatureID(24200, 24201)

mod:RegisterCombat("combat", 24200, 24201)

mod:RegisterEventsInCombat(
	"SPELL_AURA_APPLIED 43650",
	"SPELL_AURA_REMOVED 43650",
	"SPELL_SUMMON 52611"
)

local warningEnfeeble	= mod:NewTargetNoFilterAnnounce(43650, 2)
local warningSummon		= mod:NewSpellAnnounce(52611, 3)

local timerEnfeeble		= mod:NewTargetTimer(6, 43650)

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 43650 then
		warningEnfeeble:Show(args.destName)
		timerEnfeeble:Start(args.destName)
	end
end

function mod:SPELL_AURA_REMOVED(args)
	if args.spellId == 43650 then
		timerEnfeeble:Cancel(args.destName)
	end
end

function mod:SPELL_SUMMON(args)
	if args.spellId == 52611 and self:AntiSpam() then
		warningSummon:Show()
	end
end
