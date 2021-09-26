local mod	= DBM:NewMod("SneedsShredder", "DBM-Party-Classic", 5)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 7007 $"):sub(12, -3))
mod:SetCreatureID(642, 643)--Shredder, Sneed
--

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_SUCCESS 7399 6713 5141",
	"SPELL_AURA_APPLIED 7399 6713"
)

local warningFear			= mod:NewTargetNoFilterAnnounce(7399, 2)
local warningDisarm			= mod:NewTargetNoFilterAnnounce(6713, 2)
local warningEjectSneed		= mod:NewSpellAnnounce(5141, 2)

local timerFearCD			= mod:NewAITimer(180, 7399, nil, nil, nil, 3, nil, DBM_CORE_L.MAGIC_ICON)
local timerDisarmCD			= mod:NewAITimer(180, 6713, nil, nil, nil, 5, nil, DBM_CORE_L.TANK_ICON)

function mod:OnCombatStart(delay)
	timerFearCD:Start(1-delay)
end

function mod:SPELL_CAST_SUCCESS(args)
	if args.spellId == 7399 and args:IsSrcTypeHostile() then
		timerFearCD:Start()
	elseif args.spellId == 6713 and args:IsSrcTypeHostile() then
		timerDisarmCD:Start()
	elseif args.spellId == 5141 then
		warningEjectSneed:Show()
		timerFearCD:Stop()
		timerDisarmCD:Start(1)
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 7399 and args:IsDestTypePlayer() then
		warningFear:Show(args.destName)
	elseif args.spellId == 6713 and args:IsDestTypePlayer() then
		warningDisarm:Show(args.destName)
	end
end
