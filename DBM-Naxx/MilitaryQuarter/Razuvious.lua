local mod	= DBM:NewMod("Razuvious", "DBM-Naxx", 4)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("20251018121532")
mod:SetCreatureID(16061)
mod:SetEncounterID(1113)

mod:RegisterCombat("combat_yell", L.Yell1, L.Yell2, L.Yell3, L.Yell4)

mod:RegisterEventsInCombat(
	"SPELL_CAST_SUCCESS 55543 29107 29060 29061",
	"SPELL_AURA_APPLIED 605",
	"UNIT_DIED"
)

local warnShoutNow		= mod:NewSpellAnnounce(29107, 1, "Interface\\Icons\\Ability_Warrior_Rampage")
local warnShoutSoon		= mod:NewSoonAnnounce(29107, 3, "Interface\\Icons\\Ability_Warrior_Rampage")
local warnShieldWall	= mod:NewAnnounce("WarningShieldWallSoon", 3, 29061, nil, nil, nil, 29061)

local timerShout		= mod:NewVarTimer("v14.92-15.07", 29107, nil, nil, nil, 2, "Interface\\Icons\\Ability_Warrior_Rampage") -- SPELL_CAST_SUCCESS: (Lordaeron: 25m [2025-10-03]@[20:47:27]) - "Disrupting Shout-29107-npc:16061-586 = pull:14.92, 15.07, 15.07, 15.06, 14.99"
local timerTaunt		= mod:NewCDTimer(20, 29060, nil, nil, nil, 5, nil, DBM_COMMON_L.TANK_ICON) -- UNIT_SPELLCAST_SUCCEEDED: (Lordaeron: 25m [2025-10-03]@[20:47:27]) - "Taunt-npc:16803-590 = pull:13.62, 23.36, 20.47, 20.51"
local timerShieldWall	= mod:NewBuffActiveTimer(20, 29061, nil, nil, nil, 5, nil, DBM_COMMON_L.TANK_ICON) -- This is 20s of buff active duration, but the ability CD is 30s. UNIT_SPELLCAST_SUCCEEDED: (Lordaeron: 25m [2025-10-03]@[20:47:27]) - "Bone Barrier-npc:16803-590 = pull:17.66, 31.99, 31.40"
local timerMindControl	= mod:NewBuffActiveTimer(60, 605, nil, nil, nil, 6)

function mod:OnCombatStart(delay)
	timerShout:Start(-delay)
	warnShoutSoon:Schedule(11-delay)
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if args:IsSpellID(55543, 29107) then  -- Disrupting Shout
		timerShout:Start()
		warnShoutNow:Show()
		warnShoutSoon:Schedule(11)
	elseif spellId == 29060 then -- Taunt
		timerTaunt:Start(nil, args.sourceGUID)
	elseif spellId == 29061 then -- ShieldWall
		timerShieldWall:Start(nil, args.sourceGUID)
		warnShieldWall:Schedule(25)
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 605 and args:IsSrcTypePlayer() then -- Mind Control
		timerMindControl:Start(nil, args.sourceName)
	end
end

function mod:UNIT_DIED(args)
	local guid = args.destGUID
	local cid = self:GetCIDFromGUID(guid)
	if cid == 16803 then--Deathknight Understudy
		timerTaunt:Stop(args.destGUID)
		timerShieldWall:Stop(args.destGUID)
	end
end
