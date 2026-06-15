local mod	= DBM:NewMod("Fankriss", "DBM-AQ40", 1)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("20220518110528")
mod:SetCreatureID(15510)

mod:SetModelID(15510)
mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_SUMMON 518 25832 25831"
)

local warnEntangle		= mod:NewTargetAnnounce(1121, 2)
local warnWound			= mod:NewStackAnnounce(25646, 3, nil, "Tank", 3)
local warnWorm			= mod:NewSpellAnnounce(25831, 3)

local specWarnWound		= mod:NewSpecialWarningStack(25646, nil, 5, nil, nil, 1, 6)
local specWarnWoundTaunt= mod:NewSpecialWarningTaunt(25646, nil, nil, nil, 1, 2)

local timerWound		= mod:NewTargetTimer(20, 25646, nil, "Tank", 3, 5, nil, DBM_COMMON_L.TANK_ICON)

local yellEntangle		= mod:NewYell(1121)

function mod:OnCombatStart()
	if not self:IsTrivial(85) then
		self:RegisterShortTermEvents(
			"SPELL_AURA_APPLIED 25646 1121",
			"SPELL_AURA_APPLIED_DOSE 25646",
			"SPELL_AURA_REMOVED 25646"
		)
	end
end

function mod:OnCombatEnd()
	self:UnregisterShortTermEvents()
end

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 25646 then
		local amount = args.amount or 1
		timerWound:Show(args.destName)
		if amount >= 5 then
			if args:IsPlayer() then
				specWarnWound:Show(amount)
				specWarnWound:Play("stackhigh")
			elseif not DBM:UnitDebuff("player", args.spellName) and not UnitIsDeadOrGhost("player") then
				specWarnWoundTaunt:Show(args.destName)
				specWarnWoundTaunt:Play("tauntboss")
			else
				warnWound:Show(args.destName, amount)
			end
		else
			warnWound:Show(args.destName, amount)
		end
	elseif args.spellId == 1121 then
		if args:IsPlayer() then
			yellEntangle:Yell()
		end
		warnEntangle:Show(args.destName)
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	if args.spellId == 25646 then
		timerWound:Stop(args.destName)
	end
end

function mod:SPELL_SUMMON(args)
	if args:IsSpellID(518, 25832, 25831) then
		warnWorm:Show()
	end
end
