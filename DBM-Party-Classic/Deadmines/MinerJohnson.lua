local mod	= DBM:NewMod("MinerJohnson", "DBM-Party-Classic", 5)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 7007 $"):sub(12, -3))
mod:SetCreatureID(3586)
--

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_SUCCESS 12097",
	"SPELL_AURA_APPLIED 12097"
)

local warningPierceArmor			= mod:NewTargetNoFilterAnnounce(12097, 2)

local timerPierceArmorCD			= mod:NewAITimer(180, 12097, nil, nil, nil, 5, nil, DBM_CORE_L.TANK_ICON)

function mod:OnCombatStart(delay)
	timerPierceArmorCD:Start(1-delay)
end

function mod:SPELL_CAST_SUCCESS(args)
	if args.spellId == 12097 then
		timerPierceArmorCD:Start()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 12097 then
		warningPierceArmor:Show(args.destName)
	end
end
