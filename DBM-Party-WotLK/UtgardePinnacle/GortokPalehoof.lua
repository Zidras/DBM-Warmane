local mod	= DBM:NewMod("GortokPalehoof", "DBM-Party-WotLK", 11)
local L		= mod:GetLocalizedStrings()

mod.statTypes = "normal,heroic,mythic"

mod:SetRevision("20250929220131")
mod:SetCreatureID(26687)
mod:SetEncounterID(579)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_AURA_APPLIED 48261 59268"
)

local warningImpale		= mod:NewTargetNoFilterAnnounce(48261, 2, nil, "Healer")

local timerImpale		= mod:NewTargetTimer(9, 48261, nil, "Healer", 2, 5, nil, DBM_COMMON_L.HEALER_ICON)

function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpellID(48261, 59268) then
		warningImpale:Show(args.destName)
		timerImpale:Start(args.destName)
	end
end
