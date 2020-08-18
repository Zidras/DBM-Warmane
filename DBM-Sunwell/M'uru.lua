local mod	= DBM:NewMod("Muru", "DBM-Sunwell")
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 527 $"):sub(12, -3))
mod:SetCreatureID(25741)--25741 Muru, 25840 Entropius
mod:SetModelID(23404)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEvents(
	"SPELL_AURA_APPLIED",
	"SPELL_CAST_SUCCESS",
	"SPELL_SUMMON",
	"UNIT_DIED"
)

local warnHuman			= mod:NewAnnounce("WarnHuman", 4)
local warnVoid			= mod:NewAnnounce("WarnVoid", 4, 46087)
local warnDarkness		= mod:NewSpellAnnounce(45996, 2)
local warnPhase2		= mod:NewPhaseAnnounce(2)
local warnFiend			= mod:NewAnnounce("WarnFiend", 2, 46268)
local warnBlackHole		= mod:NewSpellAnnounce(46282, 3)
local specWarnVoid		= mod:NewSpecialWarning("specWarnVoid")
local specWarnBH		= mod:NewSpecialWarning("specWarnBH")
local specWarnVW		= mod:NewSpecialWarning("specWarnVW", mod:IsTank())
local specWarnDarknessSoon	= mod:NewSpecialWarning("specWarnDarknessSoon", mod:IsMelee() or mod:IsTank())
local timerHuman		= mod:NewTimer(60, "TimerHuman")
local timerVoid			= mod:NewTimer(30, "TimerVoid", 46087)
local timerNextDarkness	= mod:NewNextTimer(45, 45996)
local timerBlackHoleCD	= mod:NewCDTimer(15, 46282)
local timerPhase		= mod:NewTimer(10, "TimerPhase", 46087)

local berserkTimer		= mod:NewBerserkTimer(600)

mod:AddBoolOption("SoundWarnCountingMC", true)

local humanCount = 1
local voidCount = 1

function mod:ToMC5()
	PlaySoundFile("Interface\\AddOns\\DBM-Core\\sounds\\5.mp3", "Master")
end

function mod:ToMC4()
	PlaySoundFile("Interface\\AddOns\\DBM-Core\\sounds\\4.mp3", "Master")
end

function mod:ToMC3()
	PlaySoundFile("Interface\\AddOns\\DBM-Core\\sounds\\3.mp3", "Master")
end

function mod:ToMC2()
	PlaySoundFile("Interface\\AddOns\\DBM-Core\\sounds\\2.mp3", "Master")
end

function mod:ToMC1()
	PlaySoundFile("Interface\\AddOns\\DBM-Core\\sounds\\1.mp3", "Master")
end

function mod:ToMC0()
	PlaySoundFile("Interface\\AddOns\\DBM-Core\\sounds\\Alarm.ogg", "Master")
end

local function phase2()
	warnPhase2:Show()
	mod:UnscheduleMethod("HumanSpawn")
	mod:UnscheduleMethod("VoidSpawn")
	timerBlackHoleCD:Start(17)
	if self.Options.HealthFrame then
		DBM.BossHealth:Clear()
		DBM.BossHealth:AddBoss(25840, L.Entropius)
	end
end

function mod:HumanSpawn()
	warnHuman:Show(humanCount)
	humanCount = humanCount + 1
	timerHuman:Start(nil, humanCount)
	self:ScheduleMethod(60, "HumanSpawn")
end

function mod:VoidSpawn()
	warnVoid:Show(voidCount)
	voidCount = voidCount + 1
	timerVoid:Start(nil, voidCount)
	specWarnVW:Schedule(25)
	self:ScheduleMethod(30, "VoidSpawn")
end

function mod:OnCombatStart(delay)
	humanCount = 1
	voidCount = 1
	timerHuman:Start(10-delay, humanCount)
	timerVoid:Start(36.5-delay, voidCount)
	specWarnVW:Schedule(31.5)
	timerNextDarkness:Start(47-delay)
	specWarnDarknessSoon:Schedule(42)
	if self.Options.SoundWarnCountingMC then
		self:ScheduleMethod(42, "ToMC5")
		self:ScheduleMethod(43, "ToMC4")
		self:ScheduleMethod(44, "ToMC3")
		self:ScheduleMethod(45, "ToMC2")
		self:ScheduleMethod(46, "ToMC1")
		self:ScheduleMethod(47, "ToMC0")
	end
	self:ScheduleMethod(10, "HumanSpawn")
	self:ScheduleMethod(36.5, "VoidSpawn")
	berserkTimer:Start(-delay)
end

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 45996 and args:GetDestCreatureID() == 25741 then
		warnDarkness:Show()
		specWarnVoid:Show()
		timerNextDarkness:Start()
		if self.Options.SoundWarnCountingMC then
			self:ScheduleMethod(40, "ToMC5")
			self:ScheduleMethod(41, "ToMC4")
			self:ScheduleMethod(42, "ToMC3")
			self:ScheduleMethod(43, "ToMC2")
			self:ScheduleMethod(44, "ToMC1")
			self:ScheduleMethod(45, "ToMC0")
		end
		specWarnDarknessSoon:Schedule(40)
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if args.spellId == 46177 then
		timerNextDarkness:Cancel()
		timerHuman:Cancel()
		timerVoid:Cancel()
		timerPhase:Start()
		self:Schedule(10, phase2)
	end
end

function mod:SPELL_SUMMON(args)
	if args.spellId == 46268 then
		warnFiend:Show()
	elseif args.spellId == 46282 then
		warnBlackHole:Show()
		specWarnBH:Show()
		timerBlackHoleCD:Start()
	end
end

function mod:UNIT_DIED(args)
	if self:GetCIDFromGUID(args.destGUID) == 25840 then
		DBM:EndCombat(self)
	end
end