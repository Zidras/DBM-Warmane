if C_Timer_DBM and C_Timer_DBM._version == 2 then return end

local setmetatable = setmetatable
local type = type
local tinsert = table.insert
local tremove = table.remove

C_Timer_DBM = C_Timer_DBM or {}
C_Timer_DBM._version = 2

local TickerPrototype = {}
local TickerMetatable = {
	__index = TickerPrototype,
	__metatable = true
}

local waitTable = {}
local waitFrame = TimerFrame_DBM or CreateFrame("Frame", "TimerFrame_DBM", UIParent)
waitFrame:SetScript("OnUpdate", function(self, elapsed)
	local total = #waitTable
	local i = 1

	while i <= total do
		local ticker = waitTable[i]
		if ticker._cancelled then
			tremove(waitTable, i)
			total = total - 1
		elseif ticker._delay > elapsed then
			ticker._delay = ticker._delay - elapsed
			i = i + 1
		else
			ticker._callback(ticker)

			if ticker._remainingIterations == -1 then
				ticker._delay = ticker._duration
				i = i + 1
			elseif ticker._remainingIterations > 1 then
				ticker._remainingIterations = ticker._remainingIterations - 1
				ticker._delay = ticker._duration
				i = i + 1
			elseif ticker._remainingIterations == 1 then
				tremove(waitTable, i)
				total = total - 1
			end
		end
	end

	if #waitTable == 0 then
		self:Hide()
	end
end)

local function AddDelayedCall(ticker, oldTicker)
	if oldTicker and type(oldTicker) == "table" then
		ticker = oldTicker
	end

	tinsert(waitTable, ticker)
	waitFrame:Show()
end

_G.AddDelayedCall = AddDelayedCall

local function CreateTicker(duration, callback, iterations)
	local ticker = setmetatable({}, TickerMetatable)
	if type(duration) == "function" then
		error("usage: CreateTicker(duration, callback, iterations")
	end
	ticker._remainingIterations = iterations or -1
	ticker._duration = duration
	ticker._delay = duration
	ticker._callback = callback

	AddDelayedCall(ticker)

	return ticker
end

function C_Timer_DBM:After(duration, callback)
	return CreateTicker(duration, callback, 1)
end

function C_Timer_DBM:NewTimer(duration, callback)
	return CreateTicker(duration, callback, 1)
end

function C_Timer_DBM:NewTicker(duration, callback, iterations)
	return CreateTicker(duration, callback, iterations)
end

function TickerPrototype:Cancel()
	self._cancelled = true
end