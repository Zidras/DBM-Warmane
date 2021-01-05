local mod	= DBM:NewMod("Trollgore", "DBM-Party-WotLK", 4)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 2250 $"):sub(12, -3))
mod:SetCreatureID(26630)
mod:SetZone()

mod:RegisterCombat("combat")

local yell1 = "Взрыв"
local yell1en = "Corpse"

mod:RegisterEvents(
	"SPELL_CAST_START",
	"CHAT_MSG_RAID_BOSS_EMOTE",
	"SPELL_CAST_SUCCESS"
)
local timerExplosionCD	= mod:NewCDTimer(16, 49555)
local timerNextConsume	= mod:NewNextTimer(15, 59803)
local warnConsume		= mod:NewSpellAnnounce(59803,1)

function mod:OnCombatStart()
	timerExplosionCD:Start(3)
	timerNextConsume:Start()
end

function mod:SPELL_CAST_START(args)
	if args.spellId == 49555 then
		timerExplosionCD:Start()
	end
end

function mod:CHAT_MSG_RAID_BOSS_EMOTE(msg, mob, _, _, target)
	if msg:match(yell1) or msg:match(yell1en) then
		timerExplosionCD:Start()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if args.spellId == 59803 and self:AntiSpam(1) then
		warnConsume:Show()
		timerNextConsume:Start()
	end
end