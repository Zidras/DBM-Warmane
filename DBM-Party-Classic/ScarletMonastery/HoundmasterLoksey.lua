local mod	= DBM:NewMod("HoundmasterLoksey", "DBM-Party-Classic", 12)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("20250929220131")
mod:SetCreatureID(3974)
mod:SetEncounterID(446)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_AURA_APPLIED 6742"
)

local warningBloodLust		= mod:NewTargetNoFilterAnnounce(6742, 2)

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 6742 and args:IsDestTypeHostile() then
		warningBloodLust:Show(args.destName)
	end
end
