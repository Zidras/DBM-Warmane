local mod	= DBM:NewMod("Ayamiss", "DBM-AQ20", 1)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("20220518110528")
mod:SetCreatureID(15369)

mod:SetModelID(15369)
mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_AURA_APPLIED 25725 8269",
	"SPELL_AURA_REMOVED 25725",
	"UNIT_HEALTH mouseover target"
)

local warnPhase2	= mod:NewPhaseAnnounce(2)
local warnParalyze	= mod:NewTargetNoFilterAnnounce(25725, 3)
local warnEnrage	= mod:NewTargetNoFilterAnnounce(8269, 3)

local timerParalyze	= mod:NewTargetTimer(10, 25725, nil, nil, nil, 3)

function mod:OnCombatStart()
	self:SetStage(1)
end

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 25725 then
		warnParalyze:Show(args.destName)
		timerParalyze:Start(args.destName)
	elseif args.spellId == 8269 and args:IsDestTypeHostile() then
		warnEnrage:Show(args.destName)
	end
end

function mod:SPELL_AURA_REMOVED(args)
	if args.spellId == 25725 then
		timerParalyze:Stop(args.destName)
	end
end

function mod:UNIT_HEALTH(uId)
	if self.vb.phase < 2 and self:GetUnitCreatureId(uId) == 15369 and UnitHealth(uId) / UnitHealthMax(uId) <= 0.70 then
		self:SetStage(2)
		warnPhase2:Show()
	end
end
