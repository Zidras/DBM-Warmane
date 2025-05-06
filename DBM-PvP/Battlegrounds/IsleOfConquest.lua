local mod	= DBM:NewMod("IsleofConquest", "DBM-PvP")
local L		= mod:GetLocalizedStrings()

local GetCurrentMapAreaID = GetCurrentMapAreaID

mod:SetRevision("20250305220503")
mod:SetZone(DBM_DISABLE_ZONE_DETECTION)

mod:RegisterEvents(
	"ZONE_CHANGED_NEW_AREA"
)

mod:RemoveOption("HealthFrame")

local warnSiegeEngine = mod:NewAnnounce("WarnSiegeEngine", 3)
local warnSiegeEngineSoon = mod:NewAnnounce("WarnSiegeEngineSoon", 2)

local timerSiegeEngine = mod:NewTimer(180, "TimerSiegeEngine")

do
	local bgzone = false

	local function Init(self)
		local zoneID = GetCurrentMapAreaID()
		if not bgzone and zoneID == 541 then
			bgzone = true
			self:RegisterShortTermEvents(
				"CHAT_MSG_MONSTER_YELL",
				"UNIT_DIED"
			)
			local generalMod = DBM:GetModByName("PvPGeneral")
			generalMod:SubscribeAssault(zoneID, 5)
			generalMod:TrackHealth(34922, "HordeBoss")
			generalMod:TrackHealth(34924, "AllianceBoss")
			generalMod:TrackHealth(195494, "HordeGateFront", 600000)	-- Horde Front Gate
			generalMod:TrackHealth(195495, "HordeGateWest", 600000)		-- Horde West Gate
			generalMod:TrackHealth(195496, "HordeGateEast", 600000)		-- Horde East Gate
			generalMod:TrackHealth(195698, "AllianceGateEast", 600000)	-- Alliance East Gate
			generalMod:TrackHealth(195699, "AllianceGateWest", 600000)	-- Alliance West Gate
			generalMod:TrackHealth(195700, "AllianceGateFront", 600000)	-- Alliance Front Gate
		elseif bgzone and zoneID ~= 541 then
			bgzone = false
			self:UnregisterShortTermEvents()
			self:Stop()
			DBM:GetModByName("PvPGeneral"):StopTrackHealth()
		end
	end

	function mod:ZONE_CHANGED_NEW_AREA()
		Init(self)
	end
	mod.PLAYER_ENTERING_WORLD	= mod.ZONE_CHANGED_NEW_AREA
	mod.OnInitialize			= mod.ZONE_CHANGED_NEW_AREA
end

function mod:CHAT_MSG_MONSTER_YELL(msg)
	if msg == L.GoblinStartAlliance or msg == L.GoblinBrokenAlliance or msg:find(L.GoblinStartAlliance) or msg:find(L.GoblinBrokenAlliance) then
		self:SendSync("SEStart", "Alliance")
	elseif msg == L.GoblinStartHorde or msg == L.GoblinBrokenHorde or msg:find(L.GoblinStartHorde) or msg:find(L.GoblinBrokenHorde) then
		self:SendSync("SEStart", "Horde")
	elseif msg == L.GoblinHalfwayAlliance or msg:find(L.GoblinHalfwayAlliance) then
		self:SendSync("SEHalfway", "Alliance")
	elseif msg == L.GoblinHalfwayHorde or msg:find(L.GoblinHalfwayHorde) then
		self:SendSync("SEHalfway", "Horde")
	elseif msg == L.GoblinFinishedAlliance or msg:find(L.GoblinFinishedAlliance) then
		self:SendSync("SEFinish", "Alliance")
	elseif msg == L.GoblinFinishedHorde or msg:find(L.GoblinFinishedHorde) then
		self:SendSync("SEFinish", "Horde")
	end
end

function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 34476 then
		self:SendSync("SEBroken", "Alliance")
	elseif cid == 35069 then
		self:SendSync("SEBroken", "Horde")
	end
end

function mod:OnSync(msg, arg)
	if msg == "SEStart" then
		timerSiegeEngine:Start(178)
		warnSiegeEngineSoon:Schedule(168)
		if arg == "Alliance" then
			timerSiegeEngine:SetColor({r=0, g=0, b=1})
		elseif arg == "Horde" then
			timerSiegeEngine:SetColor({r=1, g=0, b=0})
		end
	elseif msg == "SEHalfway" then
		warnSiegeEngineSoon:Cancel()
		timerSiegeEngine:Start(89)
		warnSiegeEngineSoon:Schedule(79)
		if arg == "Alliance" then
			timerSiegeEngine:SetColor({r=0, g=0, b=1})
		elseif arg == "Horde" then
			timerSiegeEngine:SetColor({r=1, g=0, b=0})
		end
	elseif msg == "SEFinish" then
		warnSiegeEngineSoon:Cancel()
		timerSiegeEngine:Cancel()
		warnSiegeEngine:Show()
	end
end
