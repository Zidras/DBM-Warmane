local mod	= DBM:NewMod("Felmyst", "DBM-Sunwell")
local L		= mod:GetLocalizedStrings()

mod:SetRevision("20250608110528") --based on cafe&yars20250416v25
mod:SetCreatureID(25038)
mod:SetUsedIcons(8, 7)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_AURA_APPLIED 45866 45402",
	"SPELL_CAST_START 45855 45866",
	"SPELL_SUMMON 45392",
	"CHAT_MSG_RAID_BOSS_EMOTE",
	"CHAT_MSG_MONSTER_YELL",
	"UNIT_SPELLCAST_SUCCEEDED"
)
local warnEncaps			= mod:NewTargetAnnounce(45665, 4)
local warnVapor				= mod:NewTargetAnnounce(45402, 3)
local warnPhase				= mod:NewAnnounce("WarnPhase", 1, 31550)
local specWarnGasdot		= mod:NewSpecialWarningGTFO(45402, nil, nil, nil, 1, 6) --new gas warning 250322

local specWarnGas			= mod:NewSpecialWarningSpell(45855, "Healer", nil, nil, 1, 2)
local specWarnCorrosion		= mod:NewSpecialWarningTaunt(45866, nil, nil, nil, 1, 2)
local specWarnEncaps		= mod:NewSpecialWarningYou(45665, nil, nil, nil, 1, 2)
local yellEncaps			= mod:NewYell(45665)
local specWarnEncapsNear	= mod:NewSpecialWarningClose(45665, nil, nil, nil, 1, 2)
local specWarnVapor			= mod:NewSpecialWarningYou(45402, nil, nil, nil, 1, 2)
local specWarnBreath		= mod:NewSpecialWarningCount(45717, nil, nil, nil, 3, 2)
local yellVapor				= mod:NewYell(45392) --new yell if target of Vapor

local timerGasCD			= mod:NewCDTimer(18, 45855, nil, nil, nil, 3) -- adjusted to CC 250302, updated on 250331
local timerCorrosion		= mod:NewTargetTimer(10, 45866, nil, "Tank", 2, 5, nil, DBM_COMMON_L.TANK_ICON)
local timerEncaps			= mod:NewTargetTimer(7, 45665, nil, nil, nil, 3)
local timerEncapsCD			= mod:NewCDTimer(26, 45665, nil, nil, nil, 3) -- adjusted to CC 250302, updated on 250331
local timerBreath			= mod:NewCDCountTimer(18, 45717, nil, nil, nil, 3, nil, DBM_COMMON_L.DEADLY_ICON)
local timerPhase			= mod:NewTimer(60, "TimerPhase", 31550, nil, nil, 6)

local berserkTimer			= mod:NewBerserkTimer(600) --10 minutes on chromiecraft

mod:AddSetIconOption("EncapsIcon", 45665, true, 0, {7})
mod:AddSetIconOption("VaporIcon", 45402, true, 0, {8})

mod.vb.breathCounter = 0
mod.vb.scanCounter = 0
mod.vb.encapsLastTarget = nil
mod.vb.encapsAnnounced = false

function mod:Groundphase()
	self.vb.breathCounter = 0
	warnPhase:Show(L.Ground)
	timerGasCD:Start(18) -- adjusted to CC 250302
	timerPhase:Start(60, L.Air)
	timerEncapsCD:Start()
end

local function EncapsulateAnnounce(self, target)
	if target == UnitName("player") then
		specWarnEncaps:Show()
		specWarnEncaps:Play("targetyou")
		yellEncaps:Yell()
	elseif self:CheckNearby(21, target) then
		specWarnEncapsNear:Show(target)
		specWarnEncapsNear:Play("runaway")
	else
		warnEncaps:Show(target)
	end
end

