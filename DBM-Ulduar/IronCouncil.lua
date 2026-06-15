local mod	= DBM:NewMod("IronCouncil", "DBM-Ulduar")
local L		= mod:GetLocalizedStrings()

mod:SetRevision("20220714133232")
mod:SetCreatureID(32867, 32927, 32857)
mod:SetUsedIcons(1, 2, 3, 4, 5, 6, 7, 8)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 61920 63479 61879 61903 63493 62274 63489 62273 61973",
	"SPELL_CAST_SUCCESS 63490 62269 61869 63481",
	"SPELL_AURA_APPLIED 61903 63493 62269 63490 62277 63967 64637 61888 63486 61887 61912 63494 63483 61915",
	"SPELL_AURA_REMOVED 64637 61888 63483 61915 61912 63494",
	"UNIT_DIED",
	"UNIT_SPELLCAST_SUCCEEDED boss2"
)

mod:SetBossHealthInfo(
	32867, L.Steelbreaker,
	32927, L.RunemasterMolgeim,
	32857, L.StormcallerBrundir
)

-- General
local enrageTimer				= mod:NewBerserkTimer(900)

mod:AddRangeFrameOption(20, nil, true)

-- Stormcaller Brundir
-- High Voltage ... 63498
mod:AddTimerLine(L.StormcallerBrundir)
local warnChainlight			= mod:NewSpellAnnounce(64215, 2, nil, false, 2)

local specwarnLightningTendrils	= mod:NewSpecialWarningRun(63486, nil, nil, nil, 4, 2)
local specwarnOverload			= mod:NewSpecialWarningRun(63481, nil, nil, nil, 4, 2)
local specWarnLightningWhirl	= mod:NewSpecialWarningInterrupt(63483, "HasInterrupt", nil, nil, 1, 2)

local timerOverload				= mod:NewCastTimer(6, 63481, nil, nil, nil, 2, nil, DBM_COMMON_L.IMPORTANT_ICON)
local timerOverloadCD			= mod:NewCDTimer(60, 63481, nil, nil, nil, 2, nil, DBM_COMMON_L.IMPORTANT_ICON, nil, 1)
local timerLightningWhirl		= mod:NewCastTimer(5, 63483, nil, nil, nil, 4, nil, DBM_COMMON_L.INTERRUPT_ICON)
local timerLightningWhirlCD		= mod:NewCDTimer(32, 63483)
local timerLightningTendrils	= mod:NewBuffActiveTimer(35, 63486, nil, nil, nil, 6)
mod:AddBoolOption("AlwaysWarnOnOverload", false, "announce", nil, nil, nil, 63481)

-- Runemaster Molgeim
-- Lightning Blast ... don't know, maybe 63491
mod:AddTimerLine(L.RunemasterMolgeim)
local warnRuneofPower			= mod:NewTargetNoFilterAnnounce(64320, 2)
local warnRuneofDeathIn10Sec	= mod:NewSoonAnnounce(63490, 3)
local warnRuneofDeath			= mod:NewSpellAnnounce(63490, 2)
local warnShieldofRunes			= mod:NewSpellAnnounce(62274, 2)
local warnRuneofSummoning		= mod:NewSpellAnnounce(62273, 3)

local specwarnRuneofDeath		= mod:NewSpecialWarningMove(63490, nil, nil, nil, 1, 2)
local specWarnRuneofShields		= mod:NewSpecialWarningDispel(62274, "MagicDispeller", nil, nil, 1, 2)

local timerRuneofShields		= mod:NewBuffActiveTimer(15, 62274, nil, nil, nil, 5, nil, DBM_COMMON_L.MAGIC_ICON)
local timerRuneofDeath			= mod:NewCDTimer(30, 63490, nil, nil, nil, 3)
local timerRuneofPowerCast		= mod:NewCastTimer(1.5, 61973, nil, nil, nil, 5, nil, DBM_COMMON_L.TANK_ICON)  -- One log review (2022/07/05) - 60.0
local timerRuneofPowerCD		= mod:NewCDTimer(60, 61973, nil, nil, nil, 5, nil, DBM_COMMON_L.TANK_ICON)  -- One log review (2022/07/05) - 60.0
local timerRuneofSummoning		= mod:NewCDTimer(30, 62273, nil, nil, nil, 1)

