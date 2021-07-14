local mod	= DBM:NewMod("Muru", "DBM-Sunwell")
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 527 $"):sub(12, -3))
mod:SetCreatureID(25741)--25741 Muru, 25840 Entropius
mod:SetModelID(25840)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEvents(
	"SPELL_AURA_APPLIED",
	"SPELL_CAST_SUCCESS",
	"SPELL_SUMMON",
	"UNIT_DIED",
	"UNIT_HEALTH"
)

local warnHuman				= mod:NewAnnounce("WarnHuman", 4)
local warnVoid				= mod:NewAnnounce("WarnVoid", 4, 46087)
local warnDarkness			= mod:NewSpellAnnounce(45996, 2)
local warnPhase2			= mod:NewPhaseAnnounce(2)
local warnFiend				= mod:NewAnnounce("WarnFiend", 2, 46268)
local warnBlackHole			= mod:NewSpellAnnounce(46282, 3)
local specWarnVoid			= mod:NewSpecialWarning("specWarnVoid")
local specWarnBH			= mod:NewSpecialWarning("specWarnBH")
local specWarnVW			= mod:NewSpecialWarning("specWarnVW", mod:IsTank())
local specWarnDarknessSoon	= mod:NewSpecialWarning("specWarnDarknessSoon", mod:IsMelee() or mod:IsTank())
local timerHuman			= mod:NewTimer(60, "TimerHuman")
local timerVoid				= mod:NewTimer(30, "TimerVoid", 46087)
local timerNextDarkness		= mod:NewNextTimer(45, 45996)
local timerDarknessDura		= mod:NewBuffActiveTimer(20, 45996)
local timerBlackHoleCD		= mod:NewCDTimer(15, 46282)
local timerPhase			= mod:NewTimer(6, "TimerPhase", 46087)
local timerSingularity		= mod:NewNextTimer(3.2, 46238)
local berserkTimer			= mod:NewBerserkTimer(600)
local soundDarkness			= mod:NewSound(45996)
local soundBH				= mod:NewSound(46282)
local soundBH3				= mod:NewSound3(46282)
local soundDS5				= mod:NewSound5(45996)

local humanCount = 1
local voidCount = 1
local warned_phase2 = false

local function phase2(self)
	self:SetStage(2)
	warnPhase2:Show()
	warned_phase2 = true
	self:UnscheduleMethod("HumanSpawn")
	self:UnscheduleMethod("VoidSpawn")
	timerBlackHoleCD:Start(15)
	soundBH3:Schedule(15-3)
	if mod.Options.HealthFrame then
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
	self:SetStage(1)
	humanCount = 1
	voidCount = 1
	warned_phase2 = false
	timerHuman:Start(10-delay, humanCount)
	timerVoid:Start(36.5-delay, voidCount)
	specWarnVW:Schedule(31.5)
	timerNextDarkness:Start(47-delay)
	specWarnDarknessSoon:Schedule(42)
	soundDS5:Schedule(42)
	soundDarkness:Schedule(47,"Interface\\AddOns\\DBM-Core\\sounds\\beware.ogg")
	self:ScheduleMethod(10, "HumanSpawn")
	self:ScheduleMethod(36.5, "VoidSpawn")
	berserkTimer:Start(-delay)
end

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 45996 and args:GetDestCreatureID() == 25741 then
		warnDarkness:Show()
		specWarnVoid:Show()
		timerNextDarkness:Start()
		timerDarknessDura:Start()
		soundDS5:Schedule(40)
		soundDarkness:Schedule(45,"Interface\\AddOns\\DBM-Core\\sounds\\beware.ogg")
		specWarnDarknessSoon:Schedule(40)
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if args.spellId == 46177 then
		warned_phase2 =  true
		timerNextDarkness:Cancel()
		timerHuman:Cancel()
		timerVoid:Cancel()
		specWarnVW:Cancel()
		timerPhase:Start()
		specWarnDarknessSoon:Cancel()
		soundDarkness:Cancel()
		soundDS5:Cancel()
		self:Schedule(6, phase2)
	end
end

function mod:SPELL_SUMMON(args)
	if args.spellId == 46268 then
		warnFiend:Show()
	elseif args.spellId == 46282 and self:AntiSpam(2, 1) then
		warnBlackHole:Show()
		specWarnBH:Show()
		soundDarkness:Play("Interface\\AddOns\\DBM-Core\\sounds\\beware.ogg")
		timerBlackHoleCD:Start()
		timerSingularity:Start()
		soundBH3:Schedule(12)
	end
end

function mod:UNIT_DIED(args)
	if self:GetCIDFromGUID(args.destGUID) == 25840 then
		DBM:EndCombat(self)
	end
end

function mod:UNIT_HEALTH(uId)
	if not warned_phase2 and self:GetUnitCreatureId(uId) == 25840 and UnitHealth(uId) / UnitHealthMax(uId) > 0.9 and self.vb.phase == 1 then
		warned_phase2 = true
		timerNextDarkness:Cancel()
		timerHuman:Cancel()
		timerVoid:Cancel()
		specWarnDarknessSoon:Cancel()
		soundDarkness:Cancel()
		soundDS5:Cancel()
		phase2()
	end
end