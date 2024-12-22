local _, private = ...

local module = private:NewModule("DevTools")

function module:OnModuleLoad()
	self:OnDebugToggle()
end

do
	--Debug Mode
	local eventsRegistered = false
	local UnitName, UnitExists = UnitName, UnitExists
	function module:UNIT_TARGET(uId)
		local transcriptor = _G["Transcriptor"]
		if DBM.Options.DebugLevel > 2 or (transcriptor and transcriptor:IsLogging()) then
			local active = UnitExists(uId) and "true" or "false"
			self:Debug("UNIT_TARGET event fired for "..UnitName(uId)..". Active: "..active)
		end
	end

	function module:UNIT_SPELLCAST_SUCCEEDED(uId, spellName)
		self:Debug("UNIT_SPELLCAST_SUCCEEDED fired: "..UnitName(uId).."'s "..spellName, 3)
	end

	--Spammy events that core doesn't otherwise need are now dynamically registered/unregistered based on whether or not user is actually debugging
	function module:OnDebugToggle()
		if DBM.Options.DebugMode and not eventsRegistered then
			eventsRegistered = true
			self:RegisterShortTermEvents("UNIT_SPELLCAST_SUCCEEDED boss1 boss2 boss3 boss4 boss5", "UNIT_TARGET")
		elseif not DBM.Options.DebugMode and eventsRegistered then
			eventsRegistered = false
			self:UnregisterShortTermEvents()
		end
	end

	function module:Debug(text, level)
		--But we still want to generate callbacks for level 1 and 2 events
		if DBM.Options.DebugLevel >= 3 or (level or 1) < 3 then--Cap debug level to 2 for transcriptor unless user specifically specifies 3
			DBM:FireEvent("DBM_Debug", text, level)
		end
		if not DBM.Options or not DBM.Options.DebugMode then return end
		if (level or 1) <= DBM.Options.DebugLevel then
			local frame = _G[tostring(DBM.Options.ChatFrame)]
			frame = frame and frame:IsShown() and frame or DEFAULT_CHAT_FRAME
			frame:AddMessage("|cffff7d0aDBM Debug:|r "..text, 1, 1, 1)
		end
	end
end

--Taint the script that disables /run /dump, etc
--ScriptsDisallowedForBeta = function() return false end
