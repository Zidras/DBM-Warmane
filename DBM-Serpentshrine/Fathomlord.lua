local mod	= DBM:NewMod("Fathomlord", "DBM-Serpentshrine")
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 7007 $"):sub(12, -3))
mod:SetCreatureID(21214)

mod:SetModelID(20662)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_AURA_APPLIED 38451 38452 38455",
	"SPELL_CAST_START 38330",
	"SPELL_SUMMON 38236"
)

local warnCariPower		= mod:NewSpellAnnounce(38451, 3)
local warnTidalPower	= mod:NewSpellAnnounce(38452, 3)
local warnSharPower		= mod:NewSpellAnnounce(38455, 3)

local specWarnHeal		= mod:NewSpecialWarningInterrupt(38330, "HasInterrupt", nil, nil, 1, 2)
local specWarnTotem		= mod:NewSpecialWarningSwitch(38236, "Dps", nil, nil, 1, 2)

local berserkTimer		= mod:NewBerserkTimer(600)

function mod:OnCombatStart(delay)
	berserkTimer:Start(-delay)
end

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 38451 then
		warnCariPower:Show()
	elseif args.spellId == 38452 then
		warnTidalPower:Show()
	elseif args.spellId == 38455 then
		warnSharPower:Show()
	end
end

function mod:SPELL_CAST_START(args)
	if args.spellId == 38330 then
		if self:CheckInterruptFilter(args.sourceGUID) then
			specWarnHeal:Show(args.sourceName)
			specWarnHeal:Play("kickcast")
		end
	end
end

function mod:SPELL_SUMMON(args)
	if args.spellId == 38236 then
		specWarnTotem:Show()
		specWarnTotem:Play("attacktotem")
	end
end
