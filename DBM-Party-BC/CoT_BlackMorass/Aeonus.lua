local mod	= DBM:NewMod(554, "DBM-Party-BC", 12, 255)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("20250929220131")
mod:SetCreatureID(17881)
mod:SetEncounterID(1919)

mod:SetModelID(20510)
mod:SetModelScale(0.2)
mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_AURA_APPLIED 37605",
	"SPELL_CAST_SUCCESS 31422"
)

local warnFrenzy		= mod:NewSpellAnnounce(37605, 3)
local warnTimeStop		= mod:NewSpellAnnounce(31422, 3)

local timerTimeStop		= mod:NewBuffActiveTimer(4, 31422, nil, nil, nil, 3)

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 37605 then
		warnFrenzy:Show()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if args.spellId == 31422 then
		warnTimeStop:Show()
		timerTimeStop:Start()
	end
end
