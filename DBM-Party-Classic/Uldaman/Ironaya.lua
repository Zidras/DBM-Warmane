local mod	= DBM:NewMod(469, "DBM-Party-Classic", 18, 239)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 7007 $"):sub(12, -3))
mod:SetCreatureID(7228)


mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_SUCCESS 8374 11876"
)

local warningArcingSmash			= mod:NewSpellAnnounce(8374, 2)
local warningWarStomp				= mod:NewSpellAnnounce(11876, 2)

local timerArcingSmashCD			= mod:NewAITimer(180, 8374, nil, "Tank", 2, 5, nil, DBM_CORE_L.TANK_ICON)
local timerWarStompCD				= mod:NewAITimer(180, 11876, nil, nil, nil, 2)

function mod:OnCombatStart(delay)
	timerArcingSmashCD:Start(1-delay)
	timerWarStompCD:Start(1-delay)
end

function mod:SPELL_CAST_SUCCESS(args)
	if args.spellId == 8374 then
		warningArcingSmash:Show()
		timerArcingSmashCD:Start()
	elseif args.spellId == 11876 then
		warningWarStomp:Show()
		timerWarStompCD:Start()
	end
end
