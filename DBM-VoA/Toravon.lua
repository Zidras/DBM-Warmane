local mod	= DBM:NewMod("Toravon", "DBM-VoA")
local L		= mod:GetLocalizedStrings()

mod:SetRevision("20220925121705")
mod:SetCreatureID(38433)

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

local timerFrostbiteCD		= mod:NewCDTimer(4, 72004, nil, "Tank", nil, 5, nil, DBM_COMMON_L.TANK_ICON, true) -- REVIEW! ~16s variance! Added "keep" arg (10N Lordaeron 2022/09/23 wipe1 || 10N Lordaeron 2022/09/23 wipe2 || 10N Lordaeron 2022/09/23 kill) - 4.7, 12.6, 4.8, 7.2, 6.5, 4.8, 18.8, 4.8, 13.6, 5.6, 11.7, 12.0, 4.9, 4.7, 34.0, 8.6, 31.8, 4.8, 14.0, 4.8, 9.6, 4.0, 4.8, 4.7, 7.0, 4.7, 4.7, 4.8, 4.8, 6.6, 14.7, 4.0, 6.0, 8.0, 3.9, 4.0, 10.0 || 7.2, 14.4, 5.7, 4.8, 4.8, 4.3, 4.3, 13.4, 7.1, 9.6, 4.8, 20.3, 6.6, 7.1, 4.0 || 4.8, 4.8, 13.8, 18.4, 4.8, 20.5, 4.2, 9.6, 19.4, 4.8, 9.6
local timerFrostbite		= mod:NewTargetTimer(20, 72004, nil, "Tank|Healer", nil, 5)
local timerWhiteout			= mod:NewNextTimer(38, 72034, nil, nil, nil, 2) -- (10N Lordaeron 2022/09/23 wipe1 || 10N Lordaeron 2022/09/23 wipe2) - 38.1, 38.0, 38.0, 38.0, 38.0, 38.0, 38.0, 38.0 || 38.1, 38.0
local timerNextOrb			= mod:NewNextTimer(38, 72091, nil, nil, nil, 1) -- (10N Lordaeron 2022/09/23 wipe1 || 10N Lordaeron 2022/09/23 wipe2) - 38.0, 38.0, 38.0, 38.0, 38.0, 38.0, 38.0, 38.0 || 38.1, 38.0, 38.1

--local timerToravonEnrage	= mod:NewTimer(300, "ToravonEnrage", 26662)

function mod:OnCombatStart(delay)
	timerNextOrb:Start(10.8-delay) -- (10N Lordaeron 2022/09/23 wipe1 || 10N Lordaeron 2022/09/23 wipe2 || 10N Lordaeron 2022/09/23 kill) - pull:10.8 || pull:10.8 || pull:10.8
	timerWhiteout:Start(12.8-delay) -- (10N Lordaeron 2022/09/23 wipe1 || 10N Lordaeron 2022/09/23 wipe2 || 10N Lordaeron 2022/09/23 kill) - pull:12.8 || pull:12.9 || pull:12.9
	timerFrostbiteCD:Start(0.4-delay) -- REVIEW! ~3s variance? (10N Lordaeron 2022/09/23 wipe1 || 10N Lordaeron 2022/09/23 wipe2 || 10N Lordaeron 2022/09/23 kill) - pull:0.4 || pull:2.8 || pull:0.7
--	timerToravonEnrage:Start(-delay)
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
