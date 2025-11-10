local mod	= DBM:NewMod("Kil", "DBM-Sunwell")
local L		= mod:GetLocalizedStrings()

local sformat = string.format

mod:SetRevision("20251101123458")
mod:SetCreatureID(25315)
mod:SetEncounterID(729)
mod:SetUsedIcons(4, 5, 6, 7, 8)

mod:RegisterCombat("yell", L.YellPull)

mod:RegisterEventsInCombat(
	"SPELL_AURA_APPLIED 45641",
	"SPELL_AURA_REMOVED 45641",
	"SPELL_CAST_START 46605 45737 46680 45641",
	"SPELL_CAST_SUCCESS 45680 45848 45892 46589",
	"CHAT_MSG_MONSTER_YELL"
)

local warnBloom			= mod:NewTargetAnnounce(45641, 2)
local warnDarkOrb		= mod:NewAnnounce("WarnDarkOrb", 4, 45109)
local warnDart			= mod:NewSpellAnnounce(45740, 3)
local warnShield		= mod:NewSpellAnnounce(45848, 1)
local warnBlueOrb		= mod:NewAnnounce("WarnBlueOrb", 1, 45109)
local warnSpikeTarget	= mod:NewTargetAnnounce(46589, 3)
local warnPhase2		= mod:NewPhaseAnnounce(2)
local warnPhase3		= mod:NewPhaseAnnounce(3)
local warnPhase4		= mod:NewPhaseAnnounce(4)

local specWarnSpike		= mod:NewSpecialWarningMove(46589)
local yellSpike			= mod:NewYellMe(46589)
local specWarnBloom		= mod:NewSpecialWarningYou(45641, nil, nil, nil, 1, 2)
local yellBloom			= mod:NewYellMe(45641)
local specWarnBomb		= mod:NewSpecialWarningMoveTo(46605, nil, nil, nil, 3, 2)--findshield
local specWarnShield	= mod:NewSpecialWarningSpell(45848)
local specWarnDarkOrb	= mod:NewSpecialWarning("SpecWarnDarkOrb", false)
local specWarnBlueOrb	= mod:NewSpecialWarning("SpecWarnBlueOrb", false)

local timerBloomCD		= mod:NewVarTimer("v20-25", 45641, nil, nil, nil, 2) -- SPELL_CAST_START: (Onyxia: 25m [2025-10-12]@[22:27:20] || [2025-10-30]@[22:06:43]) - "Fire Bloom-45641-npc:25315-2148 = pull:18.13/[Stage 1/0.00] 18.13, 22.65, Stage 2/7.59, 42.43/50.02, 20.01" || "Fire Bloom-45641-npc:25315-2578 = pull:7.53/[Stage 1/0.00] 7.53, 22.66, Stage 2/11.11, 42.38/53.49, 20.15, 24.00, 20.02, Stage 3/7.57, 42.39/49.96, 20.58, 24.95, Stage 4/22.66, 66.18/88.84"
local timerDartCD		= mod:NewCDTimer(20, 45740, nil, nil, nil, 2)--Targeted or aoe?
local timerBomb			= mod:NewCastTimer(9, 46605, nil, nil, nil, 2, nil, DBM_COMMON_L.DEADLY_ICON)
local timerBombCD		= mod:NewCDTimer(45, 46605, nil, nil, nil, 2, nil, DBM_COMMON_L.DEADLY_ICON) -- SPELL_CAST_START: (Onyxia: 25m [2025-10-30]@[22:06:43]) - "Darkness of a Thousand Souls-46605-npc:25315-2578 = pull:115.97/[Stage 1/0.00, Stage 2/41.29] 74.68/115.97, Stage 3/39.44, 75.11/114.55, Stage 4/35.46, 53.40/88.86, 25.90"
local timerSpike		= mod:NewCastTimer(28.75, 46680, nil, nil, nil, 3)
local timerBlueOrb		= mod:NewTimer(32.5, "TimerBlueOrb", 45109, nil, nil, 5) -- phase 2: 32.48 || 32.5 || 32.48 || 32.51

local berserkTimer		= mod:NewBerserkTimer(mod:IsTimewalking() and 600 or 900)

mod:AddRangeFrameOption("12")
mod:AddSetIconOption("BloomIcon", 45641, true, false, {4, 5, 6, 7, 8})

local warnBloomTargets = {}
local orbGUIDs = {}
mod.vb.bloomIcon = 8

local function showBloomTargets(self)
	warnBloom:Show(table.concat(warnBloomTargets, "<, >"))
	table.wipe(warnBloomTargets)
	self.vb.bloomIcon = 8
end

function mod:OnCombatStart(delay)
	table.wipe(warnBloomTargets)
	table.wipe(orbGUIDs)
	self.vb.bloomIcon = 8
	self:SetStage(1)
	timerBloomCD:Start(sformat("v%s-%s", 7.53-delay, 18.13-delay))
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
			self:SetIcon(args.destName, self.vb.bloomIcon)
		end
		self.vb.bloomIcon = self.vb.bloomIcon - 1
		if args:IsPlayer() then
			specWarnBloom:Show()
			specWarnBloom:Play("targetyou")
			yellBloom:Yell()
		end
		if #warnBloomTargets >= 5 then
			showBloomTargets(self)
		else
			self:Schedule(0.3, showBloomTargets, self)
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
		specWarnBomb:Show(SHIELDSLOT)
		specWarnBomb:Play("findshield")
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
	elseif args.spellId == 45641 then -- Fire Bloom
		timerBloomCD:Start()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if args.spellId == 45680 and not orbGUIDs[args.sourceGUID] then
		orbGUIDs[args.sourceGUID] = true
		if self:AntiSpam(5, 1) then
			warnDarkOrb:Show()
			specWarnDarkOrb:Show()
		end
	elseif args.spellId == 45848 then
		warnShield:Show()
		specWarnShield:Show()
	elseif args.spellId == 45892 then
		self:SetStage(0)
		if self.vb.phase == 2 then
			warnPhase2:Show()
			timerBlueOrb:Start()
			timerDartCD:Start("v47.16-54.57") -- 47.16-54.57
			timerBombCD:Start(74.68) -- REVIEW! variance? Changed script from 71.46-71.59?
		elseif self.vb.phase == 3 then
			warnPhase3:Show()
			timerBlueOrb:Cancel()
			timerDartCD:Cancel()
			timerBombCD:Cancel()
			timerBlueOrb:Start()
			timerDartCD:Start(48.7)
			timerBombCD:Start(75.11) -- REVIEW! variance?
		elseif self.vb.phase == 4 then
			warnPhase4:Show()
			timerBlueOrb:Cancel()
			timerDartCD:Cancel()
			timerBombCD:Cancel()
			timerBlueOrb:Start(45)
			timerDartCD:Start(49)
			timerBombCD:Start(53.4) -- REVIEW! variance?
		end
	elseif args.spellId == 46589 and args.destName ~= nil then
		if args.destName == UnitName("player") then
			specWarnSpike:Show()
			yellSpike:Yell()
		else
			warnSpikeTarget:Show(args.destName)
		end
	end
end

function mod:CHAT_MSG_MONSTER_YELL(msg)
	if msg == L.OrbYell1 or msg:find(L.OrbYell1) or msg == L.OrbYell2 or msg:find(L.OrbYell2) or msg == L.OrbYell3 or msg:find(L.OrbYell3) or msg == L.OrbYell4 or msg:find(L.OrbYell4) then
		warnBlueOrb:Show()
		specWarnBlueOrb:Show()
	end
end
