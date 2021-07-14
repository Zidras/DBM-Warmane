local mod	= DBM:NewMod("Kil", "DBM-Sunwell")
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 527 $"):sub(12, -3))
mod:SetCreatureID(25315)

mod:SetZone()
mod:SetUsedIcons(4, 5, 6, 7, 8)

mod:RegisterCombat("yell", L.YellPull)

mod:RegisterEvents(
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_REMOVED",
	"SPELL_CAST_START",
	"SPELL_CAST_SUCCESS",
	"CHAT_MSG_MONSTER_YELL",
	"SPELL_DAMAGE"
)

local warnBloom			= mod:NewTargetAnnounce(45641, 2)
local warnDarkOrb		= mod:NewAnnounce("WarnDarkOrb", 4, 45109)
local warnDart			= mod:NewSpellAnnounce(45740, 3)
local warnBomb			= mod:NewCastAnnounce(46605, 4, 8)
local warnShield		= mod:NewSpellAnnounce(45848, 3)
local warnBlueOrb		= mod:NewAnnounce("WarnBlueOrb", 1, 45109)
local warnPhase2		= mod:NewPhaseAnnounce(2)
local warnPhase3		= mod:NewPhaseAnnounce(3)
local warnPhase4		= mod:NewPhaseAnnounce(4)

local warnSpikeTarget	= mod:NewTargetAnnounce(46589, 3)
local specWarnSpike		= mod:NewSpecialWarningMove(46589)
local specWarnBloom		= mod:NewSpecialWarningMoveAway(45641)
local specWarnBomb		= mod:NewSpecialWarningSpell(46605, nil, nil, nil, 3)
local specWarnShield	= mod:NewSpecialWarningSpell(45848)
local specWarnDarkOrb	= mod:NewSpecialWarning("SpecWarnDarkOrb", true)
local specWarnBlueOrb	= mod:NewSpecialWarning("SpecWarnBlueOrb", true)

local yellBloom			= mod:NewYellMe(45641)
local yellSpike			= mod:NewYellMe(46589)
local timerBloomCD		= mod:NewCDTimer(20, 45641)
local timerDartCD		= mod:NewCDTimer(20, 45740)
local timerBomb			= mod:NewCastTimer(9, 46605)
local timerBombCD		= mod:NewCDTimer(45, 46605)
local timerSpike		= mod:NewCastTimer(28, 46680)
local timerBlueOrb		= mod:NewTimer(37, "TimerBlueOrb", 45109)
local berserkTimer		= mod:NewBerserkTimer(900)

mod:AddBoolOption("BloomIcon", true)
mod:AddBoolOption("RangeFrame", true)

local warnBloomTargets = {}
local orbGUIDs = {}
local bloomIcon = 8

local function showBloomTargets()
	warnBloom:Show(table.concat(warnBloomTargets, "<, >"))
	table.wipe(warnBloomTargets)
	bloomIcon = 8
	timerBloomCD:Start()
end

function mod:OnCombatStart(delay)
	table.wipe(warnBloomTargets)
	table.wipe(orbGUIDs)
	bloomIcon = 8
	self:SetStage(1)
	berserkTimer:Start(-delay)
	if self.Options.RangeFrame then
		DBM.RangeCheck:Show()
	end
end

function mod:OnCombatEnd()
	if self.Options.RangeFrame then
		DBM.RangeCheck:Hide()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 45641 then
		warnBloomTargets[#warnBloomTargets + 1] = args.destName
		self:Unschedule(showBloomTargets)
		if self.Options.BloomIcon then
			self:SetIcon(args.destName, bloomIcon)
			bloomIcon = bloomIcon - 1
		end
		if args:IsPlayer() then
			specWarnBloom:Show()
			yellBloom:Yell()
		end
		if #warnBloomTargets >= 5 then
			showBloomTargets()
		else
			self:Schedule(0.3, showBloomTargets)
		end
	end
end

function mod:SPELL_AURA_REMOVED(args)
	if args.spellId == 45641 then
		if self.Options.BloomIcon then
			self:SetIcon(args.destName, 0)
		end
	end
end

function mod:SPELL_CAST_START(args)
	if args.spellId == 46605 then
		warnBomb:Show()
		specWarnBomb:Show()
		timerBomb:Start()
		if self.vb.phase == 4 then
			timerBombCD:Start(25)
		else
			timerBombCD:Start()
		end
	elseif args.spellId == 45737 then
		warnDart:Show()
		timerDartCD:Start()
	elseif args.spellId == 46680 then
		timerSpike:Start()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if args.spellId == 45680 and not orbGUIDs[args.sourceGUID] then
		orbGUIDs[args.sourceGUID] = true
		warnDarkOrb:Show()
		specWarnDarkOrb:Show()
	elseif args.spellId == 45848 then
		warnShield:Show()
		specWarnShield:Show()
	elseif args.spellId == 46589 and args.destName ~= nil then
		warnSpikeTarget:Show(args.destName)
		if args.destName == UnitName("player") then
			specWarnSpike:Show()
			yellSpike:Yell()
		end
	end
end

function mod:CHAT_MSG_MONSTER_YELL(msg)
	if msg == L.OrbYell1 or msg:find(L.OrbYell1) or msg == L.OrbYell2 or msg:find(L.OrbYell2) or msg == L.OrbYell3 or msg:find(L.OrbYell3) or msg == L.OrbYell4 or msg:find(L.OrbYell4) then
		warnBlueOrb:Show()
		specWarnBlueOrb:Show()
	elseif msg == L.ReflectionYell1 or msg:find(L.ReflectionYell1) or msg == L.ReflectionYell2 or msg:find(L.ReflectionYell2) then
		self:SetStage(0)
		if self.vb.phase == 2 then
			warnPhase2:Show()
			timerBlueOrb:Start()
			timerDartCD:Start(59)
			timerBombCD:Start(77)
		elseif self.vb.phase == 3 then
			warnPhase3:Show()
			timerBlueOrb:Cancel()
			timerDartCD:Cancel()
			timerBombCD:Cancel()
			timerBlueOrb:Start()
			timerDartCD:Start(59)
			timerBombCD:Start(77)
		elseif self.vb.phase == 4 then
			warnPhase4:Show()
			timerBlueOrb:Cancel()
			timerDartCD:Cancel()
			timerBombCD:Cancel()
			timerBlueOrb:Start(45)
			timerDartCD:Start(49)
			timerBombCD:Start(58)
		end
	end
end

function mod:SPELL_DAMAGE(args)
	if args.spellId == 45680 and not orbGUIDs[args.sourceGUID] then
		orbGUIDs[args.sourceGUID] = true
		warnDarkOrb:Show()
		specWarnDarkOrb:Show()
	end
end