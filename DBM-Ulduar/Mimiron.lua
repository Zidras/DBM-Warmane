local mod	= DBM:NewMod("Mimiron", "DBM-Ulduar")
local L		= mod:GetLocalizedStrings()

mod:SetRevision("20250224153430")
mod:SetCreatureID(33432)
mod:SetUsedIcons(1, 2, 3, 4, 5, 6, 7, 8)
mod:SetHotfixNoticeRev(20220823000000)

mod:RegisterCombat("combat_yell", L.YellPull)
mod:RegisterCombat("yell", L.YellHardPull)
mod:RegisterKill("yell", L.YellKilled)

mod:RegisterEvents(
	"CHAT_MSG_MONSTER_YELL"
)

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 63631 64529 62997 64570 64623 64383",
	"SPELL_CAST_SUCCESS 63027 63414 65192",
	"SPELL_AURA_APPLIED 63666 65026 64529 62997 64616 64570",
	"SPELL_AURA_REMOVED 63666 65026",
	"SPELL_SUMMON 63811",
	"UNIT_SPELLCAST_CHANNEL_STOP boss1 boss2 boss3",
	"UNIT_SPELLCAST_START boss1",
	"UNIT_SPELLCAST_SUCCEEDED boss1 boss2 boss3",
	"CHAT_MSG_LOOT",
	"PARTY_LOOT_METHOD_CHANGED"
)

--General
local timerEnrage					= mod:NewBerserkTimer(900)
local timerP1toP2					= mod:NewTimer(40, "TimeToPhase2", nil, nil, nil, 6) -- From YellPhase2 to IEEU
local timerP2toP3					= mod:NewTimer(21, "TimeToPhase3", nil, nil, nil, 6) -- From YellPhase3 to IEEU
local timerP3toP4					= mod:NewTimer(26, "TimeToPhase4", nil, nil, nil, 6) -- From YellPhase4 to IEEU

mod:AddRangeFrameOption("6")

-- Stage One
mod:AddTimerLine(DBM_CORE_L.SCENARIO_STAGE:format(1)..": "..L.MobPhase1)
local warnNapalmShell				= mod:NewTargetNoFilterAnnounce(63666, 2, nil, "Healer")
local warnPlasmaBlast				= mod:NewTargetNoFilterAnnounce(64529, 4, nil, "Tank|Healer")

local specWarnShockBlast			= mod:NewSpecialWarningRun(63631, "Melee", nil, nil, 4, 2)
local specWarnPlasmaBlast			= mod:NewSpecialWarningDefensive(64529, nil, nil, nil, 1, 2)

local timerProximityMines			= mod:NewCDTimer(35.0, 63027, nil, nil, nil, 3) -- 25 man NM log review (2022/07/10) + VOD review - 35.0
local timerShockBlast				= mod:NewCastTimer(4, 63631, nil, nil, nil, 2, nil, DBM_COMMON_L.DEADLY_ICON)
local timerNextShockBlast			= mod:NewNextTimer(35, 63631, nil, nil, nil, 2, nil, DBM_COMMON_L.DEADLY_ICON) -- REVIEW! variance?? (S2 log || S3 HM log 2022/07/17) - 38 || 44.1, 41.6
local timerNapalmShell				= mod:NewBuffActiveTimer(6, 63666, nil, "Healer", 2, 5, nil, DBM_COMMON_L.IMPORTANT_ICON..DBM_COMMON_L.HEALER_ICON)
local timerPlasmaBlastCD			= mod:NewCDTimer(31.2, 64529, nil, "Tank", 2, 5, nil, DBM_COMMON_L.TANK_ICON) -- REVIEW! ~13s variance! (S3 HM log 2022/07/17) - 44.2, 31.2 ; 39.6

mod:AddSetIconOption("SetIconOnNapalm", 63666, false, false, {1, 2, 3, 4, 5, 6, 7})
mod:AddSetIconOption("SetIconOnPlasmaBlast", 64529, false, false, {8})

