local mod	= DBM:NewMod("Kologarn", "DBM-Ulduar")
local L		= mod:GetLocalizedStrings()

mod:SetRevision("20221031105808")
mod:SetCreatureID(32930)
mod:SetUsedIcons(5, 6, 7, 8)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_SUCCESS 64003 62166 63981",
	"SPELL_AURA_APPLIED 64290 64292 64002 63355",
	"SPELL_AURA_APPLIED_DOSE 64002 63355",
	"SPELL_AURA_REMOVED 64290 64292",
	"SPELL_DAMAGE 63783 63982 63346 63976",
	"SPELL_MISSED 63783 63982 63346 63976",
	"CHAT_MSG_RAID_BOSS_EMOTE",
	"UNIT_DIED",
	"UNIT_SPELLCAST_SUCCEEDED boss1"
)

mod:SetBossHealthInfo(
	32930, L.Health_Body,
	32934, L.Health_Right_Arm,
	32933, L.Health_Left_Arm
)

-- General
local enrageTimer				= mod:NewBerserkTimer(600)
local timerTimeForDisarmed		= mod:NewTimer(10, "achievementDisarmed")	-- 10 HC / 12 nonHC

--NOTE: Two crunch armors are setup to appear in gui twice on purpose, because they are very different mechanically. One is meant to be ignored and one is meant to be tank swap
-- Kologarn
mod:AddTimerLine(L.name)
local warnFocusedEyebeam		= mod:NewTargetNoFilterAnnounce(63346, 4)
local warnCrunchArmor			= mod:NewStackAnnounce(64002, 2, nil, "Tank|Healer")

local specWarnCrunchArmor2		= mod:NewSpecialWarningStack(64002, nil, 2, nil, 2, 1, 6)
local specWarnEyebeam			= mod:NewSpecialWarningRun(63346, nil, nil, nil, 4, 2)
local specWarnEyebeamNear		= mod:NewSpecialWarningClose(63346, nil, nil, nil, 1, 2)
local yellBeam					= mod:NewYell(63346)

local timerCrunch10				= mod:NewTargetTimer(6, 63355)
local timerNextSmash			= mod:NewCDTimer(14.4, 64003, nil, "Tank", nil, 5, nil, DBM_COMMON_L.TANK_ICON) -- 3s variance (2022/07/05 log review) - 16.7, 14.4, 14.4, 16.8, 14.4, 14.4 || 13.7, 16.8, 14.4, 14.4, 14.4 || 16.0, 14.3, 16.8, 14.4 || 16.8, 14.4, 14.4, 14.4, 16.8 || 14.1, 14.4, 16.8, 14.4
local timerNextEyebeam			= mod:NewCDTimer(15.9, 63346, nil, nil, nil, 3, nil, DBM_COMMON_L.IMPORTANT_ICON, true) -- almost 20s variance! Added "keep" arg (2022/07/05 log review || ... ||| 25m Lordaeron 2022/10/09 || 25m Lordaeron 2022/10/30) - 28, 31, 27 || 21, 19, 17, 33 || 25 || 33, 23 || 30, 16 ||| 23.0, 15.9, 23.3, 25.2 || 21.2, 22.9, 17.5, 30.1, 22.9

mod:AddSetIconOption("SetIconOnEyebeamTarget", 63346, true, false, {8})

-- Right Arm
mod:AddTimerLine(L.Health_Right_Arm)
local warnGrip					= mod:NewTargetNoFilterAnnounce(64292, 2)

local timerNextGrip				= mod:NewNextTimer(25, 62166, nil, nil, nil, 3) -- (2022/07/05 log review || 25m Lordaeron 2022/10/30) - 25.0 || 25.0, 25.1, 25.0
local timerRespawnRightArm		= mod:NewTimer(30, "timerRightArm", nil, nil, nil, 1)

mod:AddSetIconOption("SetIconOnGripTarget", 64292, true, false, {7, 6, 5})

-- Left Arm
mod:AddTimerLine(L.Health_Left_Arm)
local timerNextShockwave		= mod:NewNextTimer(25, 63982, nil, nil, nil, 2) -- (2022/07/05 log review || 25m Lordaeron 2022/10/30) - 25.0 || 25.0, 25.0, 25.0, 25.1
local timerRespawnLeftArm		= mod:NewTimer(30, "timerLeftArm", nil, nil, nil, 1)

-- 5/23 00:33:48.648  SPELL_AURA_APPLIED,0x0000000000000000,nil,0x80000000,0x0480000001860FAC,"Hâzzad",0x4000512,63355,"Crunch Armor",0x1,DEBUFF
-- 6/3 21:41:56.140 UNIT_DIED,0x0000000000000000,nil,0x80000000,0xF1500080A60274A0,"Rechter Arm",0xa48

mod:GroupSpells(64292, 62166) -- Stone Grip aura and cast

mod.vb.disarmActive = false
local gripTargets = {}

local function armReset(self)
	self.vb.disarmActive = false
end

