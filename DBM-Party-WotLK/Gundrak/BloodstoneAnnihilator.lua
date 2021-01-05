local mod	= DBM:NewMod("BloodstoneAnnihilator", "DBM-Party-WotLK", 5)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 2250 $"):sub(12, -3))
mod:SetCreatureID(29307)
--mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEvents(
	"SPELL_CAST_START",
	"SPELL_CAST_SUCCESS",
	"SPELL_DAMAGE"
)

local warningElemental	= mod:NewAnnounce("WarningElemental", 3, 54850)
local warningStone		= mod:NewAnnounce("WarningStone", 3, 54878)
local timerBarrage		= mod:NewCDTimer(6, 67994)

function mod:OnCombatStart()
	timerBarrage:Start()
end

function mod:SPELL_CAST_SUCCESS(args)
	if args.spellId == 67994 then
		timerBarrage:Start()
	end
end

function mod:SPELL_CAST_START(args)
	if args:IsSpellID(54850) then
		warningElemental:Show()
		timerBarrage:Cancel()
	elseif args:IsSpellID(54878) then
		warningStone:Show()
		timerBarrage:Start()
	end
end

mod.SPELL_DAMAGE = mod.SPELL_CAST_SUCCESS