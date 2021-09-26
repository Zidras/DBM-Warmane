local mod	= DBM:NewMod(475, "DBM-Party-Classic", 19, 240)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 7007 $"):sub(12, -3))
mod:SetCreatureID(3669)


mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 8040 23381",
	"SPELL_CAST_SUCCESS 7965",
	"SPELL_AURA_APPLIED 8040 17330"
)

local warningDruidSlumber			= mod:NewTargetNoFilterAnnounce(8040, 2)
local warningHealingTouch			= mod:NewCastAnnounce(23381, 2)
local warningPoison					= mod:NewTargetNoFilterAnnounce(17330, 2, nil, "RemovePoison")

local specWarnDruidsSlumber			= mod:NewSpecialWarningInterrupt(8040, "HasInterrupt", nil, nil, 1, 2)

local timerDruidsSlumberCD			= mod:NewAITimer(180, 8040, nil, nil, nil, 4, nil, DBM_CORE_L.INTERRUPT_ICON..DBM_CORE_L.MAGIC_ICON)
local timerHealingTouchCD			= mod:NewAITimer(180, 23381, nil, nil, nil, 4, nil, DBM_CORE_L.INTERRUPT_ICON)
local timerPoisonCD					= mod:NewAITimer(180, 23381, nil, "RemovePoison", nil, 5, nil, DBM_CORE_L.POISON_ICON)

function mod:OnCombatStart(delay)
	timerDruidsSlumberCD:Start(1-delay)
	timerHealingTouchCD:Start(1-delay)
end

function mod:SPELL_CAST_START(args)
	if args.spellId == 8040 and args:IsSrcTypeHostile() then
		if self:CheckInterruptFilter(args.sourceGUID, false, true) then
			specWarnDruidsSlumber:Show(args.sourceName)
			specWarnDruidsSlumber:Play("kickcast")
		end
	elseif args.spellId == 23381 and args:IsSrcTypeHostile() then
		warningHealingTouch:Show()
		timerHealingTouchCD:Start()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if args.spellId == 7965 then
		timerDruidsSlumberCD:Stop()
		timerHealingTouchCD:Stop()
		timerPoisonCD:Start(1)
	elseif args.spellId == 17330 and args:IsSrcTypeHostile() then
		timerPoisonCD:Start()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 8040 and args:IsDestTypePlayer() then
		warningDruidSlumber:Show(args.destName)
	elseif args.spellId == 17330 and args:IsDestTypePlayer() and self:CheckDispelFilter() then
		warningPoison:Show(args.destName)
	end
end
