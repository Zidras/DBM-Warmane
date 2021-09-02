local mod = DBM:NewMod(551, "DBM-Party-BC", 15, 254)
local L = mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 7007 $"):sub(12, -3))
mod:SetCreatureID(20912)

mod:SetModelID(19943)
mod:SetModelScale(0.4)
mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"CHAT_MSG_MONSTER_YELL",
	"SPELL_AURA_APPLIED 39019 37162 36924 36929 39017 39021",
	"SPELL_AURA_REMOVED 39019 37162 36924 36929 39017 39021",
	"UNIT_HEALTH"
)

local warnSplitSoon     = mod:NewAnnounce("warnSplitSoon", 2)
local warnSplit         = mod:NewAnnounce("warnSplit", 3)
local warnMindControl   = mod:NewTargetNoFilterAnnounce(39019, 4)
local warnMindRend      = mod:NewTargetNoFilterAnnounce(39017, 2)

local timerMindControl  = mod:NewTargetTimer(6, 39019, nil, nil, nil, 3)
local timerMindRend     = mod:NewTargetTimer(6, 39017, nil, false, 2, 3)

mod.vb.warnedSplit1		= false
mod.vb.warnedSplit2		= false

function mod:OnCombatStart()
	self.vb.warnedSplit1 = false
	self.vb.warnedSplit2 = false
end

function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpellID(39019, 37162) then
		warnMindControl:Show(args.destName)
		timerMindControl:Start(args.destName)
	elseif args:IsSpellID(36924, 36929, 39017, 39021) then
		warnMindRend:Show(args.destName)
		timerMindRend:Start(args.destName)
	end
end

function mod:SPELL_AURA_REMOVED(args)
	if args:IsSpellID(39019, 37162) then
		timerMindControl:Stop(args.destName)
	elseif args:IsSpellID(36924, 36929, 39017, 39021) then
		timerMindRend:Stop(args.destName)
	end
end

function mod:CHAT_MSG_MONSTER_YELL(msg)
	if msg == L.Split then
        warnSplit:Show()
	end
end

do
	local UnitHealth, UnitHealthMax = UnitHealth, UnitHealthMax

	function mod:UNIT_HEALTH(uId)
		if not self.vb.warnedSplit1 and self:GetUnitCreatureId(uId) == 20912 and UnitHealth(uId) / UnitHealthMax(uId) <= 0.70 then
			self.vb.warnedSplit1 = true
			warnSplitSoon:Show()
		elseif not self.vb.warnedSplit2 and self:IsHeroic() and self:GetUnitCreatureId(uId) == 20912 and UnitHealth(uId) / UnitHealthMax(uId) <= 0.37 then
			self.vb.warnedSplit2 = true
			warnSplitSoon:Show()
		end
	end
end
