-- Areanas mod v3.0
-- rewrite by Tandanu
--

local Arenas	= DBM:NewMod("Arenas", "DBM-PvP", 1)
local L			= Arenas:GetLocalizedStrings()

Arenas:RemoveOption("HealthFrame")

Arenas:SetZone(DBM_DISABLE_ZONE_DETECTION)

Arenas:RegisterEvents("CHAT_MSG_BG_SYSTEM_NEUTRAL")

local timerStart	= Arenas:NewTimer(60, "TimerStart")
local timerShadow	= Arenas:NewTimer(90, "TimerShadow")

function Arenas:CHAT_MSG_BG_SYSTEM_NEUTRAL(args)
	if not IsActiveBattlefieldArena() then return end
	if args == L.Start60 then
		timerStart:Start()

	elseif args == L.Start30 then
		if timerStart:GetTime() == 0 then
			timerStart:Start()
		end
		timerStart:Update(30, 60)

	elseif args == L.Start15 then
		if timerStart:GetTime() == 0 then
			timerStart:Start()
		end
		timerStart:Update(45, 60)
		timerShadow:Schedule(15)
	end
end

