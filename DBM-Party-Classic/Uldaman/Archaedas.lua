local mod	= DBM:NewMod(473, "DBM-Party-Classic", 18, 239)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 7007 $"):sub(12, -3))
mod:SetCreatureID(2748)


mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 10252 10258",
	"SPELL_CAST_SUCCESS 6524"
)

local warningAwakenEarthenGuardians		= mod:NewSpellAnnounce(10252, 2)
local warningAwakenVaultWarder			= mod:NewSpellAnnounce(10258, 2)
local warningGroundTremor				= mod:NewSpellAnnounce(6524, 3)

local timerAwakenEarthenGuardiansCD		= mod:NewAITimer(180, 10252, nil, nil, nil, 1, nil, DBM_CORE_L.DAMAGE_ICON)
local timerGroundTremorCD				= mod:NewAITimer(180, 6524, nil, nil, nil, 2)

function mod:OnCombatStart(delay)
	timerAwakenEarthenGuardiansCD:Start(1-delay)
	timerGroundTremorCD:Start(1-delay)
end

function mod:SPELL_CAST_START(args)
	if args.spellId == 10252 then
		warningAwakenEarthenGuardians:Show()
		timerAwakenEarthenGuardiansCD:Start()
	elseif args.spellId == 10258 then
		warningAwakenVaultWarder:Show()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if args.spellId == 6524 then
		warningGroundTremor:Show()
		timerGroundTremorCD:Start()
	end
end
