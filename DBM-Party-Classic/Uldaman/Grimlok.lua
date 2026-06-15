local mod	= DBM:NewMod(472, "DBM-Party-Classic", 18, 239)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("20220518110528")
mod:SetCreatureID(4854)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 8292 12167",
	"SPELL_CAST_SUCCESS 6742",
	"SPELL_AURA_APPLIED 6742 9906"
)

local warningBloodlust				= mod:NewTargetNoFilterAnnounce(6742, 3)
local warningReflection				= mod:NewTargetNoFilterAnnounce(9906, 4)
local warningCrystallineSlumber		= mod:NewTargetNoFilterAnnounce(3636, 4, nil, "RemoveMagic")

local specWarnChainBolt				= mod:NewSpecialWarningInterrupt(8292, "HasInterrupt", nil, nil, 1, 2)
local specWarnLightningBolt			= mod:NewSpecialWarningInterrupt(12167, false, nil, nil, 1, 2)

local timerChainBoltCD				= mod:NewAITimer(180, 8292, nil, nil, nil, 4, nil, DBM_COMMON_L.INTERRUPT_ICON)
local timerLightningBoltCD			= mod:NewAITimer(180, 12167, nil, nil, nil, 4, nil, DBM_COMMON_L.INTERRUPT_ICON)
local timerBloodlustCD				= mod:NewAITimer(180, 6742, nil, nil, nil, 5, nil, DBM_COMMON_L.MAGIC_ICON)

function mod:OnCombatStart(delay)
	timerChainBoltCD:Start(1-delay)
	timerLightningBoltCD:Start(1-delay)
	timerBloodlustCD:Start(1-delay)
end

function mod:SPELL_CAST_START(args)
	if args.spellId == 8292 and args:IsSrcTypeHostile() then
		timerChainBoltCD:Start()
		if self:CheckInterruptFilter(args.sourceGUID, false, true) then
			specWarnChainBolt:Show(args.sourceName)
			specWarnChainBolt:Play("kickcast")
		end
	elseif args.spellId == 12167 and args:IsSrcTypeHostile() then
		timerLightningBoltCD:Start()
		if self:CheckInterruptFilter(args.sourceGUID, false, true) then
			specWarnLightningBolt:Show(args.sourceName)
			specWarnLightningBolt:Play("kickcast")
		end
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if args.spellId == 6742 and args:IsSrcTypeHostile() then
		timerBloodlustCD:Start()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 6742 and args:IsDestTypeHostile() then
		warningBloodlust:Show(args.destName)
	elseif args.spellId == 9906 then
		warningReflection:Show(args.destName)
	elseif args.spellId == 3636 then
		warningCrystallineSlumber:Show(args.destName)
	end
end
