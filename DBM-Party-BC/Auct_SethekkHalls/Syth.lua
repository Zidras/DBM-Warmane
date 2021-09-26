local mod = DBM:NewMod(541, "DBM-Party-BC", 9, 252)
local L = mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 7007 $"):sub(12, -3))
mod:SetCreatureID(18472)

mod:SetModelID(20599)
mod:SetModelScale(0.9)
mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_SUMMON 33537 33538 33539 33540"
)

local warnSummon   = mod:NewAnnounce("warnSummon", 3)

function mod:SPELL_SUMMON(args)
	if args:IsSpellID(33537, 33538, 33539, 33540) and self:AntiSpam() then
		warnSummon:Show()
	end
end
