local mod	= DBM:NewMod(422, "DBM-Party-Classic", 7, 231)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 7007 $"):sub(12, -3))
mod:SetCreatureID(7800)


mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_SUCCESS 10101 11130 11518 11521 11798 11524 11526 11527"
)

local warningKnockAway			= mod:NewSpellAnnounce(10101, 2)
local warningActivateBomb		= mod:NewSpellAnnounce(11518, 2)

local timerKnockAwayCD			= mod:NewAITimer(180, 10101, nil, nil, nil, 2)

function mod:OnCombatStart(delay)
	timerKnockAwayCD:Start(1-delay)
end

function mod:SPELL_CAST_SUCESS(args)
	if args:IsSpellID(10101, 11130) then
		warningKnockAway:Show()
		timerKnockAwayCD:Start()
	elseif args:IsSpellID(11518, 11521, 11798, 11524, 11526, 11527) and self:AntiSpam(3, 1) then
		warningActivateBomb:Show()
	end
end
