local _, private = ...

local L = DBM_CORE_L

local LibStub = _G["LibStub"]
local LibLatency, LibDurability, AceTimer = LibStub("LibLatency", true), LibStub("LibDurability", true), LibStub("AceTimer-3.0")

local IsInGroup = private.IsInGroup

local playerName = UnitName("player")

local function strFromTime(time)
	if type(time) ~= "number" then time = 0 end
	time = floor(time)
	if time < 60 then
		return L.TIMER_FORMAT_SECS:format(time)
	elseif time % 60 == 0 then
		return L.TIMER_FORMAT_MINS:format(time/60)
	else
		return L.TIMER_FORMAT:format(time/60, time % 60)
	end
end

local function Pull(timer)
	local isTank = UnitGroupRolesAssigned("player")
	local LFGTankException = IsPartyLFG() and isTank --Tanks in LFG need to be able to send pull timer even if someone refuses to pass lead. LFG locks roles so no one can abuse this.
	if (DBM:GetRaidRank() == 0 and IsInGroup() and not LFGTankException) or select(2, IsInInstance()) == "pvp" or DBM:IsEncounterInProgress() then
		return DBM:AddMsg(L.ERROR_NO_PERMISSION)
	end
	if timer > 0 and timer < 3 then
		return DBM:AddMsg(L.TIME_TOO_SHORT)
	end
	local targetName = (UnitExists("target") and UnitIsEnemy("player", "target")) and UnitName("target") or nil--Filter non enemies in case player isn't targetting bos but another player/pet
	if targetName then
		private.sendSync("DBMv4-PT", timer .. "\t" .. DBM:GetCurrentArea() .. "\t" .. targetName)
	else
		private.sendSync("DBMv4-PT", timer .. "\t" .. DBM:GetCurrentArea())
	end
	-- Old chat message (requested)
	if IsInGroup() then
		local channel = ((GetNumRaidMembers() == 0) and "PARTY") or "RAID_WARNING"
		DBM:Unschedule(SendChatMessage)
		-- Pull announcer
		local savedDifficulty = DBM:GetCurrentInstanceDifficulty()
		if savedDifficulty:find("heroic") then
			SendChatMessage("{rt8} "..L.ANNOUNCE_PULL_MODE:format(PLAYER_DIFFICULTY2).." {rt8}", channel)
		elseif savedDifficulty:find("normal") then
			SendChatMessage(L.ANNOUNCE_PULL_MODE:format(PLAYER_DIFFICULTY1), channel)
		end
		SendChatMessage(L.ANNOUNCE_PULL:format(timer, playerName), channel)
		if timer > 7 then DBM:Schedule(timer - 7, SendChatMessage, L.ANNOUNCE_PULL:format(7, playerName), channel) end
		if timer > 5 then DBM:Schedule(timer - 5, SendChatMessage, L.ANNOUNCE_PULL:format(5, playerName), channel) end
		if timer > 3 then DBM:Schedule(timer - 3, SendChatMessage, L.ANNOUNCE_PULL:format(3, playerName), channel) end
		if timer > 2 then DBM:Schedule(timer - 2, SendChatMessage, L.ANNOUNCE_PULL:format(2, playerName), channel) end
		if timer > 1 then DBM:Schedule(timer - 1, SendChatMessage, L.ANNOUNCE_PULL:format(1, playerName), channel) end
		DBM:Schedule(timer, SendChatMessage, L.ANNOUNCE_PULL_NOW, channel)
	end
end

