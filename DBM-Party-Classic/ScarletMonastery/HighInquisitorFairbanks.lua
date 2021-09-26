local mod	= DBM:NewMod("Fairbanks", "DBM-Party-Classic", 12)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 7007 $"):sub(12, -3))
mod:SetCreatureID(4542)
--

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_AURA_APPLIED 8282"
)

local warningCurseofBlood			= mod:NewTargetNoFilterAnnounce(8282, 2, nil, "RemoveCurse")

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 8282 then
		warningCurseofBlood:Show(args.destName)
	end
end
