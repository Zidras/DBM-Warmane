local mod	= DBM:NewMod("Tutenkash", "DBM-Party-Classic", 10)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 7007 $"):sub(12, -3))
mod:SetCreatureID(7355)
--

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_SUCCESS 12255 12252",
	"SPELL_AURA_APPLIED 12255"
)

local warningCurseofTut				= mod:NewTargetNoFilterAnnounce(12255, 2, nil, "RemoveCurse")
local warningWebSpray				= mod:NewSpellAnnounce(12252, 2)

local timerCurseofTutCD				= mod:NewAITimer(180, 12255, nil, nil, nil, 3, nil, DBM_CORE_L.CURSE_ICON)
local timerWebSprayCD				= mod:NewAITimer(180, 12252, nil, nil, nil, 5, nil, DBM_CORE_L.TANK_ICON)

function mod:OnCombatStart(delay)
	timerCurseofTutCD:Start(1-delay)
	timerWebSprayCD:Start(1-delay)
end

function mod:SPELL_CAST_SUCCESS(args)
	if args.spellId == 12255 then
		timerCurseofTutCD:Start()
	elseif args.spellId == 12252 then
		warningWebSpray:Show()
		timerWebSprayCD:Start()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 12255 and self:CheckDispelFilter() then
		warningCurseofTut:Show(args.destName)
	end
end
