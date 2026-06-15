local mod	= DBM:NewMod(481, "DBM-Party-Classic", 19, 240)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("20220518110528")
mod:SetCreatureID(3654)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 7967",
	"SPELL_CAST_SUCCESS 7399 8150",
	"SPELL_AURA_APPLIED 7399"
)

-- local warningNaralexsNightmare		= mod:NewTargetNoFilterAnnounce(7967, 2)
local warningTerrify				= mod:NewTargetNoFilterAnnounce(7399, 2)

local specWarnNaralexsNightmare		= mod:NewSpecialWarningInterrupt(7967, "HasInterrupt", nil, nil, 1, 2)

local timerNaralexsNightmareCD		= mod:NewAITimer(180, 7967, nil, nil, nil, 4, nil, DBM_COMMON_L.INTERRUPT_ICON..DBM_COMMON_L.MAGIC_ICON)
local timerTerrifyCD				= mod:NewAITimer(180, 7399, nil, nil, nil, 3, nil, DBM_COMMON_L.MAGIC_ICON)
local timerThundercrackCD			= mod:NewAITimer(180, 8150, nil, nil, nil, 2, nil, DBM_COMMON_L.HEALER_ICON..DBM_COMMON_L.MAGIC_ICON)

function mod:OnCombatStart(delay)
	timerNaralexsNightmareCD:Start(1-delay)
	timerTerrifyCD:Start(1-delay)
	timerThundercrackCD:Start(1-delay)
end

function mod:SPELL_CAST_START(args)
	if args.spellId == 7967 then
		timerNaralexsNightmareCD:Start()
		if self:CheckInterruptFilter(args.sourceGUID, false, true) then
			specWarnNaralexsNightmare:Show(args.sourceName)
			specWarnNaralexsNightmare:Play("kickcast")
		end
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if args.spellId == 7399 then
		timerTerrifyCD:Start()
	elseif args.spellId == 8150 then
		timerThundercrackCD:Start()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 7399 then
		warningTerrify:Show(args.destName)
	end
end
