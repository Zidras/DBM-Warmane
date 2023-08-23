local mod	= DBM:NewMod("Putricide", "DBM-Icecrown", 2)
local L		= mod:GetLocalizedStrings()

local GetTime = GetTime
local format = string.format

mod:SetRevision("20230823103810")
mod:SetCreatureID(36678)
mod:SetUsedIcons(1, 2, 3, 4)
mod:SetHotfixNoticeRev(20230823000000)
mod:SetMinSyncRevision(20220908000000)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 70351 71966 71967 71968 71617 72842 72843 72851 72852 71621 72850 70672 72455 72832 72833 73121 73122 73120 71893",
	"SPELL_CAST_SUCCESS 70341 71255 72855 72856 70911 72615 72295 74280 74281",
	"SPELL_AURA_APPLIED 70447 72836 72837 72838 70672 72455 72832 72833 72451 72463 72671 72672 70542 70539 72457 72875 72876 70352 74118 70353 74119 72855 72856 70911",
	"SPELL_AURA_APPLIED_DOSE 72451 72463 72671 72672 70542",
	"SPELL_AURA_REFRESH 70539 72457 72875 72876 70542",
	"SPELL_AURA_REMOVED 70447 72836 72837 72838 70672 72455 72832 72833 72855 72856 70911 71615 70539 72457 72875 72876 70542",
	"UNIT_HEALTH boss1"
)

local myRealm = select(3, DBM:GetMyPlayerInfo())

-- General
local berserkTimer					= mod:NewBerserkTimer((myRealm == "Lordaeron" or myRealm == "Frostmourne") and (mod:IsDifficulty("normal25") and 450 or 480) or 600)

-- buffs from "Drink Me"
local timerMutatedSlash				= mod:NewTargetTimer(20, 70542, nil, false, nil, 5, nil, DBM_COMMON_L.TANK_ICON)
local timerRegurgitatedOoze			= mod:NewTargetTimer(20, 70539, nil, nil, nil, 5, nil, DBM_COMMON_L.TANK_ICON)

-- Stage One
mod:AddTimerLine(DBM_CORE_L.SCENARIO_STAGE:format(1)..": 100% – 80%")
local warnSlimePuddle				= mod:NewSpellAnnounce(70341, 2)
local warnUnstableExperimentSoon	= mod:NewSoonAnnounce(70351, 3)
local warnUnstableExperiment		= mod:NewSpellAnnounce(70351, 4)
local warnVolatileOozeAdhesive		= mod:NewTargetNoFilterAnnounce(70447, 3)
local warnGaseousBloat				= mod:NewTargetNoFilterAnnounce(70672, 3)
local warnUnboundPlague				= mod:NewTargetNoFilterAnnounce(70911, 3, nil, false, nil, nil, nil, true)		-- Heroic Ability, sound muted

local specWarnVolatileOozeAdhesive	= mod:NewSpecialWarningYou(70447, nil, nil, nil, 1, 2)
local specWarnVolatileOozeAdhesiveT	= mod:NewSpecialWarningMoveTo(70447, nil, nil, nil, 1, 2)
local specWarnGaseousBloat			= mod:NewSpecialWarningRun(70672, nil, nil, nil, 4, 2)
local specWarnGaseousBloatCast		= mod:NewSpecialWarningMove(72833, nil, nil, nil, 1, 2)		-- Gaseous Bloat (cast)
local specWarnUnboundPlague			= mod:NewSpecialWarningYou(70911, nil, nil, nil, 1, 2, 3)	-- Heroic Ability
local yellUnboundPlague				= mod:NewYellMe(70911, false)	-- Heroic Ability, disabled by default to reduce chat bubble spam

