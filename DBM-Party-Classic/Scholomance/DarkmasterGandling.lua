local mod	= DBM:NewMod("DarkmasterGandling", "DBM-Party-Classic", 13)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 7007 $"):sub(12, -3))
mod:SetCreatureID(1853)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_SUCCESS 17950"
)

local warningShadowPortal		= mod:NewSpellAnnounce(17950, 2) -- Target seems unreliable

function mod:SPELL_CAST_SUCCESS(args)
	if args.spellId == 17950 then
		warningShadowPortal:Show()
	end
end
