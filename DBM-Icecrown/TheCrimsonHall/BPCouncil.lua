local mod	= DBM:NewMod("BPCouncil", "DBM-Icecrown", 3)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("20231203191448")
mod:SetCreatureID(37970, 37972, 37973)
mod:SetUsedIcons(1, 5, 6, 7, 8)
mod:SetBossHPInfoToHighest()
mod:SetMinSyncRevision(20220908000000)

mod:SetBossHealthInfo(
	37972, L.Keleseth,
	37970, L.Valanar,
	37973, L.Taldaram
)

mod:RegisterCombat("combat")

mod:RegisterEvents(
	"CHAT_MSG_MONSTER_YELL"
)

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 72037 72039 73037 73038 73039 71718 72040",
	"SPELL_AURA_APPLIED 70952 70981 70982 72999 71807 72796 72797 72798 71822",
	"SPELL_AURA_APPLIED_DOSE 72999",
	"SPELL_AURA_REMOVED 71822",
	"SPELL_SUMMON 71943",
	"CHAT_MSG_RAID_BOSS_EMOTE",
	"UNIT_SPELLCAST_SUCCEEDED boss1 boss2 boss3"
)

local myRealm = select(3, DBM:GetMyPlayerInfo())

-- General
local warnTargetSwitch			= mod:NewAnnounce("WarnTargetSwitch", 3, 70952)
local warnTargetSwitchSoon		= mod:NewAnnounce("WarnTargetSwitchSoon", 2, 70952)

local timerCombatStart			= mod:NewCombatTimer(29) -- Roleplay for first pull
local timerTargetSwitch			= mod:NewTimer(46.5, "TimerTargetSwitch", 70952) -- REVIEW! ~0.2s variance [46.42-46.60], with 46.0/46.2 outliers. Since these outliers are very rare, I prefer keeping this timer as the most probable cd seen in the logs
local berserkTimer				= mod:NewBerserkTimer((myRealm == "Lordaeron" or myRealm == "Frostmourne") and 360 or 600)

mod:AddSetIconOption("ActivePrinceIcon", nil, false, 5, {8})

-- Shadow Prison
local specWarnShadowPrison		= mod:NewSpecialWarningStack(72999, nil, 6, nil, nil, 1, 6, 3)

local timerShadowPrison			= mod:NewBuffFadesTimer(10, 72999, nil, nil, nil, 5) -- Hard mode debuff

mod:AddBoolOption("ShadowPrisonMetronome", false, "misc", nil, nil, nil, 72999)

-- Kinetic Bomb
local warnKineticBomb			= mod:NewSpellAnnounce(72053, 3, nil, false)

local specWarnKineticBomb		= mod:NewSpecialWarningCount(72053, "Ranged", nil, nil, 1)

local timerKineticBombCD		= mod:NewCDCountTimer(18, 72053, nil, "Ranged", nil, 1, nil, nil, true) -- ~6s variance [18.0-23.9] Added "keep" arg. (10N Icecrown 2022/08/25 || 25H Lordaeron 2022/12/07 || 25H Lordaeron [2023-08-23]@[21:05:58]) - 19.2, 23.6, 22.2, 18.5, 19.2 || 18.5, 18.3, 22.1, 19.2, 20.8, 20.4, 19.7, 21.6, 20.9, 19.5, 20.5 || pull:19.8, 23.9, 21.9, 19.6, 21.4, 23.9, 18.5, 22.0, 18.5, 21.9, 21.6

local soundKineticBomb			= mod:NewSound(72053, nil, "Ranged")

mod:AddSetIconOption("SetIconOnKineticBomb", 72053, true, true, {5, 6, 7})

-- Prince Valanar
mod:AddTimerLine(L.Valanar)
local warnShockVortex			= mod:NewTargetAnnounce(72037, 3)				-- 1,5sec cast

local specWarnVortex			= mod:NewSpecialWarningYou(72037, nil, nil, nil, 1, 2)
local yellVortex				= mod:NewYellMe(72037)
local specWarnVortexNear		= mod:NewSpecialWarningClose(72037, nil, nil, nil, 1, 2)
local specWarnEmpoweredShockV	= mod:NewSpecialWarningMoveAway(72039, nil, nil, nil, 1, 2)