-- Steelbreaker
-- High Voltage ... don't know what to show here - 63498
mod:AddTimerLine(L.Steelbreaker)
local warnFusionPunch			= mod:NewSpellAnnounce(61903, 4)
local warnOverwhelmingPower		= mod:NewTargetAnnounce(61888, 2)
local warnStaticDisruption		= mod:NewTargetAnnounce(63494, 3)

local timerOverwhelmingPower	= mod:NewTargetTimer(25, 61888, nil, nil, nil, 5, nil, DBM_COMMON_L.TANK_ICON..DBM_COMMON_L.DEADLY_ICON, nil, 3)
local timerFusionPunchCast		= mod:NewCastTimer(3, 61903, nil, nil, nil, 5, nil, DBM_COMMON_L.TANK_ICON..DBM_COMMON_L.MAGIC_ICON)
local timerFusionPunchActive	= mod:NewTargetTimer(4, 61903, nil, nil, nil, 5, nil, DBM_COMMON_L.TANK_ICON..DBM_COMMON_L.MAGIC_ICON)
mod:AddSetIconOption("SetIconOnOverwhelmingPower", 61888, false, false, {8})
mod:AddSetIconOption("SetIconOnStaticDisruption", 63494, false, false, {1, 2, 3, 4, 5, 6, 7})

-- Hard Mode
mod:AddTimerLine(DBM_COMMON_L.HEROIC_ICON..DBM_CORE_L.HARD_MODE)
local warnSupercharge			= mod:NewSpellAnnounce(61920, 3)

mod:GroupSpells(64320, 61973) -- Rune of Power, buff and cast

local disruptTargets = {}
mod.vb.disruptIcon = 7
local runemasterAlive = true
local brundirAlive = true
local steelbreakerAlive = true

local function ResetRange(self)
	if self.Options.RangeFrame then
		DBM.RangeCheck:DisableBossMode()
	end
end

function mod:OnCombatStart(delay)
	enrageTimer:Start(-delay)
	timerRuneofPowerCD:Start(20-delay) -- One log review (2022/07/05)
	timerOverloadCD:Start(68) -- REVIEW! Insufficent data to validate if it's correct
	table.wipe(disruptTargets)
	self.vb.disruptIcon = 7
	runemasterAlive = true
	brundirAlive = true
	steelbreakerAlive = true
end

function mod:OnCombatEnd()
	if self.Options.RangeFrame then
		DBM.RangeCheck:Hide()
	end
end

function mod:RuneTarget(targetname)
	if not targetname then return end
	warnRuneofPower:Show(targetname)
end