local timerGaseousBloat				= mod:NewTargetTimer(20, 70672, nil, nil, nil, 3)			-- Duration of debuff
local timerGaseousBloatCast			= mod:NewCastTimer(3, 70672, nil, nil, nil, 3)				-- Cast duration
local timerSlimePuddleCD			= mod:NewCDTimer(35, 70341, nil, nil, nil, 5, nil, DBM_COMMON_L.TANK_ICON)				-- Approx
local timerUnstableExperimentCD		= mod:NewCDTimer(35, 70351, nil, nil, nil, 1, nil, DBM_COMMON_L.DEADLY_ICON, true) -- 5s variance [35-40]. Added "keep" arg (10N Icecrown 2022/08/20 || 10N Icecrown 2022/08/25 || 10H Lordaeron 2022/09/02 || 25H Lordaeron 2022/09/04) - 39.1, 38.0 || 39.1, 38.0 || Stage 1/30.7, 36.2 ; Stage 1/33.9, 67.6, Stage 2/2.1, 36.5/38.6, 36.7; Stage 1/30.5, 35.7, Stage 2/41.6 || Stage 1/30.5, 68.3, Stage 2/4.9, 32.8/37.7, 37.7
local timerUnboundPlagueCD			= mod:NewNextTimer(90, 70911, nil, nil, nil, 3, nil, DBM_COMMON_L.HEROIC_ICON)
local timerUnboundPlague			= mod:NewBuffActiveTimer(12, 70911, nil, nil, nil, 3)		-- Heroic Ability: we can't keep the debuff 60 seconds, so we have to switch at 12-15 seconds. Otherwise the debuff does to much damage!

local soundSlimePuddle				= mod:NewSound(70341)

mod:AddSetIconOption("OozeAdhesiveIcon", 70447, true, 0, {4})--green icon for green ooze
mod:AddSetIconOption("GaseousBloatIcon", 70672, true, 0, {2})--Orange Icon for orange/red ooze
mod:AddSetIconOption("UnboundPlagueIcon", 70911, true, 0, {3})

-- Stage Two
mod:AddTimerLine(DBM_CORE_L.SCENARIO_STAGE:format(2)..": 80% – 35%")
local warnPhase2					= mod:NewPhaseAnnounce(2, 2, nil, nil, nil, nil, nil, 2)
local warnChokingGasBombSoon		= mod:NewPreWarnAnnounce(71255, 5, 3, nil, "Melee")
local warnChokingGasBomb			= mod:NewSpellAnnounce(71255, 3, nil, "Melee")		-- Phase 2 ability

--local specWarnMalleableGoo			= mod:NewSpecialWarningYou(72295, nil, nil, nil, 1, 2)
--local yellMalleableGoo				= mod:NewYellMe(72295)
--local specWarnMalleableGooNear		= mod:NewSpecialWarningClose(72295, nil, nil, nil, 1, 2)
local specWarnChokingGasBomb		= mod:NewSpecialWarningMove(71255, "Melee", nil, nil, 1, 2)
local specWarnMalleableGooCast		= mod:NewSpecialWarningSpell(72295, "Ranged", nil, nil, 2, 2)

local timerChokingGasBombCD			= mod:NewCDTimer(35.2, 71255, nil, nil, nil, 3, nil, nil, true) -- ~5s variance [35.2-39.8]. Added "keep" arg (25H Lordaeron 2022/09/07 || 25H Lordaeron 2022/09/23 wipe1 || 25H Lordaeron 2022/09/23 kill) - pull:126.3/Stage 2/22.8, 35.3, 35.5, 35.9; pull:126.4/Stage 2/22.1, 36.6, 35.9, 37.3, 38.7, Stage 2.5/7.8, Stage 3/31.9, 30.0/61.9/69.7, 38.2 || pull:121.2/Stage 2/21.9, 37.2, 38.7, 37.7, 38.7, Stage 2.5/2.3, Stage 3/33.0, 33.2/66.1/68.4, 39.4" || Stage 2/21.3, 38.0, 35.2, 35.8, 39.8, Stage 2.5/11.6, Stage 3/33.2, 23.9/57.1/68.8, 35.5
local timerChokingGasBombExplosion	= mod:NewCastTimer(12, 71255, nil, nil, nil, 2)
local timerMalleableGooCD			= mod:NewNextTimer(20, 72295, nil, nil, nil, 3) -- (25H Lordaeron 2022/09/07) - pull:113.6/Stage 2/10.1, 20.0, 20.0, 20.0, 20.0, 20.0, 20.0, 20.0; pull:114.4/Stage 2/10.1, 20.0, 20.1, 20.0, 20.0, 20.0, 20.0, 20.0, 20.0, Stage 2.5/8.1, Stage 3/31.9, 10.0/41.9/50.0, 20.0, 20.0, 20.0, 20.0"