-- Stage Two
mod:AddTimerLine(DBM_CORE_L.SCENARIO_STAGE:format(2)..": "..L.MobPhase2)
local specWarnP3Wx2LaserBarrage		= mod:NewSpecialWarningDodge(63274, nil, nil, nil, 3, 2) -- P3Wx2 Laser Barrage
local specWarnRocketStrike			= mod:NewSpecialWarningDodge(64402, nil, nil, nil, 2, 2)

local timerSpinUp					= mod:NewCastTimer(4, 63414, nil, nil, nil, 3, nil, DBM_COMMON_L.DEADLY_ICON)
local timerP3Wx2LaserBarrageCast	= mod:NewCastTimer(10, 63274, nil, nil, nil, 3, nil, DBM_COMMON_L.DEADLY_ICON)
local timerNextP3Wx2LaserBarrage	= mod:NewNextTimer(45, 63414, nil, nil, nil, 3, nil, DBM_COMMON_L.DEADLY_ICON) -- REVIEW! variance? S2 VOD reviews - 47.5, 45
local timerRocketStrikeCD			= mod:NewCDTimer(20, 64402, nil, nil, nil, 3)--20-25

-- Stage Three
mod:AddTimerLine(DBM_CORE_L.SCENARIO_STAGE:format(3)..": "..L.MobPhase3)
local warnLootMagneticCore			= mod:NewAnnounce("MagneticCore", 1, 64444, nil, nil, nil, 64444)
local warnBombBotSpawn				= mod:NewAnnounce("WarnBombSpawn", 3, 63811, nil, nil, nil, 63811)

local timerBombBotSpawn				= mod:NewCDTimer(16.6, 63811, nil, nil, nil, 1) -- REVIEW! variance? 25 man NM log review (2022/07/10 || 25H Lordaeron 2022/10/09) - 16.6 || 21.0

mod:AddBoolOption("AutoChangeLootToFFA", true, nil, nil, nil, nil, 64444)

-- Stage Four
mod:AddTimerLine(DBM_CORE_L.SCENARIO_STAGE:format(4)..": "..L.MobPhase4)
local timerSelfRepair				= mod:NewCastSourceTimer(15, 64383, nil, nil, nil, 7, nil, DBM_COMMON_L.IMPORTANT_ICON)

-- Hard Mode
mod:AddTimerLine(DBM_COMMON_L.HEROIC_ICON..DBM_CORE_L.HARD_MODE)
local warnFlamesSoon				= mod:NewSoonAnnounce(64566, 1)

local timerHardmode					= mod:NewTimer(610, "TimerHardmode", 64582, nil, nil, 6, nil, nil, nil, nil, nil, nil, nil, 64582)
local timerNextFlames				= mod:NewNextTimer(28, 64566, nil, nil, nil, 7, nil, DBM_COMMON_L.IMPORTANT_ICON, nil, 1, 5)

-- Stage One
mod:AddTimerLine(DBM_CORE_L.SCENARIO_STAGE:format(1)..": "..L.MobPhase1)
local timerFlameSuppressantP1Debuff	= mod:NewBuffActiveTimer(8, 64570, nil, nil, nil, 3)
local timerNextFlameSuppressantP1	= mod:NewCDTimer(60, 64570, nil, nil, nil, 3) -- S2 VOD review

-- Stage Two
mod:AddTimerLine(DBM_CORE_L.SCENARIO_STAGE:format(2)..": "..L.MobPhase2)
local warnFrostBomb					= mod:NewSpellAnnounce(64623, 3)

local timerFrostBombExplosion		= mod:NewCastTimer(15, 65333, nil, nil, nil, 3)
local timerNextFrostBomb			= mod:NewNextTimer(30.4, 64623, nil, nil, nil, 3, nil, DBM_COMMON_L.HEROIC_ICON, true) -- REVIEW! variance? Use PEWPEW to add time? Added "keep" arg (VOD review || S3 HM log 2022/07/17 || 25H Lordaeron 2022/10/09) - either gave 46 or 33s || 44.2, 44.4, 47.1 || Stage 2/44.3, 32.6, Stage 4/88.2, 28.8/116.9/145.5, 47.7, 30.4
local timerNextFlameSuppressantP2	= mod:NewNextTimer(10, 65192, nil, nil, nil, 3) -- 2s (26.4 outlier??) variance (S2 VOD review) - 12, 12, 11, 10 || 12.3, 12.4, 26.4, 11.3, 12.4