local function ScanEncapsulateTarget(self)
	--scan for target changes around the time Encaps should happen
	local target, uId = self:GetBossTarget(25038)
	if target and self.vb.scanCounter == 0 then --first scan
		self.vb.encapsLastTarget = target
	elseif target and self.vb.scanCounter <= 100 then --scan for target changes
		if self.vb.encapsLastTarget ~= target then --target changed
			EncapsulateAnnounce(self, target)
			self.vb.scanCounter = 0
			self.vb.encapsLastTarget = nil
			self.vb.encapsAnnounced = true
			return
		end
	elseif target and self.vb.scanCounter > 100 then
		self.vb.scanCounter = 0
		self.vb.encapsLastTarget = nil
		return
	end
	self.vb.scanCounter = self.vb.scanCounter + 1
	if not self.vb.encapsAnnounced then 
		self:Schedule(0.05, ScanEncapsulateTarget, self) --schedule next scan
	end
end

function mod:EncapsulateTarget(target)
	if not target then return end
	if not self.vb.encapsAnnounced then --this Encaps wasn't announced early
		EncapsulateAnnounce(self, target)
	end
	if self.Options.EncapsIcon then
		self:SetIcon(target, 7, 7)
	end
	self.vb.encapsAnnounced = false
	timerEncaps:Start(target)
	timerEncapsCD:Start(24)
	self:Schedule(22, ScanEncapsulateTarget, self)
end

function mod:OnCombatStart()
	self.vb.breathCounter = 0
	timerGasCD:Start(20)
	timerPhase:Start(62, L.Air)
	berserkTimer:Start(602)
	timerEncapsCD:Start(28)
end


function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 45866 then
		timerCorrosion:Start(args.destName)
		if not args:IsPlayer() then -- validate
			specWarnCorrosion:Show(args.destName)
			--specWarnCorrosion:Play("tauntboss")
		end
	elseif args.spellId == 45402 and args:IsPlayer() then
		specWarnGasdot:Show(args.destName)
		specWarnGasdot:Play("runaway")
	end
	
end

function mod:SPELL_SUMMON(args)
	if args.spellId == 45392 then
		warnVapor:Show(args.sourceName)
		if self.Options.VaporIcon then
			self:SetIcon(args.sourceName, 8, 10)
		end
		if args.sourceName == UnitName("player") then
			specWarnVapor:Show()
			specWarnVapor:Play("targetyou")
			yellVapor:Yell() --yell if target of Vapor, need testing 20250319
		end
	end
end

function mod:SPELL_CAST_START(args)
	if args.spellId == 45855 then
		timerGasCD:Start()
		specWarnGas:Show()
		specWarnGas:Play("helpdispel")

	end
end

function mod:CHAT_MSG_MONSTER_YELL(msg)
	if msg == L.AirPhase or msg:find(L.AirPhase) then
		self.vb.breathCounter = 0
		warnPhase:Show(L.Air)
		timerGasCD:Cancel()
		self:Unschedule(ScanEncapsulateTarget, self)
		timerEncapsCD:Cancel() --new cancel for air phase 250318
		timerBreath:Start(38.6, 1)
		timerPhase:Start(99, L.Ground) --air phase lasts about 99s on CC based on changes on 20250319
		--self:ScheduleMethod(99, "Groundphase") --air phase lasts about 99s on CC based on changes on 20250319
	end
end

function mod:CHAT_MSG_RAID_BOSS_EMOTE(msg)
	if msg == L.Breath or msg:find(L.Breath) then
		self.vb.breathCounter = self.vb.breathCounter + 1
		specWarnBreath:Show(self.vb.breathCounter)
		specWarnBreath:Play("breathsoon")
		if self.vb.breathCounter < 3 then
			timerBreath:Start(nil, self.vb.breathCounter+1)
		else
			self:ScheduleMethod(21, "Groundphase") --ground phase starts 21s after last breath emote
			timerPhase:Restart(21, L.Ground)
		end
	end
end

function mod:UNIT_SPELLCAST_SUCCEEDED(_, spellName)
	if spellName == GetSpellInfo(45661) and self:AntiSpam(2, 1) then
		self:BossTargetScanner(25038, "EncapsulateTarget", 0.05, 10)
	end
end