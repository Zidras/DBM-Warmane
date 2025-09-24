local mod	= DBM:NewMod("PT", "DBM-Party-BC", 12)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("20220518110528")

mod:RegisterEvents(
	"UPDATE_WORLD_STATES",
	"UNIT_DIED",
	"CHAT_MSG_MONSTER_YELL"
)
mod.noStatistics = true

-- Portals
local warnWavePortalSoon	= mod:NewAnnounce("WarnWavePortalSoon", 2, 33404)
local warnWavePortal		= mod:NewAnnounce("WarnWavePortal", 3, 33404)
local warnBossPortal		= mod:NewAnnounce("WarnBossPortal", 4, 33341)

local timerNextPortal		= mod:NewTimer(120, "TimerNextPortal", 33404, nil, nil, 6)

mod:AddBoolOption("ShowAllPortalTimers", false, "timer")

local lastPortal = 0

function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 17879 or cid == 17880 then
		timerNextPortal:Start(122, lastPortal + 1)
		warnWavePortalSoon:Schedule(112)
	end
end

function mod:UPDATE_WORLD_STATES()
	local text = select(3, GetWorldStateUIInfo(2))
	if not text then return end
	local currentPortal = text:match("(%d+).+18")
	if not currentPortal then
		currentPortal = 0
	end
	currentPortal = tonumber(currentPortal)
	if currentPortal > lastPortal then
		warnWavePortalSoon:Cancel()
		timerNextPortal:Cancel()
		if currentPortal == 6 or currentPortal == 12 or currentPortal == 18 then
			warnBossPortal:Show()
		else
			warnWavePortal:Show(currentPortal)
			if self.Options.ShowAllPortalTimers then
				timerNextPortal:Start(122, currentPortal + 1)
				warnWavePortalSoon:Schedule(112)
			end
		end
		lastPortal = currentPortal
	elseif currentPortal < lastPortal then
		lastPortal = 0
	end
end

function mod:CHAT_MSG_MONSTER_YELL(msg)
	if msg == L.Shielddown or msg:find(L.Shielddown) then
		self:SendSync("Wipe")
	end
end

function mod:OnSync(msg)
	if msg == "Wipe" then
		warnWavePortalSoon:Cancel()
		timerNextPortal:Cancel()
	end
end