-- Stage Three
mod:AddTimerLine(DBM_CORE_L.SCENARIO_STAGE:format(3)..": "..L.MobPhase3)
local specWarnDeafeningSiren		= mod:NewSpecialWarningMove(64616, nil, nil, nil, 1, 2)

-- Stage Four
-- mod:AddTimerLine(DBM_CORE_L.SCENARIO_STAGE:format(4)..": "..L.MobPhase4)
-- nothing new to add

mod:GroupSpells(63274, 63293) -- Spinning Up and P3Wx2 Laser Barrage
mod:GroupSpells(64623, 65333) -- Frost Bomb, Frost Bomb Explosion

local cachedLootmethod, _, masterlooterRaidID
mod.vb.hardmode = false
mod.vb.napalmShellIcon = 7
local spinningUp = DBM:GetSpellInfo(63414)
local lastSpinUp = 0
mod.vb.is_spinningUp = false
local napalmShellTargets = {}

local function ResetRange(self)
	if self.Options.RangeFrame then
		DBM.RangeCheck:DisableBossMode()
	end
end

local function Flames(self)	-- Flames -- UNIT_SPELLCAST_SUCCEEDED does not show on etrace
	timerNextFlames:Start()
	self:Schedule(28, Flames, self)
	warnFlamesSoon:Schedule(18)
	warnFlamesSoon:Schedule(23)
end

local function warnNapalmShellTargets(self)
	warnNapalmShell:Show(table.concat(napalmShellTargets, "<, >"))
	table.wipe(napalmShellTargets)
	self.vb.napalmShellIcon = 7
end

local function show_warning_for_spinup(self)
	if self.vb.is_spinningUp then
		specWarnP3Wx2LaserBarrage:Show()
		specWarnP3Wx2LaserBarrage:Play("watchstep")
		specWarnP3Wx2LaserBarrage:ScheduleVoice(1, "keepmove")
	end
end

local function NextPhase(self)
	self:SetStage(0)
	if self.vb.phase == 1 then
		if self.Options.HealthFrame then
			DBM.BossHealth:Clear()
			DBM.BossHealth:AddBoss(33432, L.MobPhase1)
		end
	elseif self.vb.phase == 2 then
		timerNextShockBlast:Stop()
		timerProximityMines:Stop()
		timerNextFlameSuppressantP1:Stop()
		timerPlasmaBlastCD:Stop()
		timerP1toP2:Start()
		timerNextP3Wx2LaserBarrage:Schedule(40, 31) -- REVIEW! ~3s variance? (25 man NM log 2022/07/10 || S3 HM log 2022/07/17 || Lord 25 NM log 2022/07/31 ) - 34 || 31 || 34
		if self.Options.HealthFrame then
			DBM.BossHealth:Clear()
			DBM.BossHealth:AddBoss(33651, L.MobPhase2)
		end
		if self.Options.RangeFrame then
			DBM.RangeCheck:Hide()
		end
		if self.vb.hardmode then
			timerNextFrostBomb:Start(44.3) -- (25H Lordaeron 2022/10/09) - 44.3
		end
	elseif self.vb.phase == 3 then
		if self.Options.AutoChangeLootToFFA and DBM:GetRaidRank() == 2 and GetLootMethod() ~= "freeforall" then
			cachedLootmethod, _, masterlooterRaidID = GetLootMethod()
			SetLootMethod("freeforall")
		end
		timerP3Wx2LaserBarrageCast:Cancel()
		timerNextP3Wx2LaserBarrage:Cancel()
		timerNextFrostBomb:Cancel()
		timerP2toP3:Start()
		timerBombBotSpawn:Start(32.5) -- 25 man NM log review (2022/07/10 || 25H Lordaeron 2022/10/09) - 33 || 32.5
		if self.Options.HealthFrame then
			DBM.BossHealth:Clear()
			DBM.BossHealth:AddBoss(33670, L.MobPhase3)
		end
	elseif self.vb.phase == 4 then
		-- Don't change loot if it was manually changed
		if self.Options.AutoChangeLootToFFA and DBM:GetRaidRank() == 2 and GetLootMethod() == "freeforall" and cachedLootmethod then
			if masterlooterRaidID then
				SetLootMethod(cachedLootmethod, "raid"..masterlooterRaidID)
			else
				SetLootMethod(cachedLootmethod)
			end
		end
		timerBombBotSpawn:Cancel()
		timerP3toP4:Start()
		timerProximityMines:Start(41) -- 25 man NM log review (2022/07/10) - 26 (phasing) + 15 (timer)
		timerNextP3Wx2LaserBarrage:Start(56) -- 25 man NM log review (2022/07/10) - 26 (phasing) + 30 (timer)
		if self.Options.HealthFrame then
			DBM.BossHealth:Show(L.name)
			DBM.BossHealth:AddBoss(33670, L.MobPhase3)
			DBM.BossHealth:AddBoss(33651, L.MobPhase2)
			DBM.BossHealth:AddBoss(33432, L.MobPhase1)
		end
		if self.vb.hardmode then
			timerNextFrostBomb:Start(28)
		end
	end
