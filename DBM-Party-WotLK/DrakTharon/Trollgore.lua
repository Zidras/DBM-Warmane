local mod	= DBM:NewMod("Trollgore", "DBM-Party-WotLK", 4)
local L		= mod:GetLocalizedStrings()

mod.statTypes = "normal,heroic,mythic"

mod:SetRevision("20220518110528")
mod:SetCreatureID(26630)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 49555",
	"SPELL_CAST_SUCCESS 59803",
	"CHAT_MSG_RAID_BOSS_EMOTE"
)

local warnConsume		= mod:NewSpellAnnounce(59803,1)

local timerExplosionCD	= mod:NewCDTimer(16, 49555)
local timerNextConsume	= mod:NewNextTimer(15, 59803)

function mod:OnCombatStart()
	timerExplosionCD:Start(3)
	timerNextConsume:Start()
end

function mod:SPELL_CAST_START(args)
	if args.spellId == 49555 then
		timerExplosionCD:Start()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if args.spellId == 59803 and self:AntiSpam(1) then
		warnConsume:Show()
		timerNextConsume:Start()
	end
end

function mod:CHAT_MSG_RAID_BOSS_EMOTE(msg)
	if msg == L.YellExplosion or msg:find(L.YellExplosion) then
		timerExplosionCD:Start()
	end
end
