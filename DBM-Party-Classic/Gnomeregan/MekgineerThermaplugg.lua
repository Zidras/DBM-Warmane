local mod	= DBM:NewMod(422, "DBM-Party-Classic", 7, 231)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("20220518110528")
mod:SetCreatureID(7800)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_SUCCESS 10101 11130",
	"CHAT_MSG_MONSTER_YELL"
)

local warningKnockAway			= mod:NewSpellAnnounce(10101, 2)
local warningActivateBomb		= mod:NewSpellAnnounce(11511, 2)

local timerKnockAwayCD			= mod:NewAITimer(180, 10101, nil, nil, nil, 2)
local timerActivateBomb			= mod:NewNextTimer(30, 11511, nil, nil, nil, 2)

function mod:OnCombatStart(delay)
	timerKnockAwayCD:Start(1-delay)
	timerActivateBomb:Start(-delay)
end

function mod:SPELL_CAST_SUCESS(args)
	if args:IsSpellID(10101, 11130) then
		warningKnockAway:Show()
		timerKnockAwayCD:Start()
	end
end

function mod:CHAT_MSG_MONSTER_YELL(msg)
	if msg == L.YellBomb and self:AntiSpam(3, 1) then
		warningActivateBomb:Show()
		timerActivateBomb:Start()
	end
end
