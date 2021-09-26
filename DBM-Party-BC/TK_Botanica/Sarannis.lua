local mod = DBM:NewMod(558, "DBM-Party-BC", 14, 257)
local L = mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 7007 $"):sub(12, -3))
mod:SetCreatureID(17976)

mod:SetModelID(18929)
mod:RegisterCombat("combat")

local warnReinforcementsNow		= mod:NewSpellAnnounce(34803, 1)
local warnReinforcementsSoon	= mod:NewSoonAnnounce(34803, 3)

local timerReinforcements		= mod:NewCDTimer(60, 34803, nil, nil, nil, 2)

function mod:OnCombatStart(delay)
	if self:IsNormal() then
		self:RegisterShortTermEvents("UNIT_HEALTH")
	else
		self:RegisterShortTermEvnts("UNIT_SPELLCAST_SUCCEEDED")
		timerReinforcements:Start(60 - delay)
		warnReinforcementsSoon:Schedule(55 - delay)
	end
end

function mod:OnCombatEnd()
	self:UnregisterShortTermEvents()
end

do
	local UnitHealth, UnitHealthMax = UnitHealth, UnitHealthMax

	function mod:UNIT_HEALTH(uId)
		if self:GetUnitCreatureId(uId) == 17976 and UnitHealth(uId) / UnitHealthMax(uId) <= 0.60 then
			warnReinforcementsSoon:Show()
			self:UnregisterShortTermEvents()
		end
	end
end

function mod:UNIT_SPELLCAST_SUCCEEDED(_, _, spellId)
	if spellId == 34803 and self:AntiSpam(3, 1) then
		timerReinforcements:Start(60 )
		warnReinforcementsSoon:Schedule(55)
		warnReinforcementsNow:Show()
	end
end
