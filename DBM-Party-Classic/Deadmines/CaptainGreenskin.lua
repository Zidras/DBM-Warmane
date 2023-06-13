local mod	= DBM:NewMod("CaptainGreenskin", "DBM-Party-Classic", 5)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("20220518110528")
mod:SetCreatureID(647)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_SUCCESS 5208",
	"SPELL_AURA_APPLIED 5208"
)

--TODO, consider a cleave timer if not cast too often
local warningPoisonedHarpoon		= mod:NewTargetNoFilterAnnounce(5208, 2, nil, "RemovePoison")

local timerPoisonedHarpoonCD		= mod:NewAITimer(30, 5208, nil, "RemovePoison", nil, 5, nil, DBM_COMMON_L.POISON_ICON)

function mod:OnCombatStart(delay)
	timerPoisonedHarpoonCD:Start(1-delay)
end

function mod:SPELL_CAST_SUCCESS(args)
	if args.spellId == 5208 then
		timerPoisonedHarpoonCD:Start()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 5208 then
		warningPoisonedHarpoon:Show(args.destName)
	end
end