local soundSpecWarnMalleableGoo		= mod:NewSound(72295, nil, "Ranged")
local soundMalleableGooSoon			= mod:NewSoundSoon(72295, nil, "Ranged")
local soundSpecWarnChokingGasBomb	= mod:NewSound(71255, nil, "Melee")
local soundChokingGasSoon			= mod:NewSoundSoon(71255, nil, "Melee")

--mod:AddSetIconOption("MalleableGooIcon", 72295, true, 0, {1})
--mod:AddArrowOption("GooArrow", 72295)

-- Stage Three
mod:AddTimerLine(DBM_CORE_L.SCENARIO_STAGE:format(3)..": 35% – 0%")
local warnPhase3					= mod:NewPhaseAnnounce(3, 2, nil, nil, nil, nil, nil, 2)
local warnMutatedPlague				= mod:NewStackAnnounce(72451, 3, nil, "Tank|Healer|RemoveEnrage") -- Phase 3 ability

local timerMutatedPlagueCD			= mod:NewCDTimer(10, 72451, nil, "Tank|Healer|RemoveEnrage", nil, 5, nil, DBM_COMMON_L.TANK_ICON)				-- 10 to 11

-- Intermission
mod:AddTimerLine(DBM_COMMON_L.INTERMISSION)
local warnPhase2Soon				= mod:NewPrePhaseAnnounce(2)
local warnPhase3Soon				= mod:NewPrePhaseAnnounce(3)
local warnTearGas					= mod:NewSpellAnnounce(71617, 2)		-- Phase transition normal
local warnVolatileExperiment		= mod:NewSpellAnnounce(72843, 4)		-- Phase transition heroic

local specWarnOozeVariable			= mod:NewSpecialWarningYou(70352, nil, nil, nil, nil, nil, 3)	-- Heroic Ability
local specWarnGasVariable			= mod:NewSpecialWarningYou(70353, nil, nil, nil, nil, nil, 3)	-- Heroic Ability

local timerNextPhase				= mod:NewPhaseTimer(30)
--local timerTearGas					= mod:NewBuffFadesTimer(16, 71617, nil, nil, nil, 6)
--local timerPotions					= mod:NewBuffActiveTimer(30, 71621, nil, nil, nil, 6)

local redOozeGUIDsCasts = {}
local PuddleTime = 0
local ChokingTime = 0
local UnboundTime = 0
mod.vb.warned_preP2 = false
mod.vb.warned_preP3 = false

local function NextPhase(self)
	self:SetStage(self.vb.phase + 0.5)
	if self.vb.phase == 2 then
		warnPhase2:Show()
		warnPhase2:Play("ptwo")
		self:UnregisterShortTermEvents() -- UnregisterShortTermEvents moved here to ensure UNIT_TARGET is unregistered (previously was running on sync, which is not always used)
	elseif self.vb.phase == 3 then
		warnPhase3:Show()
		warnPhase3:Play("pthree")
		self:UnregisterShortTermEvents() -- UnregisterShortTermEvents moved here to ensure UNIT_TARGET is unregistered (previously was running on sync, which is not always used)
	end
end

