local mod	= DBM:NewMod("WolfMasterNandos", "DBM-Party-Classic", 14)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 7007 $"):sub(12, -3))
mod:SetCreatureID(3927)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 7487 7489 7488"
)

local warningBleakWorg		= mod:NewSpellAnnounce(7487, 2)
local warningLupineHorror	= mod:NewSpellAnnounce(7489, 2)
local warningSlaveringWorg	= mod:NewSpellAnnounce(7488, 2)

local timerBleakWorgCD		= mod:NewAITimer(180, 7487, nil, nil, nil, 1, nil, DBM_CORE_L.DAMAGE_ICON)
local timerLupineHorrorCD	= mod:NewAITimer(180, 7489, nil, nil, nil, 1, nil, DBM_CORE_L.DAMAGE_ICON)
local timerSlaveringWorgCD	= mod:NewAITimer(180, 7488, nil, nil, nil, 1, nil, DBM_CORE_L.DAMAGE_ICON)

function mod:OnCombatStart(delay)
	timerBleakWorgCD:Start(1-delay)
	timerLupineHorrorCD:Start(1-delay)
	timerSlaveringWorgCD:Start(1-delay)
end

function mod:SPELL_CAST_START(args)
	if args.spellId == 7487 then
		warningBleakWorg:Show()
		timerBleakWorgCD:Start()
	elseif args.spellId == 7489 then
		warningLupineHorror:Show()
		timerLupineHorrorCD:Start()
	elseif args.spellId == 7488 then
		warningSlaveringWorg:Show()
		timerSlaveringWorgCD:Start()
	end
end
