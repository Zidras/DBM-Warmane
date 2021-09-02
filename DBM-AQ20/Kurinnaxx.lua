local mod	= DBM:NewMod("Kurinnaxx", "DBM-AQ20", 1)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 7007 $"):sub(12, -3))
mod:SetCreatureID(15348)

mod:SetModelID(15348)
mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CREATE 25648",
	"SPELL_AURA_APPLIED 25646 26527",
	"SPELL_AURA_APPLIED_DOSE 25646",
	"SPELL_AURA_REMOVED 25646"
)

local warnWound			= mod:NewStackAnnounce(25646, 2, nil, "Tank", 2)
local warnSandTrap		= mod:NewTargetNoFilterAnnounce(25656, 3)
local warnFrenzy		= mod:NewTargetNoFilterAnnounce(26527, 3)

local specWarnSandTrap	= mod:NewSpecialWarningYou(25656, nil, nil, nil, 1, 2)
local yellSandTrap		= mod:NewYell(25656)
local specWarnWound		= mod:NewSpecialWarningStack(25646, nil, 5, nil, nil, 1, 6)
local specWarnWoundTaunt= mod:NewSpecialWarningTaunt(25646, nil, nil, nil, 1, 2)

local timerWound		= mod:NewTargetTimer(15, 25646, nil, "Tank", 2, 5, nil, DBM_CORE_L.TANK_ICON)
local timerSandTrapCD	= mod:NewCDTimer(8, 25656, nil, nil, nil, 3)

--mod:AddSpeedClearOption("AQ20", true)

--mod.vb.firstEngageTime = nil

function mod:OnCombatStart(delay)
	timerSandTrapCD:Start(8-delay)
--[[	if not self.vb.firstEngageTime then
		self.vb.firstEngageTime = time()
		if self.Options.FastestClear and self.Options.SpeedClearTimer then
			--Custom bar creation that's bound to core, not mod, so timer doesn't stop when mod stops it's own timers
			DBT:CreateBar(self.Options.FastestClear, DBM_CORE_L.SPEED_CLEAR_TIMER_TEXT, 136106)
		end
	end--]]
end

function mod:SPELL_CREATE(args)
	if args.spellId == 25648 then
		timerSandTrapCD:Start()
		if args:IsPlayerSource() then
			specWarnSandTrap:Show()
			specWarnSandTrap:Play("targetyou")
			yellSandTrap:Yell()
		else
			warnSandTrap:Show(args.sourceName)
		end
	end
end

function mod:SPELL_AURA_APPLIED(args)
	--if args.spellId == 25646 and not self:IsTrivial(80) then
	if args.spellID == 25646 then
		local amount = args.amount or 1
		timerWound:Start(args.destName)
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
	elseif args.spellId == 26527 and args:IsDestTypeHostile() then
		warnFrenzy:Show(args.destName)
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	if args.spellId == 25646 then
		timerWound:Stop(args.destName)
	end
end