local stringWorkaround
local function Break(timer)
	if IsInGroup() and (DBM:GetRaidRank() == 0 or IsPartyLFG()) or DBM:IsEncounterInProgress() or select(2, IsInInstance()) == "pvp" then--No break timers if not assistant or if it's dungeon/raid finder/BG
		DBM:AddMsg(L.ERROR_NO_PERMISSION)
		return
	end
	if timer > 60 then
		DBM:AddMsg(L.BREAK_USAGE)
		return
	end
	timer = timer * 60 -- convert minutes to seconds
	private.sendSync("DBMv4-BT", timer)
	-- Old chat message (requested)
	if IsInGroup() then
		local channel = ((GetNumRaidMembers() == 0) and "PARTY") or "RAID_WARNING"
		DBM:Unschedule(SendChatMessage)

		local hour, minute = GetGameTime()
		minute = minute+(timer/60)
		if minute >= 60 then
			hour = hour + 1
			minute = minute - 60
		end
		minute = floor(minute)
		if minute < 10 then
			minute = tostring(0 .. minute)
		end
		stringWorkaround = stringWorkaround or CreateFrame("Button") -- ugly workaround for SendChatMessage not error with invalid escape sequence | coming from strFromTime; applied below with b:GetText(b:SetFormattedText(strFromTime(timer),3))
		SendChatMessage(L.BREAK_START:format(stringWorkaround:GetText(stringWorkaround:SetFormattedText(strFromTime(timer),3)).." ("..hour..":"..minute..")", playerName), channel)
		if timer/60 > 5 then DBM:Schedule(timer - 5*60, SendChatMessage, L.BREAK_MIN:format(5), channel) end
		if timer/60 > 2 then DBM:Schedule(timer - 2*60, SendChatMessage, L.BREAK_MIN:format(2), channel) end
		if timer/60 > 1 then DBM:Schedule(timer - 1*60, SendChatMessage, L.BREAK_MIN:format(1), channel) end
		if timer > 30 then DBM:Schedule(timer - 30, SendChatMessage, L.BREAK_SEC:format(30), channel) end
		DBM:Schedule(timer, SendChatMessage, L.ANNOUNCE_BREAK_OVER:format(hour..":"..minute), channel)
	end
end

local ShowLag, ShowDurability
do
	local tconcat, tinsert, tsort = table.concat, table.insert, table.sort

	local function SortLag(v1, v2)
		return (v1.worldlag or 0) < (v2.worldlag or 0)
	end

	function ShowLag()
		local sortLag, noLagResponse = {}, {}
		for _, v in pairs(DBM:GetRaidRoster()) do
			tinsert(sortLag, v)
		end
		tsort(sortLag, SortLag)
		DBM:AddMsg(L.LAG_HEADER)
		for _, v in ipairs(sortLag) do
			local name = v.name
			local playerColor = RAID_CLASS_COLORS[DBM:GetRaidClass(name)]
			if playerColor then
				name = ("|r|cff%.2x%.2x%.2x%s|r|cff%.2x%.2x%.2x"):format(playerColor.r * 255, playerColor.g * 255, playerColor.b * 255, name, 0.41 * 255, 0.8 * 255, 0.94 * 255)
			end
			if v.worldlag then
				DBM:AddMsg(L.LAG_ENTRY:format(name, v.worldlag, v.homelag), false)
			else
				tinsert(noLagResponse, v.name)
			end
		end
		if #noLagResponse > 0 then
			DBM:AddMsg(L.LAG_FOOTER:format(tconcat(noLagResponse, ", ")), false)
		end
	end

	if LibLatency then
		LibLatency:Register("DBM", function(homelag, worldlag, sender)
			if not sender then
				return
			end
			local player = DBM:GetRaidRoster()[sender]
			if player then
				player.homelag = homelag
				player.worldlag = worldlag
			end
		end)
	end

	local function SortDurability(v1, v2)
		return (v1.durpercent or 0) < (v2.durpercent or 0)
	end

	function ShowDurability()
		local sortDur, noDurResponse = {}, {}
		for _, v in pairs(DBM:GetRaidRoster()) do
			tinsert(sortDur, v)
		end
		tsort(sortDur, SortDurability)
		DBM:AddMsg(L.DUR_HEADER)
		for _, v in ipairs(sortDur) do
			local name = v.name
			local playerColor = RAID_CLASS_COLORS[DBM:GetRaidClass(name)]
			if playerColor then
				name = ("|r|cff%.2x%.2x%.2x%s|r|cff%.2x%.2x%.2x"):format(playerColor.r * 255, playerColor.g * 255, playerColor.b * 255, name, 0.41 * 255, 0.8 * 255, 0.94 * 255)
			end
			if v.durpercent then
				DBM:AddMsg(L.DUR_ENTRY:format(name, v.durpercent, v.durbroken), false)
			else
				tinsert(noDurResponse, v.name)
			end
		end
		if #noDurResponse > 0 then
			DBM:AddMsg(L.LAG_FOOTER:format(tconcat(noDurResponse, ", ")), false)
		end
	end

	if LibDurability then
		LibDurability:Register("DBM", function(percent, broken, sender)
			if not sender then
				return
			end
			local player = DBM:GetRaidRoster()[sender]
			if player then
				player.durpercent = percent
				player.durbroken = broken
			end
		end)
	end
