local mod	= DBM:NewMod(456, "DBM-Party-Classic", 16, 236)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("20220518110528")
mod:SetCreatureID(10440)--10440 Baron Rivendare, 45412 Lord Aurius Rivendare, 11197/mindless-skeleton

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_SUMMON 17480"
)

--TODO, verify Raise Dead for adds or replace it with 17473 and SPELL_CAST event or some emote/yell
local warningRaiseDead					= mod:NewSpellAnnounce(17473, 2)

local timerRaiseDeadCD					= mod:NewAITimer(180, 17473, nil, nil, nil, 1, nil, DBM_COMMON_L.DAMAGE_ICON)
local timerDeathPactCD					= mod:NewNextTimer(12, 17471, nil, nil, nil, 5, nil, DBM_COMMON_L.DAMAGE_ICON)

function mod:OnCombatStart(delay)
	timerRaiseDeadCD:Start(1-delay)
end

function mod:SPELL_SUMMON(args)
	if args.spellId == 17480 and self:AntiSpam(5, 1) then
		warningRaiseDead:Show()
		timerDeathPactCD:Start()
		timerRaiseDeadCD:Start()
	end
end
