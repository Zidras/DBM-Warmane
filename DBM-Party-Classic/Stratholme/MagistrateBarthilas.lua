local mod	= DBM:NewMod(454, "DBM-Party-Classic", 16, 236)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 7007 $"):sub(12, -3))
mod:SetCreatureID(10435)


mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_SUCCESS 10887 14099"
)

local warningCrowdPummel		= mod:NewSpellAnnounce(10887, 2)
local warningMightyBlow			= mod:NewSpellAnnounce(14099, 2)

local timerCrowdPummelCD		= mod:NewAITimer(180, 10887, nil, nil, nil, 2)
local timerMightyBlowCD			= mod:NewAITimer(180, 14099, nil, "Tank", 2, 5, nil, DBM_CORE_L.TANK_ICON)

function mod:OnCombatStart(delay)
	timerCrowdPummelCD:Start(1-delay)
	timerMightyBlowCD:Start(1-delay)
end

function mod:SPELL_CAST_SUCCESS(args)
	if args.spellId == 10887 then
		warningCrowdPummel:Show()
		timerCrowdPummelCD:Start()
	elseif args.spellId == 14099 then
		warningMightyBlow:Show()
		timerMightyBlowCD:Start()
	end
end
