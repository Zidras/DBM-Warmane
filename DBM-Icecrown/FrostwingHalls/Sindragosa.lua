local mod	= DBM:NewMod("Sindragosa", "DBM-Icecrown", 4)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("20241204093130")
mod:SetCreatureID(36853)
mod:SetUsedIcons(1, 2, 3, 4, 5, 6)
mod:SetHotfixNoticeRev(20241203000000)
mod:SetMinSyncRevision(20241203000000)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 69649 71056 71057 71058 73061 73062 73063 73064 71077",
	"SPELL_CAST_SUCCESS 70117 69762",
	"SPELL_AURA_APPLIED 70126 69762 70106 69766 70127 72528 72529 72530",
	"SPELL_AURA_APPLIED_DOSE 70106 69766 70127 72528 72529 72530",
	"SPELL_AURA_REMOVED 69762 70157 70106 69766 70127 72528 72529 72530",
	"UNIT_HEALTH boss1",
	"CHAT_MSG_MONSTER_YELL"
)

local strupper = strupper
local myRealm = select(3, DBM:GetMyPlayerInfo())

-- General
local berserkTimer				= mod:NewBerserkTimer(myRealm == "Frostmourne" and 420 or 600) -- Lordaeron hardcore berserk timer removed (Warmane Changelog November 15th 2023 )

mod:AddBoolOption("RangeFrame", true) -- keep as BoolOption since the localization offers important information regarding boss ability and player debuff behaviour (Unchained Magic is Heroic only)
mod:AddBoolOption("ClearIconsOnAirphase", true) -- don't group with any spellId, it applies to all raid icons

-- Stage One
mod:AddTimerLine(DBM_CORE_L.SCENARIO_STAGE:format(1))
local warnAirphase				= mod:NewAnnounce("WarnAirphase", 2, 43810)
local warnGroundphaseSoon		= mod:NewAnnounce("WarnGroundphaseSoon", 2, 43810)
local warnPhase2soon			= mod:NewPrePhaseAnnounce(2)
local warnInstability			= mod:NewCountAnnounce(69766, 2, nil, false)
local warnChilledtotheBone		= mod:NewCountAnnounce(70106, 2, nil, false)
local warnFrostBeacon			= mod:NewTargetNoFilterAnnounce(70126, 4)
local warnFrostBreath			= mod:NewSpellAnnounce(69649, 2, nil, "Tank|Healer")
local warnUnchainedMagic		= mod:NewTargetAnnounce(69762, 2, nil, "SpellCaster", 2)

local specWarnUnchainedMagic	= mod:NewSpecialWarningYou(69762, nil, nil, nil, 1, 2)
local specWarnFrostBeacon		= mod:NewSpecialWarningMoveAway(70126, nil, nil, nil, 3, 2)
local specWarnFrostBeaconSide	= mod:NewSpecialWarningMoveTo(70126, nil, nil, nil, 3, 2)
local specWarnInstability		= mod:NewSpecialWarningStack(69766, nil, mod:IsHeroic() and 4 or 8, nil, nil, 1, 6)
local specWarnChilledtotheBone	= mod:NewSpecialWarningStack(70106, nil, mod:IsHeroic() and 4 or 8, nil, nil, 1, 6)
local specWarnBlisteringCold	= mod:NewSpecialWarningRun(70123, nil, nil, nil, 4, 2)

