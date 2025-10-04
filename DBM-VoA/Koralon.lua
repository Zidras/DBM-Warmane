local mod	= DBM:NewMod("Koralon", "DBM-VoA")
local L		= mod:GetLocalizedStrings()

mod:SetRevision("20250929220131")
mod:SetCreatureID(35013)
mod:SetEncounterID(776)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 67328 66665 66725 68161",
	"SPELL_AURA_APPLIED 66684 67332 66721",
	"SPELL_AURA_APPLIED_DOSE 66721"
)

local warnBreath			= mod:NewSpellAnnounce(66665, 3)
local warnMeteor			= mod:NewSpellAnnounce(66725, 3)
local warnMeteorSoon		= mod:NewPreWarnAnnounce(66725, 5, 2)
local warnBurningFury		= mod:NewStackAnnounce(66721, 2, nil, "Tank|Healer")

local specWarnCinder		= mod:NewSpecialWarningMove(66684, nil, nil, nil, 1, 2)

local timerNextMeteor		= mod:NewNextTimer(45, 66725, nil, nil, nil, 5, nil, DBM_COMMON_L.TANK_ICON)
local timerNextBurningFury	= mod:NewNextTimer(20, 66721, nil, nil, nil, 5, nil, DBM_COMMON_L.TANK_ICON..DBM_COMMON_L.HEALER_ICON)
local timerBreath			= mod:NewBuffActiveTimer(4.5, 66665, nil, nil, nil, 2)
local timerBreathCD			= mod:NewCDTimer(45, 66665, nil, nil, nil, 2)

local timerKoralonEnrage	= mod:NewBerserkTimer(300, nil, "KoralonEnrage")

function mod:OnCombatStart(delay)
	timerKoralonEnrage:Start(-delay)
	timerNextMeteor:Start(75-delay)
	warnMeteorSoon:Schedule(75-5-delay)
	timerBreathCD:Start(14.9-delay)
	timerNextBurningFury:Start(-delay)
end

function mod:SPELL_CAST_START(args)
	if args:IsSpellID(67328, 66665) then
		warnBreath:Show()
		timerBreath:Start()
		timerBreathCD:Start()
	elseif args:IsSpellID(66725, 68161) then
		warnMeteor:Show()
		timerNextMeteor:Start()
		warnMeteorSoon:Schedule(40)
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args:IsPlayer() and args:IsSpellID(66684, 67332) then
		specWarnCinder:Show()
		specWarnCinder:Play("runaway")
	elseif args.spellId == 66721 then
		warnBurningFury:Show(args.destName, args.amount or 1)
		timerNextBurningFury:Start()
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED
