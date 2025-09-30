local mod	= DBM:NewMod("Golemagg", "DBM-MC", 1)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("20250929220131")
mod:SetCreatureID(11988)--, 11672
mod:SetEncounterID(670)

mod:SetModelID(11986)
mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_SUCCESS 20553"
)

--TODO, quake not in combat log on classic?
local warnQuake		= mod:NewSpellAnnounce(20553)

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 20553 then
		warnQuake:Show()
	end
end
