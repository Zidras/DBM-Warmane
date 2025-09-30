local mod	= DBM:NewMod("DarkmasterGandling", "DBM-Party-Classic", 13)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("20250929220131")
mod:SetCreatureID(1853)
mod:SetEncounterID(--[[ mod:IsClassic() and 2801 or  ]]463)

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