local function GripAnnounce(self)
	warnGrip:Show(table.concat(gripTargets, "<, >"))
	table.wipe(gripTargets)
end

function mod:OnCombatStart(delay)
	enrageTimer:Start(-delay)
	timerNextSmash:Start(5-delay) -- 2s variance (2022/07/05 log review) - [5-7]
	timerNextEyebeam:Start(20.2-delay) -- (2022/07/05 log review || 25m Lordaeron 2022/10/30) - 21 || 20.2
	timerNextShockwave:Start(18.2-delay) -- (2022/07/05 log review || 25m Lordaeron 2022/10/30) - 19 || 18.2
	timerNextGrip:Start(24.2-delay) --  (25m Lordaeron 2022/10/30) - 24.2
end

function mod:SPELL_CAST_SUCCESS(args)
	if args.spellId == 64003 then
		timerNextSmash:Start()
	elseif args.IsSpellID(62166, 63981) then -- Stone Grip
		timerNextGrip:Start()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpellID(64290, 64292) then
		if self.Options.SetIconOnGripTarget then
			self:SetIcon(args.destName, 8 - #gripTargets, 10)
		end
		table.insert(gripTargets, args.destName)
		self:Unschedule(GripAnnounce)
		if #gripTargets >= 3 then
			GripAnnounce(self)
		else
			self:Schedule(0.3, GripAnnounce, self)
		end
	elseif args:IsSpellID(64002, 63355) then	-- Crunch Armor
		local amount = args.amount or 1
		if amount >= 2 then
			if args:IsPlayer() then
				specWarnCrunchArmor2:Show(amount)
				specWarnCrunchArmor2:Play("stackhigh")
			else
				warnCrunchArmor:Show(args.destName, amount)
			end
		else
			warnCrunchArmor:Show(args.destName, amount)
		end
		if self:IsDifficulty("normal10") then
			timerCrunch10:Start(args.destName)  -- We track duration timer only in 10-man since it's only 6sec and tanks don't switch.
		end
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	if args:IsSpellID(64290, 64292) then
		self:SetIcon(args.destName, 0)
	end
end

function mod:UNIT_DIED(args)
	if self:GetCIDFromGUID(args.destGUID) == 32934 then		-- right arm
		timerRespawnRightArm:Start()
		timerNextGrip:Cancel()
		if not self.vb.disarmActive then
			self.vb.disarmActive = true
			if self:IsDifficulty("normal10") then
				timerTimeForDisarmed:Start(12)
				self:Schedule(12, armReset, self)
			else
				timerTimeForDisarmed:Start()
				self:Schedule(10, armReset, self)
			end
		end
	elseif self:GetCIDFromGUID(args.destGUID) == 32933 then		-- left arm
		timerRespawnLeftArm:Start()
		if not self.vb.disarmActive then
			self.vb.disarmActive = true
			if self:IsDifficulty("normal10") then
				timerTimeForDisarmed:Start(12)
				self:Schedule(12, armReset, self)
			else
				timerTimeForDisarmed:Start()
				self:Schedule(10, armReset, self)
			end
		end
	end
end

function mod:SPELL_DAMAGE(_, _, _, destGUID, destName, _, spellId)
	if (spellId == 63346 or spellId == 63976) and self:AntiSpam(2, 2) then
		if destGUID == UnitGUID("player") then
			specWarnEyebeam:Show()
		else
			local uId = self:GetUnitIdFromGUID(destGUID)
			if uId then
				local inRange = CheckInteractDistance(uId, 5)
				if inRange then
					specWarnEyebeamNear:Show(destName)
				end
			end
		end

	end
end
mod.SPELL_MISSED = mod.SPELL_DAMAGE

function mod:CHAT_MSG_RAID_BOSS_EMOTE(msg, _, _, _, target)
	if msg == L.FocusedEyebeam or msg:find(L.FocusedEyebeam) then
		self:SendSync("EyeBeamOn", target)
	end
end

function mod:OnSync(msg, target)
	if msg == "EyeBeamOn" and self:AntiSpam(2, 1) then
		warnFocusedEyebeam:Show(target)
		if target == UnitName("player") then
			specWarnEyebeam:Show()
			specWarnEyebeam:Play("justrun")
			specWarnEyebeam:ScheduleVoice(1, "keepmove")
			yellBeam:Yell()
		end
		warnFocusedEyebeam:Show(target)
		if self.Options.SetIconOnEyebeamTarget then
			self:SetIcon(target, 5, 8)
		end
	end
end

function mod:UNIT_SPELLCAST_SUCCEEDED(_, spellName)
	if spellName == GetSpellInfo(63983) then--Arm Sweep
		timerNextShockwave:Start()
	elseif spellName == GetSpellInfo(63342) then--Focused Eyebeam Summon Trigger
		timerNextEyebeam:Start()
	elseif spellName == GetSpellInfo(63726) then -- Pacify Self (End Combat, since there isn't a UNIT_DIED for OnMobKill to run)
		DBM:EndCombat(self)
	end
end
