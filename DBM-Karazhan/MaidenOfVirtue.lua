local mod	= DBM:NewMod("Maiden", "DBM-Karazhan")
local L		= mod:GetLocalizedStrings()

mod:SetRevision("20250130220330")
mod:SetCreatureID(16457)

mod:SetModelID(16198)
mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 29511",
	"SPELL_AURA_APPLIED 29522",
	"SPELL_AURA_REMOVED 29522"
)

--TODO, rependance timer is consistent but there is an unknown trigger that happens once per kill where the timer resets?
--Maybe reaching a health threshold resets the CD?
--ability.id = 29511 and type = "begincast"
local warningRepentance		= mod:NewSpellAnnounce(29511, 4)
local warningHolyFire		= mod:NewTargetNoFilterAnnounce(29522, 2)

--local specWarnHolyFire		= mod:NewSpecialWarningMoveAway(29522, nil, nil, nil, 1, 2)

local timerRepentance		= mod:NewBuffActiveTimer(12.6, 29511, nil, nil, nil, 2)
local timerRepentanceCD		= mod:NewNextTimer(33, 29511, nil, nil, nil, 6) -- (PTR [2025-01-15]@[20:56:43] || Onyxia 10N [2025-01-30]@[22:02:22]) - "Repentance-29511-npc:16457-468 = pull:33.01, 32.98, 33.00, 33.02, 33.02, 33.01" || "Repentance-29511-npc:16457-468 = pull:33.02"
local timerHolyFire			= mod:NewTargetTimer(12, 29522, nil, nil, nil, 5, nil, DBM_COMMON_L.MAGIC_ICON)

mod:AddRangeFrameOption(10, 29522)

function mod:OnCombatStart(delay)
	timerRepentanceCD:Start(-delay)
	if self.Options.RangeFrame then
		DBM.RangeCheck:Show(10)
	end
	--DBM:AddMsg("Repentance timer is not broken. This is an ability that has a 29 second minimum cooldown window, but after coming off CD can be delayed up to 20 seconds on when it's cast. Basically it's a 29-49sec window. DBM shows timer for the start of that window, but cannot control whether or not the boss casts it at 29, 39, or 49. Use this knowledge to inform you of when the ability can NOT be cast, not when it will be.")
end

function mod:OnCombatEnd()
	if self.Options.RangeFrame then
		DBM.RangeCheck:Hide()
	end
end

function mod:SPELL_CAST_START(args)
	if args.spellId == 29511 then
		warningRepentance:Show()
		timerRepentance:Start()
		timerRepentanceCD:Start()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 29522 then
		warningHolyFire:Show(args.destName)
		timerHolyFire:Start(args.destName)
	end
end

function mod:SPELL_AURA_REMOVED(args)
	if args.spellId == 29522 then
		timerHolyFire:Stop(args.destName)
	end
end
