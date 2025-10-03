local mod	= DBM:NewMod(489, "DBM-Party-Classic", 20, 241)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("20250929220131")
mod:SetCreatureID(7267)--7797/ruuzlu
mod:SetEncounterID(600)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_AURA_APPLIED 8269"
)

--TODO, Add cleave timer?
local warningEnrage			= mod:NewTargetNoFilterAnnounce(8269, 2)

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 8269 and args:IsDestTypePlayer() then
		warningEnrage:Show(args.destName)
	end
end
