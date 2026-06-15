local mod	= DBM:NewMod(480, "DBM-Party-Classic", 19, 240)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("20220518110528")
mod:SetCreatureID(5775)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 8142"
)

local warnVines			= mod:NewSpellAnnounce(8142, 2)

local timerVinesCD		= mod:NewAITimer(180, 8142, nil, nil, nil, 4, nil, DBM_COMMON_L.INTERRUPT_ICON)

function mod:OnCombatStart(delay)
	timerVinesCD:Start(1-delay)
end

function mod:SPELL_CAST_START(args)
	if args.spellId == 8142 and args:IsDestTypePlayer() then
		warnVines:Show(args.sourceName)
		timerVinesCD:Start()
	end
end
