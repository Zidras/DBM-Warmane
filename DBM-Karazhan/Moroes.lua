local mod	= DBM:NewMod("Moroes", "DBM-Karazhan")
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 7007 $"):sub(12, -3))
mod:SetCreatureID(15687)--Moroes

mod:SetModelID(16540)
mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 29405 35096 29562",
	"SPELL_AURA_APPLIED 29448 29425 34694 29572 37023 37066",
	"SPELL_AURA_REMOVED 34694 29425"
)

local warningVanish			= mod:NewSpellAnnounce(29448, 4)
local warningGarrote		= mod:NewTargetNoFilterAnnounce(37066, 2, nil, "Healer")
local warningGouge			= mod:NewTargetAnnounce(29425, 4)
local warningBlind			= mod:NewTargetAnnounce(34694, 3)
local warningMortalStrike	= mod:NewTargetNoFilterAnnounce(29572, 1, nil, "Tank|Healer")
local warningFrenzy			= mod:NewSpellAnnounce(37023, 4)
local warningManaBurn		= mod:NewCastAnnounce(29405, 3, nil, nil, false)
local warningGreaterHeal	= mod:NewCastAnnounce(35096, 3, nil, nil, "HasInterrupt")
local warningHolyLight		= mod:NewCastAnnounce(29562, 3, nil, nil, "HasInterrupt")

local specWarnGreaterHeal	= mod:NewSpecialWarningInterrupt(35096, "HasInterrupt", nil, nil, 1, 2)
local specWarnHolyLight		= mod:NewSpecialWarningInterrupt(29562, "HasInterrupt", nil, nil, 1, 2)

local timerVanishCD			= mod:NewCDTimer(35.1, 29448, nil, nil, nil, 6)--35.1-51.8
local timerGougeCD			= mod:NewCDTimer(22.6, 29448, nil, "Tank", nil, 6)--22.6-43.6
local timerGouge			= mod:NewTargetTimer(6, 29425, nil, false, nil, 3)
local timerBlind			= mod:NewTargetTimer(10, 34694, nil, false, nil, 3)
local timerMortalStrike		= mod:NewTargetTimer(5, 29572, nil, "Tank|Healer", nil, 5)

function mod:OnCombatStart(delay)
	timerVanishCD:Start(-delay)
	timerGougeCD:Start(-delay)
end

function mod:SPELL_CAST_START(args)
	if args.spellId == 29405 then
		warningManaBurn:Show()
	elseif args.spellId == 35096 then
		if self:CheckInterruptFilter(args.sourceGUID, false, true) then--Only show warning/timer for your own target.
			specWarnGreaterHeal:Show(args.sourceName)
			specWarnGreaterHeal:Play("kickcast")
		else
			warningGreaterHeal:Show()
		end
	elseif args.spellId == 29562 then
		if self:CheckInterruptFilter(args.sourceGUID, false, true) then--Only show warning/timer for your own target.
			specWarnHolyLight:Show(args.sourceName)
			specWarnHolyLight:Play("kickcast")
		else
			warningHolyLight:Show()
		end
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 29448 then
		warningVanish:Show()
		timerVanishCD:Start()
	elseif args.spellId == 29425 then
		warningGouge:Show(args.destName)
		timerGouge:Show(args.destName)
		timerGougeCD:Start()
	elseif args.spellId == 34694 then
		warningBlind:Show(args.destName)
		timerBlind:Show(args.destName)
	elseif args.spellId == 29572 then
		warningMortalStrike:Show(args.destName)
		timerMortalStrike:Show(args.destName)
	elseif args.spellId == 37023 then--Frenzy, he's no longer going to vanish.
		warningFrenzy:Show()
		timerVanishCD:Cancel()
	elseif args.spellId == 37066 then
		warningGarrote:Show(args.destName)
	end
end

function mod:SPELL_AURA_REMOVED(args)
	if args.spellId == 34694 then
		timerBlind:Stop(args.destName)
	elseif args.spellId == 29425 then
		timerGouge:Stop(args.destName)
	end
end
