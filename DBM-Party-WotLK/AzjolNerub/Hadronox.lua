local mod	= DBM:NewMod("Hadronox", "DBM-Party-WotLK", 2)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 2250 $"):sub(12, -3))
mod:SetCreatureID(28921)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_AURA_APPLIED 53030 59417",
	"SPELL_PERIODIC_DAMAGE 53400 59419"
)

local specWarningCloud	= mod:NewSpecialWarningMove(53400, nil, nil, nil, 1, 2)
local warningLeech	= mod:NewSpellAnnounce(53030, 1)

function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpellID(53030, 59417) and args:IsPlayer() then
		warningLeech:Show()
	end
end

function mod:SPELL_PERIODIC_DAMAGE(_, _, _, destGUID, _, _, spellId)
	if (spellId == 53400 or spellId == 59419) and destGUID == UnitGUID("player") and self:AntiSpam(2, 1) and not self:IsTrivial() then
		specWarningCloud:Show()
		specWarningCloud:Play("runaway")
	end
end
