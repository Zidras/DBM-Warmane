local mod	= DBM:NewMod("BloodstoneAnnihilator", "DBM-Party-WotLK", 5)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 2250 $"):sub(12, -3))
mod:SetCreatureID(29307)
--mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 54850 54878",
	"SPELL_PERIODIC_DAMAGE 59451"
)

local warningElemental		= mod:NewAnnounce("WarningElemental", 3, 54850)
local warningStone			= mod:NewAnnounce("WarningStone", 3, 54878)

local specWarnPurpleShit	= mod:NewSpecialWarningMove(59451, nil, nil, nil, 1, 2)

function mod:SPELL_CAST_START(args)
	if args.spellId == 54850 then
		warningElemental:Show()
	elseif args.spellId == 54878 then
		warningStone:Show()
	end
end

function mod:SPELL_PERIODIC_DAMAGE(_, _, _, destGUID, _, _, spellId)
	if spellId == 59451 and destGUID == UnitGUID("player") and self:AntiSpam(2, 1) and not self:IsTrivial() then
		specWarnPurpleShit:Show()
		specWarnPurpleShit:Play("runaway")
	end
end