local timerShockVortex			= mod:NewCDTimer(18.2, 72037, nil, nil, nil, 3, nil, nil, true) -- ~5s variance [18.2 - 22.7]. Added "keep" arg. (2 Warmane 2021 logs || 25H Lordaeron 2022/07/09 || 10N Icecrown 2022/08/25 || 25H Lordaeron 2022/09/07 || 25H Lordaeron 2022/10/21) - 19-22s || 20.3, 22.6, 21.3, 19.6, ..., 19.4, 19.7 || 18.5, 18.6 || pull:76.0 (Empowered 30.1), 18.4, 19.4, 22.0, 19.7, 22.7 || pull:76.3 (Empowered 16.3 + 30.0), 19.9, 18.2, 22.2
local timerEmpoweredShockVortex	= mod:NewCDTimer(30, 72039, nil, nil, nil, 3, nil, DBM_COMMON_L.DEADLY_ICON, true) -- Added "keep" arg. (25H Lordaeron 2022/09/07) - pull:15.9, 30.0, 152.4 (20.1 non-empowered)

local soundSpecWarnVortexNear	= mod:NewSoundClose(72037)
local soundEmpoweredShockV		= mod:NewSound(72039)

mod:AddRangeFrameOption(12, 72039)
mod:AddArrowOption("VortexArrow", 72037, true)

-- Prince Taldaram
mod:AddTimerLine(L.Taldaram)
local warnConjureFlames			= mod:NewCastAnnounce(71718, 2)
local warnEmpoweredFlamesCast	= mod:NewCastAnnounce(72040, 3)
local warnEmpoweredFlames		= mod:NewTargetNoFilterAnnounce(72040, 4)
local warnGliteringSparks		= mod:NewTargetAnnounce(71807, 2, nil, false)

local specWarnEmpoweredFlames	= mod:NewSpecialWarningRun(72040, nil, nil, nil, 4, 2)
local yellEmpoweredFlames		= mod:NewYellMe(72040)

local timerConjureFlamesCD		= mod:NewCDTimer(15.3, 71718, nil, nil, nil, 3, nil, nil, true) -- normal + empowered. REVIEW! ~13s variance [15.3-29.4]. Added "keep" arg (25H Lordaeron 2022/09/07 || 25H Lordaeron 2022/10/09 || 25H Lordaeron 2022/10/21) -- 20.0, 29.4, 24.3, 18.0, 23.5, 21.3, 27.6, 20.5, 22.3 || 20.0, 29.9, 22.0, 17.7, 24.6, 29.1, 29.9 || pull:76.3, 19.9, 18.2, 22.2 (Empowered: pull:93.8, 18.7, 15.3)
local timerGlitteringSparksCD	= mod:NewCDTimer(15.9, 71807, nil, nil, nil, 2, nil, nil, true) -- This is pretty nasty on heroic. Very high variance! Added "keep" arg (10N Icecrown 2022/08/25 || 25H Lordaeron 2022/09/07) - 36, 17.5 || pull:12.5, 43.5, 20.8, 44.3, 38.6, 16.9, 33.3

local soundEmpoweredFlames		= mod:NewSoundYou(72040)

mod:AddSetIconOption("EmpoweredFlameIcon", 72040, true, 0, {1})
mod:AddArrowOption("EmpoweredFlameArrow", 72040, true)

-- Prince Keleseth
mod:AddTimerLine(L.Keleseth)
local warnDarkNucleus			= mod:NewSpellAnnounce(71943, 1, nil, false)	-- instant cast

local timerDarkNucleusCD		= mod:NewCDTimer(10, 71943, nil, false, nil, 5, nil, nil, true)	-- ~6s variance [10.5-16.3]. Added "keep" arg (25H Lordaeron 2022/09/07) - 12.1, 12.2, 14.2, 16.3, 12.2, 10.5, 13.8, 12.1, 14.1, 12.2, 12.1, 14.3, 14.1, 14.3, 13.9, 12.1

mod.vb.kineticIcon = 7
mod.vb.kineticCount = 0
local personalNucleusCount = 0

function mod:OnCombatStart(delay)
	self.vb.kineticIcon = 7
	self.vb.kineticCount = 0
	personalNucleusCount = 0
	berserkTimer:Start(-delay)
	warnTargetSwitchSoon:Schedule(42-delay)
	warnTargetSwitchSoon:ScheduleVoice(42-delay, "swapsoon")
	timerTargetSwitch:Start(-delay)
	timerEmpoweredShockVortex:Start(15-delay) -- REVIEW! 5s variance [15-20] (25H Lordaeron 2022/09/07 || 10N Frostmourne 2023-01-22) - 15.9 || 15.6
	timerKineticBombCD:Start(19.8-delay, 1) -- (25H Lordaeron 2022/07/09 || 25H Lordaeron 2022/07/30 || 10N Icecrown 2022/08/22 || 10N Icecrown 2022/08/25 || 25H Lordaeron 2022/09/07 || 25H Lordaeron 2022/12/07 || 10N Frostmourne 2023-01-22 || 25H Lordaeron [2023-08-23]@[21:05:58]) - 24 || 24 || 27 || 24.9 || 23.1 || 22.1 || 21.6 || 19.8
	timerDarkNucleusCD:Start(12-delay) -- REVIEW! Lowest possible timer? (25H Lordaeron 2022/07/09 || 25H Lordaeron 2022/07/30 || 10N Icecrown 2022/08/22 || 10N Icecrown 2022/08/25 || 25H Lordaeron 2022/09/07 || 10N Frostmourne 2023-01-22) - 15 || 12 || 14 || 12 || 12.3 || 13.5
	if self.Options.RangeFrame then
		DBM.RangeCheck:Show(12)
	end
