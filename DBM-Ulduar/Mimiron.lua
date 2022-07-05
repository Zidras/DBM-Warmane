local mod	= DBM:NewMod("Mimiron", "DBM-Ulduar")
local L		= mod:GetLocalizedStrings()

mod:SetRevision("20220701215737")
mod:SetCreatureID(33432)
mod:SetUsedIcons(1, 2, 3, 4, 5, 6, 7, 8)

mod:RegisterCombat("combat_yell", L.YellPull)
mod:RegisterCombat("yell", L.YellHardPull)

mod:RegisterEvents(
	"CHAT_MSG_MONSTER_YELL"
)

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 63631 64529 62997 64570 64623 64383",
	"SPELL_CAST_SUCCESS 63027 63414 65192",
	"SPELL_AURA_APPLIED 63666 65026 64529 62997 64616",
	"SPELL_AURA_REMOVED 63666 65026",
	"SPELL_SUMMON 63811",
	"UNIT_SPELLCAST_CHANNEL_STOP boss1 boss2 boss3 boss4",
	"UNIT_SPELLCAST_SUCCEEDED boss1 boss2 boss3 boss4",
	"CHAT_MSG_LOOT"
)

--General
local timerEnrage					= mod:NewBerserkTimer(900)
local timerP1toP2					= mod:NewTimer(41, "TimeToPhase2", nil, nil, nil, 6)
local timerP2toP3					= mod:NewTimer(15, "TimeToPhase3", nil, nil, nil, 6)
local timerP3toP4					= mod:NewTimer(30, "TimeToPhase4", nil, nil, nil, 6)

mod:AddRangeFrameOption("6")

-- Stage One
mod:AddTimerLine(DBM_CORE_L.SCENARIO_STAGE:format(1)..": "..L.MobPhase1)
local warnNapalmShell				= mod:NewTargetNoFilterAnnounce(63666, 2, nil, "Healer")
local warnPlasmaBlast				= mod:NewTargetNoFilterAnnounce(64529, 4, nil, "Tank|Healer")

local specWarnShockBlast			= mod:NewSpecialWarningRun(63631, "Melee", nil, nil, 4, 2)
local specWarnPlasmaBlast			= mod:NewSpecialWarningDefensive(64529, nil, nil, nil, 1, 2)

local timerProximityMines			= mod:NewCDTimer(25, 63027, nil, nil, nil, 3)
local timerShockBlast				= mod:NewCastTimer(4, 63631, nil, nil, nil, 2, nil, DBM_COMMON_L.DEADLY_ICON)
local timerNextShockBlast			= mod:NewNextTimer(40, 63631, nil, nil, nil, 2, nil, DBM_COMMON_L.DEADLY_ICON)
local timerNapalmShell				= mod:NewBuffActiveTimer(6, 63666, nil, "Healer", 2, 5, nil, DBM_COMMON_L.IMPORTANT_ICON..DBM_COMMON_L.HEALER_ICON)
local timerPlasmaBlastCD			= mod:NewCDTimer(30, 64529, nil, "Tank", 2, 5, nil, DBM_COMMON_L.TANK_ICON)

mod:AddSetIconOption("SetIconOnNapalm", 63666, false, false, {1, 2, 3, 4, 5, 6, 7})
mod:AddSetIconOption("SetIconOnPlasmaBlast", 64529, false, false, {8})

-- Stage Two
mod:AddTimerLine(DBM_CORE_L.SCENARIO_STAGE:format(2)..": "..L.MobPhase2)
local specWarnP3Wx2LaserBarrage		= mod:NewSpecialWarningDodge(63274, nil, nil, nil, 3, 2) -- P3Wx2 Laser Barrage
local specWarnRocketStrike			= mod:NewSpecialWarningDodge(64402, nil, nil, nil, 2, 2)

