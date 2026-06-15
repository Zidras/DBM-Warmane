local mod	= DBM:NewMod("MordreshFireEye", "DBM-Party-Classic", 10)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("20220518110528")
mod:SetCreatureID(7357)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 12466",
	"SPELL_CAST_SUCCESS 12470"
)

local warningFireNova			= mod:NewSpellAnnounce(12470, 2)

local specWarnFireball			= mod:NewSpecialWarningInterrupt(12466, "HasInterrupt", nil, nil, 1, 2)

local timerFireballCD			= mod:NewAITimer(180, 12466, nil, nil, nil, 4, nil, DBM_COMMON_L.INTERRUPT_ICON)
local timerFireNovaCD			= mod:NewAITimer(180, 12470, nil, nil, nil, 5, nil, DBM_COMMON_L.HEALER_ICON)

function mod:OnCombatStart(delay)
	timerFireballCD:Start(1-delay)
	timerFireNovaCD:Start(1-delay)
end

function mod:SPELL_CAST_START(args)
	if args.spellId == 12466 and args:IsSrcTypeHostile() then
		timerFireballCD:Start()
		if self:CheckInterruptFilter(args.sourceGUID, false, true) then
			specWarnFireball:Show(args.sourceName)
			specWarnFireball:Play("kickcast")
		end
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if args.spellId == 12470 then
		warningFireNova:Show()
		timerFireNovaCD:Start()
	end
end