local timerNextAirphase			= mod:NewTimer(110, "TimerNextAirphase", 43810, nil, nil, 6) -- Fixed timer on Air Yell: 110s
local timerNextGroundphase		= mod:NewTimer(44.2, "TimerNextGroundphase", 43810, nil, nil, 6) -- 0.4s variance (10H Lordaeron 2022/10/02 || 25H Lordaeron 2022/10/02 || 25H Lordaeron 2022/10/06) - 44.2; 44.2 || 44.2; 44.3, 44.6; 44.2 || 45.1
local timerNextFrostBreath		= mod:NewNextTimer(22, 69649, nil, "Tank|Healer", nil, 5, nil, DBM_COMMON_L.TANK_ICON)
local timerNextBlisteringCold	= mod:NewCDTimer(66, 70123, nil, nil, nil, 2, nil, DBM_COMMON_L.DEADLY_ICON, true, 2) -- Added "keep" arg
local timerNextBeacon			= mod:NewNextCountTimer(16, 70126, nil, nil, nil, 3, nil, DBM_COMMON_L.DEADLY_ICON)
local timerBeaconIncoming		= mod:NewTargetTimer("d7", 70126, nil, nil, nil, 3) -- One incoming timer for each target
local timerBlisteringCold		= mod:NewCastTimer(6, 70123, nil, nil, nil, 2)
local timerUnchainedMagic		= mod:NewCDTimer(32, 69762, nil, nil, nil, 3) -- (25H Lordaeron 2022/07/09 || 10N Icecrown 2022/08/22 || 10N Icecrown 2022/08/25) - 32.0, 63.2, 32.1, 77.8, 32.1, 32.5, 31.9, 34.8 || 35.7, 58.4, 32.1, 77.9, 32.1, 78.6, 32.0, 32.0, 32.1 || 32.0, 62.1, 32.0, Stage 2/68.4, 9.9/78.3, 32.0
local timerInstability			= mod:NewBuffFadesTimer(5, 69766, nil, nil, nil, 5)
local timerChilledtotheBone		= mod:NewBuffFadesTimer(8, 70106, nil, nil, nil, 5)
local timerTailSmash			= mod:NewCDTimer(27.1, 71077, nil, nil, nil, 2, nil, nil, true) -- ~7s variance [27-34]? Added "keep" arg. (25H Lordaeron 2022/07/09 || 10N Icecrown 2022/08/25 || 25H Lordaeron 2022/10/14) - 28.7; 93.3, 30.6, 83.1, 29.2, 29.6, 29.6, 33.8; 29.2, 65.7, 30.8, 79.1, 27.9, 31.1, 27.9, 27.4; 29.7; 28.9, 64.7, 27.4, 84.3, 32.4, 30.0, 29.2 || 94.0, 31.5, Stage 2/59.0, 19.1/78.0, 31.9 || Stage 1/20.0, 28.9, Stage 1.5/1.1, Stage 1/44.3, 21.5/65.7/66.8, 28.7, Stage 1.5/15.6, Stage 1/45.0, Stage 2/20.0, 2.1/22.1/67.1/82.8, 27.2, 31.6, 29.6, 31.4

local soundUnchainedMagic		= mod:NewSoundYou(69762, nil, "SpellCaster")

mod:AddSetIconOption("SetIconOnFrostBeacon", 70126, true, 7, {1, 2, 3, 4, 5, 6})
mod:AddSetIconOption("SetIconOnUnchainedMagic", 69762, true, 0, {1, 2, 3, 4, 5, 6})
mod:AddBoolOption("AnnounceFrostBeaconIcons", false, nil, nil, nil, nil, 70126)
mod:AddBoolOption("AssignWarnDirectionsCount", true, nil, nil, nil, nil, 70126)

-- Stage Two
mod:AddTimerLine(DBM_CORE_L.SCENARIO_STAGE:format(2))
local warnPhase2				= mod:NewPhaseAnnounce(2, 2, nil, nil, nil, nil, nil, 2)
local warnMysticBuffet			= mod:NewCountAnnounce(70128, 2, nil, false)

local specWarnMysticBuffet		= mod:NewSpecialWarningStack(70128, false, 5, nil, nil, 1, 6)

local timerMysticBuffet			= mod:NewBuffFadesTimer(8, 70128, nil, nil, nil, 5)
local timerNextMysticBuffet		= mod:NewNextTimer(6, 70128, nil, nil, nil, 2)
local timerMysticAchieve		= mod:NewAchievementTimer(30, 4620, "AchievementMystic")

mod:AddBoolOption("AchievementCheck", false, "announce", nil, nil, nil, 4620, "achievement")

local beaconTargets		= {}
local unchainedTargets	= {}
mod.vb.warned_P2 = false
mod.vb.warnedfailed = false
mod.vb.unchainedIcons = 1
mod.vb.beaconP2Count = 1
local playerUnchained = false
local playerBeaconed = false

local directionIndex
local DirectionAssignments = {DBM_COMMON_L.LEFT, DBM_COMMON_L.MIDDLE, DBM_COMMON_L.RIGHT}
local DirectionVoiceAssignments	= {"left", "center", "right"}

local beaconDebuffFilter, unchainedDebuffFilter
do
	local beaconDebuff, unchainedDebuff = DBM:GetSpellInfo(70126), DBM:GetSpellInfo(69762)
	beaconDebuffFilter = function(uId)
		return DBM:UnitDebuff(uId, beaconDebuff)
	end
	unchainedDebuffFilter = function(uId)
		return DBM:UnitDebuff(uId, unchainedDebuff)
	end
end

