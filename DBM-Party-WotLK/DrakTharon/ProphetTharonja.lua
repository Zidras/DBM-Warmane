local mod	= DBM:NewMod("ProphetTharonja", "DBM-Party-WotLK", 4)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 3369 $"):sub(12, -3))
mod:SetCreatureID(26632)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEvents(
	"SPELL_CAST_SUCCESS",
	"SPELL_AURA_APPLIED",
	"UNIT_HEALTH"
)

local warningDecayFleshSoon	= mod:NewSoonAnnounce(49356, 2)
local warningCloud 			= mod:NewSpellAnnounce(49548, 3)
local warningFleshSoon 		= mod:NewSoonAnnounce(49356, 3)
local warningFlesh 			= mod:NewSpellAnnounce(49356, 3)
local timerSoulstorm		= mod:NewCastTimer(6, 69049)
local warnSoulstorm			= mod:NewSpecialWarningDodge(69049)
local warnedDecay			= false

function mod:OnCombatStart()
	warnedDecay = false
end

function mod:SPELL_CAST_SUCCESS(args)
	if args:IsSpellID(49548, 59969) then
		warningCloud:Show()
	end
end

function mod:UNIT_HEALTH(uId)
	if not warnedDecay and self:GetUnitCreatureId(uId) == 26632 and UnitHealth(uId) / UnitHealthMax(uId) <= 0.58 then
		warnedDecay = true
		warningDecayFleshSoon:Show()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 49356 and self:AntiSpam(1) then
		warningFleshSoon:Show()
		warningFlesh:Schedule(5)
		timerSoulstorm:Schedule(5)
		warnSoulstorm:Schedule(11)
	end
end