local mod	= DBM:NewMod("OverlordRamtusk", "DBM-Party-Classic", 11)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 7007 $"):sub(12, -3))
mod:SetCreatureID(4420)
--

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 8259"
)

local warningWhirlingBarrage		= mod:NewCastAnnounce(8259, 2)

function mod:SPELL_CAST_START(args)
	if args.spellId == 8259 and self:AntiSpam(3, 1) then
		warningWhirlingBarrage:Show()
	end
end
