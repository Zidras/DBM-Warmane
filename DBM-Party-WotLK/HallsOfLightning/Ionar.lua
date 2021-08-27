local mod	= DBM:NewMod("Ionar", "DBM-Party-WotLK", 6)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 3001 $"):sub(12, -3))
mod:SetCreatureID(28546)
mod:SetZone()
mod:SetUsedIcons(8)

mod:RegisterCombat("combat")

mod:RegisterEvents(
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_REMOVED",
	"SPELL_CAST_START",
	"UNIT_HEALTH"
)

local warningDisperseSoon	= mod:NewSoonAnnounce(52770, 2)
local warningDisperse		= mod:NewSpellAnnounce(52770, 3)
local warningOverload		= mod:NewTargetAnnounce(52658, 2)

local specWarnOverload		= mod:NewSpecialWarningMoveAway(52658, nil, nil, nil, 1, 2)

local timerOverload			= mod:NewTargetTimer(10, 52658, nil, nil, nil, 3)

mod:AddRangeFrameOption(10, 52658)
mod:AddSetIconOption("SetIconOnOverloadTarget", 59795, true, false, {8})

local warnedDisperse = false

function mod:OnCombatStart()
	warnedDisperse = false
end

function mod:OnCombatEnd()
	if self.Options.RangeFrame then
		DBM.RangeCheck:Hide()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpellID(52658, 59795) then
		if args:IsPlayer() then
			specWarnOverload:Show()
			specWarnOverload:Play("runout")
			if self.Options.RangeFrame then
				DBM.RangeCheck:Show(10)
			end
		else
			warningOverload:Show(args.destName)
		end
		timerOverload:Start(args.destName)
		if self.Options.SetIconOnOverloadTarget then
			self:SetIcon(args.destName, 8, 10)
		end
	end
end

function mod:SPELL_AURA_REMOVED(args)
	if args:IsSpellID(52658, 59795) then
		if args:IsPlayer() and self.Options.RangeFrame then
			DBM.RangeCheck:Hide()
		end
		if self.Options.SetIconOnOverloadTarget then
			self:SetIcon(args.destName, 0)
		end
	end
end

function mod:SPELL_CAST_START(args)
	if args.spellId == 52770 then
		warningDisperse:Show()
	end
end

function mod:UNIT_HEALTH(uId)
	if not warnedDisperse and self:GetUnitCreatureId(uId) == 28546 and UnitHealth(uId) / UnitHealthMax(uId) <= 0.54 then
		warnedDisperse = true
		warningDisperseSoon:Show()
	end
end