-- This does not work on Warmane - boss never swaps targets to throw malleable (last checked on 14/07/2021)
--[[function mod:MalleableGooTarget(targetname, uId)
	if not targetname then return end
		if self.Options.MalleableGooIcon then
			self:SetIcon(targetname, 1, 10)
		end
	if targetname == UnitName("player") then
		specWarnMalleableGoo:Show()
		specWarnMalleableGoo:Play("targetyou")
		yellMalleableGoo:Yell()
		soundSpecWarnMalleableGoo:Play("Interface\\AddOns\\DBM-Core\\sounds\\RaidAbilities\\malleable.mp3")
	else
		if self:CheckNearby(11, targetname) then
			specWarnMalleableGooNear:Show(targetname)
			specWarnMalleableGooNear:Play("watchstep")
			soundSpecWarnMalleableGoo:Play("Interface\\AddOns\\DBM-Core\\sounds\\RaidAbilities\\malleable.mp3")
		else
			specWarnMalleableGooCast:Show()
			specWarnMalleableGooCast:Play("watchstep")
			soundSpecWarnMalleableGoo:Play("Interface\\AddOns\\DBM-Core\\sounds\\RaidAbilities\\malleable.mp3")
		end
		if self.Options.GooArrow then
			local x, y = GetPlayerMapPosition(uId)
			if x == 0 and y == 0 then
				SetMapToCurrentZone()
				x, y = GetPlayerMapPosition(uId)
			end
			DBM.Arrow:ShowRunAway(x, y, 10, 5)
		end
	end
end]]

function mod:OnCombatStart(delay)
	self:SetStage(1)
	berserkTimer:Start(-delay)
	timerSlimePuddleCD:Start(10-delay)
	timerUnstableExperimentCD:Start(30-delay) -- REVIEW! need P1 N log data to determine whether H/N has difference. heroic 5s variance (10N Icecrown 2022/08/25 || 10H Lordaeron 2022/09/02 || 25H Lordaeron 2022/09/04) - 61 || 33.0; 30.7; 30.5; 33.9 || 30.5
	warnUnstableExperimentSoon:Schedule(25-delay)
	table.wipe(redOozeGUIDsCasts)
	PuddleTime = 0
	ChokingTime = 0
	UnboundTime = 0
	self.vb.warned_preP2 = false
	self.vb.warned_preP3 = false
	if self:IsHeroic() then
		timerUnboundPlagueCD:Start(20-delay)
	end
end

function mod:OnCombatEnd()
	self:UnregisterShortTermEvents()
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if args:IsSpellID(70351, 71966, 71967, 71968) then	-- Unstable Experiment
		warnUnstableExperimentSoon:Cancel()
		warnUnstableExperiment:Show()
		timerUnstableExperimentCD:Start()
		warnUnstableExperimentSoon:Schedule(30)
	elseif spellId == 71617 then				--Tear Gas (stun all on Normal phase) (Normal intermission)
		self:SetStage(self.vb.phase + 0.5) -- ACTION_CHANGE_PHASE
		warnTearGas:Show()
		if self.vb.phase == 2.5 then -- Usual timer delta is not reliable for Malleable Goo, it's a different logic, commented below
			local gooElapsed = timerMalleableGooCD:GetTime() -- On second intermission, the next Malleable Goo will always be 50s after the previous Malleable Goo cast, so calculate elapsed time and update timer
			timerMalleableGooCD:Update(gooElapsed, 50)
			soundMalleableGooSoon:Schedule(50-gooElapsed-3, "Interface\\AddOns\\DBM-Core\\sounds\\RaidAbilities\\malleable_soon.mp3")
		end
	elseif args:IsSpellID(72842, 72843) then		--Volatile Experiment (Heroic intermission)
		-- TO DO: check whether delaying all running timers by 30s is accurate, according to TC. According to AC is 24+25s
		self:SetStage(self.vb.phase + 0.5) -- ACTION_CHANGE_PHASE
		warnVolatileExperiment:Show()
		warnUnstableExperimentSoon:Cancel()
		warnChokingGasBombSoon:Cancel()
		timerUnstableExperimentCD:Cancel()
		timerSlimePuddleCD:Cancel()
		timerChokingGasBombCD:Cancel()
		timerUnboundPlagueCD:Cancel()
		if self.vb.phase == 2.5 then -- Usual timer delta is not reliable for Malleable Goo, it's a different logic, commented below (25H Icecrown [2023-05-28]@[17:19:33] || [2023-05-28]@[16:42:29] || [2023-05-28]@[16:59:21] || [2023-05-28]@[16:32:41]) - First intermission: 52.45 || 49.14 || 49.97 || 48.50 ; Second intermission: 30.41 || x || 38.82 || x.
			local gooElapsed = timerMalleableGooCD:GetTime() -- On second intermission, the next Malleable Goo will always be 50s after the previous Malleable Goo cast, so calculate elapsed time and update timer
			timerMalleableGooCD:Update(gooElapsed, 50)
			soundMalleableGooSoon:Schedule(50-gooElapsed-3, "Interface\\AddOns\\DBM-Core\\sounds\\RaidAbilities\\malleable_soon.mp3")
		end
	elseif args:IsSpellID(72851, 72852, 71621, 72850) then		--Create Concoction (phase2 change)
		local puddleTimeAdjust = GetTime() - PuddleTime
		DBM:Debug("During Create Concoction, PuddleTime is: "..puddleTimeAdjust, 2)
		warnUnstableExperimentSoon:Cancel()
		timerUnstableExperimentCD:Cancel()
		timerSlimePuddleCD:Cancel()
		timerUnboundPlagueCD:Cancel()
		timerSlimePuddleCD:Start(65-puddleTimeAdjust)
		if puddleTimeAdjust > 35 then
			timerUnstableExperimentCD:Start(90-puddleTimeAdjust)
		else
			timerUnstableExperimentCD:Start(53.8-puddleTimeAdjust) -- REVIEW! Variance? Lowest possible timer? (25H Lordaeron 2022/09/04) - 31
		end
		if self:IsHeroic() then
