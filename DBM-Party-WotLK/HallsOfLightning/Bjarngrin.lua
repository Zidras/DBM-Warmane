local mod	= DBM:NewMod("Bjarngrin", "DBM-Party-WotLK", 6)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("20220518110528")
mod:SetCreatureID(28586)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 52027 52028"
)

local warningWhirlwind		= mod:NewSpellAnnounce(52027, 3)

local specWarnWhirlwind		= mod:NewSpecialWarningRun(52027, "Melee", nil, nil, 4, 2)

function mod:SPELL_CAST_START(args)
	if args:IsSpellID(52027, 52028) then
		if self.Options.SpecWarn52024run then
			specWarnWhirlwind:Show()
			specWarnWhirlwind:Play("runout")
		else
			warningWhirlwind:Show()
		end
	end
end
