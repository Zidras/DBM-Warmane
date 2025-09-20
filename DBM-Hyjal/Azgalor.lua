local mod	= DBM:NewMod("Azgalor", "DBM-Hyjal")
local L		= mod:GetLocalizedStrings()

mod:SetRevision("20250920081544")
mod:SetCreatureID(17842)
mod:SetUsedIcons(8)
mod:SetHotfixNoticeRev(20250920000000)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_AURA_APPLIED 31340 31347",
	"SPELL_AURA_REMOVED 31347",
	"SPELL_CAST_SUCCESS 31344 31340"
)

local warnSilence		= mod:NewSpellAnnounce(31344, 3)
local warnDoom			= mod:NewTargetNoFilterAnnounce(31347, 4)

local specWarnFire		= mod:NewSpecialWarningMove(31340, nil, nil, nil, 1, 2)
local specWarnDoom		= mod:NewSpecialWarningYou(31347, nil, nil, nil, 1, 2)
local yellDoom			= mod:NewShortFadesYell(31347)

local timerDoom			= mod:NewTargetTimer(20, 31347, nil, nil, nil, 3)
local timerDoomCD		= mod:NewCDTimer(45, 31347, nil, nil, nil, 3) --new CD added Cafe2024.05.31
local timerSilence		= mod:NewBuffFadesTimer(5, 31344, nil, nil, nil, 2, nil, DBM_COMMON_L.TANK_ICON..DBM_COMMON_L.HEALER_ICON)
local timerSilenceCD		= mod:NewCDTimer(18, 31344, nil, nil, nil, 2, nil, DBM_COMMON_L.TANK_ICON..DBM_COMMON_L.HEALER_ICON)
local timerRoFCD		= mod:NewCDTimer(12, 31340, nil, nil, nil, 3)

local berserkTimer		= mod:NewBerserkTimer(600)

mod:AddSetIconOption("DoomIcon", 31347, true, false, {8})

function mod:OnCombatStart(delay)
	berserkTimer:Start(-delay)
	timerSilenceCD:Start(30-delay) --added estimated start time Cafe2024.05.31
	timerDoomCD:Start(-delay) --added estimated start time Cafe2024.05.31
	timerRoFCD:Start(20-delay) --added estimated start time Cafe2024.07.16
end

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 31340 and args:IsPlayer() and self:AntiSpam() then
		specWarnFire:Show()
		specWarnFire:Play("runaway")
	elseif args.spellId == 31347 then
		timerDoom:Start(args.destName)
		timerDoomCD:Start() --trigger doomCD timer Cafe2024.05.31
		if args:IsPlayer() then
			specWarnDoom:Show()
			specWarnDoom:Play("targetyou")
			yellDoom:Countdown(args.spellId)
		else
			warnDoom:Show(args.destName)
		end
		if self.Options.DoomIcon then
			self:SetIcon(args.destName, 8)
		end
	end
end

function mod:SPELL_AURA_REMOVED(args)
	if args.spellId == 31347 then
		if args:IsPlayer() then
			yellDoom:Cancel()
		end
		if self.Options.DoomIcon then
			self:SetIcon(args.destName, 0)
		end
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if args.spellId == 31344 then
		warnSilence:Show()
		timerSilence:Start()
		timerSilenceCD:Start()
	end	
	if args.spellId == 31340 then
		timerRoFCD:Start()
	end
end
