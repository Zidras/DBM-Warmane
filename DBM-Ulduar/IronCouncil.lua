local mod	= DBM:NewMod("IronCouncil", "DBM-Ulduar")
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 4154 $"):sub(12, -3))
mod:SetCreatureID(32927)
mod:SetUsedIcons(1, 2, 3, 4, 5, 6, 7, 8)

-- mod:RegisterCombat("combat", 32867, 32927, 32857)
mod:RegisterCombat("yell", L.YellPull1)
mod:RegisterCombat("yell", L.YellPull2)
mod:RegisterCombat("yell", L.YellPull3)

mod:RegisterEvents(
	"SPELL_CAST_START",
	"SPELL_AURA_APPLIED",
	"SPELL_CAST_SUCCESS",
	"UNIT_DIED"
)

mod:AddBoolOption("HealthFrame", true)

mod:SetBossHealthInfo(
	32867, L.Steelbreaker,
	32927, L.RunemasterMolgeim,
	32857, L.StormcallerBrundir
)

local warnSupercharge			= mod:NewSpellAnnounce(61920, 3)
-- Stormcaller Brundir
-- High Voltage ... 63498
local warnChainlight			= mod:NewSpellAnnounce(64215, 1)
local timerOverload				= mod:NewCastTimer(6, 63481)
local timerOverloadCooldown		= mod:NewCDTimer(60, 63481, nil, nil, nil, 2, nil, DBM_CORE_L.DEADLY_ICON, nil, 1)
local timerLightningWhirl		= mod:NewCastTimer(5, 63483)
local lightningWhirlCD			= mod:NewCDTimer(32, 63483)
local specwarnLightningTendrils	= mod:NewSpecialWarningRun(63486)
local timerLightningTendrils	= mod:NewBuffActiveTimer(35, 63486)
local specwarnOverload			= mod:NewSpecialWarningRun(63481)
mod:AddBoolOption("AlwaysWarnOnOverload", true, "announce")
mod:AddBoolOption("PlaySoundOnOverload", true)
mod:AddBoolOption("PlaySoundLightningTendrils", true)

-- Steelbreaker
-- High Voltage ... don't know what to show here - 63498
local warnFusionPunch			= mod:NewSpellAnnounce(61903, 4)
local timerFusionPunchCast		= mod:NewCastTimer(3, 61903)
local timerFusionPunchActive	= mod:NewTargetTimer(4, 61903)
local warnOverwhelmingPower		= mod:NewTargetAnnounce(61888, 2)
local timerOverwhelmingPower	= mod:NewTargetTimer(25, 61888, nil, nil, nil, 2, nil, DBM_CORE_L.MYTHIC_ICON, nil, 3)
local warnStaticDisruption		= mod:NewTargetAnnounce(61912, 3)
mod:AddBoolOption("SetIconOnOverwhelmingPower")
mod:AddBoolOption("SetIconOnStaticDisruption")

-- Runemaster Molgeim
-- Lightning Blast ... don't know, maybe 63491
local timerShieldofRunes		= mod:NewBuffActiveTimer(15, 63967)
local warnRuneofPower			= mod:NewTargetAnnounce(64320, 2)
local warnRuneofDeath			= mod:NewSpellAnnounce(63490, 2)
local warnShieldofRunes			= mod:NewSpellAnnounce(63489, 2)
local warnRuneofSummoning		= mod:NewSpellAnnounce(62273, 3)
local timerRuneofSummoning  = mod:NewCDTimer(30, 62273)
local specwarnRuneofDeath		= mod:NewSpecialWarningMove(63490)
local timerRuneofDeathDura		= mod:NewNextTimer(30, 63490, nil, nil, nil, 2, nil, DBM_CORE_L.DEADLY_ICON, nil, 1)
local timerRuneofPower			= mod:NewCDTimer(30, 61974)
local timerRuneofDeath			= mod:NewCDTimer(30, 63490)
local warnRuneofDeathIn10Sec	= mod:NewSpecialWarning("WarningRuneofDeathIn10Sec", 3)
mod:AddBoolOption("PlaySoundDeathRune", true, "announce")

local enrageTimer				= mod:NewBerserkTimer(900)

mod:AddBoolOption("RangeFrame", true)

local disruptTargets = {}
local disruptIcon = 7
local runemasterAlive = true
local brundirAlive = true
local steelbreakerAlive = true

function mod:OnCombatStart(delay)
	enrageTimer:Start()
	timerRuneofPower:Start(30)
	timerOverloadCooldown:Start(40)
	self:ScheduleMethod(30, "RuneOfPower")
	table.wipe(disruptTargets)
	disruptIcon = 7
	runemasterAlive = true
	brundirAlive = true
	steelbreakerAlive = true
end

function mod:OnCombatEnd()
	if self.Options.RangeFrame then
		DBM.RangeCheck:Hide()
	end
end

function mod:RuneOfPower()
	timerRuneofPower:Start()
	self:ScheduleMethod(60, "RuneOfPower")
end

function mod:RuneTarget()
	local targetname = self:GetBossTarget(32927)
	if not targetname then return end
		warnRuneofPower:Show(targetname)
end

