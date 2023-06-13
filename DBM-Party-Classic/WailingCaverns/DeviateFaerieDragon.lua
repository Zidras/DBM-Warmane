local mod	= DBM:NewMod("DeviateFaerie", "DBM-Party-Classic", 19)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("20220518110528")
mod:SetCreatureID(5912)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 8040",
	"SPELL_AURA_APPLIED 8040"
)

local warningDruidSlumber			= mod:NewTargetNoFilterAnnounce(8040, 2)

local specWarnDruidsSlumber			= mod:NewSpecialWarningInterrupt(8040, "HasInterrupt", nil, nil, 1, 2)

function mod:SPELL_CAST_START(args)
	if args.spellId == 8040 and args:IsSrcTypeHostile() then
		if self:CheckInterruptFilter(args.sourceGUID, false, true) then
			specWarnDruidsSlumber:Show(args.sourceName)
			specWarnDruidsSlumber:Play("kickcast")
		end
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 8040 and args:IsDestTypePlayer() then
		warningDruidSlumber:Show(args.destName)
	end
end
