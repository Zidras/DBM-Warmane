local mod	= DBM:NewMod("Kurinnaxx", "DBM-AQ20", 1)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("20220518110528")
mod:SetCreatureID(15348)

mod:SetModelID(15348)
mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CREATE 25648", -- spawn spell differently on CC
	"SPELL_AURA_APPLIED 25646 26527",
	"SPELL_AURA_APPLIED_DOSE 25646",
	"SPELL_AURA_REMOVED 25646",
	"SPELL_CAST_SUCCESS 3391",
	"SPELL_EXTRA_ATTACKS 3391"
)

local warnWound			= mod:NewStackAnnounce(25646, 2, nil, "Tank", 2)
local warnSandTrap		= mod:NewTargetNoFilterAnnounce(25656, 3)
local warnFrenzy		= mod:NewTargetNoFilterAnnounce(26527, 3)

local specWarnSandTrap	= mod:NewSpecialWarningYou(25656, nil, nil, nil, 1, 2)
local specWarnSandTrapNearby = mod:NewSpecialWarningClose(25656, nil, nil, nil, 2, 2)
local yellSandTrap		= mod:NewYell(25656)
local specWarnWound		= mod:NewSpecialWarningStack(25646, nil, 5, nil, nil, 1, 6)
local specWarnWoundTaunt= mod:NewSpecialWarningTaunt(25646, nil, nil, nil, 1, 2)

local timerWound		= mod:NewTargetTimer(15, 25646, nil, "Tank", 2, 5, nil, DBM_COMMON_L.TANK_ICON)
local timerSandTrapCD	= mod:NewCDTimer(8-3, 25656, nil, nil, nil, 3)
local timerThrashCD		= mod:NewCDTimer(16, 3391, nil, nil, nil, 3)

--mod:AddSpeedClearOption("AQ20", true)

--mod.vb.firstEngageTime = nil

function mod:OnCombatStart(delay)
	timerSandTrapCD:Start(8-3-delay)
	timerThrashCD:Start(16-delay)
--[[	if not self.vb.firstEngageTime then
		self.vb.firstEngageTime = time()
		if self.Options.FastestClear and self.Options.SpeedClearTimer then
			--Custom bar creation that's bound to core, not mod, so timer doesn't stop when mod stops it's own timers
			DBT:CreateBar(self.Options.FastestClear, DBM_CORE_L.SPEED_CLEAR_TIMER_TEXT, "Interface\\Icons\\Spell_Nature_TimeStop")
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
		elseif self:CheckNearby(10+2, args.destName) then
			specWarnSandTrapNearby:Show(args.destName)
			specWarnSandTrapNearby:Play("watchfeet")
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

function mod:SPELL_CAST_SUCCESS(args)
	if args.spellID == 3391 then
		timerThrashCD:Start()
	end
end
mod.SPELL_EXTRA_ATTACKS = mod.SPELL_CAST_SUCCESS
