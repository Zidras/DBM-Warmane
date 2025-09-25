local mod	= DBM:NewMod("Razuvious", "DBM-Naxx", 4)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("20250924081528")
mod:SetCreatureID(16061)

mod:RegisterCombat("combat_yell", L.Yell1, L.Yell2, L.Yell3, L.Yell4)

mod:RegisterEventsInCombat(
	"SPELL_CAST_SUCCESS 55543 29107 29060 29061",
	"SPELL_AURA_APPLIED 605",
	"UNIT_DIED"
)

local warnShoutNow		= mod:NewSpellAnnounce(29107, 1, "Interface\\Icons\\Ability_Warrior_Rampage")
local warnShoutSoon		= mod:NewSoonAnnounce(29107, 3, "Interface\\Icons\\Ability_Warrior_Rampage")
local warnShieldWall	= mod:NewAnnounce("WarningShieldWallSoon", 3, 29061, nil, nil, nil, 29061)

local timerShout		= mod:NewNextTimer(15, 29107, nil, nil, nil, 2, "Interface\\Icons\\Ability_Warrior_Rampage")
local timerTaunt		= mod:NewCDTimer(20, 29060, nil, nil, nil, 5, nil, DBM_COMMON_L.TANK_ICON)
local timerShieldWall	= mod:NewCDTimer(20, 29061, nil, nil, nil, 5, nil, DBM_COMMON_L.TANK_ICON)
local timerMindControl	= mod:NewBuffActiveTimer(60, 605, nil, nil, nil, 6)

function mod:OnCombatStart(delay)
	timerShout:Start(16 - delay)
	warnShoutSoon:Schedule(11 - delay)
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if args:IsSpellID(55543, 29107) then  -- Disrupting Shout
		timerShout:Start()
		warnShoutNow:Show()
		warnShoutSoon:Schedule(11)
	elseif spellId == 29060 then -- Taunt
		timerTaunt:Start(20, args.sourceGUID)
	elseif spellId == 29061 then -- ShieldWall
		timerShieldWall:Start(20, args.sourceGUID)
		warnShieldWall:Schedule(15)
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