--			if self:IsDifficulty("heroic10") then -- Apply to both 10H and 25H (reason below)
				self:Schedule(35.63, NextPhase, self) -- using longest timer found, since this is a schedule
				self:RegisterShortTermEvents(
					"UNIT_TARGET boss1"
				)
--			end
			timerNextPhase:Start(35.59) -- Until Gas/Ooze Variable SAR. no variance [35.59-35.63] (25H Lordaeron [2022-07-07]@[21:47:34] || 25H Lordaeron [2023-06-28]@[20:50:27] || 10H Lordaeron [2023-08-12]@[20:34:20]) - 35.60 || 35.63 || 35.59
			timerMalleableGooCD:Start(45.14) --  On first intermission, timer delta is fixed [45.1] (25H Icecrown [2023-05-28]@[17:19:33] || [2023-05-28]@[16:42:29] || [2023-05-28]@[16:59:21] || [2023-05-28]@[16:32:41]) - 45.18 || 45.14 || 45.20 || 45.16
			soundMalleableGooSoon:Schedule(45.14-3, "Interface\\AddOns\\DBM-Core\\sounds\\RaidAbilities\\malleable_soon.mp3")
			timerChokingGasBombCD:Start(55) -- timer after phase 2. 5s variance [20-25s] (25H Lordaeron 2022/09/07 || 25H Lordaeron 2022/09/23 wipe1 || 25H Lordaeron 2022/09/23 kill || 25H Lordaeron [2023-06-28]@[20:42:59] || 10H Lordaeron [2023-08-12]@[20:28:10]) - 22.8 ; 22.1 || 21.9 || 21.3 || 20.3 || 24.8
			soundChokingGasSoon:Schedule(55-3, "Interface\\AddOns\\DBM-Core\\sounds\\RaidAbilities\\choking_soon.mp3")
			warnChokingGasBombSoon:Schedule(55-5)
			timerUnboundPlagueCD:Start(120-(GetTime()-UnboundTime))
		else
			timerNextPhase:Start(9.5)
			timerMalleableGooCD:Start(19) -- On first intermission, timer delta is almost fixed [19-19.2]
			soundMalleableGooSoon:Schedule(19-3, "Interface\\AddOns\\DBM-Core\\sounds\\RaidAbilities\\malleable_soon.mp3")
			timerChokingGasBombCD:Start(30.5)
			soundChokingGasSoon:Schedule(30.5-3, "Interface\\AddOns\\DBM-Core\\sounds\\RaidAbilities\\choking_soon.mp3")
			warnChokingGasBombSoon:Schedule(30.5-5)
		end
	elseif args:IsSpellID(70672, 72455, 72832, 72833) then	--Red Slime
		timerGaseousBloatCast:Start(args.sourceGUID) -- account for multiple red oozes
		if not redOozeGUIDsCasts[args.sourceGUID] then
			redOozeGUIDsCasts[args.sourceGUID] = 1
		else
			redOozeGUIDsCasts[args.sourceGUID] = redOozeGUIDsCasts[args.sourceGUID] + 1
		end
		if redOozeGUIDsCasts[args.sourceGUID] > 1 then -- Red Ooze retarget
			specWarnGaseousBloatCast:Show()
			specWarnGaseousBloatCast:Play("targetchange")
		end
	elseif args:IsSpellID(73121, 73122, 73120, 71893) then		--Guzzle Potions (phase3 change)
		local currentTime = GetTime()
		local puddleTimeAdjust = currentTime-PuddleTime
		local chokingTimeAdjust = currentTime-ChokingTime
		local unboundTimeAdjust = currentTime-UnboundTime
		DBM:Debug(format("During Guzzle Potions, PuddleTime is %d, ChokingTime is %d and UnboundTime is %d", puddleTimeAdjust, chokingTimeAdjust, unboundTimeAdjust), 2)
		timerUnstableExperimentCD:Cancel()
		timerSlimePuddleCD:Cancel()
		timerChokingGasBombCD:Cancel()
		timerUnboundPlagueCD:Cancel()
		timerSlimePuddleCD:Start(65-puddleTimeAdjust)
		timerChokingGasBombCD:Start(65.8-chokingTimeAdjust) -- (25H Lordaeron 2022/11/16) - -0.2 excess
		soundChokingGasSoon:Schedule((65.8-chokingTimeAdjust)-3, "Interface\\AddOns\\DBM-Core\\sounds\\RaidAbilities\\choking_soon.mp3")
		warnChokingGasBombSoon:Schedule((65.8-chokingTimeAdjust)-5)
		if self:IsDifficulty("heroic10") then -- REVIEW! Refactor needed
			self:Schedule(38.69, NextPhase, self) -- REVIEW! using longest timer found, since this is a schedule
			timerNextPhase:Start(38.67) -- (10H Lordaeron [2023-08-12]@[20:34:20]) - 38.67
			timerUnboundPlagueCD:Start(120-unboundTimeAdjust)		--this requires more analysis
			self:RegisterShortTermEvents(
				"UNIT_TARGET boss1"
			)
		elseif self:IsDifficulty("heroic25") then
			self:Schedule(28.62, NextPhase, self)
			timerNextPhase:Start(28.62) -- (25H Lordaeron: [2023-05-28]@[17:19:33] || [2023-06-28]@[20:50:27]) - 28.62 || 28.62
			timerUnboundPlagueCD:Start(120-unboundTimeAdjust)		--this requires more analysis
			self:RegisterShortTermEvents(
				"UNIT_TARGET boss1"
			)
		else
			timerNextPhase:Start(12.5)
		end
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 70341 and self:AntiSpam(5, 1) then
		warnSlimePuddle:Show()
		soundSlimePuddle:Play("Interface\\AddOns\\DBM-Core\\sounds\\RaidAbilities\\puddle_cast.mp3")
		timerSlimePuddleCD:Start()
		PuddleTime = GetTime()
	elseif spellId == 71255 then -- Choking Gas
		warnChokingGasBomb:Show()
		specWarnChokingGasBomb:Show()
		soundSpecWarnChokingGasBomb:Play("Interface\\AddOns\\DBM-Core\\sounds\\RaidAbilities\\choking.mp3")
		soundChokingGasSoon:Cancel()
		soundChokingGasSoon:Schedule(35.5-3, "Interface\\AddOns\\DBM-Core\\sounds\\RaidAbilities\\choking_soon.mp3")
		timerChokingGasBombCD:Start()
		timerChokingGasBombExplosion:Start()
		warnChokingGasBombSoon:Schedule(30.5)
		ChokingTime = GetTime()
	elseif args:IsSpellID(72855, 72856, 70911) then
		timerUnboundPlagueCD:Start()
		UnboundTime = GetTime()
	elseif args:IsSpellID(72615, 72295, 74280, 74281) then -- Malleable Goo
		--self:BossTargetScanner(36678, "MalleableGooTarget", 0.05, 6)
		specWarnMalleableGooCast:Show()
		--specWarnMalleableGooCast:Play("watchstep")
		timerMalleableGooCD:Start()
		soundSpecWarnMalleableGoo:Play("Interface\\AddOns\\DBM-Core\\sounds\\RaidAbilities\\malleable.mp3")
		soundMalleableGooSoon:Cancel()
		soundMalleableGooSoon:Schedule(20-3, "Interface\\AddOns\\DBM-Core\\sounds\\RaidAbilities\\malleable_soon.mp3")
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if args:IsSpellID(70447, 72836, 72837, 72838) then--Green Slime
		if args:IsPlayer() then--Still worth warning 100s because it does still do knockback
			specWarnVolatileOozeAdhesive:Show()
		elseif not self:IsTank() then
			specWarnVolatileOozeAdhesiveT:Show(args.destName)
			specWarnVolatileOozeAdhesiveT:Play("helpsoak")
		else
			warnVolatileOozeAdhesive:Show(args.destName)
		end
		if self.Options.OozeAdhesiveIcon then
			self:SetIcon(args.destName, 1)
		end
	elseif args:IsSpellID(70672, 72455, 72832, 72833) then	--Red Slime
		timerGaseousBloat:Start(args.destName)
		if args:IsPlayer() then
			specWarnGaseousBloat:Show()
			specWarnGaseousBloat:Play("justrun")
			specWarnGaseousBloat:ScheduleVoice(1.5, "keepmove")
		else
			warnGaseousBloat:Show(args.destName)
		end
		if self.Options.GaseousBloatIcon then
			self:SetIcon(args.destName, 2)
		end
	--elseif args:IsSpellID(71615, 71618) then	--71615 used in 10 and 25 normal, 71618?
	--	timerTearGas:Start()
	elseif args:IsSpellID(72451, 72463, 72671, 72672) then	-- Mutated Plague
		warnMutatedPlague:Show(args.destName, args.amount or 1)
		timerMutatedPlagueCD:Start()
	elseif spellId == 70542 then
		timerMutatedSlash:Show(args.destName)
	elseif args:IsSpellID(70539, 72457, 72875, 72876) then
		timerRegurgitatedOoze:Show(args.destName)
	elseif args:IsSpellID(70352, 74118) then	--Ooze Variable
		if args:IsPlayer() then
			specWarnOozeVariable:Show()
		end
	elseif args:IsSpellID(70353, 74119) then	-- Gas Variable
		if args:IsPlayer() then
			specWarnGasVariable:Show()
		end
	elseif args:IsSpellID(72855, 72856, 70911) then	 -- Unbound Plague
		if self.Options.UnboundPlagueIcon then
			self:SetIcon(args.destName, 3)
		end
		if args:IsPlayer() then
			specWarnUnboundPlague:Show()
			specWarnUnboundPlague:Play("targetyou")
			timerUnboundPlague:Start()
			yellUnboundPlague:Yell()
		else
			warnUnboundPlague:Show(args.destName)
		end
	end
