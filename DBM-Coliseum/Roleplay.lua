local mod	= DBM:NewMod("Roleplay", "DBM-Coliseum")
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 4346 $"):sub(12, -3))

mod:RegisterEvents(
	"CHAT_MSG_MONSTER_YELL"
)

local timerAnubRP			= mod:NewTimer(52, "TimerAnubRP")

function mod:CHAT_MSG_MONSTER_YELL(msg)
	if msg == L.AnubRP or msg:find(L.AnubRP) then
		timerAnubRP:Start()
	end
end