end

function mod:OnCombatEnd()
	if self.Options.RangeFrame then
		DBM.RangeCheck:Hide()
	end
	if self.Options.VortexArrow then
		DBM.Arrow:Hide()
	end
end

function mod:ShockVortexTarget(targetname, uId)
	if not targetname then return end
	if targetname == UnitName("player") then
		specWarnVortex:Show()
		specWarnVortex:Play("watchstep")
		yellVortex:Yell()
	else
		if uId then
			local inRange = CheckInteractDistance(uId, 2)
			if inRange then
				specWarnVortexNear:Show(targetname)
				specWarnVortexNear:Play("watchstep")
				soundSpecWarnVortexNear:Play("Interface\\AddOns\\DBM-Core\\sounds\\RaidAbilities\\vortexNear.mp3")
				if self.Options.VortexArrow then
					local x, y = GetPlayerMapPosition(uId)
					if x == 0 and y == 0 then
						SetMapToCurrentZone()
						x, y = GetPlayerMapPosition(uId)
					end
					DBM.Arrow:ShowRunAway(x, y, 10, 5)
				end
			else
				warnShockVortex:Show(targetname)
			end
		end
	end
end

function mod:HideRange()
	DBM.RangeCheck:Hide()
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 72037 then		-- Shock Vortex
		timerShockVortex:Start()
		self:BossTargetScanner(37970, "ShockVortexTarget", 0.05, 6)
	elseif args:IsSpellID(72039, 73037, 73038, 73039) then	-- Empowered Shock Vortex(73037, 73038, 73039 drycoded from wowhead)
		specWarnEmpoweredShockV:Show()
		if not self.Options.Sound72039 then
			specWarnEmpoweredShockV:Play("scatter")
		end
		timerEmpoweredShockVortex:Start()
		soundEmpoweredShockV:Play("Interface\\AddOns\\DBM-Core\\sounds\\RaidAbilities\\EmpoweredVortex.mp3")
	elseif spellId == 71718 then	-- Conjure Flames
		warnConjureFlames:Show()
		timerConjureFlamesCD:Start()
	elseif spellId == 72040 then	-- Conjure Empowered Flames
		warnEmpoweredFlamesCast:Show()
		timerConjureFlamesCD:Start()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 70952 then
		if self:IsInCombat() then
			warnTargetSwitch:Show(L.Valanar)
			warnTargetSwitchSoon:Schedule(42)
			warnTargetSwitchSoon:ScheduleVoice(42, "swapsoon")
			timerTargetSwitch:Start()
			if not timerEmpoweredShockVortex:IsStarted() then -- avoid overwriting first vortex
				if timerShockVortex:IsStarted() then
					timerEmpoweredShockVortex:Start(timerShockVortex:GetRemaining())
				else
					timerEmpoweredShockVortex:Start(20) -- random
				end
			end
			timerShockVortex:Cancel()
			if self.Options.RangeFrame then
				DBM.RangeCheck:Show(12)
			end
		end
		if self.Options.ActivePrinceIcon then
			self:ScanForMobs(args.destGUID, 2, 8, 1, nil, 12, "ActivePrinceIcon")
		end
	elseif spellId == 70981 then
		warnTargetSwitch:Show(L.Keleseth)
		warnTargetSwitchSoon:Schedule(42)
		warnTargetSwitchSoon:ScheduleVoice(42, "swapsoon")
		timerTargetSwitch:Start()
		if not timerShockVortex:IsStarted() then
			if timerEmpoweredShockVortex:IsStarted() then
				timerShockVortex:Start(timerEmpoweredShockVortex:GetRemaining())
				timerEmpoweredShockVortex:Cancel()
			else
				timerShockVortex:Start()
			end
		end
		if self.Options.RangeFrame then
			self:ScheduleMethod(4.5, "HideRange")--delay hiding range frame for a few seconds after change incase valanaar got a last second vortex cast off
		end
		if self.Options.ActivePrinceIcon then
			self:ScanForMobs(args.destGUID, 2, 8, 1, nil, 12, "ActivePrinceIcon")
		end
	elseif spellId == 70982 and self:IsInCombat() then
		warnTargetSwitch:Show(L.Taldaram)
		warnTargetSwitchSoon:Schedule(42)
		warnTargetSwitchSoon:ScheduleVoice(42, "swapsoon")
		timerTargetSwitch:Start()
		if not timerShockVortex:IsStarted() then
			if timerEmpoweredShockVortex:IsStarted() then
				timerShockVortex:Start(timerEmpoweredShockVortex:GetRemaining())
				timerEmpoweredShockVortex:Cancel()
			else
				timerShockVortex:Start()
			end
		end
		if self.Options.RangeFrame then
			self:ScheduleMethod(4.5, "HideRange")--delay hiding range frame for a few seconds after change incase valanaar got a last second vortex cast off
		end
		if self.Options.ActivePrinceIcon then
			self:ScanForMobs(args.destGUID, 2, 8, 1, nil, 12, "ActivePrinceIcon")
		end
	elseif spellId == 72999 then	--Shadow Prison (hard mode)
		if args:IsPlayer() then
			timerShadowPrison:Start()
			if personalNucleusCount < 3 and (args.amount or 1) >= 10 then	--Placeholder right now, might use a different value. Ignore if player has more than 3 Dark Nucleus
				specWarnShadowPrison:Show(args.amount)
				specWarnShadowPrison:Play("stackhigh")
			end
			if self.Options.ShadowPrisonMetronome then
				self:RegisterOnUpdateHandler(function(frame, elapsed)
					frame.time = (frame.time or 0) + elapsed
					if frame.time >= 1 then
						if not UnitAffectingCombat("player") then
							self:UnregisterOnUpdateHandler()
						end
						DBM:PlaySoundFile("Interface\\AddOns\\DBM-Core\\sounds\\tick.mp3")
						frame.time = frame.time - 1
					end
				end)
			end
		end
	elseif args:IsSpellID(71807, 72796, 72797, 72798) and args:IsDestTypePlayer() then	-- Glittering Sparks(Dot/slow, dangerous on heroic during valanaar)
		warnGliteringSparks:CombinedShow(1, args.destName)
	elseif spellId == 71822 and args:IsPlayer() then -- Shadow Resonance (from Dark Nucleus)
		personalNucleusCount = personalNucleusCount + 1 -- 35% reduction for each nucleus
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	if args.spellId == 71822 and args:IsPlayer() then -- Shadow Resonance (from Dark Nucleus)
		personalNucleusCount = personalNucleusCount - 1
	end
