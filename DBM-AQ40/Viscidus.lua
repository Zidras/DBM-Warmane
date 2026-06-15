local mod	= DBM:NewMod("Viscidus", "DBM-AQ40", 1)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("20240716232440")
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

local timerPoisonBoltVolleyCD	= mod:NewCDCountTimer(10.13, 25991, nil, nil, nil, 2, nil, DBM_COMMON_L.POISON_ICON, true) -- ~5s variance [10.13-14.98]. Added "keep" arg (Onyxia: 25N [2024-07-05]@[18:31:25] || PTR: [2024-07-16]@[22:41:16]) - "Poison Bolt Volley-25991-npc:15299-610 = pull:13.42, 14.33, 13.24, 13.18, 10.50, 12.49, 10.18, 10.17, 10.46, 11.12, 13.84, 11.87, 13.18, 13.47, 10.61, 13.15, 12.13, 14.30, 13.97, 12.19, 14.32, 13.99, 10.55, 10.72, 13.85, 10.21, 12.42, 10.13, 14.38, 12.72, 12.41, 14.32, 13.27, 13.75, 12.15, 14.29, 13.68, 11.05, 13.90, 10.48, 14.25, 10.92, 14.90, 11.64, 12.02, 12.54, 11.47, 12.89, 14.15, 14.40, 10.78, 10.68, 13.01, 13.17, 14.98, 10.71, 12.79, 11.44"

mod.vb.volleyCount = 0

function mod:OnCombatStart()
	self.vb.volleyCount = 0
	timerPoisonBoltVolleyCD:Start(7.78, 1)
end

function mod:SPELL_CAST_SUCCESS(args)
	if args.spellId == 25991 then
		self.vb.volleyCount = self.vb.volleyCount + 1
		warnPoisonBoltVolley:Show(self.vb.volleyCount)
		timerPoisonBoltVolleyCD:Start(nil, self.vb.volleyCount+1)
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
