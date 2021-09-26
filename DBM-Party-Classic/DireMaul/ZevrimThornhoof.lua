local mod	= DBM:NewMod(402, "DBM-Party-Classic", 6, 230)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 7007 $"):sub(12, -3))
mod:SetCreatureID(11490)
--


mod:RegisterCombat("combat")
--mod:DisableFriendlyDetection()

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 22651"
)

local warnSacrifice				= mod:NewTargetNoFilterAnnounce(22651, 4)

local yellSacrifice				= mod:NewYell(22651)

function mod:SacTarget(targetname, uId)
	if not targetname then return end
	warnSacrifice:Show(targetname)
	if targetname == UnitName("player") then
		yellSacrifice:Yell()
	end
end

function mod:SPELL_CAST_START(args)
	if args.spellId == 22651 and args:IsSrcTypeHostile() then
		self:BossTargetScanner(args.sourceGUID, "SacTarget", 0.1, 8)
	end
end
