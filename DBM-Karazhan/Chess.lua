local mod	= DBM:NewMod("Chess", "DBM-Karazhan")
local L		= mod:GetLocalizedStrings()

local playerFactoin = UnitFactionGroup("player")
mod:SetRevision(("$Revision: 7007 $"):sub(12, -3))
if playerFactoin == "Alliance" then
	mod:SetCreatureID(21752)--Warchief Blackhand
else
	mod:SetCreatureID(21684)--King Llane
end
mod:SetModelID(18720)

mod:RegisterCombat("combat")--Actually not how we register combat, bogus because SetWipeTime needs it
mod:SetWipeTime(600)

mod:RegisterEventsInCombat(
	"SPELL_CAST_SUCCESS 37471 37472",
	"SPELL_AURA_APPLIED 30529",
	"CHAT_MSG_RAID_BOSS_EMOTE"
)

--Verify cheat timer
local timerHeroism			= mod:NewBuffActiveTimer(10, 37471)
local timerBloodlust		= mod:NewBuffActiveTimer(10, 37472)
local timerRecentlyInGame	= mod:NewBuffFadesTimer(10, 30529, nil, nil, nil, 5)
local timerNextCheat		= mod:NewTimer(108, "timerCheat", 39342, nil, nil, 3)

function mod:OnCombatStart(delay)
	timerNextCheat:Start(108-delay)
end

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 30529 and args:IsPlayer() then
		timerRecentlyInGame:Start()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if args.spellId == 37471 then
		timerHeroism:Start()
	elseif args.spellId == 37472 then
		timerBloodlust:Start()
	end
end

function mod:CHAT_MSG_RAID_BOSS_EMOTE(msg)
	if msg == L.EchoCheats then
		timerNextCheat:Start()--All other cheats should be every 108 like clockwork. Only the second is random. Ie, 111, 120, 108 repeating, OR 111, 108 repeating.
	end
end
