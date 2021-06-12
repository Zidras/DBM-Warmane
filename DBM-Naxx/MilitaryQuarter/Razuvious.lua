local mod	= DBM:NewMod("Razuvious", "DBM-Naxx", 4)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 4905 $"):sub(12, -3))
mod:SetCreatureID(16061)

mod:RegisterCombat("yell", L.Yell1, L.Yell2, L.Yell3, L.Yell4)

mod:RegisterEvents(
	"SPELL_CAST_SUCCESS",
	"SPELL_AURA_APPLIED"
)

local warnShoutNow		= mod:NewSpellAnnounce(55543, 1)
local warnShoutSoon		= mod:NewSoonAnnounce(55543, 3)
local warnShieldWall	= mod:NewAnnounce("WarningShieldWallSoon", 3, 29061)

local timerShout		= mod:NewNextTimer(16, 55543)
local timerTaunt		= mod:NewCDTimer(20, 29060)
local timerShieldWall	= mod:NewCDTimer(20, 29061)

function mod:OnCombatStart(delay)
	timerShout:Start(16 - delay)
	warnShoutSoon:Schedule(11 - delay)
end

function mod:SPELL_CAST_SUCCESS(args)
	if args:IsSpellID(55543, 29107) then  -- Disrupting Shout
		timerShout:Start()
		warnShoutNow:Show()
		warnShoutSoon:Schedule(11)
	elseif args:IsSpellID(29060) then -- Taunt
		timerTaunt:Start()
	elseif args:IsSpellID(29061) then -- ShieldWall
		timerShieldWall:Start()
		warnShieldWall:Schedule(15)
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpellID(605) and args:IsSrcTypePlayer() then -- Mind Control
		local timerMindControl = mod:NewTimer(60, args.sourceName.." Mind Control", 605)
		timerMindControl:Start()
	end
end