local function warnStaticDisruptionTargets(self)
	warnStaticDisruption:Show(table.concat(disruptTargets, "<, >"))
	table.wipe(disruptTargets)
	self.vb.disruptIcon = 7
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 61920 then -- Supercharge - Unleashes one last burst of energy as the caster dies, increasing all allies damage by 25% and granting them an additional ability.
		warnSupercharge:Show()
	elseif args:IsSpellID(63479, 61879) then	-- Chain light
		warnChainlight:Show()
	elseif args:IsSpellID(61903, 63493) then	-- Fusion Punch
		warnFusionPunch:Show()
		timerFusionPunchCast:Start()
	elseif args:IsSpellID(62274, 63489) then	-- Shield of Runes
		warnShieldofRunes:Show()
	elseif spellId == 62273 then			-- Rune of Summoning
		warnRuneofSummoning:Show()
		timerRuneofSummoning:Start()
	elseif spellId == 61973 then	-- Rune of Power (cast success not fired on Warmane, and not correct to check target after cast either)
		self:BossTargetScanner(32927, "RuneTarget", 0.1, 16, true, true)--Scan only boss unitIDs, scan only hostile targets
		timerRuneofPowerCast:Start()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if args:IsSpellID(63490, 62269) then		-- Rune of Death
		warnRuneofDeath:Show()
		timerRuneofDeath:Start()
		warnRuneofDeathIn10Sec:Schedule(20)
	elseif args:IsSpellID(61869, 63481) then	-- Overload
		timerOverload:Start()
		timerOverloadCD:Start()
		if self.Options.AlwaysWarnOnOverload or UnitGUID("target") == args.sourceGUID or self:CheckTankDistance(args.sourceGUID, 15) then
			specwarnOverload:Show()
			specwarnOverload:Play("justrun")
		end
		if self.Options.RangeFrame then
			DBM.RangeCheck:SetBossRange(20, self:GetBossUnitByCreatureId(32857))
			self:Schedule(6.5, ResetRange, self)
		end
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpellID(61903, 63493) then		-- Fusion Punch
		timerFusionPunchActive:Start(args.destName)
	elseif args:IsSpellID(62269, 63490) then	-- Rune of Death - move away from it
		if args:IsPlayer() then
			specwarnRuneofDeath:Show()
			specwarnRuneofDeath:Play("runaway")
		end
	elseif args:IsSpellID(62277, 63967) and not args:IsDestTypePlayer() then		-- Shield of Runes
		specWarnRuneofShields:Show(args.destName)
		specWarnRuneofShields:Play("dispelboss")
		timerRuneofShields:Start()
	elseif args:IsSpellID(64637, 61888) then	-- Overwhelming Power
		warnOverwhelmingPower:Show(args.destName)
		if args:IsPlayer() then
			if self.Options.RangeFrame then
				DBM.RangeCheck:Show(20)
			end
		end
		if self:IsDifficulty("normal10") then
			timerOverwhelmingPower:Start(60, args.destName)
		else
			timerOverwhelmingPower:Start(35, args.destName)
		end
		if self.Options.SetIconOnOverwhelmingPower then
			if self:IsDifficulty("normal10") then
				self:SetIcon(args.destName, 8, 60) -- skull for 60 seconds (until meltdown)
			else
				self:SetIcon(args.destName, 8, 35) -- skull for 35 seconds (until meltdown)
			end
		end
	elseif args:IsSpellID(63486, 61887) then	-- Lightning Tendrils
		timerLightningTendrils:Start()
		specwarnLightningTendrils:Show()
		specwarnLightningTendrils:Play("justrun")
	elseif args:IsSpellID(61912, 63494) then	-- Static Disruption (Hard Mode)
		disruptTargets[#disruptTargets + 1] = args.destName
		if self.Options.SetIconOnStaticDisruption and self.vb.disruptIcon > 0 then
			self:SetIcon(args.destName, self.vb.disruptIcon, 20)
		end
		self.vb.disruptIcon = self.vb.disruptIcon - 1
		self:Unschedule(warnStaticDisruptionTargets)
		self:Schedule(0.3, warnStaticDisruptionTargets, self)
	elseif args:IsSpellID(63483, 61915) then	-- Lightning Whirl
		timerLightningWhirl:Start()
		timerLightningWhirlCD:Start()
		if self:CheckInterruptFilter(args.destGUID, false, true) then
			specWarnLightningWhirl:Show(args.destName)
			specWarnLightningWhirl:Play("kickcast")
		end
	end
end

function mod:SPELL_AURA_REMOVED(args)
	if args:IsSpellID(64637, 61888) then	-- Overwhelming Power
		if self.Options.SetIconOnOverwhelmingPower then
			self:SetIcon(args.destName, 0)
		end
	elseif args:IsSpellID(63483, 61915) then	-- LightningWhirl
		timerLightningWhirl:Stop()
	elseif args:IsSpellID(61912, 63494) then	-- Static Disruption (Hard Mode)
		if self.Options.SetIconOnStaticDisruption then
			self:SetIcon(args.destName, 0)
		end
	end
end

function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 32867 then		--Steelbreaker
		steelbreakerAlive = false
		if runemasterAlive and brundirAlive then
			timerRuneofDeath:Start()
			warnRuneofDeathIn10Sec:Schedule(20)
			timerLightningWhirlCD:Start()
		elseif runemasterAlive then
			timerRuneofSummoning:Start(25)
		end
		timerFusionPunchCast:Cancel()
	elseif cid == 32927 then	--Runemaster Molgeim
		runemasterAlive = false
		if brundirAlive and steelbreakerAlive then
			timerLightningWhirlCD:Start()
		end
		timerRuneofDeath:Cancel()
		warnRuneofDeathIn10Sec:Cancel()
		timerRuneofPowerCD:Cancel()
		timerRuneofPowerCast:Cancel()
	elseif cid == 32857 then	--Stormcaller Brundir
		brundirAlive = false
		if runemasterAlive and steelbreakerAlive then
			timerRuneofDeath:Start()
			warnRuneofDeathIn10Sec:Schedule(20)
		elseif runemasterAlive then
			timerRuneofSummoning:Start(25)
		end
		timerOverload:Cancel()
		timerOverloadCD:Cancel()
		timerLightningWhirl:Cancel()
	end
end

function mod:UNIT_SPELLCAST_SUCCEEDED(_, spellName)
	if spellName == GetSpellInfo(61973) then	-- Rune of Power
		timerRuneofPowerCD:Start()
	end
end
