local mod	= DBM:NewMod(471, "DBM-Party-Classic", 18, 239)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("20220518110528")
mod:SetCreatureID(7291)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 6725 3356 11969"
)

local warningFireNova				= mod:NewSpellAnnounce(11969, 2)

local specWarnFlameSpike			= mod:NewSpecialWarningInterrupt(6725, "HasInterrupt", nil, nil, 1, 2)
local specWarnFlameLash				= mod:NewSpecialWarningInterrupt(3356, "HasInterrupt", nil, nil, 1, 2)

local timerFireNovaCD				= mod:NewAITimer(180, 11969, nil, nil, nil, 2)

function mod:OnCombatStart(delay)
	timerFireNovaCD:Start(1-delay)
end

function mod:SPELL_CAST_START(args)
	if args.spellId == 6725 then
		if self:CheckInterruptFilter(args.sourceGUID, false, true) then
			specWarnFlameSpike:Show(args.sourceName)
			specWarnFlameSpike:Play("kickcast")
		end
	elseif args.spellId == 3356 then
		if self:CheckInterruptFilter(args.sourceGUID, false, true) then
			specWarnFlameLash:Show(args.sourceName)
			specWarnFlameLash:Play("kickcast")
		end
	elseif args.spellId == 11969 then
		warningFireNova:Show()
		timerFireNovaCD:Start()
	end
end
