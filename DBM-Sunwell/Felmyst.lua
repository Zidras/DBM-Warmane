local mod	= DBM:NewMod("Felmyst", "DBM-Sunwell")
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 531 $"):sub(12, -3))
mod:SetCreatureID(25038)

mod:SetZone()
mod:SetUsedIcons(8)

mod:RegisterCombat("combat")

mod:RegisterEvents(
	"SPELL_AURA_APPLIED",
	"SPELL_CAST_START",
	"SPELL_SUMMON",
	"RAID_BOSS_EMOTE",
	"CHAT_MSG_MONSTER_YELL",
	"CHAT_MSG_RAID_BOSS_EMOTE",
	"UNIT_AURA"
)

local warnGas				= mod:NewSpellAnnounce(45855, 3)
local warnCorrosion			= mod:NewTargetAnnounce(45866, 2)
local warnEncaps			= mod:NewTargetAnnounce(45665, 4)
local warnVapor				= mod:NewTargetAnnounce(45392, 3)
local warnBreath			= mod:NewCountAnnounce(45717, 4)
local warnPhase				= mod:NewAnnounce("WarnPhase", 1, 31550)

local specWarnGas			= mod:NewSpecialWarningSpell(45855, mod:IsHealer())
local specWarnCorrosion		= mod:NewSpecialWarningTarget(45866, mod:IsHealer() or mod:IsTank())
local specWarnEncaps		= mod:NewSpecialWarningYou(45665)
local specWarnEncapsNear	= mod:NewSpecialWarningClose(45665)
local specWarnVapor			= mod:NewSpecialWarningYou(45392)
local specWarnBreath		= mod:NewSpecialWarningSpell(45717, nil, nil, nil, 3)

local yellEncaps			= mod:NewYellMe(45665)

local timerGas				= mod:NewCastTimer(1, 45855)
local timerGasCD			= mod:NewCDTimer(19, 45855)
local timerCorrosion		= mod:NewTargetTimer(10, 45866)
local timerEncaps			= mod:NewTargetTimer(7, 45665)
local timerEncapsCD			= mod:NewCDTimer(50, 45665)
local timerBreath			= mod:NewCDCountTimer(20, 45717)
local timerPhase			= mod:NewTimer(60, "TimerPhase", 31550)

local berserkTimer			= mod:NewBerserkTimer(600)

mod:AddBoolOption("EncapsIcon", true)
mod:AddBoolOption("VaporIcon", true)


local encaura = GetSpellInfo(45665)

local breathCounter = 0

function mod:Groundphase()
	breathCounter = 0
	warnPhase:Show(L.Ground)
	timerGasCD:Start(17)
	timerPhase:Start(60, L.Air)
	timerEncapsCD:Start()
end

function mod:EncapsulateTarget(targetname, uId)
	if not targetname then return end
	timerEncapsCD:Cancel()
	warnEncaps:Show(targetname)
	timerEncaps:Start(targetname)
	if self.Options.EncapsIcon then
		self:SetIcon(targetname, 8, 6)
	end
	if targetname == UnitName("player") then
		specWarnEncaps:Show()
		yellEncaps:Yell()
	elseif uId then
		local x, y = GetPlayerMapPosition(uId)
		if x == 0 and y == 0 then
			SetMapToCurrentZone()
			x, y = GetPlayerMapPosition(uId)
		end
		local inRange = CheckInteractDistance(uId, 4)
		if inRange then
			specWarnEncapsNear:Show(targetname)
		end
	end
end

function mod:OnCombatStart(delay)
	breathCounter = 0
	timerGasCD:Start(16-delay)
	timerPhase:Start(-delay, L.Air)
	berserkTimer:Start(-delay)
	timerEncapsCD:Start()
end


function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 45866 then
		warnCorrosion:Show(args.destName)
		timerCorrosion:Start(args.destName)
		specWarnCorrosion:Show(args.destName)
	end
end

function mod:SPELL_SUMMON(args)
	if args.spellId == 45392 then
		warnVapor:Show(args.sourceName)
		if args.sourceName == UnitName("player") then
			specWarnVapor:Show()
		end
		if self.Options.VaporIcon then
			self:SetIcon(args.sourceName, 8, 10)
		end
	end
end

function mod:SPELL_CAST_START(args)
	if args.spellId == 45855 then
		warnGas:Show()
		timerGas:Start()
		timerGasCD:Start()
		specWarnGas:Show()
	end
end

function mod:CHAT_MSG_MONSTER_YELL(msg)
	if msg == L.AirPhase or msg:find(L.AirPhase) then
		breathCounter = 0
		warnPhase:Show(L.Air)
		timerGasCD:Cancel()
		timerBreath:Start(42, 1)
		timerPhase:Start(118, L.Ground)
		self:ScheduleMethod(118, "Groundphase")
	end
end

function mod:CHAT_MSG_RAID_BOSS_EMOTE(msg)
	if msg == L.Breath or msg:find(L.Breath) then
		breathCounter = breathCounter + 1
		warnBreath:Show(breathCounter)
		specWarnBreath:Show()
		if breathCounter < 3 then
			timerBreath:Start(nil, breathCounter+1)
		end
	end
end


function mod:UNIT_AURA(uId)
	local name = DBM:GetUnitFullName(uId)
	if (not name) then return end
	local _, _, _, _, _, _, expires, _, _, _, spellId = UnitDebuff(uId, encaura)
	if not spellId or not expires then return end
	if (spellId == 45665 or spellId == 45661) and expires > 0 and self:AntiSpam(10, 1) then
		mod:EncapsulateTarget(name, uId)
	end
end
