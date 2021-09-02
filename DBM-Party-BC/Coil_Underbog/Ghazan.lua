local mod	= DBM:NewMod(577, "DBM-Party-BC", 5, 262)

mod:SetRevision(("$Revision: 7007 $"):sub(12, -3))
mod:SetCreatureID(18105)

mod:SetModelID(17528)
mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_AURA_APPLIED 15716"
)

local warnEnrage	= mod:NewSpellAnnounce(15716, 4)

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 15716 then
		warnEnrage:Show()
	end
end