end

if not _G["BigWigs"] then
	--Register pull and break slash commands for BW converts, if BW isn't loaded
	--This shouldn't raise an issue since BW SHOULD load before DBM in any case they are both present.
	SLASH_DEADLYBOSSMODSPULL1 = "/pull"
	SlashCmdList["DEADLYBOSSMODSPULL"] = function(msg)
		Pull(tonumber(msg) or 10)
	end
	SLASH_DEADLYBOSSMODSBREAK1 = "/break"
	SlashCmdList["DEADLYBOSSMODSBREAK"] = function(msg)
		Break(tonumber(msg) or 10)
	end
end

SLASH_DEADLYBOSSMODSRPULL1 = "/rpull"
SlashCmdList["DEADLYBOSSMODSRPULL"] = function()
	Pull(30)
end

--local trackedHudMarkers = {}
SLASH_DEADLYBOSSMODS1 = "/dbm"
SlashCmdList["DEADLYBOSSMODS"] = function(msg)
	if not private.dbmIsEnabled then
		DBM:ForceDisableSpam()
		return
	end
	local cmd = msg:lower()
	if cmd == "ver" or cmd == "version" then
		DBM:ShowVersions(false)
	elseif cmd == "ver2" or cmd == "version2" then
		DBM:ShowVersions(true)
	elseif cmd == "unlock" or cmd == "move" then
		DBT:ShowMovableBar()
	elseif cmd == "help2" then
		for _, v in ipairs(L.SLASHCMD_HELP2) do
			DBM:AddMsg(v)
		end
	elseif cmd == "help" then
		for _, v in ipairs(L.SLASHCMD_HELP) do
			DBM:AddMsg(v)
		end
	elseif cmd:sub(1, 13) == "timer endloop" then
		DBM:CreatePizzaTimer(time, "", nil, nil, nil, true)
	elseif cmd:sub(1, 5) == "timer" then
		local time, text = msg:match("^%w+ ([%d:]+) (.+)$")
		if not time and not text then
			for _, v in ipairs(L.TIMER_USAGE) do
				DBM:AddMsg(v)
			end
			return
		end
		local min, sec = string.split(":", time)
		min = tonumber(min or "") or 0
		sec = tonumber(sec or "")
		if min and not sec then
			sec = min
			min = 0
		end
		DBM:CreatePizzaTimer(min * 60 + sec, text)
	elseif cmd:sub(1, 6) == "ltimer" then
		local time, text = msg:match("^%w+ ([%d:]+) (.+)$")
		if not time and not text then
			DBM:AddMsg(L.PIZZA_ERROR_USAGE)
			return
		end
		local min, sec = string.split(":", time)
		min = tonumber(min or "") or 0
		sec = tonumber(sec or "")
		if min and not sec then
			sec = min
			min = 0
		end
		DBM:CreatePizzaTimer(min * 60 + sec, text, nil, nil, true)
	elseif cmd:sub(1, 15) == "broadcast timer" then--Standard Timer
		local permission = true
		if DBM:GetRaidRank() == 0 then
			DBM:AddMsg(L.ERROR_NO_PERMISSION)
			permission = false
		end
		local time, text = msg:match("^%w+ %w+ ([%d:]+) (.+)$")
		if not time and not text then
			DBM:AddMsg(L.PIZZA_ERROR_USAGE)
			return
		end
		local min, sec = string.split(":", time)
		min = tonumber(min or "") or 0
		sec = tonumber(sec or "")
		if min and not sec then
			sec = min
			min = 0
		end
		DBM:CreatePizzaTimer(min * 60 + sec, text, permission)
	elseif cmd:sub(1, 16) == "broadcast ltimer" then
		local permission = true
		if DBM:GetRaidRank() == 0 then
			DBM:AddMsg(L.ERROR_NO_PERMISSION)
			permission = false
		end
		local time, text = msg:match("^%w+ %w+ ([%d:]+) (.+)$")
		if not time and not text then
			DBM:AddMsg(L.PIZZA_ERROR_USAGE)
			return
		end
		local min, sec = string.split(":", time)
		min = tonumber(min or "") or 0
		sec = tonumber(sec or "")
		if min and not sec then
			sec = min
			min = 0
		end
		DBM:CreatePizzaTimer(min * 60 + sec, text, permission, nil, true)
	elseif cmd:sub(0,5) == "break" then
		Break(tonumber(cmd:sub(6)) or 5)
	elseif cmd:sub(1, 4) == "pull" then
		Pull(tonumber(cmd:sub(5)) or 10)
	elseif cmd:sub(1, 5) == "rpull" then
		Pull(30)
	elseif cmd:sub(1, 3) == "lag" then
		if not LibLatency then
			DBM:AddMsg(L.UPDATE_REQUIRES_RELAUNCH)
			return
		end
		LibLatency:RequestLatency()
		DBM:AddMsg(L.LAG_CHECKING)
		AceTimer:ScheduleTimer(ShowLag, 5)
	elseif cmd:sub(1, 10) == "durability" then
		if not LibDurability then
			DBM:AddMsg(L.UPDATE_REQUIRES_RELAUNCH)
			return
		end
		LibDurability:RequestDurability()
		DBM:AddMsg(L.DUR_CHECKING)
		AceTimer:ScheduleTimer(ShowDurability, 5)
