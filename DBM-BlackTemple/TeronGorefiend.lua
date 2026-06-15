local mod	= DBM:NewMod("TeronGorefiend", "DBM-BlackTemple")
local L		= mod:GetLocalizedStrings()

mod:SetRevision("20230129114417")
mod:SetCreatureID(22871)

mod:SetModelID(21254)
mod:SetUsedIcons(4, 5, 6, 7, 8)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_AURA_APPLIED 40243 40251",
	"SPELL_AURA_REMOVED 40243 40251",
	"SPELL_CAST_SUCCESS 40239"
)

--Incinerate useful?
local warnCrushed			= mod:NewTargetNoFilterAnnounce(40243, 3, nil, "Healer")
local warnIncinerate		= mod:NewSpellAnnounce(40239, 3)
local warnDeath				= mod:NewTargetNoFilterAnnounce(40251, 3)

local specWarnDeath			= mod:NewSpecialWarningYou(40251, nil, nil, nil, 1, 2)
local specWarnDeathEnding	= mod:NewSpecialWarningMoveAway(40251, nil, nil, nil, 3, 2)

local timerCrushed			= mod:NewBuffActiveTimer(15, 40243, nil, "Healer", 2, 5, nil, DBM_COMMON_L.HEALER_ICON)
local timerDeathCD			= mod:NewCDTimer(32, 40251, nil, nil, nil, 3)--32-40 (small sample size, could be bigger range)
local timerDeath			= mod:NewTargetTimer(55, 40251, nil, nil, nil, 3)
local timerVengefulSpirit	= mod:NewTimer(60, "TimerVengefulSpirit", 40325, nil, nil, 1)

local berserkTimer			= mod:NewBerserkTimer(300)

mod:AddSetIconOption("CrushIcon", 40243, false, false, {1, 2, 3, 4, 5})

local CrushedTargets = {}
mod.vb.crushIcon = 1

local function showCrushedTargets(self)
	warnCrushed:Show(table.concat(CrushedTargets, "<, >"))
	table.wipe(CrushedTargets)
	self.vb.crushIcon = 1
end

function mod:OnCombatStart(delay)
	berserkTimer:Start(-delay)
	table.wipe(CrushedTargets)
	timerDeathCD:Start(11.1-delay)--11-13?
end

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 40243 then
		CrushedTargets[#CrushedTargets + 1] = args.destName
		timerCrushed:Start()
		self:Unschedule(showCrushedTargets)
		if self.Options.CrushIcon then
			self:SetIcon(args.destName, self.vb.crushIcon, 15)
			self.vb.crushIcon = self.vb.crushIcon + 1
		end
		self:Schedule(0.5, showCrushedTargets, self)
	elseif args.spellId == 40251 then
		timerDeath:Start(args.destName)
		if args:IsPlayer() then
			specWarnDeath:Show()
			specWarnDeath:Play("targetyou")
			specWarnDeathEnding:Schedule(50)
			specWarnDeathEnding:ScheduleVoice(50, "runout")
		else
			warnDeath:Show(args.destName)
		end
	end
end

function mod:SPELL_AURA_REMOVED(args)
	if args.spellId == 40243 then
		if self.Options.CrushIcon then
			self:SetIcon(args.destName, 0)
		end
	elseif args.spellId == 40251 then
		timerDeath:Stop(args.destName)
		timerVengefulSpirit:Start(args.destName)
		if args:IsPlayer() then
			specWarnDeathEnding:Cancel()
			specWarnDeathEnding:CancelVoice()
		end
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if args.spellId == 40239 then
		warnIncinerate:Show()
	elseif args.spellId == 40251 then
		timerDeathCD:Start()
	end
end
