local mod	= DBM:NewMod("Jergosh", "DBM-Party-Classic", 9)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("20220518110528")
mod:SetCreatureID(11518)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_SUCCESS 6304 20800",
	"SPELL_AURA_APPLIED 6304 20800"
)

local warningCurseofWeakness			= mod:NewTargetNoFilterAnnounce(18267, 2)
local warningImmolate					= mod:NewTargetNoFilterAnnounce(20800, 2, nil, "Healer|RemoveMagic")

local timerCurseofWeaknessCD			= mod:NewAITimer(180, 18267, nil, nil, nil, 3, nil, DBM_COMMON_L.CURSE_ICON)
local timerImmolateCD					= mod:NewAITimer(180, 20800, nil, "Healer|RemoveMagic", nil, 5, nil, DBM_COMMON_L.MAGIC_ICON)

function mod:OnCombatStart(delay)
	timerCurseofWeaknessCD:Start(1-delay)
	timerImmolateCD:Start(1-delay)
end

function mod:SPELL_CAST_SUCCESS(args)
	if args.spellId == 18267 and args:IsSrcTypeHostile() then
		timerCurseofWeaknessCD:Start()
	elseif args.spellId == 20800 and args:IsSrcTypeHostile() then
		timerImmolateCD:Start()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 18267 and args:IsDestTypePlayer() then
		warningCurseofWeakness:Show(args.destName)
	elseif args.spellId == 20800 and args:IsDestTypePlayer() then
		warningImmolate:Show(args.destName)
	end
end