--	elseif cmd:sub(1, 3) == "hud" then
--		if DBM:HasMapRestrictions() then
--			DBM:AddMsg(L.NO_HUD)
--			return
--		end
--		local hudType, target, duration = string.split(" ", cmd:sub(4):trim())
--		if hudType == "" then
--			for _, v in ipairs(L.HUD_USAGE) do
--				DBM:AddMsg(v)
--			end
--			return
--		end
--		local hudDuration = tonumber(duration) or 1200 -- If no duration defined. 20 minutes to cover even longest of fights
--		if type(hudType) == "string" and hudType:trim() ~= "" then
--			if hudType == "hide" then
--				for _, name in ipairs(trackedHudMarkers) do
--					DBM.HudMap:FreeEncounterMarkerByTarget(12345, name)
--				end
--				table.wipe(trackedHudMarkers)
--				return
--			end
--			if not target then
--				DBM:AddMsg(L.HUD_INVALID_TARGET)
--				return
--			end
--			local uId
--			if target == "target" and UnitExists("target") then
--				uId = "target"
--			elseif target == "focus" and UnitExists("focus") then
--				uId = "focus"
--			else -- Try to use it as player name
--				uId = DBM:GetRaidUnitId(target)
--			end
--			if not uId then
--				DBM:AddMsg(L.HUD_INVALID_TARGET)
--				return
--			end
--			if UnitIsUnit("player", uId) and not DBM.Options.DebugMode then -- Don't allow hud to self, except if debug mode is enabled, then hud to self useful for testing
--				DBM:AddMsg(L.HUD_INVALID_SELF)
--				return
--			end
--			local targetName = UnitName(uId)
--			if hudType == "arrow" then
--				local playerName = UnitName("player")
--				local _, targetClass = UnitClass(uId)
--				local color2 = RAID_CLASS_COLORS[targetClass]
--				local m1 = DBM.HudMap:RegisterRangeMarkerOnPartyMember(12345, "party", playerName, 0.1, hudDuration, 0, 1, 0, 1, nil, false):Appear()
--				local m2 = DBM.HudMap:RegisterRangeMarkerOnPartyMember(12345, "party", targetName, 0.75, hudDuration, color2.r, color2.g, color2.b, 1, nil, false):Appear()
--				tinsert(trackedHudMarkers, playerName)
--				tinsert(trackedHudMarkers, targetName)
--				m2:EdgeTo(m1, nil, hudDuration, 0, 1, 0, 1)
--				DBM:AddMsg(L.HUD_SUCCESS:format(DBM:strFromTime(hudDuration)))
--			elseif hudType == "dot" then
--				local _, targetClass = UnitClass(uId)
--				local color2 = RAID_CLASS_COLORS[targetClass]
--				DBM.HudMap:RegisterRangeMarkerOnPartyMember(12345, "party", targetName, 0.75, hudDuration, color2.r, color2.g, color2.b, 1, nil, false):Appear()
--				tinsert(trackedHudMarkers, targetName)
--				DBM:AddMsg(L.HUD_SUCCESS:format(DBM:strFromTime(hudDuration)))
--			elseif hudType == "green" then
--				DBM.HudMap:RegisterRangeMarkerOnPartyMember(12345, "highlight", targetName, 3.5, hudDuration, 0, 1, 0, 0.5, nil, false):Pulse(0.5, 0.5)
--				tinsert(trackedHudMarkers, targetName)
--				DBM:AddMsg(L.HUD_SUCCESS:format(DBM:strFromTime(hudDuration)))
--			elseif hudType == "red" then
--				DBM.HudMap:RegisterRangeMarkerOnPartyMember(12345, "highlight", targetName, 3.5, hudDuration, 1, 0, 0, 0.5, nil, false):Pulse(0.5, 0.5)
--				tinsert(trackedHudMarkers, targetName)
--				DBM:AddMsg(L.HUD_SUCCESS:format(DBM:strFromTime(hudDuration)))
--			elseif hudType == "yellow" then
--				DBM.HudMap:RegisterRangeMarkerOnPartyMember(12345, "highlight", targetName, 3.5, hudDuration, 1, 1, 0, 0.5, nil, false):Pulse(0.5, 0.5)
--				tinsert(trackedHudMarkers, targetName)
--				DBM:AddMsg(L.HUD_SUCCESS:format(DBM:strFromTime(hudDuration)))
--			elseif hudType == "blue" then
--				DBM.HudMap:RegisterRangeMarkerOnPartyMember(12345, "highlight", targetName, 3.5, hudDuration, 0, 0, 1, 0.5, nil, false):Pulse(0.5, 0.5)
--				tinsert(trackedHudMarkers, targetName)
--				DBM:AddMsg(L.HUD_SUCCESS:format(DBM:strFromTime(hudDuration)))
--			elseif hudType == "icon" then
--				local icon = GetRaidTargetIndex(uId)
--				if not icon then
--					DBM:AddMsg(L.HUD_INVALID_ICON)
--					return
--				end
--				DBM.HudMap:RegisterRangeMarkerOnPartyMember(12345, DBM:IconNumToString(icon):lower(), targetName, 3.5, hudDuration, 1, 1, 1, 0.5, nil, false):Pulse(0.5, 0.5)
--				tinsert(trackedHudMarkers, targetName)
--				DBM:AddMsg(L.HUD_SUCCESS:format(DBM:strFromTime(hudDuration)))
--			else
--				DBM:AddMsg(L.HUD_INVALID_TYPE)
--			end
--		end
	elseif cmd:sub(1, 5) == "arrow" then
		if DBM:HasMapRestrictions() then
			DBM:AddMsg(L.NO_ARROW)
			return
		end
		local x, y = string.split(" ", cmd:sub(6):trim())
		local xNum, yNum = tonumber(x or ""), tonumber(y or "")
		if xNum and yNum then
			DBM.Arrow:ShowRunTo(xNum, yNum, 0)
			return
		elseif type(x) == "string" and x:trim() ~= "" then
			local subCmd = x:trim()
			if subCmd== "hide" then
				DBM.Arrow:Hide()
				return
			elseif subCmd == "move" then
				DBM.Arrow:Move()
				return
			elseif subCmd == "target" then
				DBM.Arrow:ShowRunTo("target")
				return
			elseif subCmd == "focus" then
				DBM.Arrow:ShowRunTo("focus")
				return