local function warnBeaconTargets(self)
	if self.Options.RangeFrame then
		if not playerBeaconed then
			DBM.RangeCheck:Show(10, beaconDebuffFilter, nil, nil, nil, 9)
		else
			DBM.RangeCheck:Show(10, nil, nil, nil, nil, 9)
		end
	end
	if self.Options.AssignWarnDirectionsCount then
		if self.vb.phase == 1.5 then
			if self:IsDifficulty("normal25") then
				-- 5 beacons
				warnFrostBeacon:Show("\n<   >"..
				strupper(DBM_COMMON_L.LEFT)		..": <".."   >"..(beaconTargets[1] or DBM_COMMON_L.UNKNOWN).."<, >"..(beaconTargets[2] or DBM_COMMON_L.UNKNOWN).."<   >\n".."<   >"..
				strupper(DBM_COMMON_L.MIDDLE)	..": <".."   >"..(beaconTargets[3] or DBM_COMMON_L.UNKNOWN).."<   >\n".."<   >"..
				strupper(DBM_COMMON_L.RIGHT)	..": <".."   >"..(beaconTargets[4] or DBM_COMMON_L.UNKNOWN).."<, >"..(beaconTargets[5] or DBM_COMMON_L.UNKNOWN))
			elseif self:IsDifficulty("heroic25") then
				-- 6 beacons
				warnFrostBeacon:Show("\n<   >"..
				strupper(DBM_COMMON_L.LEFT)		..": <".."   >"..(beaconTargets[1] or DBM_COMMON_L.UNKNOWN).."<, >"..(beaconTargets[2] or DBM_COMMON_L.UNKNOWN).."<   >\n".."<   >"..
				strupper(DBM_COMMON_L.MIDDLE)	..": <".."   >"..(beaconTargets[3] or DBM_COMMON_L.UNKNOWN).."<, >"..(beaconTargets[4] or DBM_COMMON_L.UNKNOWN).."<   >\n".."<   >"..
				strupper(DBM_COMMON_L.RIGHT)	..": <".."   >"..(beaconTargets[5] or DBM_COMMON_L.UNKNOWN).."<, >"..(beaconTargets[6] or DBM_COMMON_L.UNKNOWN))
			elseif self:IsDifficulty("normal10", "heroic10") then
				-- 2 beacons
				warnFrostBeacon:Show("\n<   >"..
				strupper(DBM_COMMON_L.LEFT)		..": <".."   >"..(beaconTargets[1] or DBM_COMMON_L.UNKNOWN).."<   >\n".."<   >"..
				strupper(DBM_COMMON_L.RIGHT)	..": <".."   >"..(beaconTargets[2] or DBM_COMMON_L.UNKNOWN))
			end
		elseif self.vb.phase == 2 then
			warnFrostBeacon:Show(beaconTargets[1].."< = >"..self.vb.beaconP2Count - 1)
		end
	else
		warnFrostBeacon:Show(table.concat(beaconTargets, "<, >"))
	end
	table.wipe(beaconTargets)
	playerBeaconed = false
end

local function warnUnchainedTargets(self)
	if self.Options.RangeFrame and self:IsHeroic() then
		if not playerUnchained then
			DBM.RangeCheck:Show(21, unchainedDebuffFilter) -- 21.5 yd with new radar calculations. 21 here since radar code adds 0.5 to activeRange
		else
			DBM.RangeCheck:Show(21) -- 21.5 yd with new radar calculations. 21 here since radar code adds 0.5 to activeRange
		end
	end
	warnUnchainedMagic:Show(table.concat(unchainedTargets, "<, >"))
	table.wipe(unchainedTargets)
	self.vb.unchainedIcons = 1
	playerUnchained = false
end

local function directionBeaconTargets(self, index)
	if index then
		if self:IsDifficulty("normal25") then
			if (index == 1 or index == 2) then directionIndex = 1		--LEFT
			elseif (index == 3) then directionIndex = 2					--CENTER
			else directionIndex = 3 end									--RIGHT
		elseif self:IsDifficulty("heroic25") then
			if (index == 1 or index == 2) then directionIndex = 1		--LEFT
			elseif (index == 3 or index == 4) then directionIndex = 2	--CENTER
			else directionIndex = 3 end									--RIGHT
		elseif self:IsDifficulty("normal10", "heroic10") then
			if index == 1 then directionIndex = 1						--LEFT
			else directionIndex = 3 end									--RIGHT
		end
		specWarnFrostBeaconSide:Show(DirectionAssignments[directionIndex])
		specWarnFrostBeaconSide:Play(DirectionVoiceAssignments[directionIndex] or "scatter")
	end
