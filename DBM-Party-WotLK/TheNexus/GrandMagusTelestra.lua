local mod	= DBM:NewMod("GrandMagusTelestra", "DBM-Party-WotLK", 8)
local L		= mod:GetLocalizedStrings()

mod.statTypes = "normal,heroic,mythic"

mod:SetRevision("20220806222721")
mod:SetCreatureID(26731)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"UNIT_HEALTH",
	"CHAT_MSG_MONSTER_YELL"
)

local warningSplitSoon	= mod:NewAnnounce("WarningSplitSoon", 2)
local warningSplitNow	= mod:NewAnnounce("WarningSplitNow", 3)
local warningMerge		= mod:NewAnnounce("WarningMerge", 2)

mod.vb.warnedSplit1		= false
mod.vb.warnedSplit2		= false

function mod:OnCombatStart()
	self.vb.warnedSplit1 = false
	self.vb.warnedSplit2 = false
end

function mod:UNIT_HEALTH(uId)
	if not self.vb.warnedSplit1 and self:GetUnitCreatureId(uId) == 26731 and UnitHealth(uId) / UnitHealthMax(uId) <= 0.58 then
		self.vb.warnedSplit1 = true
		warningSplitSoon:Show()
	elseif not self.vb.warnedSplit2 and not self:IsDifficulty("normal5") and self:GetUnitCreatureId(uId) == 26731 and UnitHealth(uId) / UnitHealthMax(uId) <= 0.19 then
		self.vb.warnedSplit2 = true
		warningSplitSoon:Show()
	end
end

function mod:CHAT_MSG_MONSTER_YELL(msg)
	if msg == L.SplitTrigger1 or msg == L.SplitTrigger2 then
		warningSplitNow:Show()
	elseif msg == L.MergeTrigger then
		warningMerge:Show()
	end
end
