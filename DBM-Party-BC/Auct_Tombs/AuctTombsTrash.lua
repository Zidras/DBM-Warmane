local mod	= DBM:NewMod("AuctTombsTrash", "DBM-Party-BC", 8, 250)

mod:SetRevision("20220518110528")

mod.isTrashMod = true

mod:RegisterEvents(
	"SPELL_AURA_APPLIED 34925",
	"SPELL_CAST_START 34945 15785 34931"
)

local warningCurseOfImpotence	= mod:NewTargetNoFilterAnnounce(34925, 2)

local specWarnHeal				= mod:NewSpecialWarningInterrupt(34945, "HasInterrupt", nil, nil, 1, 2)
local specWarnManaBurn			= mod:NewSpecialWarningInterrupt(15785, "HasInterrupt", nil, nil, 1, 2)

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 34925 then
		warningCurseOfImpotence:Show(args.destName)
	end
end

function mod:SPELL_CAST_START(args)
	if args.spellId == 34945 and self:CheckInterruptFilter(args.sourceGUID, false, true) then
		specWarnHeal:Show(args.sourceName)
		specWarnHeal:Play("kickcast")
	elseif args:IsSpellID(15785, 34931) and self:CheckInterruptFilter(args.sourceGUID, false, true) then
		specWarnManaBurn:Show(args.sourceName)
		specWarnManaBurn:Play("kickcast")
	end
end
