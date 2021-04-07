
local LL = LibStub:NewLibrary("LibLatency", 2)
if not LL then return end -- No upgrade needed

-- Throttle times for separate channels
LL.throttleTable = LL.throttleTable or {
	["RAID"] = 0,
	["PARTY"] = 0,
	["GUILD"] = 0,
}
LL.throttleSendTable = LL.throttleSendTable or {
	["RAID"] = 0,
	["PARTY"] = 0,
	["GUILD"] = 0,
}
LL.callbackMap = LL.callbackMap or {}
LL.frame = LL.frame or CreateFrame("Frame")
LL.serverFrame = LL.serverFrame or CreateFrame("Frame")

local throttleTable = LL.throttleTable
local throttleSendTable = LL.throttleSendTable
local throttleSInfo = 0
local serverLatency = 0
local callbackMap = LL.callbackMap
local frame = LL.frame
local serverFrame = LL.serverFrame

local next, type, error, tonumber, format, match = next, type, error, tonumber, string.format, string.match
local GetTime, GetNetStats, IsInGroup, IsInRaid, SendAddonMessage = GetTime, GetNetStats, IsInGroup, IsInRaid, SendAddonMessage
local SendChatMessage = SendChatMessage
local pName = UnitName("player")

local function GetServerInfo()
	local t = GetTime()
	if t - throttleSInfo > 30 then
		throttleSInfo = GetTime()
		serverFrame:RegisterEvent("CHAT_MSG_SYSTEM")
		SendChatMessage(".server info", "SAY")
		C_Timer.After(0.2, function() serverFrame:UnregisterEvent("CHAT_MSG_SYSTEM") end)
	end
	return serverLatency
end

-- parse server info wowcircle
serverFrame:SetScript("OnEvent", function (self, event, ...)
	local msg = ...
	local m1 = match(msg, "Server delay: (%d+) ms")
	local m2 = match(msg, "Server latency: (%d+) ms")
	if m1 or m2 then
		serverLatency = m1 or m2
	end
end)


GetServerInfo()


frame:SetScript("OnEvent", function(_, _, prefix, msg, channel, sender)
	if prefix == "Lag" and throttleTable[channel] then
		if msg == "R" then
			local t = GetTime()
			if t - throttleTable[channel] > 1 then
				throttleTable[channel] = t
				local _, _, latencyHome = GetNetStats()
				local latencyWorld = latencyHome + ( GetServerInfo() or 0 ) -- compatibility with newer api
				-- 4.0.6 has added a return value so that two distinct latency values are now returned
				-- may be able to parse .server info but different servers have different stuff, so just a workaround for now
				SendAddonMessage("Lag", format("%d,%d", latencyHome or 0, latencyWorld or 0), channel)
			end
			return
		end

		local latencyHome, latencyWorld = match(msg, "^(%d+),(%d+)$")
		latencyHome = tonumber(latencyHome)
		latencyWorld = tonumber(latencyWorld)
		if latencyHome and latencyWorld then
			for _,func in next, callbackMap do
				func(latencyHome, latencyWorld, sender, channel)
			end
		end
	end
end)
frame:RegisterEvent("CHAT_MSG_ADDON")

-- For automatic group handling, don't pass a channel. The order is INSTANCE_CHAT > RAID > GROUP.
-- GUILD is not covered by auto handling.
function LL:RequestLatency(channel)
	if channel and not throttleSendTable[channel] then
		error("LibLatency: Incorrect channel type for :RequestLatency.")
	else
		if not channel and IsInGroup() then
			channel = IsInRaid() and "RAID" or "PARTY"
		end

		local _, _, latencyHome = GetNetStats()
		local latencyWorld = latencyHome + ( GetServerInfo() or 0 )

		for _,func in next, callbackMap do
			func(latencyHome, latencyWorld, pName, channel) -- This allows us to show our own latency when not grouped
		end

		if channel then
			local t = GetTime()
			if t - throttleSendTable[channel] > 1 then
				throttleSendTable[channel] = t
				SendAddonMessage("Lag", "R", channel)
			end
		end
	end
end

function LL:Register(addon, func)
	if not addon or addon == LL then
		error("LibLatency: You must pass your own addon name or object to :Register.")
	end

	local t = type(func)
	if t == "string" then
		callbackMap[addon] = function(...) addon[func](addon, ...) end
	elseif t == "function" then
		callbackMap[addon] = func
	else
		error("LibLatency: Incorrect function type for :Register.")
	end
end

function LL:Unregister(addon)
	if not addon or addon == LL then
		error("LibLatency: You must pass your own addon name or object to :Unregister.")
	end
	callbackMap[addon] = nil
end

