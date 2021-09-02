local mod	= DBM:NewMod("Viscidus", "DBM-AQ40", 1)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 7007 $"):sub(12, -3))
mod:SetCreatureID(15299)

mod:SetModelID(15299)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_SUCCESS 25991 25896",
	"SPELL_AURA_APPLIED 25989",
	"CHAT_MSG_MONSTER_EMOTE"
)

local warnPoisonBoltVolley		= mod:NewCountAnnounce(25991, 3)
local warnFreeze				= mod:NewAnnounce("WarnFreeze", 2, 16350)
local warnShatter				= mod:NewAnnounce("WarnShatter", 2, 12982)

local specWarnGTFO				= mod:NewSpecialWarningGTFO(25989, nil, nil, nil, 1, 8)

local timerPoisonBoltVolleyCD	= mod:NewCDCountTimer(11, 25991, nil, nil, nil, 2, nil, DBM_CORE_L.POISON_ICON)

mod.vb.volleyCount = 0

function mod:OnCombatStart(delay)
	self.vb.volleyCount = 0
	timerPoisonBoltVolleyCD:Start(12.9, 1)
end

function mod:SPELL_CAST_SUCCESS(args)
	if args.spellId == 25991 then
		self.vb.volleyCount = self.vb.volleyCount + 1
		warnPoisonBoltVolley:Show(self.vb.volleyCount)
		timerPoisonBoltVolleyCD:Start(11, self.vb.volleyCount+1)
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 25989 and args:IsPlayer() and self:AntiSpam(3, 2) then
		specWarnGTFO:Show(args.spellName)
		specWarnGTFO:Play("watchfeet")
	end
end

function mod:CHAT_MSG_MONSTER_EMOTE(msg)
	if msg == L.Phase4 or msg:find(L.Phase4) then
		self:SendSync("Shatter", 1)
	elseif msg == L.Phase5 or msg:find(L.Phase5) then
		self:SendSync("Shatter", 2)
	elseif msg == L.Phase6 or msg:find(L.Phase6) then--No longer present in classic?
		self:SendSync("Shatter", 3)
	elseif msg == L.Slow or msg:find(L.Slow) then
		self:SendSync("Freeze", 1)
	elseif msg == L.Freezing or msg:find(L.Freezing) then
		self:SendSync("Freeze", 2)
	elseif msg == L.Frozen or msg:find(L.Frozen) then
		self:SendSync("Freeze", 3)
	end
end

function mod:OnSync(msg, count)
	if msg == "Shatter" and count then
		count = tonumber(count)
		warnShatter:Show(count)
	elseif msg == "Freeze" and count then
		count = tonumber(count)
		warnFreeze:Show(count)
		if count == 3 then
			timerPoisonBoltVolleyCD:Stop()
		end
	end
end
