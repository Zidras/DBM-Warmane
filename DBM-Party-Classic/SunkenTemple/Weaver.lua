local mod	= DBM:NewMod("Weaver", "DBM-Party-Classic", 17)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 7007 $"):sub(12, -3))
mod:SetCreatureID(5720)


mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_SUCCESS 12882 12884"
)

--TODO, Change timers to sourcename timers when not AI
local warnWingFlap						= mod:NewSpellAnnounce(12882, 2)
local warnAcidBreath					= mod:NewSpellAnnounce(12884, 2)

local timerWingFlapCD					= mod:NewAITimer(180, 12882, nil, nil, nil, 5, nil, DBM_CORE_L.TANK_ICON)
local timerAcidBreathCD					= mod:NewAITimer(180, 12884, nil, nil, nil, 5, nil, DBM_CORE_L.TANK_ICON)

function mod:OnCombatStart(delay)
	timerWingFlapCD:Start(1-delay)
	timerAcidBreathCD:Start(1-delay)
end

function mod:SPELL_CAST_SUCCESS(args)
	if args.spellId == 12882 and args:IsSrcTypeHostile() then
		warnWingFlap:Show()
		timerWingFlapCD:Start()
	elseif args.spellId == 12884 then
		warnAcidBreath:Show()
		timerAcidBreathCD:Start()
	end
end