local timerSpinUp					= mod:NewCastTimer(4, 63414, nil, nil, nil, 3, nil, DBM_COMMON_L.DEADLY_ICON)
local timerP3Wx2LaserBarrageCast	= mod:NewCastTimer(10, 63274, nil, nil, nil, 3, nil, DBM_COMMON_L.DEADLY_ICON)
local timerNextP3Wx2LaserBarrage	= mod:NewNextTimer(31, 63414, nil, nil, nil, 3, nil, DBM_COMMON_L.DEADLY_ICON)
local timerRocketStrikeCD			= mod:NewCDTimer(20, 64402, nil, nil, nil, 3)--20-25

-- Stage Three
mod:AddTimerLine(DBM_CORE_L.SCENARIO_STAGE:format(3)..": "..L.MobPhase3)
local warnLootMagneticCore			= mod:NewAnnounce("MagneticCore", 1, 64444, nil, nil, nil, 64444)
local warnBombBotSpawn				= mod:NewAnnounce("WarnBombSpawn", 3, 63811, nil, nil, nil, 63811)

local timerBombBotSpawn				= mod:NewCDTimer(15, 63811)

mod:AddBoolOption("AutoChangeLootToFFA", true, nil, nil, nil, nil, 64444)

-- Stage Four
mod:AddTimerLine(DBM_CORE_L.SCENARIO_STAGE:format(4)..": "..L.MobPhase4)
local timerSelfRepair				= mod:NewCastSourceTimer(15, 64383, nil, nil, nil, 7, nil, DBM_COMMON_L.IMPORTANT_ICON)

-- Hard Mode
mod:AddTimerLine(DBM_COMMON_L.HEROIC_ICON..DBM_CORE_L.HARD_MODE)
local warnFlamesSoon				= mod:NewSoonAnnounce(64566, 1)

local timerHardmode					= mod:NewTimer(610, "TimerHardmode", 64582, nil, nil, 6, nil, nil, nil, nil, nil, nil, nil, 64582)
local timerNextFlames				= mod:NewNextTimer(28, 64566, nil, nil, nil, 7, nil, DBM_COMMON_L.IMPORTANT_ICON)

-- Stage One
mod:AddTimerLine(DBM_CORE_L.SCENARIO_STAGE:format(1)..": "..L.MobPhase1)
local timerFlameSuppressant			= mod:NewBuffActiveTimer(10, 64570, nil, nil, nil, 3)

-- Stage Two
mod:AddTimerLine(DBM_CORE_L.SCENARIO_STAGE:format(2)..": "..L.MobPhase2)
local warnFrostBomb					= mod:NewSpellAnnounce(64623, 3)

local timerFrostBombExplosion		= mod:NewCastTimer(15, 65333, nil, nil, nil, 3)
local timerNextFrostBomb			= mod:NewNextTimer(30, 64623, nil, nil, nil, 3, nil, DBM_COMMON_L.HEROIC_ICON)
local timerNextFlameSuppressant		= mod:NewNextTimer(60, 65192, nil, nil, nil, 3)

-- Stage Three
mod:AddTimerLine(DBM_CORE_L.SCENARIO_STAGE:format(3)..": "..L.MobPhase3)
local specWarnDeafeningSiren		= mod:NewSpecialWarningMove(64616, nil, nil, nil, 1, 2)

-- Stage Four
-- mod:AddTimerLine(DBM_CORE_L.SCENARIO_STAGE:format(4)..": "..L.MobPhase4)
-- nothing new to add

mod:GroupSpells(63274, 63293) -- Spinning Up and P3Wx2 Laser Barrage
mod:GroupSpells(64623, 65333) -- Frost Bomb, Frost Bomb Explosion

local lootmethod, _, masterlooterRaidID
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

local function Flames(self)	-- Flames
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