--			elseif subCmd == "map" then
--				DBM.Arrow:ShowRunTo(yNum, zNum, 0, nil, true)
--				return
			elseif DBM:GetRaidUnitId(DBM:Capitalize(subCmd)) then
				DBM.Arrow:ShowRunTo(DBM:Capitalize(subCmd))
				return
			end
		end
		for _, v in ipairs(L.ARROW_ERROR_USAGE) do
			DBM:AddMsg(v)
		end
	elseif cmd:sub(1, 7) == "lockout" or cmd:sub(1, 3) == "ids" then
		if DBM:GetRaidRank(playerName) == 0 then
			return DBM:AddMsg(L.ERROR_NO_PERMISSION)
		end
		if GetNumRaidMembers() == 0 then
			return DBM:AddMsg(L.ERROR_NO_RAID)
		end
		DBM:RequestInstanceInfo()
	elseif cmd:sub(1, 10) == "debuglevel" then
		local level = tonumber(cmd:sub(11)) or 1
		if level < 1 or level > 3 then
			DBM:AddMsg("Invalid Value. Debug Level must be between 1 and 3.")
			return
		end
		DBM.Options.DebugLevel = level
		DBM:AddMsg("Debug Level is " .. level)
	elseif cmd:sub(1, 5) == "debug" then
		DBM.Options.DebugMode = not DBM.Options.DebugMode
		DBM:AddMsg("Debug Message is " .. (DBM.Options.DebugMode and "ON" or "OFF"))
		private:GetModule("DevTools"):OnDebugToggle()
	elseif cmd:sub(1, 4) == "test" then
		DBM:DemoMode()
	elseif cmd:sub(1, 8) == "whereiam" or cmd:sub(1, 8) == "whereami" then
		local x, y = GetPlayerMapPosition("player")
		local map, mapx, mapy = GetMapInfo()
		local mapID = GetCurrentMapAreaID() or "nil"
		if DBM:HasMapRestrictions() then
			DBM:AddMsg(("Location Information\nYou are at zone %s (%s).\nLocal Map ID %u (%s)"):format(map, GetRealZoneText(map), mapID, GetZoneText()))
		else
			DBM:AddMsg(("Location Information\nYou are at zone %s (%s): x=%f, y=%f.\nLocal Map ID %u (%s): x=%f, y=%f"):format(map, GetRealZoneText(map), x, y, mapID, GetZoneText(),mapx, mapy))
		end
	elseif cmd:sub(1, 7) == "request" then
		DBM:Unschedule(DBM.RequestTimers)
		DBM:RequestTimers(1)
		DBM:RequestTimers(2)
		DBM:RequestTimers(3)
	elseif cmd:sub(1, 6) == "silent" then
		DBM.Options.SilentMode = not DBM.Options.SilentMode
		DBM:AddMsg(L.SILENTMODE_IS .. (DBM.Options.SilentMode and "ON" or "OFF"))
	elseif cmd:sub(1, 10) == "musicstart" then
		DBM:TransitionToDungeonBGM(true)
	elseif cmd:sub(1, 9) == "musicstop" then
		DBM:TransitionToDungeonBGM(false, true)
	elseif cmd:sub(1, 9) == "infoframe" then
		if DBM.InfoFrame:IsShown() then
			DBM.InfoFrame:Hide()
		else
			DBM.InfoFrame:Show(5, "test")
		end
	elseif cmd:sub(1, 10) == "aggroframe" then
		if DBM.InfoFrame:IsShown() then
			DBM.InfoFrame:Hide()
		else
			DBM.InfoFrame:SetHeader(L.INFOFRAME_AGGRO)
			DBM.InfoFrame:Show(7, "playeraggro", 1)
		end
	else
		DBM:LoadGUI()
	end
end
