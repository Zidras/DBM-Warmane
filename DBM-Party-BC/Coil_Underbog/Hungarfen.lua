local mod	= DBM:NewMod(576, "DBM-Party-BC", 5, 262)

mod:SetRevision(("$Revision: 7007 $"):sub(12, -3))
mod:SetCreatureID(17770)

mod:SetModelID(17228)
mod:SetModelOffset(-2, 0.4, -1)
mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_SUCCESS 31673"
)

local warnFoulSpores  = mod:NewSpellAnnounce(31673, 2)

function mod:SPELL_CAST_SUCCESS(args)
	if args.spellId == 31673 then
		warnFoulSpores:Show()
	end
end