local function BombBot(self)	-- Bomb Bot
	if self.vb.phase == 3 then
		timerBombBotSpawn:Start()
		self:Schedule(15, BombBot, self)
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
		timerFlameSuppressant:Stop()
		timerPlasmaBlastCD:Stop()
		timerP1toP2:Start()
		timerNextP3Wx2LaserBarrage:Schedule(30)
		if self.Options.HealthFrame then
			DBM.BossHealth:Clear()
			DBM.BossHealth:AddBoss(33651, L.MobPhase2)
		end
		if self.Options.RangeFrame then
			DBM.RangeCheck:Hide()
		end
		if self.vb.hardmode then
			timerNextFrostBomb:Start(46)
		end
	elseif self.vb.phase == 3 then
		if self.Options.AutoChangeLootToFFA and DBM:GetRaidRank() == 2 then
			SetLootMethod("freeforall")
		end
		timerP3Wx2LaserBarrageCast:Cancel()
		timerNextP3Wx2LaserBarrage:Cancel()
		timerNextFrostBomb:Cancel()
		timerP2toP3:Start()
		timerBombBotSpawn:Start(34)
		self:Schedule(34, BombBot, self)
		if self.Options.HealthFrame then
			DBM.BossHealth:Clear()
			DBM.BossHealth:AddBoss(33670, L.MobPhase3)
		end
	elseif self.vb.phase == 4 then
		if self.Options.AutoChangeLootToFFA and DBM:GetRaidRank() == 2 then
			if masterlooterRaidID then
				SetLootMethod(lootmethod, "raid"..masterlooterRaidID)
			else
				SetLootMethod(lootmethod)
			end
		end
		timerBombBotSpawn:Cancel()
		self:Unschedule(BombBot)
		timerP3toP4:Start()
		timerProximityMines:Start(34)
		timerNextP3Wx2LaserBarrage:Start(72)
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

function mod:OnCombatStart(delay)
	self.vb.phase = 0
	self.vb.hardmode = false
	timerEnrage:Start(-delay)
	self.vb.is_spinningUp = false
	self.vb.napalmShellIcon = 7
	table.wipe(napalmShellTargets)
	NextPhase(self)
	timerPlasmaBlastCD:Start(24-delay)
	timerNextShockBlast:Start(35-delay) -- normal mode. Will be overriden in hard mode yell
	if DBM:GetRaidRank() == 2 then
		lootmethod, _, masterlooterRaidID = GetLootMethod()
	end
	if self.Options.RangeFrame then
		DBM.RangeCheck:Show(6)
	end
end

function mod:OnCombatEnd()
	timerBombBotSpawn:Cancel()
	self:Unschedule(BombBot)
	self:Unschedule(Flames)
	if self.Options.HealthFrame then
		DBM.BossHealth:Hide()
	end
	if self.Options.RangeFrame then
		DBM.RangeCheck:Hide()
	end
	if self.Options.AutoChangeLootToFFA and DBM:GetRaidRank() == 2 then
		if masterlooterRaidID then
			SetLootMethod(lootmethod, "raid"..masterlooterRaidID)
		else
			SetLootMethod(lootmethod)
		end
	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 63631 then -- Shock Blast
		specWarnShockBlast:Show()
		specWarnShockBlast:Play("runout")
		timerShockBlast:Start()
		timerNextShockBlast:Start()
		if self.Options.RangeFrame then
			DBM.RangeCheck:SetBossRange(15, self:GetBossUnitByCreatureId(33432))
			self:Schedule(4.5, ResetRange, self)
		end
	elseif args:IsSpellID(64529, 62997) then	-- Plasma Blast
		local tanking, status = UnitDetailedThreatSituation("player", "boss1")--Change boss unitID if it's not boss 1
		if tanking or (status == 3) then
			specWarnPlasmaBlast:Show()
			specWarnPlasmaBlast:Play("defensive")
		end
		timerPlasmaBlastCD:Start()
	elseif spellId == 64570 then	-- Flame Suppressant (phase 1)
		timerFlameSuppressant:Start()
	elseif spellId == 64623 then	-- Frost Bomb
		warnFrostBomb:Show()
		timerFrostBombExplosion:Start()
		timerNextFrostBomb:Start()
	elseif spellId == 64383 then -- Self Repair (phase 4)
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
		DBM:Schedule(0.15, show_warning_for_spinup, self)	-- wait 0.15 and then announce it, otherwise it will sometimes fail
		lastSpinUp = GetTime()
	elseif spellId == 65192 then	-- Flame Suppressant CD (phase 2)
		timerNextFlameSuppressant:Start()
	end
