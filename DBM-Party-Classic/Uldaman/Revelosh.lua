local mod	= DBM:NewMod(467, "DBM-Party-Classic", 18, 239)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("20220518110528")
mod:SetCreatureID(6910)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 16006 15801"
)

local specWarnChainLightning			= mod:NewSpecialWarningInterrupt(16006, "HasInterrupt", nil, nil, 1, 2)
local specWarnLightningBolt				= mod:NewSpecialWarningInterrupt(15801, false, nil, nil, 1, 2)

local timerChainLightningCD				= mod:NewAITimer(180, 16006, nil, nil, nil, 4, nil, DBM_COMMON_L.INTERRUPT_ICON)
local timerLightningBoltCD				= mod:NewAITimer(180, 15801, nil, nil, nil, 4, nil, DBM_COMMON_L.INTERRUPT_ICON)

function mod:OnCombatStart(delay)
	timerChainLightningCD:Start(1-delay)
	timerLightningBoltCD:Start(1-delay)
end

function mod:SPELL_CAST_START(args)
	if args.spellId == 16006 and args:IsSrcTypeHostile() then
		timerChainLightningCD:Start()
		if self:CheckInterruptFilter(args.sourceGUID, false, true) then
			specWarnChainLightning:Show(args.sourceName)
			specWarnChainLightning:Play("kickcast")
		end
	elseif args.spellId == 15801 and args:IsSrcTypeHostile() then
		timerLightningBoltCD:Start()
		if self:CheckInterruptFilter(args.sourceGUID, false, true) then
			specWarnLightningBolt:Show(args.sourceName)
			specWarnLightningBolt:Play("kickcast")
		end
	end
end