end

function mod:SPELL_SUMMON(args)
	if args.spellId == 71943 then
		warnDarkNucleus:Show()
		timerDarkNucleusCD:Start()
	end
end

function mod:CHAT_MSG_RAID_BOSS_EMOTE(msg, _, _, _, target)
	if msg:match(L.EmpoweredFlames) and target then
		target = DBM:GetUnitFullName(target)
		if target == UnitName("player") then
			specWarnEmpoweredFlames:Show()
			if not self.Options.Sound72040 then
				specWarnEmpoweredFlames:Play("justrun")
			end
			soundEmpoweredFlames:Play("Interface\\AddOns\\DBM-Core\\sounds\\RaidAbilities\\EmpoweredOrbOnYou.mp3")
			yellEmpoweredFlames:Yell()
		else
			warnEmpoweredFlames:Show(target)
		end
		if self.Options.EmpoweredFlameIcon then
			self:SetIcon(target, 1, 10)
		end
		if self.Options.EmpoweredFlameArrow then
			DBM.Arrow:ShowRunTo(target, 0, 0, 10) -- 0 distance (so it doesn't hide with proximity) and 10s hideTime
		end
	end
end

function mod:UNIT_SPELLCAST_SUCCEEDED(_, spellName)
	if spellName == GetSpellInfo(72080) then -- Kinetic Bomb
		self.vb.kineticCount = self.vb.kineticCount + 1
		warnKineticBomb:Show()
		specWarnKineticBomb:Show(self.vb.kineticCount)
		soundKineticBomb:Play("Interface\\AddOns\\DBM-Core\\sounds\\RaidAbilities\\KineticSpawn.mp3")
		timerKineticBombCD:Start(nil, self.vb.kineticCount+1)
		if self.Options.SetIconOnKineticBomb then
			self:ScanForMobs(38454, 2, self.vb.kineticIcon, 5, nil, 12, "SetIconOnKineticBomb", false, nil, true)
			self.vb.kineticIcon = self.vb.kineticIcon - 1
			if self.vb.kineticIcon < 5 then
				self.vb.kineticIcon = 7
			end
		end
	elseif spellName == GetSpellInfo(71807) then -- Glittering Sparks
		timerGlitteringSparksCD:Start()
	end
end

function mod:CHAT_MSG_MONSTER_YELL(msg)
	if msg == L.FirstPull or msg:find(L.FirstPull) then
		timerCombatStart:Start()
	end
end
