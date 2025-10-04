local mod	= DBM:NewMod("Toravon", "DBM-VoA")
local L		= mod:GetLocalizedStrings()

mod:SetRevision("20250929220131")
mod:SetCreatureID(38433)
mod:SetEncounterID(885)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 72096 72034 72095 72091",
	"SPELL_CAST_SUCCESS 72104 72090",
	"SPELL_AURA_APPLIED 72098 72004",
	"SPELL_AURA_APPLIED_DOSE 72098 72004",
	"SPELL_AURA_REMOVED 72098 72004"
)

local warnFreezingGround	= mod:NewSpellAnnounce(72090, 1)
local warnWhiteout			= mod:NewSpellAnnounce(72034, 2)
local warnOrb				= mod:NewSpellAnnounce(72091, 3)
local warnFrostbite			= mod:NewStackAnnounce(72004, 2, nil, "Tank|Healer")

local timerFrostbiteCD		= mod:NewCDTimer(4, 72004, nil, "Tank", nil, 5, nil, DBM_COMMON_L.TANK_ICON, true)
local timerFrostbite		= mod:NewTargetTimer(20, 72004, nil, "Tank|Healer", nil, 5)
local timerWhiteout			= mod:NewNextTimer(38, 72034, nil, nil, nil, 2)
local timerNextOrb			= mod:NewNextTimer(32, 72091, nil, nil, nil, 1)

function mod:OnCombatStart(delay)
	timerNextOrb:Start(11.5-delay)
	timerWhiteout:Start(24.5-delay)
	timerFrostbiteCD:Start(0.4-delay)
end

function mod:SPELL_CAST_START(args)
	if args:IsSpellID(72096, 72034) then
		warnWhiteout:Show()
		timerWhiteout:Start()
	elseif args:IsSpellID(72095, 72091) then	--Frozen Orb(add)
		warnOrb:Show()
		timerNextOrb:Start()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if args:IsSpellID(72104, 72090) then			-- Freezing Ground (Aoe and damage debuff)
		warnFreezingGround:Show()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpellID(72098, 72004) then		-- Frostbite (tanks only debuff)
		warnFrostbite:Show(args.destName, args.amount or 1)
		timerFrostbiteCD:Start()
		timerFrostbite:Start(args.destName)
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	if args:IsSpellID(72098, 72004) then		-- Frostbite (tanks only debuff)
		timerFrostbite:Stop(args.destName)
	end
end
