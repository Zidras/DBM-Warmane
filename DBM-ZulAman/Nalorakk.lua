local mod	= DBM:NewMod("Nalorakk", "DBM-ZulAman")
local L		= mod:GetLocalizedStrings()

mod:SetRevision("20250104100832")
mod:SetCreatureID(23576)

mod:SetZone()

mod:RegisterCombat("combat_yell", L.YellPull)

mod:RegisterEventsInCombat(
	"SPELL_AURA_APPLIED 42398",
	"CHAT_MSG_MONSTER_YELL"
)

local warnBear			= mod:NewAnnounce("WarnBear", 4, 31974)
local warnBearSoon		= mod:NewAnnounce("WarnBearSoon", 3, 31974)
local warnNormal		= mod:NewAnnounce("WarnNormal", 4, 39414)
local warnNormalSoon	= mod:NewAnnounce("WarnNormalSoon", 3, 39414)
local warnSilence		= mod:NewSpellAnnounce(42398, 3)

local timerBear 		= mod:NewTimer(45, "TimerBear", 31974, nil, nil, 6) -- AC 45-50s; Labeled timerBear and warnBearSoon as CD in localization.en 
local timerNormal		= mod:NewTimer(30, "TimerNormal", 39414, nil, nil, 6) -- AC 30s

local berserkTimer		= mod:NewBerserkTimer(600)



function mod:OnCombatStart(delay)
	timerBear:Start() 
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
