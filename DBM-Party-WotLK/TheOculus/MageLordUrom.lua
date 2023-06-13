local mod	= DBM:NewMod("MageLordUrom", "DBM-Party-WotLK", 9)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("20220518110528")
mod:SetCreatureID(27655)
mod:SetMinSyncRevision(2824)

mod:RegisterCombat("yell", L.CombatStart)

mod:RegisterEventsInCombat(
	"SPELL_AURA_APPLIED 51121 59376",
	"SPELL_CAST_START 51110 59377"
)

local warningTimeBomb		= mod:NewTargetNoFilterAnnounce(51121, 4)

local specWarnExplosion		= mod:NewSpecialWarningMoveTo(51110, nil, nil, nil, 3, 2)
local specWarnBombYou		= mod:NewSpecialWarningYou(51121)

local timerTimeBomb			= mod:NewTargetTimer(6, 51121, nil, nil, nil, 5, nil, DBM_COMMON_L.HEALER_ICON)
local timerExplosion		= mod:NewCastTimer(8, 51110, nil, nil, nil, 2, nil, DBM_COMMON_L.DEADLY_ICON)

function mod:SPELL_CAST_START(args)
	if args:IsSpellID(51110, 59377) then
		specWarnExplosion:Show(DBM_COMMON_L.BREAK_LOS)
		specWarnExplosion:Play("findshelter")
		timerExplosion:Start()
		if args:IsPlayer() then
			specWarnBombYou:Show()
		end
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpellID(51121, 59376) then
		warningTimeBomb:Show(args.destName)
		timerTimeBomb:Start(args.destName)
	end
end
