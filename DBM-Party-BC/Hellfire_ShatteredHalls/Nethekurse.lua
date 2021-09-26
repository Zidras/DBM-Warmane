local mod	= DBM:NewMod(566, "DBM-Party-BC", 3, 259)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 7007 $"):sub(12, -3))
mod:SetCreatureID(16807)

mod:SetModelID(16628)
mod:SetModelOffset(-1, 0.4, -0.4)
mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_SUCCESS 30496"
)

--TODO, maybe add a GTFO for 35951 (Void zone damage)
--TODO, check target scanning when in a group. Solo testing cannot verify this
--If target scanning works on fissure, special warning and yell
local warnShadowFissure		= mod:NewSpellAnnounce(30496, 3)

local timerShadowFissureCD	= mod:NewNextTimer(8.5, 30496, nil, nil, nil, 3)--8.5-8.8

function mod:OnCombatStart(delay)
	timerShadowFissureCD:Start(8.3-delay)
end

function mod:SPELL_CAST_SUCCESS(args)
	if args.spellId == 30496 then
		warnShadowFissure:Show()
		timerShadowFissureCD:Start()
	end
end
