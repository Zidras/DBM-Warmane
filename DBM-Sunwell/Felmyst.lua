local mod	= DBM:NewMod("Felmyst", "DBM-Sunwell")
local L		= mod:GetLocalizedStrings()

mod:SetRevision("20220518110528")
mod:SetCreatureID(25038)
mod:SetUsedIcons(8, 7)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_AURA_APPLIED 45866",
	"SPELL_CAST_START 45855",
	"SPELL_SUMMON 45392",
	"CHAT_MSG_RAID_BOSS_EMOTE",
	"CHAT_MSG_MONSTER_YELL",
	"UNIT_SPELLCAST_SUCCEEDED"
)

local warnEncaps			= mod:NewTargetAnnounce(45665, 4)
local warnVapor				= mod:NewTargetAnnounce(45402, 3)
local warnPhase				= mod:NewAnnounce("WarnPhase", 1, 31550)

local specWarnGas			= mod:NewSpecialWarningSpell(45855, "Healer", nil, nil, 1, 2)
local specWarnCorrosion		= mod:NewSpecialWarningTaunt(45866, nil, nil, nil, 1, 2)
local specWarnEncaps		= mod:NewSpecialWarningYou(45665, nil, nil, nil, 1, 2)
local yellEncaps			= mod:NewYell(45665)
local specWarnEncapsNear	= mod:NewSpecialWarningClose(45665, nil, nil, nil, 1, 2)
local specWarnVapor			= mod:NewSpecialWarningYou(45402, nil, nil, nil, 1, 2)
local specWarnBreath		= mod:NewSpecialWarningCount(45717, nil, nil, nil, 3, 2)

local timerGasCast			= mod:NewCastTimer(1, 45855)
local timerGasCD			= mod:NewCDTimer(19, 45855, nil, nil, nil, 3)
local timerCorrosion		= mod:NewTargetTimer(10, 45866, nil, "Tank", 2, 5, nil, DBM_COMMON_L.TANK_ICON)
local timerEncaps			= mod:NewTargetTimer(7, 45665, nil, nil, nil, 3)
local timerEncapsCD			= mod:NewCDTimer(50, 45665, nil, nil, nil, 3)
local timerBreath			= mod:NewCDCountTimer(17, 45717, nil, nil, nil, 3, nil, DBM_COMMON_L.DEADLY_ICON)
local timerPhase			= mod:NewTimer(60, "TimerPhase", 31550, nil, nil, 6)

local berserkTimer			= mod:NewBerserkTimer(mod:IsTimewalking() and 500 or 600)

mod:AddSetIconOption("EncapsIcon", 45665, true, false, {7})
mod:AddSetIconOption("VaporIcon", 45402, true, true, {8})

mod.vb.breathCounter = 0

function mod:Groundphase()
	self.vb.breathCounter = 0
	warnPhase:Show(L.Ground)
	timerGasCD:Start(17)
	timerPhase:Start(60, L.Air)
	timerEncapsCD:Start()
end

function mod:EncapsulateTarget(targetname)
	if not targetname then return end
	timerEncapsCD:Cancel()
	timerEncaps:Start(targetname)
	if self.Options.EncapsIcon then
		self:SetIcon(targetname, 7, 6)
	end
	if targetname == UnitName("player") then
		specWarnEncaps:Show()
		specWarnEncaps:Play("targetyou")
		yellEncaps:Yell()
	elseif self:CheckNearby(21, targetname) then
		specWarnEncapsNear:Show(targetname)
		specWarnEncapsNear:Play("runaway")
	else
		warnEncaps:Show(targetname)
	end
end

function mod:OnCombatStart(delay)
	self.vb.breathCounter = 0
	timerGasCD:Start(17-delay)
	timerPhase:Start(-delay, L.Air)
	berserkTimer:Start(-delay)
	timerEncapsCD:Start()
end


function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 45866 then
		timerCorrosion:Start(args.destName)
		if not args:IsPlayer() then -- validate
			specWarnCorrosion:Show(args.destName)
			specWarnCorrosion:Play("tauntboss")
		end
	end
end

function mod:SPELL_SUMMON(args)
	if args.spellId == 45392 then
		warnVapor:Show(args.sourceName)
		if args.sourceName == UnitName("player") then
			specWarnVapor:Show()
			specWarnVapor:Play("targetyou")
		else
			warnVapor:Show(args.sourceName)
		end
		if self.Options.VaporIcon then
			self:SetIcon(args.sourceName, 8, 10)
		end
	end
end

function mod:SPELL_CAST_START(args)
	if args.spellId == 45855 then
		timerGasCast:Start()
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
		timerBreath:Start(42, 1)
		timerPhase:Start(99, L.Ground)
		self:ScheduleMethod(99, "Groundphase")
	end
end

function mod:CHAT_MSG_RAID_BOSS_EMOTE(msg)
	if msg == L.Breath or msg:find(L.Breath) then
		self.vb.breathCounter = self.vb.breathCounter + 1
		specWarnBreath:Show(self.vb.breathCounter)
		specWarnBreath:Play("breathsoon")
		if self.vb.breathCounter < 3 then
			timerBreath:Start(nil, self.vb.breathCounter+1)
		end
	end
end

function mod:UNIT_SPELLCAST_SUCCEEDED(_, spellName)
	if spellName == GetSpellInfo(45661) and self:AntiSpam(2, 1) then
		self:BossTargetScanner(25038, "EncapsulateTarget", 0.05, 10)
	end
end