end

function mod:OnCombatStart()
	self.vb.phase = 0
	self.vb.is_spinningUp = false
	self.vb.napalmShellIcon = 7
	table.wipe(napalmShellTargets)
	NextPhase(self)
	-- Cache the loot method in case loot gets manually changed to ffa before Phase 3
	if DBM:GetRaidRank() == 2 then
		cachedLootmethod, _, masterlooterRaidID = GetLootMethod()
		if cachedLootmethod == "freeforall" then cachedLootmethod = nil end
	end
	if self.Options.RangeFrame then
		DBM.RangeCheck:Show(6)
	end
end

function mod:OnCombatEnd()
	self:Unschedule(Flames)
	if self.Options.HealthFrame then
		DBM.BossHealth:Hide()
	end
	if self.Options.RangeFrame then
		DBM.RangeCheck:Hide()
	end
	-- Don't change loot if it was manually changed away from ffa
	if self.Options.AutoChangeLootToFFA and DBM:GetRaidRank() == 2 and GetLootMethod() == "freeforall" and cachedLootmethod then
		if masterlooterRaidID then
			SetLootMethod(cachedLootmethod, "raid"..masterlooterRaidID)
		else
			SetLootMethod(cachedLootmethod)
		end
	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
--[[if spellId == 63631 then -- Shock Blast. Replaced with UNIT_SPELLCAST_START since 2022/07/2022 log had one instance where this event was not fired
		specWarnShockBlast:Show()
		specWarnShockBlast:Play("runout")
		timerShockBlast:Start()
		timerNextShockBlast:Start()
		if self.Options.RangeFrame then
			DBM.RangeCheck:SetBossRange(15, self:GetBossUnitByCreatureId(33432))
			self:Schedule(4.5, ResetRange, self)
		end]]
	if args:IsSpellID(64529, 62997) then	-- Plasma Blast
		if self:IsTanking("player", "boss1", nil, true) then
			specWarnPlasmaBlast:Show()
			specWarnPlasmaBlast:Play("defensive")
		end
		timerPlasmaBlastCD:Start()
	elseif spellId == 64570 then	-- Flame Suppressant (phase 1)
		timerNextFlameSuppressantP1:Start()
	elseif spellId == 64623 then	-- Frost Bomb
		warnFrostBomb:Show()
		timerFrostBombExplosion:Start()
		timerNextFrostBomb:Start()
	elseif spellId == 64383 then -- Self Repair (phase 4)
		-- REVIEW! Makes sense to cancel timers when each part dies? Or timers are continuous?
		timerSelfRepair:Start(args.sourceName)
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 63027 then				-- Proximity Mines
		timerProximityMines:Start()
	elseif spellId == 63414 then			-- Spinning UP (before Dark Glare)
		self.vb.is_spinningUp = true
		timerSpinUp:Start()
		timerP3Wx2LaserBarrageCast:Schedule(4)
		timerNextP3Wx2LaserBarrage:Schedule(14)			-- 4 (cast spinup) + 10 sec (cast dark glare)
		self:Schedule(0.15, show_warning_for_spinup, self)	-- wait 0.15 and then announce it, otherwise it will sometimes fail
		lastSpinUp = GetTime()
	elseif spellId == 65192 then	-- Flame Suppressant CD (phase 2)
		timerNextFlameSuppressantP2:Start()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if args:IsSpellID(63666, 65026) and args:IsDestTypePlayer() then	-- Napalm Shell
		napalmShellTargets[#napalmShellTargets + 1] = args.destName
		timerNapalmShell:Start()
		if self.Options.SetIconOnNapalm and self.vb.napalmShellIcon > 0 then
			self:SetIcon(args.destName, self.vb.napalmShellIcon, 6)
		end
		self.vb.napalmShellIcon = self.vb.napalmShellIcon - 1
		self:Unschedule(warnNapalmShellTargets)
		self:Schedule(0.3, warnNapalmShellTargets, self)
	elseif args:IsSpellID(64529, 62997) then	-- Plasma Blast
		warnPlasmaBlast:Show(args.destName)
		if self.Options.SetIconOnPlasmaBlast then
			self:SetIcon(args.destName, 8, 6)
		end
	elseif spellId == 64616 and args:IsPlayer() then	-- Deafening Siren (Hard Mode)
		specWarnDeafeningSiren:Show()
	elseif spellId == 64570 and args:IsPlayer() then	-- Flame Suppressant (phase 1)
		timerFlameSuppressantP1Debuff:Start()
	end
end

function mod:SPELL_AURA_REMOVED(args)
	if args:IsSpellID(63666, 65026) then -- Napalm Shell
		if self.Options.SetIconOnNapalm then
			self:SetIcon(args.destName, 0)
		end
	end
end

function mod:SPELL_SUMMON(args)
	if args.spellId == 63811 then -- Bomb Bot, never fired on Warmane
		DBM:Debug("Bomb Bot unhidden from combat log. Notify Zidras on Discord or GitHub")
		timerBombBotSpawn:Start()
		warnBombBotSpawn:Show()
	end
end

function mod:UNIT_SPELLCAST_CHANNEL_STOP(_, spellName)
	if spellName == spinningUp and GetTime() - lastSpinUp < 3.9 then
		self.vb.is_spinningUp = false
		self:SendSync("SpinUpFail")
	end
end

function mod:UNIT_SPELLCAST_START(_, spellName)
	if spellName == GetSpellInfo(63631) then -- Shock Blast. Used UNIT event instead since I have a log where CLEU missed one SCStart
		specWarnShockBlast:Show()
		specWarnShockBlast:Play("runout")
		timerShockBlast:Start()
		timerNextShockBlast:Start()
		if self.Options.RangeFrame then
			DBM.RangeCheck:SetBossRange(15, self:GetBossUnitByCreatureId(33432))
			self:Schedule(4.5, ResetRange, self)
		end
	end
end

function mod:UNIT_SPELLCAST_SUCCEEDED(_, spellName)
	--[[if spellId == 34098 then--ClearAllDebuffs never fired due to unit not existing
		self:SetStage(0)
		if self.vb.phase == 2 then
			timerNextShockBlast:Stop()
			timerProximityMines:Stop()
			timerNextFlameSuppressantP1:Stop()
			timerPlasmaBlastCD:Stop()
			timerP1toP2:Start()
			if self.Options.RangeFrame then
				DBM.RangeCheck:Hide()
			end
			timerRocketStrikeCD:Start(63)
			timerNextP3Wx2LaserBarrage:Start(78)
			if self.vb.hardmode then
				timerNextFrostBomb:Start(94)
			end
		elseif self.vb.phase == 3 then
			timerP3Wx2LaserBarrageCast:Stop()
			timerNextP3Wx2LaserBarrage:Stop()
			timerNextFrostBomb:Stop()
			timerRocketStrikeCD:Stop()
			timerP2toP3:Start()
		elseif self.vb.phase == 4 then
			timerP3toP4:Start()
			if self.vb.hardmode then
				timerNextFrostBomb:Start(32)
			end
			timerRocketStrikeCD:Start(50)
			timerNextP3Wx2LaserBarrage:Start(59.8)
			timerNextShockBlast:Start(81)
		end--]]
	if spellName == GetSpellInfo(64402) or spellName == GetSpellInfo(65034) then	--P2, P4 Rocket Strike
		specWarnRocketStrike:Show()
		specWarnRocketStrike:Play("watchstep")
		timerRocketStrikeCD:Start()
	elseif spellName == GetSpellInfo(63811) then	--Bomb Bot
		warnBombBotSpawn:Show()
		timerBombBotSpawn:Start()
	end
end

function mod:CHAT_MSG_MONSTER_YELL(msg)
	if msg == L.YellPull or msg:find(L.YellPull) then -- register Normal Mode
		self.vb.hardmode = false -- set this here instead of CombatStart to prevent possible overwrites
		timerPlasmaBlastCD:Start(22.0) -- REVIEW! variance? 25 man NM log review (2022/07/10) - 22.0
		timerNextShockBlast:Start(31.1) -- REVIEW! variance? 25 man NM log review (2022/07/10) - 31.1
		timerEnrage:Start()
	elseif msg == L.YellHardPull or msg:find(L.YellHardPull) then -- register HARD Mode
		self.vb.hardmode = true
		self:SetWipeTime(10)
		timerHardmode:Start()
		timerPlasmaBlastCD:Start(26.6) -- REVIEW! variance? (S2 VOD || S3 HM log 2022/07/17) - 29 || 26.6, 26.6
		timerNextFlameSuppressantP1:Start(75) -- REVIEW! ~5s variance (S2 VOD review || S3 HM log 2022/07/17) - 75 || 80.0 ; 77.3
		timerProximityMines:Start(11) -- S2 VOD review
		timerNextFlames:Start(6) -- S2 VOD review
		self:Schedule(6, Flames, self)
		warnFlamesSoon:Schedule(1)
		timerNextShockBlast:Start(35.8) -- REVIEW! variance? (S3 HM log 2022/07/17 || 25H Lordaeron 2022/10/09) - 37.9, 37.7 || 35.8
		timerEnrage:Start(600) -- REVIEW! 10 or 8 mins? By the yells, it is 10 mins, but wowhead states 8 min enrage timer...
	elseif msg == L.YellPhase2 or msg:find(L.YellPhase2) then -- register Phase 2
		NextPhase(self)
	elseif msg == L.YellPhase3 or msg:find(L.YellPhase3) then -- register Phase 3
		NextPhase(self)
	elseif msg == L.YellPhase4 or msg:find(L.YellPhase4) then -- register Phase 4
		NextPhase(self)
	end
end

function mod:CHAT_MSG_LOOT(msg)
	local player, itemID = msg:match(L.LootMsg)
	if player and itemID and tonumber(itemID) == 46029 and self:IsInCombat() then
		player = DBM:GetUnitFullName(player) or UnitName("player") -- prevents nil string if the player is the one looting it: "You" receive loot...
		self:SendSync("LootMsg", player)
	end
end

-- Case where combat was started with the wrong loot and changed manually, and then put to ffa manually before Phase 3
-- This will not protect against misclicks before changing manually to ffa (loot will be returned to last misclicked type)
function mod:PARTY_LOOT_METHOD_CHANGED()
	if self.Options.AutoChangeLootToFFA and DBM:GetRaidRank() == 2 and self:GetStage(3, 1) and GetLootMethod() ~= "freeforall" then
		cachedLootmethod, _, masterlooterRaidID = GetLootMethod()
	end
end

function mod:OnSync(event, args)
	if event == "SpinUpFail" then
		self.vb.is_spinningUp = false
		timerSpinUp:Cancel()
		timerP3Wx2LaserBarrageCast:Cancel()
		timerNextP3Wx2LaserBarrage:Cancel()
		specWarnP3Wx2LaserBarrage:Cancel()
	elseif event == "LootMsg" and args and self:AntiSpam(2, 1) then
		warnLootMagneticCore:Show(args)
	end
end
