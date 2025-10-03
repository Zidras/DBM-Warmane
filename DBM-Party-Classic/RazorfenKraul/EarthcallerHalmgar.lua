local mod	= DBM:NewMod("EarthcallerHalmgar", "DBM-Party-Classic", 11)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("20250929220131")
mod:SetCreatureID(4842)
mod:SetEncounterID(438)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_SUCCESS 8270"
)

--Guide mentions a totem, but no data for it in wowhead
--Rumbler spawned on engage
local warningSummonEarthRumbler		= mod:NewSpellAnnounce(8270, 2)

function mod:SPELL_CAST_SUCCESS(args)
	if args.spellId == 8270 then
		warningSummonEarthRumbler:Show()
	end
end
