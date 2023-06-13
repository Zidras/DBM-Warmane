local mod	= DBM:NewMod(418, "DBM-Party-Classic", 7, 231)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("20220518110528")
mod:SetCreatureID(6229)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_SUCCESS 10887 8374"
)

local specWarnCrowdPummel			= mod:NewSpecialWarningSpell(10887, "Melee", nil, nil, 2, 2)

local timerCrowdPummelCD			= mod:NewAITimer(180, 10887, nil, nil, nil, 2)

local timerArcingSmashD				= mod:NewAITimer(180, 8374, nil, "Tank", 2, 5, nil, DBM_COMMON_L.TANK_ICON)

function mod:OnCombatStart(delay)
	timerCrowdPummelCD:Start(1-delay)
	timerArcingSmashD:Start(1-delay)
end

function mod:SPELL_CAST_SUCCESS(args)
	if args.spellId == 10887 then
		specWarnCrowdPummel:Show()
		specWarnCrowdPummel:Play("carefly")
		timerCrowdPummelCD:Start()
	elseif args.spellId == 8374 then
		timerArcingSmashD:Start()
	end
end
