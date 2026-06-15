local mod	= DBM:NewMod("Zuramat", "DBM-Party-WotLK", 12)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("20220823234921")
mod:SetCreatureID(29314)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_AURA_APPLIED 59743 54361 54343 59745 54524"
)

local warningVoidShift			= mod:NewTargetNoFilterAnnounce(59743, 2)
local warningShroudofDarkness	= mod:NewTargetNoFilterAnnounce(59745, 3)

local specWarnVoidShifted		= mod:NewSpecialWarningYou(54343, nil, nil, nil, 1, 2)
local specWarnShroud			= mod:NewSpecialWarningDispel(59745, "MagicDispeller", nil, nil, 1, 2)

local timerVoidShift			= mod:NewTargetTimer(5, 59743, nil, nil, nil, 3)
local timerVoidShifted			= mod:NewTargetTimer(15, 54343, nil, nil, nil, 5)

mod:GroupSpells(59743, 54343)

function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpellID(59743, 54361) then			-- Void Shift			59743 (HC)  54361 (nonHC)
		warningVoidShift:Show(args.destName)
		timerVoidShift:Start(args.destName)
	elseif args.spellId == 54343 then
		if args:IsPlayer() then
			specWarnVoidShifted:Show()
			specWarnVoidShifted:Play("targetyou")
		end
		timerVoidShifted:Start(args.destName)
	elseif args:IsSpellID(59745, 54524) then		-- Shroud of Darkness	59745 (HC)   54524 (nonHC)
		if self.Options.SpecWarn59745dispel then
			specWarnShroud:Show(args.destName)
			specWarnShroud:Play("dispelboss")
		else
			warningShroudofDarkness:Show(args.destName)
		end
	end
end
