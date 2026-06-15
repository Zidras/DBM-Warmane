local mod	= DBM:NewMod(570, "DBM-Party-BC", 4, 260)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("20220518110528")
mod:SetCreatureID(17941)

mod:SetModelID(17728)
mod:SetModelOffset(-0.4, 0, -0.3)
mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_SUMMON 31991 31985 34980"
)

--TODO, add a switch warning for the totem you actually want to kill (healing one probably)
local WarnStoneskinTotem		= mod:NewSpellAnnounce(31985, 2)
local WarnHealingWard			= mod:NewSpellAnnounce(34980, 3)

local specWarnCorruptedNova		= mod:NewSpecialWarningMove(31991, false, nil, nil, 1, 2)

function mod:SPELL_SUMMON(args)
	if args.spellId == 31991 then
		specWarnCorruptedNova:Show()
		specWarnCorruptedNova:Play("runaway")
	elseif args.spellId == 31985 then
		WarnStoneskinTotem:Show()
	elseif args.spellId == 34980 then
		WarnHealingWard:Show()
	end
end
