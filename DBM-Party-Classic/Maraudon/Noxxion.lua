local mod	= DBM:NewMod(423, "DBM-Party-Classic", 8, 232)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 7007 $"):sub(12, -3))
mod:SetCreatureID(13282)


mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_SUCCESS 10966 21707"
)

--TODO, spawns affect uppercut timer?
local warningSpawns					= mod:NewSpellAnnounce(21707, 2)
local warningUppercut				= mod:NewSpellAnnounce(10966, 2)

local timerSpawnsCD					= mod:NewAITimer(180, 21707, nil, nil, nil, 1, nil, DBM_CORE_L.DAMAGE_ICON)
local timerUppercutCD				= mod:NewAITimer(180, 10966, nil, nil, nil, 5, nil, DBM_CORE_L.TANK_ICON)

function mod:OnCombatStart(delay)
	timerSpawnsCD:Start(1-delay)--6
	timerUppercutCD:Start(1-delay)--18
end

function mod:SPELL_CAST_SUCCESS(args)
	if args.spellId == 10966 then
		warningUppercut:Show()
		timerUppercutCD:Start()
	elseif args.spellId == 21707 then
		warningSpawns:Show()
		timerSpawnsCD:Start()
	end
end