end

local function ResetRange(self)
	if self.Options.RangeFrame then
		DBM.RangeCheck:DisableBossMode()
	end
end

-- Warmane workaround, since there is no dedicated event for Sindragosa Landing Phase, and UNIT_TARGET boss1 only fires if Sindragosa is targeted or focused (sync'ed below)
local function landingPhaseWorkaround(self, timeOffset)
	DBM:Debug("UNIT_TARGET boss1 didn't fire. Landing Phase scheduled")
	self:SetStage(1)
	timerUnchainedMagic:Start(10-timeOffset)
	timerTailSmash:Start(19-timeOffset)
	timerNextBlisteringCold:Start(34-timeOffset)
	self:UnregisterShortTermEvents()
end

local function cycleMysticBuffet(self)
--	timerNextMysticBuffet:Stop() -- disabled for debugging
	timerNextMysticBuffet:Start()
	self:Schedule(6, cycleMysticBuffet, self)
end

function mod:AnnounceBeaconIcons(uId, icon)
	if self.Options.AnnounceFrostBeaconIcons and DBM:IsInGroup() and DBM:GetRaidRank() > 1 then
		SendChatMessage(L.BeaconIconSet:format(icon, DBM:GetUnitFullName(uId)), DBM:IsInRaid() and "RAID" or "PARTY")
	end
end

function mod:OnCombatStart(delay)
	self:SetStage(1)
	berserkTimer:Start(-delay)
	timerNextAirphase:Start(50-delay)
	timerNextBlisteringCold:Start(31.6-delay) -- ~10s variance [31.6-40] (10H Lordaeron 2022/10/02 || 25H Lordaeron 2022/10/02) - 37.5; 34.9 || 31.6; 36.4; 34.9; 34.9
	timerTailSmash:Start(20-delay) -- (25H Lordaeron 2022/07/09 || 10N Icecrown 2022/08/22 || 10N Icecrown 2022/08/25 || 10H Lordaeron 2022/10/02 || 25H Lordaeron 2022/10/02) - 20.0 || 20.0 || 20.0 || 20.0; 20.0 || 20.0; 19.9; 20.0; 20.0
	timerUnchainedMagic:Start(10-delay) -- (25H Lordaeron 2022/07/09 || 10N Icecrown 2022/08/22 || 10N Icecrown 2022/08/25) - 10.1 || 10.1 || 10.0
	self.vb.warned_P2 = false
	self.vb.warnedfailed = false
	table.wipe(beaconTargets)
	table.wipe(unchainedTargets)
	self.vb.unchainedIcons = 1
	self.vb.beaconP2Count = 1
	playerUnchained = false
	playerBeaconed = false
end

function mod:OnCombatEnd()
	self:UnregisterShortTermEvents()
	if self.Options.RangeFrame then
		DBM.RangeCheck:Hide()
	end
end

function mod:SPELL_CAST_START(args)
	if args:IsSpellID(69649, 71056, 71057, 71058) or args:IsSpellID(73061, 73062, 73063, 73064) then--Frost Breath
		warnFrostBreath:Show()
		timerNextFrostBreath:Start()
	elseif args.spellId == 71077 then
		timerTailSmash:Start()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 70117 then--Icy Grip Cast, not blistering cold, but adds an extra 1sec to the warning
		specWarnBlisteringCold:Show()
		specWarnBlisteringCold:Play("runout")
		timerBlisteringCold:Start()
		timerNextBlisteringCold:Start()

		if self.Options.RangeFrame then
			DBM.RangeCheck:SetBossRange(25, self:GetBossUnitByCreatureId(36853))
			self:Schedule(5.5, ResetRange, self)
		end
	elseif spellId == 69762 then	-- Unchained Magic
		timerUnchainedMagic:Start()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 70126 then
		timerBeaconIncoming:Start(args.destName)
		beaconTargets[#beaconTargets + 1] = args.destName
		if args:IsPlayer() then
			playerBeaconed = true
			-- Beacon Direction snippet
			if self.vb.phase == 1.5 and self.Options.SpecWarn70126moveto then
				for i = 1, #beaconTargets do
					local targetName = beaconTargets[i]
					if targetName == DBM:GetMyPlayerInfo() then
						directionBeaconTargets(self, i)
					end
				end
			else
				specWarnFrostBeacon:Show()
				specWarnFrostBeacon:Play("scatter")
			end
		end
		if self.vb.phase == 2 then--Phase 2 there is only one icon/beacon, don't use sorting method if we don't have to.
			self.vb.beaconP2Count = self.vb.beaconP2Count + 1
			timerNextBeacon:Start(16, self.vb.beaconP2Count)
			if self.Options.SetIconOnFrostBeacon then
				self:SetIcon(args.destName, 8)
				if self.Options.AnnounceFrostBeaconIcons and DBM:IsInGroup() and DBM:GetRaidRank() > 1 then
					SendChatMessage(L.BeaconIconSet:format(8, args.destName), DBM:IsInRaid() and "RAID" or "PARTY")
				end
			end
			warnBeaconTargets(self)
		else--Phase 1 air phase, multiple beacons
			local maxBeacon = self:IsDifficulty("heroic25") and 6 or self:IsDifficulty("normal25") and 5 or 2--Heroic 10 and normal 2 are both 2
			if self.Options.SetIconOnFrostBeacon then
				self:SetUnsortedIcon(0.3, args.destName, 1, maxBeacon, false, "AnnounceBeaconIcons") -- Unsorted, to match CLEU order, which is the one used for announce object. Roster sorting makes icons not reproducible
			end
			self:Unschedule(warnBeaconTargets)
			if #beaconTargets >= maxBeacon then
				warnBeaconTargets(self)
			else
				self:Schedule(0.3, warnBeaconTargets, self)
			end
		end
	elseif spellId == 69762 then
		unchainedTargets[#unchainedTargets + 1] = args.destName
		if args:IsPlayer() then
			playerUnchained = true
			specWarnUnchainedMagic:Show()
			specWarnUnchainedMagic:Play("targetyou")
			soundUnchainedMagic:Play("Interface\\AddOns\\DBM-Core\\sounds\\RaidAbilities\\unchained.mp3")
		end
		if self.Options.SetIconOnUnchainedMagic then
			self:SetIcon(args.destName, self.vb.unchainedIcons)
		end
		self.vb.unchainedIcons = self.vb.unchainedIcons + 1
		self:Unschedule(warnUnchainedTargets)
		if #unchainedTargets >= 6 then
			warnUnchainedTargets(self)
		else
			self:Schedule(0.3, warnUnchainedTargets, self)
		end
	elseif spellId == 70106 then	--Chilled to the bone (melee)
		if args:IsPlayer() then
			timerChilledtotheBone:Start()
			if (self:IsHeroic() and (args.amount or 1) >= 4) or (args.amount or 1) >= 8 then
				specWarnChilledtotheBone:Show(args.amount)
				specWarnChilledtotheBone:Play("stackhigh")
			else
				warnChilledtotheBone:Show(args.amount or 1)
			end
		end
	elseif spellId == 69766 then	--Instability (casters)
		if args:IsPlayer() then
			timerInstability:Start()
			if (self:IsHeroic() and (args.amount or 1) >= 4) or (args.amount or 1) >= 8 then
				specWarnInstability:Show(args.amount)
				specWarnInstability:Play("stackhigh")
			else
				warnInstability:Show(args.amount or 1)
			end
		end
	elseif args:IsSpellID(70127, 72528, 72529, 72530) then	--Mystic Buffet (phase 2 - everyone)
		if args:IsPlayer() then
			timerMysticBuffet:Start()
--			timerNextMysticBuffet:Start()
			if (args.amount or 1) >= 5 then
				specWarnMysticBuffet:Show(args.amount)
				specWarnMysticBuffet:Play("stackhigh")
			else
				warnMysticBuffet:Show(args.amount or 1)
			end
			if self.Options.AchievementCheck and not self.vb.warnedfailed and (args.amount or 1) < 2 then
				timerMysticAchieve:Start()
			end
		end
		if args:IsDestTypePlayer() then
			if self.Options.AchievementCheck and DBM:GetRaidRank() > 0 and not self.vb.warnedfailed and self:AntiSpam(3) then
				if (args.amount or 1) == 5 then
					SendChatMessage(L.AchievementWarning:format(args.destName), "RAID")
				elseif (args.amount or 1) > 5 then
					self.vb.warnedfailed = true
					SendChatMessage(L.AchievementFailed:format(args.destName, (args.amount or 1)), "RAID_WARNING")
				end
			end
			if self:AntiSpam(5, 2) then -- real time correction if any raid member receives the debuff in a 5 second window
				self:Unschedule(cycleMysticBuffet)
				cycleMysticBuffet(self)
			end
		end
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 69762 then
		if self.Options.SetIconOnUnchainedMagic then
			self:SetIcon(args.destName, 0)
		end
	elseif spellId == 70157 then
		if self.Options.SetIconOnFrostBeacon then
			self:SetIcon(args.destName, 0)
		end
	elseif spellId == 70106 then	--Chilled to the bone (melee)
		if args:IsPlayer() then
			timerChilledtotheBone:Cancel()
		end
	elseif spellId == 69766 then	--Instability (casters)
		if args:IsPlayer() then
			timerInstability:Cancel()
		end
	elseif args:IsSpellID(70127, 72528, 72529, 72530) then
		if args:IsPlayer() then
			timerMysticAchieve:Cancel()
			timerMysticBuffet:Cancel()
		end
	end
end

function mod:UNIT_HEALTH(uId)
	if not self.vb.warned_P2 and self:GetUnitCreatureId(uId) == 36853 and UnitHealth(uId) / UnitHealthMax(uId) <= 0.38 then
		self.vb.warned_P2 = true
		warnPhase2soon:Show()
	end
end

function mod:UNIT_TARGET(uId)
	-- Attempt to catch when she lands by checking for Sindragosa's target being a raid member
	if UnitExists(uId.."target") then
		self:SendSync("SindragosaLanded") -- Sync landing with raid since UNIT_TARGET:boss1 event requires Sindragosa to be target/focus, which not all members do
	end
end

function mod:CHAT_MSG_MONSTER_YELL(msg)
	if (msg == L.YellAirphase or msg:find(L.YellAirphase)) or (msg == L.YellAirphaseDem or msg:find(L.YellAirphaseDem)) then
		if self.Options.ClearIconsOnAirphase then
			self:ClearIcons()
		end
		self:SetStage(1.5)
		warnAirphase:Show()
		timerNextFrostBreath:Cancel()
		timerUnchainedMagic:Cancel()
		timerNextBlisteringCold:Cancel()
		timerTailSmash:Cancel()
		timerNextAirphase:Start()
		timerNextGroundphase:Start()
		warnGroundphaseSoon:Schedule(37.5)
		self:Schedule(45.2, landingPhaseWorkaround, self, 1) -- giving a 0.2s cushion from 45s (max I have on logs is 45.1s). 1s comes from 45.2-44.2s from ground timer
		self:RegisterShortTermEvents(
			"UNIT_TARGET boss1"
		)
	elseif (msg == L.YellPhase2 or msg:find(L.YellPhase2)) or (msg == L.YellPhase2Dem or msg:find(L.YellPhase2Dem)) then
		self:SetStage(2)
		warnPhase2:Show()
		warnPhase2:Play("ptwo")
		timerNextBeacon:Start(7, 1) -- no need to use self.vb.beaconP2Count here since it will always be one on this timer
		timerNextAirphase:Cancel()
		timerNextGroundphase:Cancel()
		warnGroundphaseSoon:Cancel()
		timerNextBlisteringCold:Restart(35) -- Fixed timer: 35s (25H Lordaeron 2024/11/28) - 35.03
		timerNextMysticBuffet:Start(6)
		self:Schedule(6, cycleMysticBuffet, self)
		self:Unschedule(landingPhaseWorkaround)
		self:UnregisterShortTermEvents() -- REVIEW! not sure it's needed, but doesn't hurt. Would need validation on event order when boss is intermissioned with health right above phase 2 threshold, to check which of the events come first (TARGET or YELL)
	end
end

function mod:OnSync(msg)
	if not self:IsInCombat() then return end
	if msg == "SindragosaLanded" and self:GetStage(1.5) then
		self:Unschedule(landingPhaseWorkaround)
		self:SetStage(1)
		timerUnchainedMagic:Start(10) -- (10H Lordaeron 2022/10/02 || 25H Lordaeron 2022/10/02) - 10.0; 10.0 || 10.0; 10.0, 10.0; 10.0
		timerTailSmash:Start(19) -- ~5s variance [19-23.8]? (10N Icecrown 2022/08/25 || 10H Lordaeron 2022/10/02 || 25H Lordaeron 2022/10/02) - 19.0 || 21.4; 21.9 || 21.4; 23.8, 22.6; 22.2
		timerNextBlisteringCold:Start(34) -- 6s variance [34-40]? (10H Lordaeron 2022/10/02 || 25H Lordaeron 2022/10/02) - 34.0; 34.0 || 34.0; 34.0; 34.0
		self:UnregisterShortTermEvents()
	end
end
