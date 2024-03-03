local mod   = DBM:NewMod("BWLTrash", "DBM-BWL", 1)
local L     = mod:GetLocalizedStrings()

mod:SetRevision("20220518110528")
mod.noStatistics = true
mod.isTrashMod = true

mod:RegisterEvents(
    "SPELL_PERIODIC_DAMAGE 19717",
    "SPELL_PERIODIC_MISSED 19717"
)

do
	local specWarnGTFO	= mod:NewSpecialWarningGTFO(19717, nil, nil, nil, 1, 8)

	function mod:SPELL_PERIODIC_DAMAGE(_, _, _, destGUID, _, _, spellId, spellName)
		if spellId == 19717 and destGUID == UnitGUID("player") and self:AntiSpam() then
			specWarnGTFO:Show(spellName)
			specWarnGTFO:Play("watchfeet")
		end
	end
	mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE
end
