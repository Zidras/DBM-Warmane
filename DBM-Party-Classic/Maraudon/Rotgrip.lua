local mod	= DBM:NewMod(430, "DBM-Party-Classic", 8, 232)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("20220518110528")
mod:SetCreatureID(13596)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_SUCCESS 16495"
)

--Puncture too random, and not important enough, so removed. Fatal bite was never seen?
local warningFatalBite				= mod:NewSpellAnnounce(16495, 3)

local timerFatalBiteCD				= mod:NewAITimer(180, 16495, nil, nil, nil, 5, nil, DBM_COMMON_L.TANK_ICON)

function mod:OnCombatStart(delay)
	timerFatalBiteCD:Start(1-delay)
end

function mod:SPELL_CAST_SUCCESS(args)
	if args.spellId == 16495 then
		warningFatalBite:Show()
		timerFatalBiteCD:Start()
	end
end