end

function mod:SPELL_AURA_APPLIED_DOSE(args)
	if args:IsSpellID(72451, 72463, 72671, 72672) then	-- Mutated Plague
		warnMutatedPlague:Show(args.destName, args.amount or 1)
		timerMutatedPlagueCD:Start()
	elseif args.spellId == 70542 then
		timerMutatedSlash:Show(args.destName)
	end
end

function mod:SPELL_AURA_REFRESH(args)
	if args:IsSpellID(70539, 72457, 72875, 72876) then
		timerRegurgitatedOoze:Show(args.destName)
	elseif args.spellId == 70542 then
		timerMutatedSlash:Show(args.destName)
	end
end

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if args:IsSpellID(70447, 72836, 72837, 72838) then
		if self.Options.OozeAdhesiveIcon then
			self:SetIcon(args.destName, 0)
		end
	elseif args:IsSpellID(70672, 72455, 72832, 72833) then
		timerGaseousBloat:Cancel(args.destName)
		if self.Options.GaseousBloatIcon then
			self:SetIcon(args.destName, 0)
		end
	elseif args:IsSpellID(72855, 72856, 70911) then						-- Unbound Plague
		timerUnboundPlague:Stop(args.destName)
		if self.Options.UnboundPlagueIcon then
			self:SetIcon(args.destName, 0)
		end
	elseif spellId == 71615 and (self.vb.phase == 1.5 or self.vb.phase == 2.5) then	-- Tear Gas Removal. Requires phase check because sometimes Tear Gas is removed from Abomination much later than the rest of the raid, during phase 2, causing another phasing to 2.5 (Logs: 10N Frostmourne [2023-01-07]@[17:20:22] and [2023-01-07]@[17:42:33] || 10N Icecrown [2023-04-05]@[22:54:25])
		NextPhase(self)
	elseif args:IsSpellID(70539, 72457, 72875, 72876) then
		timerRegurgitatedOoze:Cancel(args.destName)
	elseif spellId == 70542 then
		timerMutatedSlash:Cancel(args.destName)
	elseif (args:IsSpellID(70352, 74118) or args:IsSpellID(70353, 74119)) and (self.vb.phase == 1.5 or self.vb.phase == 2.5) then	-- Ooze Variable / Gas Variable (Heroic 25 - Phase 2 and 3). Disabled for two main reasons: raid member dying will trigger this event, and I have found multiple logs with early SAR
		DBM:Debug("Variable phasing time marker")
