local mod	= DBM:NewMod("Hadronox", "DBM-Party-WotLK", 2)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("20220518110528")
mod:SetCreatureID(28921)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_AURA_APPLIED 53030 59417",
	"SPELL_PERIODIC_DAMAGE 53400 59419",
	"SPELL_PERIODIC_MISSED 53400 59419"
)

local warningLeech	= mod:NewSpellAnnounce(53030, 1)

local specWarnGTFO	= mod:NewSpecialWarningGTFO(53400, nil, nil, nil, 1, 8)

function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpellID(53030, 59417) and args:IsPlayer() then
		warningLeech:Show()
	end
end

function mod:SPELL_PERIODIC_DAMAGE(_, _, _, destGUID, _, _, spellId, spellName)
	if (spellId == 53400 or spellId == 59419) and destGUID == UnitGUID("player") and self:AntiSpam(3, 1) then
		specWarnGTFO:Show(spellName)
		specWarnGTFO:Play("watchfeet")
	end
end
mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE
