local mod	= DBM:NewMod("AgathelostheRaging", "DBM-Party-Classic", 11)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("20220518110528")
mod:SetCreatureID(4422)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_AURA_APPLIED 8269"
)

--https://classic.wowhead.com/spell=8555/left-for-dead nani? is wowhead tripping? no mention of this in comments or guides
local warningEnrage				= mod:NewTargetNoFilterAnnounce(8269, 2)

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 8269 and args:IsDestTypeHostile() then
		warningEnrage:Show(args.destName)
	end
end
