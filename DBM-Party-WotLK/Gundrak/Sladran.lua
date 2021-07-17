local mod	= DBM:NewMod("Sladran", "DBM-Party-WotLK", 5)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 2250 $"):sub(12, -3))
mod:SetCreatureID(29304)
--mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEvents(
	"SPELL_CAST_START",
	"SPELL_DAMAGE",
	"SPELL_PERIODIC_DAMAGE"
)

local warningNova	= mod:NewSpellAnnounce(55081, 3)
local timerNovaCD	= mod:NewCDTimer(24, 55081)
local timerSpores	= mod:NewCDTimer(10, 38575)
local specwarnSpores= mod:NewSpecialWarningMove(38575)
local left = 0

local function spores()
	if mod:IsInCombat() then
		timerSpores:Start()
		mod:Schedule(10, spores)
	end
end

function mod:OnCombatStart()
	timerSpores:Start(3)
	self:Schedule(3, spores)
end

function mod:OnCombatEnd()
	self:Unschedule(spores)
	timerSpores:Cancel()
end

function mod:SPELL_CAST_START(args)
	if args:IsSpellID(55081, 59842) then
		warningNova:Show()
		timerNovaCD:Start()
		left = tonumber(timerSpores:GetRemaining())
		if left < 3.5 then
			self:Unschedule(spores)
			timerSpores:Update(10-3.5,10)
			self:Schedule(3.5, spores)
		end
	end
end

function mod:SPELL_DAMAGE(args)
	if args.spellId == 38575 and args:IsPlayer() then
		specwarnSpores:Show()
	end
end

mod.SPELL_PERIODIC_DAMAGE = mod.SPELL_DAMAGE