end

function mod:SPELL_AURA_APPLIED(args)
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
	elseif args.spellId == 64616 and args:IsPlayer() then
		specWarnDeafeningSiren:Show()
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
	if args.spellId == 63811 then -- Bomb Bot
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

function mod:CHAT_MSG_LOOT(msg)
	local player, itemID = msg:match(L.LootMsg)
	if player and itemID and tonumber(itemID) == 46029 and self:IsInCombat() then
		player = DBM:GetUnitFullName(player) or UnitName("player") -- prevents nil string if the player is the one looting it: "You" receive loot...
		self:SendSync("LootMsg", player)
	end
end

function mod:CHAT_MSG_MONSTER_YELL(msg)
	if msg == L.YellPhase2 or msg:find(L.YellPhase2) then -- register Phase 2
		self:SendSync("Phase2")
	elseif msg == L.YellPhase3 or msg:find(L.YellPhase3) then -- register Phase 3
		self:SendSync("Phase3")
	elseif msg == L.YellPhase4 or msg:find(L.YellPhase4) then -- register Phase 4
		self:SendSync("Phase4")
	elseif msg == L.YellHardPull or msg:find(L.YellHardPull) then -- register HARDMODE
		timerEnrage:Stop()
		self.vb.hardmode = true
		self:SetWipeTime(10)
		timerHardmode:Start()
		timerPlasmaBlastCD:Start(28)
		timerFlameSuppressant:Start()
		timerProximityMines:Start(21)
		timerNextFlames:Start(6)
		self:Schedule(6, Flames, self)
		warnFlamesSoon:Schedule(1)
		timerNextShockBlast:Start(37)
	elseif msg == L.YellKilled or msg:find(L.YellKilled) then -- register kill
		timerEnrage:Stop()
		timerHardmode:Stop()
		timerNextFlames:Stop()
		self:Unschedule(Flames)
		timerNextFrostBomb:Stop()
		timerNextP3Wx2LaserBarrage:Stop()
		timerProximityMines:Stop()
		warnFlamesSoon:Cancel()
		warnFlamesSoon:Cancel()
	end
end

function mod:UNIT_SPELLCAST_SUCCEEDED(_, spellName)
	--[[if spellId == 34098 then--ClearAllDebuffs
		self:SetStage(0)
		if self.vb.phase == 2 then
			timerNextShockBlast:Stop()
			timerProximityMines:Stop()
			timerFlameSuppressant:Stop()
			--timerNextFlameSuppressant:Stop()
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
	if spellName == GetSpellInfo(64402) or spellName == GetSpellInfo(65034) then--P2, P4 Rocket Strike
		specWarnRocketStrike:Show()
		specWarnRocketStrike:Play("watchstep")
		timerRocketStrikeCD:Start()
	end
end

function mod:OnSync(event, args)
	if event == "SpinUpFail" then
		self.vb.is_spinningUp = false
		timerSpinUp:Cancel()
		timerP3Wx2LaserBarrageCast:Cancel()
		timerNextP3Wx2LaserBarrage:Cancel()
		specWarnP3Wx2LaserBarrage:Cancel()
	elseif event == "Phase2" and self.vb.phase == 1 then -- alternate localized-dependent detection
		NextPhase(self)
	elseif event == "Phase3" and self.vb.phase == 2 then
		NextPhase(self)
	elseif event == "Phase4" and self.vb.phase == 3 then
		NextPhase(self)
	elseif event == "LootMsg" and args and self:AntiSpam(2, 1) then
		warnLootMagneticCore:Show(args)
	end
end