local function warnStaticDisruptionTargets()
	warnStaticDisruption:Show(table.concat(disruptTargets, "<, >"))
	table.wipe(disruptTargets)
	disruptIcon = 7
end

function mod:SPELL_CAST_START(args)
	if args:IsSpellID(61920) then -- Supercharge - Unleashes one last burst of energy as the caster dies, increasing all allies damage by 25% and granting them an additional ability.
		warnSupercharge:Show()
	elseif args:IsSpellID(63479, 61879) then	-- Chain light
		warnChainlight:Show()
	elseif args:IsSpellID(61903, 63493) then	-- Fusion Punch
		warnFusionPunch:Show()
		timerFusionPunchCast:Start()
	elseif args:IsSpellID(62274, 63489) then		-- Shield of Runes
		warnShieldofRunes:Show()
	elseif args:IsSpellID(62273) then				-- Rune of Summoning
		warnRuneofSummoning:Show()
		timerRuneofSummoning:Start()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if args:IsSpellID(63490, 62269) then		-- Rune of Death
		warnRuneofDeath:Show()
		timerRuneofDeathDura:Start(30)
		warnRuneofDeathIn10Sec:Schedule(20)
	elseif args:IsSpellID(64321, 61974) then	-- Rune of Power
		self:ScheduleMethod(0.1, "RuneTarget")
		timerRuneofPower:Start()
	elseif args:IsSpellID(61869, 63481) then	-- Overload
		timerOverload:Start()
		timerOverloadCooldown:Start()
		if self.Options.AlwaysWarnOnOverload or UnitName("target") == L.StormcallerBrundir then
			specwarnOverload:Show()
			if self.Options.PlaySoundOnOverload then
				PlaySoundFile("Sound\\Creature\\HoodWolf\\HoodWolfTransformPlayer01.wav")
			end
		end
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpellID(61903, 63493) then		-- Fusion Punch
		timerFusionPunchActive:Start(args.destName)
	elseif args:IsSpellID(62269, 63490) then	-- Rune of Death - move away from it
		if args:IsPlayer() then
			specwarnRuneofDeath:Show()
			if self.Options.PlaySoundDeathRune then
				PlaySoundFile("Sound\\Creature\\HoodWolf\\HoodWolfTransformPlayer01.wav")
			end
		end
	elseif args:IsSpellID(62277, 63967) and not args:IsDestTypePlayer() then		-- Shield of Runes
		timerShieldofRunes:Start()
	elseif args:IsSpellID(64637, 61888) then	-- Overwhelming Power
		warnOverwhelmingPower:Show(args.destName)
		if args:IsPlayer() then
			if self.Options.RangeFrame then
				DBM.RangeCheck:Show(20)
			end
		end
		if mod:IsDifficulty("heroic10") then
			timerOverwhelmingPower:Start(60, args.destName)
		else
			timerOverwhelmingPower:Start(35, args.destName)
		end
		if self.Options.SetIconOnOverwhelmingPower then
			if mod:IsDifficulty("heroic10") then
				self:SetIcon(args.destName, 8, 60) -- skull for 60 seconds (until meltdown)
			else
				self:SetIcon(args.destName, 8, 35) -- skull for 35 seconds (until meltdown)
			end
		end
	elseif args:IsSpellID(63486, 61887) then	-- Lightning Tendrils
		timerLightningTendrils:Start()
		specwarnLightningTendrils:Show()
		if self.Options.PlaySoundLightningTendrils then
			PlaySoundFile("Sound\\Creature\\HoodWolf\\HoodWolfTransformPlayer01.wav")
		end
	elseif args:IsSpellID(63483, 61915) then	-- Lightning Whirl
		timerLightningWhirl:Start()
		lightningWhirlCD:Start()
	elseif args:IsSpellID(61912, 63494) then	-- Static Disruption (Hard Mode)
		disruptTargets[#disruptTargets + 1] = args.destName
		if self.Options.SetIconOnStaticDisruption then
			self:SetIcon(args.destName, disruptIcon, 20)
			disruptIcon = disruptIcon - 1
		end
		self:Unschedule(warnStaticDisruptionTargets)
		self:Schedule(0.3, warnStaticDisruptionTargets)
	end
end

function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 32857 then -- brundir
		brundirAlive = false
		if runemasterAlive and steelbreakerAlive then
			timerRuneofDeathDura:Start()
			warnRuneofDeathIn10Sec:Schedule(20)
		elseif runemasterAlive then
			timerRuneofSummoning:Start(25)
		end
	elseif cid == 32927 then -- runemaster
		runemasterAlive = false
		if brundirAlive and steelbreakerAlive then
			lightningWhirlCD:Start()
		end
		timerRuneofDeathDura:Stop()
		warnRuneofDeathIn10Sec:Cancel()
		timerRuneofPower:Stop()
		self:UnscheduleMethod("RuneOfPower")
	elseif cid == 32867 then -- steelbreaker
		steelbreakerAlive = false
		if runemasterAlive and brundirAlive then
			timerRuneofDeathDura:Start()
			warnRuneofDeathIn10Sec:Schedule(20)
			lightningWhirlCD:Start()
		elseif runemasterAlive then
			timerRuneofSummoning:Start(25)
		end
	end
end
