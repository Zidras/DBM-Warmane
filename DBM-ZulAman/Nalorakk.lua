local mod	= DBM:NewMod("Nalorakk", "DBM-ZulAman")
local L		= mod:GetLocalizedStrings()

mod:SetRevision("20221031191110")
mod:SetCreatureID(23576)

mod:SetZone()

mod:RegisterCombat("combat_yell", L.YellPull)

mod:RegisterEventsInCombat(
	"SPELL_AURA_APPLIED 42398",
	"CHAT_MSG_MONSTER_YELL"
)

local warnBear			= mod:NewAnnounce("WarnBear", 4, 39414)
local warnBearSoon		= mod:NewAnnounce("WarnBearSoon", 3, 39414)
local warnNormal		= mod:NewAnnounce("WarnNormal", 4, 39414)
local warnNormalSoon	= mod:NewAnnounce("WarnNormalSoon", 3, 39414)
local warnSilence		= mod:NewSpellAnnounce(42398, 3)

local timerBear			= mod:NewTimer(45, "TimerBear", 39414, nil, nil, 6) -- Shape of the Bear. REVIEW! (10m Frostmourne 2022/10/28) - 75.0
local timerNormal		= mod:NewTimer(30, "TimerNormal", 39414, nil, nil, 6) -- (10m Frostmourne 2022/10/28) - pull:74.5, 75.0

local berserkTimer		= mod:NewBerserkTimer(600)

function mod:OnCombatStart(delay)
	timerBear:Start() -- (10m Frostmourne 2022/10/28) - 45.0
	warnBearSoon:Schedule(40)
	berserkTimer:Start(-delay)
end

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 42398 and self:AntiSpam(4, 1) then
		warnSilence:Show()
	end
end

function mod:CHAT_MSG_MONSTER_YELL(msg)
	if msg == L.YellBear or msg:find(L.YellBear) then
		timerBear:Cancel()
		warnBearSoon:Cancel()
		warnBear:Show()
		timerNormal:Start()
		warnNormalSoon:Schedule(25)
	elseif msg == L.YellNormal or msg:find(L.YellNormal) then
		timerNormal:Cancel()
		warnNormalSoon:Cancel()
		warnNormal:Show()
		timerBear:Start()
		warnBearSoon:Schedule(40)
	end
end
