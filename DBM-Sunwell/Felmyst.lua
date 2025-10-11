local mod	= DBM:NewMod("Felmyst", "DBM-Sunwell")
local L		= mod:GetLocalizedStrings()

mod:SetRevision("20251011114446")
mod:SetCreatureID(25038)
mod:SetEncounterID(726)
mod:SetUsedIcons(8, 7)
mod:SetHotfixNoticeRev(202501011000000)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_AURA_APPLIED 45866",
	"SPELL_CAST_START 45855 45866",
	"SPELL_SUMMON 45392",
	"CHAT_MSG_RAID_BOSS_WHISPER",
	"CHAT_MSG_MONSTER_YELL",
	"UNIT_SPELLCAST_SUCCEEDED boss1"
)

local warnEncaps			= mod:NewTargetAnnounce(45665, 4)
local warnVapor				= mod:NewTargetAnnounce(45402, 3)
local warnPhase				= mod:NewAnnounce("WarnPhase", 1, 31550)

local specWarnGas			= mod:NewSpecialWarningSpell(45855, "Healer", nil, nil, 1, 2)
local specWarnCorrosion		= mod:NewSpecialWarningTaunt(45866, nil, nil, nil, 1, 2)
local specWarnCorrosionHeal	= mod:NewSpecialWarningSpell(45866, "Healer", nil, nil, 1, 2)
local specWarnEncaps		= mod:NewSpecialWarningYou(45665, nil, nil, nil, 1, 2)
local yellEncaps			= mod:NewYell(45665)
local specWarnEncapsNear	= mod:NewSpecialWarningClose(45665, nil, nil, nil, 1, 2)
local specWarnVapor			= mod:NewSpecialWarningYou(45402, nil, nil, nil, 1, 2)
local specWarnBreath		= mod:NewSpecialWarningCount(45717, nil, nil, nil, 3, 2)

local timerGasCast			= mod:NewCastTimer(1, 45855)
local timerGasCD			= mod:NewCDTimer(32.97, 45855, nil, nil, nil, 3, nil, nil, true) -- REVIEW! Check proper variance with Phase Transcriptor events. Added "keep" arg. (Onyxia: [2025-10-09]@[20:58:45]) - "Gas Nova-45855-npc:25038-1001 = pull:20.92, 32.97, 129.37"
local timerCorrosionCD		= mod:NewCDTimer(27.08, 45866, nil, "Healer", 2, 5, nil, DBM_COMMON_L.HEALER_ICON, true) -- REVIEW! Check proper variance with Phase Transcriptor events. Added "keep" arg. (Onyxia: [2025-10-09]@[20:58:45]) - "Corrosion-45866-npc:25038-1001 = pull:15.24, 27.08, 141.97"
local timerCorrosion		= mod:NewTargetTimer(10, 45866, nil, "Tank", 2, 5, nil, DBM_COMMON_L.TANK_ICON)
local timerEncaps			= mod:NewTargetTimer(7, 45665, nil, nil, nil, 3)
local timerEncapsCD			= mod:NewCDTimer(30, 45665, nil, nil, nil, 3) -- REVIEW! (Onyxia: [2025-10-09]@[20:58:45]) - "Encapsulate-npc:25038-1001 = pull:32.55"
local timerBreath			= mod:NewCDCountTimer(17, 45717, nil, nil, nil, 3, nil, DBM_COMMON_L.DEADLY_ICON)
local timerPhase			= mod:NewTimer(61, "TimerPhase", 31550, nil, nil, 6) -- (Onyxia: [2025-10-09]@[20:58:45]) - "?-I am stronger than ever before!-npc:Felmyst = pull:61.00"

local berserkTimer			= mod:NewBerserkTimer(mod:IsTimewalking() and 500 or 600)

mod:AddSetIconOption("EncapsIcon", 45665, true, false, {7})
mod:AddSetIconOption("VaporIcon", 45402, true, true, {8})

mod.vb.breathCounter = 0
local encapsulateSpellName = DBM:GetSpellInfo(45661)

function mod:Groundphase()
	DBM:AddSpecialEventToTranscriptorLog("Ground Phase")
	self.vb.breathCounter = 0
	warnPhase:Show(L.Ground)
	timerGasCD:Start(22)
	timerPhase:Start(nil, L.Air)
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
	timerGasCD:Start(20.92-delay)
	timerCorrosionCD:Start(15.2-delay)
	timerPhase:Start(-delay, L.Air)
	berserkTimer:Start(-delay)
	timerEncapsCD:Start(32.55-delay)
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
	local spellId = args.spellId
	if spellId == 45855 then
		timerGasCast:Start()
		timerGasCD:Start()
		specWarnGas:Show()
		specWarnGas:Play("helpdispel")
	end
	if spellId == 45866 then
		timerCorrosionCD:Start()
		specWarnCorrosionHeal:Play("tankheal")
	end
end

function mod:CHAT_MSG_MONSTER_YELL(msg)
	if msg == L.AirPhase or msg:find(L.AirPhase) then
		DBM:AddSpecialEventToTranscriptorLog("Air Phase")
		self.vb.breathCounter = 0
		warnPhase:Show(L.Air)
		timerGasCD:Cancel()
		timerBreath:Start(42, 1)
		timerPhase:Start(105.5, L.Ground) -- REVIEW! One YELL > UNIT_TARGET diff had 97.40 > 202.89 (Onyxia: [2025-10-09]@[20:58:45]) - 105.49
		self:ScheduleMethod(105.5, "Groundphase")
	end
end

function mod:CHAT_MSG_RAID_BOSS_WHISPER(msg)
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
	if spellName == encapsulateSpellName and self:AntiSpam(2, 1) then
		self:BossTargetScanner(25038, "EncapsulateTarget", 0.05, 10)
	end
end
