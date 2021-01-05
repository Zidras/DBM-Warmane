local mod	= DBM:NewMod("Moorabi", "DBM-Party-WotLK", 5)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 3354 $"):sub(12, -3))
mod:SetCreatureID(29305)
--mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEvents(
	"SPELL_CAST_START",
	"UNIT_HEALTH",
	"SPELL_CAST_START"
)

local warningTransform	= mod:NewSpellAnnounce(55098, 3)
local timerTransform	= mod:NewCDTimer(10, 55098)--experimental
local timerCopies		= mod:NewCDTimer(21, 55342)
local warnCopies		= mod:NewSpellAnnounce(55101, 4)

local lowHealth

local function copies()
	timerCopies:Start()
	warnCopies:Show()
	mod:Schedule(21, copies)
end

function mod:OnCombatStart()
	lowHealth = nil
	copies()
end

function mod:OnCombatEnd()
	self:Unschedule(copies)
	timerCopies:Cancel()
end

function mod:SPELL_CAST_START(args)
	if args:IsSpellID(55098) then
		warningTransform:Show()
		if lowHealth then
			timerTransform:Start(5) --cast every 5 seconds below 50% health
		else
			timerTransform:Start() --cast every 10 seconds above 50% health
		end
	end
end

function mod:UNIT_HEALTH(uId)
	if self:GetUnitCreatureId(uId) == 29305 then
		if UnitHealth(uId) / UnitHealthMax(uId) <= 0.50 then
			lowHealth = true
		else
			lowHealth = nil -- just in case the combat detection doesn't work
		end
	end
end