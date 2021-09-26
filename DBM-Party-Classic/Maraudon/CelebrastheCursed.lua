local mod	= DBM:NewMod(428, "DBM-Party-Classic", 8, 232)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 7007 $"):sub(12, -3))
mod:SetCreatureID(12225)


mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 21807",
	"SPELL_CAST_SUCCESS 21968",
	"SPELL_AURA_APPLIED 12747"
)

--TODO, Add https://www.wowhead.com/spell=21793/twisted-tranquility using right event?
local warningEntanglingRoots		= mod:NewTargetNoFilterAnnounce(12747, 2)
local warningCorruptForces			= mod:NewSpellAnnounce(21968, 2, nil, false)

local specWarnWrath					= mod:NewSpecialWarningInterrupt(21807, "HasInterrupt", nil, nil, 1, 2)

function mod:SPELL_CAST_START(args)
	if args.spellId == 21807 and args:IsSrcTypeHostile() then
		if self:CheckInterruptFilter(args.sourceGUID, false, true) then
			specWarnWrath:Show(args.sourceName)
			specWarnWrath:Play("kickcast")
		end
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if args.spellId == 21968 then
		warningCorruptForces:Show()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 12747 and args:IsDestTypePlayer() then
		warningEntanglingRoots:Show(args.destName)
	end
end