--		NextPhase(self)
	end
end

--values subject to tuning depending on dps and his health pool
function mod:UNIT_HEALTH(uId)
	if self.vb.phase == 1 and not self.vb.warned_preP2 and self:GetUnitCreatureId(uId) == 36678 and UnitHealth(uId) / UnitHealthMax(uId) <= 0.83 then
		self.vb.warned_preP2 = true
		warnPhase2Soon:Show()
		warnPhase2Soon:Play("nextphasesoon")
	elseif self.vb.phase == 2 and not self.vb.warned_preP3 and self:GetUnitCreatureId(uId) == 36678 and UnitHealth(uId) / UnitHealthMax(uId) <= 0.38 then
		self.vb.warned_preP3 = true
		warnPhase3Soon:Show()
		warnPhase3Soon:Play("nextphasesoon")
	elseif self:GetUnitCreatureId(uId) == 36678 and UnitHealth(uId) / UnitHealthMax(uId) == 0.35 then
		warnUnstableExperimentSoon:Cancel()
		warnChokingGasBombSoon:Cancel()
		soundMalleableGooSoon:Cancel()
		soundChokingGasSoon:Cancel()
	end
end

-- On 10 Heroic, there is no event we can use to accurately trigger phasing. On 25 Heroic, we could use SPELL_AURA_REMOVED, but not reliable without UnitBuff checks or table management which would add unnecessary overhead (see above)
-- UNIT_TARGET only fires if boss is targeted or focused (sync'ed below)
function mod:UNIT_TARGET(uId)
	if self:GetUnitCreatureId(uId) ~= 36678 then return end
	-- Attempt to catch when boss phases by checking for Putricide's target being a raid member
	if UnitExists(uId.."target") then
		if self.vb.phase == 1.5 then
			self:SendSync("ProfessorPhase2") -- Sync phasing with raid since UNIT_TARGET event requires boss to be target/focus, which not all members do
		elseif self.vb.phase == 2.5 then
			self:SendSync("ProfessorPhase3") -- Sync phasing with raid since UNIT_TARGET event requires boss to be target/focus, which not all members do
		else
			self:UnregisterShortTermEvents()
			DBM:Debug("UNIT_TARGET phasing did not work since phase was wrongly set: " .. self.vb.phase)
		end
	end
end

function mod:OnSync(msg)
	if not self:IsInCombat() then return end
	if msg == "ProfessorPhase2" and self.vb.phase == 1.5 then
		self:Unschedule(NextPhase)
		NextPhase(self)
		DBM:Debug("Putricide phase 2 via UNIT_TARGET sync")
	elseif msg == "ProfessorPhase3" and self.vb.phase == 2.5 then
		self:Unschedule(NextPhase)
		NextPhase(self)
		DBM:Debug("Putricide phase 3 via UNIT_TARGET sync")
	end
end
