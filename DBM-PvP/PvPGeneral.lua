local mod	= DBM:NewMod("PvPGeneral", "DBM-PvP")
local L		= mod:GetLocalizedStrings()

local DBM = DBM
local AceTimer = LibStub("AceTimer-3.0")

mod:SetRevision("20250328212421")
mod:SetZone(DBM_DISABLE_ZONE_DETECTION)

mod:RegisterEvents(
	"ZONE_CHANGED_NEW_AREA",
	"PLAYER_ENTERING_WORLD",
	"PLAYER_DEAD",
	"CHAT_MSG_BG_SYSTEM_NEUTRAL"
)

local vulnerableTimer	= mod:NewNextTimer(600, 46392)

mod:AddBoolOption("ColorByClass", true)
mod:AddBoolOption("HideBossEmoteFrame", false)
mod:AddBoolOption("AutoSpirit", false)
mod:AddBoolOption("ShowRelativeGameTime", true)
mod:AddBoolOption("ShowGatesHealth", true)
mod:RemoveOption("HealthFrame")

do
	local IsInInstance, RepopMe, HasSoulstone = IsInInstance, RepopMe, HasSoulstone

	function mod:PLAYER_DEAD()
		local _, instanceType = IsInInstance()
		if instanceType == "pvp" and not HasSoulstone() and self.Options.AutoSpirit then
			RepopMe()
		end
	end
end

-- Utility functions
local format, strsplit = string.format, strsplit
local hooksecurefunc = hooksecurefunc
local IsActiveBattlefieldArena, FauxScrollFrame_GetOffset, GetBattlefieldScore, GetNumBattlefieldScores, GetUnitName, UnitFactionGroup, UnitName = IsActiveBattlefieldArena, FauxScrollFrame_GetOffset, GetBattlefieldScore, GetNumBattlefieldScores, GetUnitName, UnitFactionGroup, UnitName
local MAX_WORLDSTATE_SCORE_BUTTONS, CUSTOM_CLASS_COLORS, RAID_CLASS_COLORS = MAX_WORLDSTATE_SCORE_BUTTONS, CUSTOM_CLASS_COLORS, RAID_CLASS_COLORS
local playerName = UnitName("player")

local function GetBattlefieldFaction(unit) -- workaround to detect faction in Cross-Faction BG
	if not unit then return UnitFactionGroup("player") end
	local numScores = GetNumBattlefieldScores()
	if numScores == 0 then return UnitFactionGroup("player")
	else
		local unitName = GetUnitName(unit, true)
		for i = 1, numScores do
			local name, _, _, _, _, faction = GetBattlefieldScore(i)
			if name == unitName then
				if faction == 0 then
					return "Horde"
				else
					return "Alliance"
				end
			end
		end
	end
end

local myScoreName = format("> %s <", playerName)
hooksecurefunc("WorldStateScoreFrame_Update", function()
	if not mod.Options.ColorByClass then return	end
	local inArena = IsActiveBattlefieldArena()
	local offset = FauxScrollFrame_GetOffset(WorldStateScoreScrollFrame)

	local _, name, faction, classToken, realm, classTextColor, nameText

	for i = 1, MAX_WORLDSTATE_SCORE_BUTTONS do
		name, _, _, _, _, faction, _, _, _, classToken = GetBattlefieldScore(offset + i)

		if name then
			name, realm = strsplit("-", name, 2)

			if name == playerName then
				name = myScoreName
			end

			if realm then
				local color

				if inArena then
					if faction == 1 then
						color = "|cffffd100"
					else
						color = "|cff19ff19"
					end
				else
					if faction == 1 then
						color = "|cff00adf0"
					else
						color = "|cffff1919"
					end
				end

				name = format("%s|cffffffff - |r%s%s|r", name, color, realm)
			end

			classTextColor = CUSTOM_CLASS_COLORS and CUSTOM_CLASS_COLORS[classToken] or RAID_CLASS_COLORS[classToken]

			nameText = _G["WorldStateScoreButton"..i.."NameText"]
			nameText:SetText(name)
			nameText:SetTextColor(classTextColor.r, classTextColor.g, classTextColor.b)
		end
	end
end)

local CreateFrame, GetCurrentMapAreaID = CreateFrame, GetCurrentMapAreaID
local scoreFrame1, scoreFrame2, scoreFrameToWin, scoreFrame1Text, scoreFrame2Text, scoreFrameToWinText, flagFrame1, flagButton1, flagFrame2, flagButton2, flagFrame1Text, flagFrame2Text
local allyFlag, hordeFlag

local function ShowEstimatedPoints()
	if AlwaysUpFrame1 and AlwaysUpFrame2 then
		if not scoreFrame1 then
			scoreFrame1 = CreateFrame("Frame", "DBM_ScoreFrame1", AlwaysUpFrame1)
			scoreFrame1:SetHeight(10)
			scoreFrame1:SetWidth(37)
			scoreFrame1:SetPoint("LEFT", "AlwaysUpFrame1Text", "RIGHT", 4, 0)
			scoreFrame1Text = scoreFrame1:CreateFontString("$parentText", "ARTWORK", "GameFontNormalSmall")
			scoreFrame1Text:SetAllPoints(scoreFrame1)
			scoreFrame1Text:SetJustifyH("LEFT")
		end
		if not scoreFrame2 then
			scoreFrame2 = CreateFrame("Frame", "DBM_ScoreFrame2", AlwaysUpFrame2)
			scoreFrame2:SetHeight(10)
			scoreFrame2:SetWidth(37)
			scoreFrame2:SetPoint("LEFT", "AlwaysUpFrame2Text", "RIGHT", 4, 0)
			scoreFrame2Text = scoreFrame2:CreateFontString("$parentText", "ARTWORK", "GameFontNormalSmall")
			scoreFrame2Text:SetAllPoints(scoreFrame2)
			scoreFrame2Text:SetJustifyH("LEFT")
		end
		scoreFrame1Text:SetText("")
		scoreFrame1:Show()
		scoreFrame2Text:SetText("")
		scoreFrame2:Show()
	end
end

local function ShowFlagDisplay()
	if (scoreFrame1Text and scoreFrame2Text) or AlwaysUpFrame2DynamicIconButton or AlwaysUpFrame3DynamicIconButton then

		if not flagFrame1 then
			if GetCurrentMapAreaID() == 444 and AlwaysUpFrame2DynamicIconButton then -- WG specific
				flagFrame1 = CreateFrame("Frame", "DBM_FlagFrame1", AlwaysUpFrame2DynamicIconButton)
				flagFrame1:SetPoint("LEFT", "AlwaysUpFrame2DynamicIconButton", "RIGHT", 4, 0)
				DBM:Debug("DBM_FlagFrame1 anchored to AlwaysUpFrame2DynamicIconButton")

				flagButton1 = flagButton1 or CreateFrame("Button", "DBM_FlagButton1", nil, "SecureActionButtonTemplate")
				flagButton1:SetPoint("LEFT", "AlwaysUpFrame2", "RIGHT", 15, 0)
				DBM:Debug("DBM_FlagButton1 anchored to AlwaysUpFrame2")
			elseif scoreFrame1 then
				flagFrame1 = CreateFrame("Frame", "DBM_FlagFrame1", scoreFrame1)
				flagFrame1:SetPoint("LEFT", "DBM_ScoreFrame1Text", "RIGHT", 4, 0)
				DBM:Debug("DBM_FlagFrame1 anchored to scoreFrame1")

				flagButton1 = flagButton1 or CreateFrame("Button", "DBM_FlagButton1", nil, "SecureActionButtonTemplate")
				flagButton1:SetPoint("LEFT", "AlwaysUpFrame1", "RIGHT", 50, 0)
				DBM:Debug("DBM_FlagButton1 anchored to AlwaysUpFrame1 after scoreFrame1")
			elseif AlwaysUpFrame1 then
				flagFrame1 = CreateFrame("Frame", "DBM_FlagFrame1", AlwaysUpFrame1)
				flagFrame1:SetPoint("LEFT", "AlwaysUpFrame1Text", "RIGHT", 4, 0)
				DBM:Debug("DBM_FlagFrame1 anchored to AlwaysUpFrame1")

				flagButton1 = flagButton1 or CreateFrame("Button", "DBM_FlagButton1", nil, "SecureActionButtonTemplate")
				flagButton1:SetPoint("LEFT", "AlwaysUpFrame1", "RIGHT", 15, 0)
				DBM:Debug("DBM_FlagButton1 anchored to AlwaysUpFrame1")
			end
			flagFrame1:SetHeight(10)
			flagFrame1:SetWidth(150)

			flagButton1:SetHeight(15)
			flagButton1:SetWidth(150)
			flagButton1:SetAttribute("type", "macro")

			flagFrame1Text = flagFrame1:CreateFontString("$parentText", "ARTWORK", "GameFontNormalSmall")
			flagFrame1Text:SetAllPoints(flagFrame1)
			flagFrame1Text:SetJustifyH("LEFT")
		end
		if not flagFrame2 then
			if GetCurrentMapAreaID() == 444 and AlwaysUpFrame3DynamicIconButton then -- WG specific
				flagFrame2 = CreateFrame("Frame", "DBM_FlagFrame2", AlwaysUpFrame3DynamicIconButton)
				flagFrame2:SetPoint("LEFT", "AlwaysUpFrame3DynamicIconButton", "RIGHT", 4, 0)
				DBM:Debug("DBM_FlagFrame2 anchored to AlwaysUpFrame3DynamicIconButton")

				flagButton2 = flagButton2 or CreateFrame("Button", "DBM_FlagButton2", nil, "SecureActionButtonTemplate")
				flagButton2:SetPoint("LEFT", "AlwaysUpFrame3", "RIGHT", 15, 0)
				DBM:Debug("DBM_FlagButton2 anchored to AlwaysUpFrame3")
			elseif scoreFrame2 then
				flagFrame2 = CreateFrame("Frame", "DBM_FlagFrame2", scoreFrame2)
				flagFrame2:SetPoint("LEFT", "DBM_ScoreFrame2Text", "RIGHT", 4, 0)
				DBM:Debug("DBM_FlagFrame2 anchored to scoreFrame2")

				flagButton2 = flagButton2 or CreateFrame("Button", "DBM_FlagButton2", nil, "SecureActionButtonTemplate")
				flagButton2:SetPoint("LEFT", "AlwaysUpFrame2", "RIGHT", 50, 0)
				DBM:Debug("DBM_FlagButton2 anchored to AlwaysUpFrame2 after scoreFrame2")
			elseif AlwaysUpFrame2 then
				flagFrame2 = CreateFrame("Frame", "DBM_FlagFrame2", AlwaysUpFrame2)
				flagFrame2:SetPoint("LEFT", "AlwaysUpFrame2Text", "RIGHT", 4, 0)
				DBM:Debug("DBM_FlagFrame2 anchored to AlwaysUpFrame2")

				flagButton2 = flagButton2 or CreateFrame("Button", "DBM_FlagButton2", nil, "SecureActionButtonTemplate")
				flagButton2:SetPoint("LEFT", "AlwaysUpFrame2", "RIGHT", 15, 0)
				DBM:Debug("DBM_FlagButton2 anchored to AlwaysUpFrame2")
			end
			flagFrame2:SetHeight(10)
			flagFrame2:SetWidth(150)

			flagButton2:SetHeight(15)
			flagButton2:SetWidth(150)
			flagButton2:SetAttribute("type", "macro")

			flagFrame2Text = flagFrame2:CreateFontString("$parentText", "ARTWORK", "GameFontNormalSmall")
			flagFrame2Text:SetAllPoints(flagFrame2)
			flagFrame2Text:SetJustifyH("LEFT")
		end
		flagFrame1Text:SetText("")
		flagFrame1:Show()
		flagButton1:Show()
		flagFrame2Text:SetText("")
		flagFrame2:Show()
		flagButton2:Show()
	end
end

local function HideFlagDisplay()
	if flagFrame1 and flagFrame2 then
		if flagFrame1Text then
			flagFrame1Text:SetText("")
			flagFrame1 = nil
		end
		if flagFrame2Text then
			flagFrame2Text:SetText("")
			flagFrame2 = nil
		end
	end
end

local function UpdateFlagDisplay()
	if flagFrame1Text and flagFrame2Text then
		if allyFlag then
			if GetCurrentMapAreaID() == 483 then -- EotS
				flagFrame1Text:SetText(L.Flag..": "..allyFlag)
			else
				flagFrame1Text:SetText(allyFlag)
			end
			flagButton1:SetAttribute("macrotext", "/targetexact "..allyFlag)
		else
			flagFrame1Text:SetText("")
			flagButton1:SetAttribute("macrotext", "")
		end

		if hordeFlag then
			if GetCurrentMapAreaID() == 483 then -- EotS
				flagFrame2Text:SetText(L.Flag..": "..hordeFlag)
			else
				flagFrame2Text:SetText(hordeFlag)
			end
			flagButton2:SetAttribute("macrotext", "/targetexact "..hordeFlag)
		else
			flagFrame2Text:SetText("")
			flagButton2:SetAttribute("macrotext", "")
		end
		if allyFlag and hordeFlag and not vulnerableTimer:IsStarted() then -- WSG specific (no need to check mapID since only this BG has 2 flags)
			vulnerableTimer:Start()
		end
	end
end

local function ShowBasesToWin()
	if not AlwaysUpFrame2 then
		return
	end
	if not scoreFrameToWin then
		scoreFrameToWin = CreateFrame("Frame", nil, AlwaysUpFrame2)
		scoreFrameToWin:SetHeight(10)
		scoreFrameToWin:SetWidth(200)
		scoreFrameToWin:SetPoint("TOPLEFT", "AlwaysUpFrame2", "BOTTOMLEFT", 22, 2)
		scoreFrameToWinText = scoreFrameToWin:CreateFontString(nil, nil, "GameFontNormalSmall")
		scoreFrameToWinText:SetAllPoints(scoreFrameToWin)
		scoreFrameToWinText:SetJustifyH("LEFT")
	end
	scoreFrameToWinText:SetText("")
	scoreFrameToWin:Show()
end

local function HideEstimatedPoints()
	if scoreFrame1 and scoreFrame2 then
		scoreFrame1:Hide()
		scoreFrame2:Hide()
	end
end

local function HideBasesToWin()
	if scoreFrameToWin then
		scoreFrameToWin:Hide()
	end
end

mod:AddBoolOption("ShowEstimatedPoints", true, nil, function()
	if mod.Options.ShowEstimatedPoints then
		ShowEstimatedPoints()
	else
		HideEstimatedPoints()
	end
end)
mod:AddBoolOption("ShowBasesToWin", true, nil, function()
	if mod.Options.ShowBasesToWin then
		ShowBasesToWin()
	else
		HideBasesToWin()
	end
end)
mod:AddBoolOption("ShowFlagCarrier", true, nil, function()
	if mod.Options.ShowFlagCarrier then
		ShowFlagDisplay()
	else
		HideFlagDisplay()
	end
end)

local getGametime, updateGametime
do
	local time, GetTime, GetBattlefieldInstanceRunTime = time, GetTime, GetBattlefieldInstanceRunTime
	local gameTime = 0

	function updateGametime()
		gameTime = time()
	end

	function getGametime()
		if mod.Options.ShowRelativeGameTime then
			local sysTime = GetBattlefieldInstanceRunTime()
			if sysTime and sysTime > 0 then
				return sysTime / 1000
			end
			return time() - gameTime
		end
		return GetTime()
	end
end

local subscribedMapID, prevAScore, prevHScore, warnAtEnd, hasWarns = 0, 0, 0, {}, false
local numObjectives, objectivesStore

function mod:SubscribeAssault(mapID, objectsCount)
	if self.Options.ShowEstimatedPoints then
		ShowEstimatedPoints()
	end
	if self.Options.ShowBasesToWin then
		ShowBasesToWin()
	end
	self:RegisterShortTermEvents(
		"UPDATE_WORLD_STATES",
		"CHAT_MSG_BG_SYSTEM_ALLIANCE",
		"CHAT_MSG_BG_SYSTEM_HORDE"
	)
	subscribedMapID = mapID
	objectivesStore = {}
	numObjectives = objectsCount
	updateGametime()
end

function mod:SubscribeFlags()
	if self.Options.ShowFlagCarrier then
		self:Schedule(0.5, ShowFlagDisplay) -- Applied 0.5s delay to give time for the game to create AlwaysUpFrame3DynamicIconButton. Added debug lines on the Flag frames creation to validate this delay is enough.
	end
	self:RegisterShortTermEvents(
		"CHAT_MSG_BG_SYSTEM_ALLIANCE",
		"CHAT_MSG_BG_SYSTEM_HORDE"
	)
end

do
	local pairs = pairs
	local IsInInstance, SendAddonMessage, RequestBattlefieldScoreData = IsInInstance, SendAddonMessage, RequestBattlefieldScoreData
	local bgzone, currentBGzone, lastBGzone = false, 0, 0

	local function Init(self)
		local _, instanceType = IsInInstance()
		if instanceType == "pvp" or instanceType == "arena" then
			RequestBattlefieldScoreData() -- for Cross-Faction UnitFactionGroup
			if bgzone and currentBGzone ~= lastBGzone then
				lastBGzone = GetCurrentMapAreaID()
				if hasWarns then
					DBM:AddMsg("DBM-PvP missing data, please report to our discord.")
					DBM:AddMsg("Battleground: " .. (subscribedMapID or "Unknown"))
					for k, v in pairs(warnAtEnd) do
						DBM:AddMsg(v .. "x " .. k)
					end
					DBM:AddMsg("Thank you for making DBM-PvP a better addon.")
				end
				self:UnregisterShortTermEvents()
				self:Stop()
				warnAtEnd = {}
				hasWarns = false
				HideEstimatedPoints()
				HideBasesToWin()
				HideFlagDisplay()
				subscribedMapID = nil
				prevAScore, prevHScore = 0, 0
				if mod.Options.HideBossEmoteFrame then
					DBM:HideBlizzardEvents(0, true)
				end
				TT:OnEvent("PLAYER_ENTERING_WORLD")
			end
			if not bgzone then
				SendAddonMessage("DBMv4-H", "", "BATTLEGROUND")
				self:Schedule(3, DBM.RequestTimers, DBM)
				if self.Options.HideBossEmoteFrame then
					DBM:HideBlizzardEvents(1, true)
				end
				lastBGzone = GetCurrentMapAreaID()
			end
			bgzone = true
		elseif bgzone then
			bgzone = false
			if hasWarns then
				DBM:AddMsg("DBM-PvP missing data, please report to our discord.")
				DBM:AddMsg("Battleground: " .. (subscribedMapID or "Unknown"))
				for k, v in pairs(warnAtEnd) do
					DBM:AddMsg(v .. "x " .. k)
				end
				DBM:AddMsg("Thank you for making DBM-PvP a better addon.")
			end
			self:UnregisterShortTermEvents()
			self:Stop()
			warnAtEnd = {}
			hasWarns = false
			HideEstimatedPoints()
			HideBasesToWin()
			HideFlagDisplay()
			subscribedMapID = nil
			prevAScore, prevHScore = 0, 0
			if mod.Options.HideBossEmoteFrame then
				DBM:HideBlizzardEvents(0, true)
			end
			TT:OnEvent("PLAYER_ENTERING_WORLD")
		end
	end

	function mod:ZONE_CHANGED_NEW_AREA()
		currentBGzone = GetCurrentMapAreaID()
		Init(self)
	end
	mod.PLAYER_ENTERING_WORLD	= mod.ZONE_CHANGED_NEW_AREA
	mod.OnInitialize			= mod.ZONE_CHANGED_NEW_AREA
end

local trackedUnits, syncTrackedUnits, gatesHP = {}, {}, {}
do
	local pairs, twipe = pairs, table.wipe
	local UnitGUID, UnitHealth, UnitHealthMax, SendAddonMessage = UnitGUID, UnitHealth, UnitHealthMax, SendAddonMessage
	local healthScan, trackedUnitsCount, gatesEventsRegistered = nil, 0, false

	local function updateInfoFrame()
		local lines, sortedLines = {}, {}
		for cid, health in pairs(syncTrackedUnits) do
			if trackedUnits[cid] then
				lines[trackedUnits[cid]] = health .. "%"
				sortedLines[#sortedLines + 1] = trackedUnits[cid]
			end
		end
		return lines, sortedLines
	end

	local function healthScanFunc()
		local syncs, syncCount = {}, 0
		for i = 1, 40 do
			if syncCount >= trackedUnitsCount then -- We've already scanned all our tracked units, exit out to save CPU
				break
			end
			local target = "raid" .. i .. "target"
			local guid = UnitGUID(target)
			if guid then
				local cid = mod:GetCIDFromGUID(guid)
				if trackedUnits[cid] and not syncs[cid] then
					syncs[cid] = true
					syncCount = syncCount + 1
					SendAddonMessage("DBM-PvP", format("%s:%.1f:%d", cid, UnitHealth(target) / UnitHealthMax(target) * 100, UnitHealth(target)), "BATTLEGROUND")
				end
			end
		end
	end

	function mod:TrackHealth(cid, name, gateHP)
		if not healthScan then
			healthScan = AceTimer:ScheduleRepeatingTimer(healthScanFunc, 1)
			-- workaround to register only once, instead of every TrackHealth call
			self:RegisterShortTermEvents("CHAT_MSG_ADDON")
		end
		if gateHP and self.Options.ShowGatesHealth and not gatesEventsRegistered then
			gatesEventsRegistered = true
			self:RegisterShortTermEvents(
				"SPELL_BUILDING_DAMAGE",
				"CHAT_MSG_RAID_BOSS_EMOTE"
			)
		end
		trackedUnits[cid] = L[name] or name

		if gateHP and self.Options.ShowGatesHealth then
			syncTrackedUnits[cid] = 100 -- fills the infoFrame with all the gates
			gatesHP[cid] = {gateHP, gateHP, L[name] or name} -- {GateHealth, GateHealthMax, GatePOITexture}
		end

		trackedUnitsCount = trackedUnitsCount + 1
		if not DBM.InfoFrame:IsShown() then
			DBM.InfoFrame:SetHeader((gateHP and self.Options.ShowGatesHealth and L.GatesHealthFrame) or L.InfoFrameHeader)
			DBM.InfoFrame:Show(42, "function", updateInfoFrame, false, false)
			DBM.InfoFrame:SetColumns(1)
		end
	end

	function mod:StopTrackHealth()
		if healthScan then
			AceTimer:CancelTimer(healthScan)
			healthScan = nil
		end
		twipe(trackedUnits)
		twipe(syncTrackedUnits)
		if gatesEventsRegistered then
			twipe(gatesHP)
			gatesEventsRegistered = false
		end
		DBM.InfoFrame:Hide()
	end

	function mod:GatesHPReset()
		for cid, _ in pairs(syncTrackedUnits) do
			trackedUnits[cid] = gatesHP[cid][3] -- resets POI icon/name
			syncTrackedUnits[cid] = 100 -- resets gate HP percentage
			gatesHP[cid][1] = gatesHP[cid][2] -- resets gate HP
			DBM:Debug(gatesHP[cid][3]..cid.." reset with HP: "..gatesHP[cid][1])
		end
	end

	function mod:SPELL_BUILDING_DAMAGE(sourceGUID, _, _, destGUID, destName, _, _, _, _, amount)
		if sourceGUID == nil or destName == nil or destGUID == nil or amount == nil then
			return
		end
		local cId = DBM:GetCIDFromGUID(destGUID)
		if not gatesHP[cId] then
			DBM:Debug("SPELL_BUILDING_DAMAGE on ID: "..cId.." is not a tracked unit")
			DBM:AddMsg("DBM-PvP missing gate data, please notify Zidras on Github or Discord - ID: "..cId.." and Name: "..destName)
			return
		end
		if gatesHP[cId][1] == nil then -- first hit
			if self.Options.ShowGatesHealth then
				if not DBM.InfoFrame:IsShown() then
					DBM.InfoFrame:Show(7, "function", updateInfoFrame, false, false, true)
				else
					DBM.InfoFrame:Update()
				end
			end
		end
		if gatesHP[cId][1] > amount then
			gatesHP[cId][1] = gatesHP[cId][1] - amount
		else
			gatesHP[cId][1] = 0
		end
		if self.Options.ShowGatesHealth then
			DBM.InfoFrame:Update()
		end
		SendAddonMessage("DBM-PvP", format("%s:%.1f:%d", cId, gatesHP[cId][1] / gatesHP[cId][2] * 100, gatesHP[cId][1]), "BATTLEGROUND")
	end

	function mod:CHAT_MSG_RAID_BOSS_EMOTE(msg)
		if not DBM.InfoFrame:IsShown() then return end
		-- Gate of the Green Emerald
		if msg == L.GreenEmeraldAttacked then
			trackedUnits[190722] = L.GreenEmeraldAttackedTex
		elseif msg == L.GreenEmeraldDestroyed then
			trackedUnits[190722] = L.GreenEmeraldDestroyedTex
			syncTrackedUnits[190722] = 0
			gatesHP[190722][1] = 0
		-- Gate of the Blue Sapphire
		elseif msg == L.BlueSapphireAttacked then
			trackedUnits[190724] = L.BlueSapphireAttackedTex
		elseif msg == L.BlueSapphireDestroyed then
			trackedUnits[190724] = L.BlueSapphireDestroyedTex
			syncTrackedUnits[190724] = 0
			gatesHP[190724][1] = 0
		-- Gate of the Purple Amethyst
		elseif msg == L.PurpleAmethystAttacked then
			trackedUnits[190723] = L.PurpleAmethystAttackedTex
		elseif msg == L.PurpleAmethystDestroyed then
			trackedUnits[190723] = L.PurpleAmethystDestroyedTex
			syncTrackedUnits[190723] = 0
			gatesHP[190723][1] = 0
		-- Gate of the Red Sun
		elseif msg == L.RedSunAttacked then
			trackedUnits[190726] = L.RedSunAttackedTex
		elseif msg == L.RedSunDestroyed then
			trackedUnits[190726] = L.RedSunDestroyedTex
			syncTrackedUnits[190726] = 0
			gatesHP[190726][1] = 0
		-- Gate of the Yellow Moon
		elseif msg == L.YellowMoonAttacked then
			trackedUnits[190727] = L.YellowMoonAttackedTex
		elseif msg == L.YellowMoonDestroyed then
			trackedUnits[190727] = L.YellowMoonDestroyedTex
			syncTrackedUnits[190727] = 0
			gatesHP[190727][1] = 0
		-- Chamber of Ancient Relics
		elseif msg == L.ChamberAncientRelicsAttacked then
			trackedUnits[192549] = L.ChamberAncientRelicsAttackedTex
		elseif msg == L.ChamberAncientRelicsDestroyed then
			trackedUnits[192549] = L.ChamberAncientRelicsDestroyedTex
			syncTrackedUnits[192549] = 0
			gatesHP[192549][1] = 0
		end
	end

	function mod:CHAT_MSG_ADDON(prefix, msg, channel, sender)
		if channel ~= "BATTLEGROUND" or (prefix ~= "DBM-PvP" and prefix ~= "Capping") then -- Lets listen to capping as well, for extra data.
			return
		end
		local cid, hpPerc, hpRaw = strsplit(":", msg)
		local cId, hpPercN, hpRawN = tonumber(cid), tonumber(hpPerc), tonumber(hpRaw)

		-- Update gatesHP table, since only the person inside the vehicle sees the CLEU event
		if gatesHP[cId] and gatesHP[cId][1] > hpRawN then
			gatesHP[cId][1] = hpRawN
			DBM:Debug("GatesHP table synced. "..gatesHP[cId][3]..", cId: "..cid..", now has "..gatesHP[cId][1].." HP")
		end

		if gatesHP[cId] and syncTrackedUnits[cId] and tonumber(syncTrackedUnits[cId]) < hpPercN then
			--TO DO: sync gates on BG join
			DBM:Debug(sender.." is not synced and is sending wrong information about cId: "..cid..". Received ".. hpPerc.."% and "..hpRaw.." HP, while cached table already having ".. syncTrackedUnits[cId])
		else
			syncTrackedUnits[cId] = hpPerc
		end
	end
end

do
	local smatch = string.match
	local FACTION_ALLIANCE = FACTION_ALLIANCE

	local flagTimer			= mod:NewTimer(8, "TimerFlag", "Interface\\Icons\\INV_Banner_02")
	local startTimer		= mod:NewTimer(120, "TimerStart", GetBattlefieldFaction("player") == "Alliance" and "Interface\\Icons\\INV_BannerPVP_02" or "Interface\\Icons\\INV_BannerPVP_01", nil, nil, nil, nil, nil, 1, 5)
	local timerShadow		= mod:NewNextTimer(90, 34709)

	local function updateflagcarrier(self, msg)
		if not self.Options.TimerFlag then
			return
		end
		if smatch(msg, L.FlagCaptured) or smatch(msg, L.FlagCapturedTC) or (L.FlagCapturedATC and smatch(msg, L.FlagCapturedATC)) or (L.FlagCapturedHTC and smatch(msg, L.FlagCapturedHTC)) or smatch(msg, L.ExprFlagCaptured) or smatch(msg, L.ExprFlagCapturedTC) then
			if smatch(msg, L.ExprFlagCaptured) or smatch(msg, L.ExprFlagCapturedTC) then -- Warsong Gulch
				flagTimer:Start(23)
			else
				flagTimer:Start()
			end
			if msg:find(FACTION_ALLIANCE) or msg:find("Alliance") then -- workaround to Warmane's missing BG localizations
				flagTimer:SetColor({r=0, g=0, b=1})
				flagTimer:UpdateIcon("Interface\\Icons\\INV_BannerPVP_02")
			else
				flagTimer:SetColor({r=1, g=0, b=0})
				flagTimer:UpdateIcon("Interface\\Icons\\INV_BannerPVP_01")
			end
			vulnerableTimer:Cancel()
		end
	end

	function mod:CHAT_MSG_BG_SYSTEM_ALLIANCE(...)
		updateflagcarrier(self, ...)
		if self.Options.ShowFlagCarrier then
			local msg, _, _, _, name = ...
			if smatch(msg, L.FlagTaken) or smatch(msg, L.FlagTakenTC) then -- Eye of the Storm
				local carrier = (name ~= "" and name) or smatch(msg, L.FlagTaken) or smatch(msg, L.FlagTakenTC) -- Missng arg5 on Warmane events
				if carrier then
					allyFlag = carrier
					hordeFlag = nil
					UpdateFlagDisplay()
				end
			elseif smatch(msg, L.ExprFlagPickUp) or smatch(msg, L.ExprFlagPickUpTC) or (L.ExprFlagPickUpHTC and smatch(msg, L.ExprFlagPickUpHTC)) then -- Warsong Gulch
				if name then
					allyFlag = name
					UpdateFlagDisplay()
				end
			elseif smatch(msg, L.FlagDropped) or smatch(msg, L.FlagDroppedTC) then -- Eye of the Storm
				allyFlag = nil
				hordeFlag = nil
				UpdateFlagDisplay()
			elseif smatch(msg, L.ExprFlagDropped) or smatch(msg, L.ExprFlagDroppedTC) or (L.ExprFlagDroppedATC and smatch(msg, L.ExprFlagDroppedATC)) or (L.ExprFlagDroppedHTC and smatch(msg, L.ExprFlagDroppedHTC)) then -- Warsong Gulch
				hordeFlag = nil
				UpdateFlagDisplay()
			elseif smatch(msg, L.FlagCaptured) or smatch(msg, L.FlagCapturedTC) or (L.FlagCapturedATC and smatch(msg, L.FlagCapturedATC)) or smatch(msg, L.ExprFlagCaptured) or smatch(msg, L.ExprFlagCapturedTC) then
				allyFlag = nil
				hordeFlag = nil
				UpdateFlagDisplay()
			end
		end

	end

	function mod:CHAT_MSG_BG_SYSTEM_HORDE(...)
		updateflagcarrier(self, ...)
		if self.Options.ShowFlagCarrier then
			local msg, _, _, _, name = ...
			if smatch(msg, L.FlagTaken) or smatch(msg, L.FlagTakenTC) then -- Eye of the Storm
				local carrier = (name ~= "" and name) or smatch(msg, L.FlagTaken) or smatch(msg, L.FlagTakenTC) -- Missng arg5 on Warmane events
				if carrier then
					allyFlag = nil
					hordeFlag = carrier
					UpdateFlagDisplay()
				end
			elseif smatch(msg, L.ExprFlagPickUp) or smatch(msg, L.ExprFlagPickUpTC) or (L.ExprFlagPickUpATC and smatch(msg, L.ExprFlagPickUpATC)) then -- Warsong Gulch
				if name then
					hordeFlag = name
					UpdateFlagDisplay()
				end
			elseif smatch(msg, L.FlagDropped) or smatch(msg, L.FlagDroppedTC) then -- Eye of the Storm
				allyFlag = nil
				hordeFlag = nil
				UpdateFlagDisplay()
			elseif smatch(msg, L.ExprFlagDropped) or smatch(msg, L.ExprFlagDroppedTC) or (L.ExprFlagDroppedATC and smatch(msg, L.ExprFlagDroppedATC)) or (L.ExprFlagDroppedHTC and smatch(msg, L.ExprFlagDroppedHTC)) then -- Warsong Gulch
				allyFlag = nil
				UpdateFlagDisplay()
			elseif smatch(msg, L.FlagCaptured) or smatch(msg, L.FlagCapturedTC) or (L.FlagCapturedHTC and smatch(msg, L.FlagCapturedHTC)) or smatch(msg, L.ExprFlagCaptured) or smatch(msg, L.ExprFlagCapturedTC) then
				allyFlag = nil
				hordeFlag = nil
				UpdateFlagDisplay()
			end
		end
	end

	function mod:CHAT_MSG_BG_SYSTEM_NEUTRAL(msg)
		TT:OnEvent("CHAT_MSG_BG_SYSTEM_NEUTRAL", msg) -- TimerTracker
		if msg == L.BGStart120 or msg == L.BgStart120TC or msg == L.BgStart120Alterac or msg == L.BgStart120Arathi or msg == L.BgStart120EotS or msg == L.BgStart120IoConquest or msg == L.BgStart120SotA or msg == L.BgStart120Warsong then
			startTimer:Update(0, 120)
			startTimer:UpdateIcon(GetBattlefieldFaction("player") == "Alliance" and "Interface\\Icons\\INV_BannerPVP_02" or "Interface\\Icons\\INV_BannerPVP_01")
		elseif msg == L.BgStart60TC or msg == L.BgStart60OLD or  msg == L.BgStart60Alterac or msg == L.BgStart60AlteracTC or msg == L.BgStart60Arathi or msg == L.BgStart60ArathiOLD or msg == L.BgStart60EotS or msg == L.BgStart60IoConquest or msg == L.BgStart60SotA or msg == L.BgStart60SotAOLD or msg == L.BgStart60SotA2 or msg == L.BgStart60SotA2TC or msg == L.BgStart60Warsong or msg == L.BgStart60WarsongTC then
			startTimer:Update(60, 120)
			startTimer:UpdateIcon(GetBattlefieldFaction("player") == "Alliance" and "Interface\\Icons\\INV_BannerPVP_02" or "Interface\\Icons\\INV_BannerPVP_01")
			if msg == L.BgStart60SotA2 or msg == L.BgStart60SotA2TC then
				if DBM.InfoFrame:IsShown() then
					self:GatesHPReset()
				end
			end
		elseif msg == L.BgStart30TC or msg == L.BgStart30OLD or msg == L.BgStart30Alterac or msg == L.BgStart30AlteracTC or msg == L.BgStart30Arathi or msg == L.BgStart30ArathiOLD or msg == L.BgStart30EotS or msg == L.BgStart30IoConquest or msg == L.BgStart30SotA or msg == L.BgStart30SotAOLD or msg == L.BgStart30SotA2 or msg == L.BgStart30SotA2TC or msg == L.BgStart30Warsong or msg == L.BgStart30WarsongTC then
			startTimer:Update(90, 120)
			startTimer:UpdateIcon(GetBattlefieldFaction("player") == "Alliance" and "Interface\\Icons\\INV_BannerPVP_02" or "Interface\\Icons\\INV_BannerPVP_01")
		elseif msg == L.Vulnerable1 or msg:find(L.Vulnerable1) then
			vulnerableTimer:Start(300)
			vulnerableTimer:UpdateIcon(46393)
		-- Arenas
		elseif msg == L.Start60 or msg == L.Start60TC then
			startTimer:Start(60)
		elseif msg == L.Start30 or msg == L.Start30TC then
			startTimer:Update(30, 60)
		elseif msg == L.Start15 or msg == L.Start15TC then
			startTimer:Update(45, 60)
			timerShadow:Schedule(15)
		elseif smatch(msg, L.FlagReset) or smatch(msg, L.FlagResetTC) then
			vulnerableTimer:Cancel()
			if self.Options.ShowFlagCarrier then
				allyFlag = nil
				hordeFlag = nil
				UpdateFlagDisplay()
			end
		-- Isle of Conquest Gates
		elseif self.Options.ShowGatesHealth then
			-- Horde Front Gate
			if msg == L.HordeGateFrontDestroyed or msg == L.HordeGateFrontDestroyedTC then
				trackedUnits[64422] = L.HordeGateFrontDestroyedTex
				syncTrackedUnits[64422] = 0
				gatesHP[64422][1] = 0
			-- Horde West Gate
			elseif msg == L.HordeGateWestDestroyed or msg == L.HordeGateWestDestroyedTC then
				trackedUnits[64423] = L.HordeGateWestDestroyedTex
				syncTrackedUnits[64423] = 0
				gatesHP[64423][1] = 0
			-- Horde East Gate
			elseif msg == L.HordeGateEastDestroyed or msg == L.HordeGateEastDestroyedTC then
				trackedUnits[64424] = L.HordeGateEastDestroyedTex
				syncTrackedUnits[64424] = 0
				gatesHP[64424][1] = 0
			-- Alliance East Gate
			elseif msg == L.AllianceGateEastDestroyed or msg == L.AllianceGateEastDestroyedTC then
				trackedUnits[64626] = L.AllianceGateEastDestroyedTex
				syncTrackedUnits[64626] = 0
				gatesHP[64626][1] = 0
			-- Alliance West Gate
			elseif msg == L.AllianceGateWestDestroyed or msg == L.AllianceGateWestDestroyedTC then
				trackedUnits[64627] = L.AllianceGateWestDestroyedTex
				syncTrackedUnits[64627] = 0
				gatesHP[64627][1] = 0
			-- Alliance Front Gate
			elseif msg == L.AllianceGateFrontDestroyed or msg == L.AllianceGateFrontDestroyedTC then
				trackedUnits[64628] = L.AllianceGateFrontDestroyedTex
				syncTrackedUnits[64628] = 0
				gatesHP[64628][1] = 0
			end
		end
	end
end

do
	local pairs, select, tonumber, mfloor, mmin, smatch = pairs, select, tonumber, math.floor, math.min, string.match
	local GetMapLandmarkInfo, GetNumMapLandmarks, GetWorldStateUIInfo = GetMapLandmarkInfo, GetNumMapLandmarks, GetWorldStateUIInfo
	local FACTION_HORDE, FACTION_ALLIANCE = FACTION_HORDE, FACTION_ALLIANCE

	local winTimer = mod:NewTimer(30, "TimerWin", GetBattlefieldFaction("player") == "Alliance" and "Interface\\Icons\\INV_BannerPVP_02" or "Interface\\Icons\\INV_BannerPVP_01")
	local resourcesPerSec = {
		[4] = { -- Eye of the Storm
			[0] = 1e-300,
			[1] = 0.5,
			[2] = 1,
			[3] = 2,
			[4] = 5
		},
		[5] = { -- Arathi Basin/Isle of Conquest
			[0] = 1e-300,
			[1] = 10/12,
			[2] = 10/9,
			[3] = 10/6,
			[4] = 10/3,
			[5] = 30
		}
	}

	function mod:UpdateWinTimer(maxScore, allianceScore, hordeScore, allianceBases, hordeBases)
		local resPerSec = resourcesPerSec[numObjectives]
		-- Start debug
		if prevAScore ~= allianceScore then
			if resPerSec[allianceBases] == 1000 then
				local key = format("%d,%d", allianceScore - prevAScore, allianceBases)
				local warnCount = warnAtEnd[key] or 0
				warnAtEnd[key] = warnCount + 1
				if warnCount > 2 then
					hasWarns = true
				end
			end
			if allianceScore < maxScore then
				DBM:Debug(format("Alliance: +%d (%d)", allianceScore - prevAScore, allianceBases), 3)
			end
			prevAScore = allianceScore
		end
		if prevHScore ~= hordeScore then
			if resPerSec[hordeBases] == 1000 then
				local key = format("%d,%d", hordeScore - prevHScore, hordeBases)
				local warnCount = warnAtEnd[key] or 0
				warnAtEnd[key] = warnCount + 1
				if warnCount > 2 then
					hasWarns = true
				end
			end
			if hordeScore < maxScore then
				DBM:Debug(format("Horde: +%d (%d)", hordeScore - prevHScore, hordeBases), 3)
			end
			prevHScore = hordeScore
		end
		-- End debug
		local gameTime = getGametime()
		local allyTime = mfloor(mmin(maxScore, (maxScore - allianceScore) / resPerSec[allianceBases]))
		local hordeTime = mfloor(mmin(maxScore, (maxScore - hordeScore) / resPerSec[hordeBases]))
		if allyTime == hordeTime or allyTime == 0 or hordeTime == 0 then
			winTimer:Stop()
			if scoreFrame1Text then
				scoreFrame1Text:SetText("")
				scoreFrame2Text:SetText("")
			end
		elseif allyTime > hordeTime then
			if scoreFrame1Text and scoreFrame2Text then
				scoreFrame1Text:SetText("(" .. mfloor(mfloor(((hordeTime * resPerSec[allianceBases]) + allianceScore) / 10) * 10) .. ")")
				scoreFrame2Text:SetText("(" .. maxScore .. ")")
			end
			winTimer:Update(gameTime, gameTime + hordeTime)
			winTimer:DisableEnlarge()
			winTimer:UpdateName(L.WinBarText:format(FACTION_HORDE))
			winTimer:SetColor({r=1, g=0, b=0})
			winTimer:UpdateIcon("Interface\\Icons\\INV_BannerPVP_01")
		elseif hordeTime > allyTime then
			if scoreFrame1Text and scoreFrame2Text then
				scoreFrame2Text:SetText("(" .. mfloor(mfloor(((allyTime * resPerSec[hordeBases]) + hordeScore) / 10) * 10) .. ")")
				scoreFrame1Text:SetText("(" .. maxScore .. ")")
			end
			winTimer:Update(gameTime, gameTime + allyTime)
			winTimer:DisableEnlarge()
			winTimer:UpdateName(L.WinBarText:format(FACTION_ALLIANCE))
			winTimer:SetColor({r=0, g=0, b=1})
			winTimer:UpdateIcon("Interface\\Icons\\INV_BannerPVP_02")
		end
		if self.Options.ShowBasesToWin then
			local friendlyLast, enemyLast, friendlyBases, enemyBases
			if GetBattlefieldFaction("player") == "Alliance" then
				friendlyLast = allianceScore
				enemyLast = hordeScore
				friendlyBases = allianceBases
				enemyBases = hordeBases
			else
				friendlyLast = hordeScore
				enemyLast = allianceScore
				friendlyBases = hordeBases
				enemyBases = allianceBases
			end
			if (maxScore - friendlyLast) / resPerSec[friendlyBases] > (maxScore - enemyLast) / resPerSec[enemyBases] then
				local enemyTime, friendlyTime, baseLowest, enemyFinal, friendlyFinal
				for i = 1, numObjectives do
					enemyTime = (maxScore - enemyLast) / resPerSec[numObjectives - i]
					friendlyTime = (maxScore - friendlyLast) / resPerSec[i]
					baseLowest = friendlyTime < enemyTime and friendlyTime or enemyTime
					enemyFinal = mfloor((enemyLast + mfloor(baseLowest * resPerSec[numObjectives - i] + 0.5)) / 10) * 10
					friendlyFinal = mfloor((friendlyLast + mfloor(baseLowest * resPerSec[i] + 0.5)) / 10) * 10
					if friendlyFinal >= maxScore and enemyFinal < maxScore then
						scoreFrameToWinText:SetText(L.BasesToWin:format(i))
						break
					end
				end
			else
				scoreFrameToWinText:SetText("")
			end
		end
	end

	local overrideTimers = {
		-- Alterac Valley
		[402] = 240
	}
	local State = {
		["ALLY_CONTESTED"]		= 1,
		["ALLY_CONTROLLED"]		= 2,
		["HORDE_CONTESTED"]		= 3,
		["HORDE_CONTROLLED"]	= 4
	}
	local icons = {
		-- Graveyard
		[4]							= State.ALLY_CONTESTED,
		[15]						= State.ALLY_CONTROLLED,
		[14]						= State.HORDE_CONTESTED,
		[13]						= State.HORDE_CONTROLLED,
		-- Tower/Lighthouse
		[9]							= State.ALLY_CONTESTED,
		[11]						= State.ALLY_CONTROLLED,
		[12]						= State.HORDE_CONTESTED,
		[10]						= State.HORDE_CONTROLLED,
		-- Mine/Quarry
		[17]						= State.ALLY_CONTESTED,
		[18]						= State.ALLY_CONTROLLED,
		[19]						= State.HORDE_CONTESTED,
		[20]						= State.HORDE_CONTROLLED,
		-- Lumber
		[22]						= State.ALLY_CONTESTED,
		[23]						= State.ALLY_CONTROLLED,
		[24]						= State.HORDE_CONTESTED,
		[25]						= State.HORDE_CONTROLLED,
		-- Blacksmith/Waterworks
		[27]						= State.ALLY_CONTESTED,
		[28]						= State.ALLY_CONTROLLED,
		[29]						= State.HORDE_CONTESTED,
		[30]						= State.HORDE_CONTROLLED,
		-- Farm
		[32]						= State.ALLY_CONTESTED,
		[33]						= State.ALLY_CONTROLLED,
		[34]						= State.HORDE_CONTESTED,
		[35]						= State.HORDE_CONTROLLED,
		-- Stables
		[37]						= State.ALLY_CONTESTED,
		[38]						= State.ALLY_CONTROLLED,
		[39]						= State.HORDE_CONTESTED,
		[40]						= State.HORDE_CONTROLLED,
		-- Workshop
		[137]						= State.ALLY_CONTESTED,
		[138]						= State.ALLY_CONTROLLED,
		[139]						= State.HORDE_CONTESTED,
		[140]						= State.HORDE_CONTROLLED,
		-- Hangar
		[142]						= State.ALLY_CONTESTED,
		[143]						= State.ALLY_CONTROLLED,
		[144]						= State.HORDE_CONTESTED,
		[145]						= State.HORDE_CONTROLLED,
		-- Docks
		[147]						= State.ALLY_CONTESTED,
		[148]						= State.ALLY_CONTROLLED,
		[149]						= State.HORDE_CONTESTED,
		[150]						= State.HORDE_CONTROLLED,
		-- Refinery
		[152]						= State.ALLY_CONTESTED,
		[153]						= State.ALLY_CONTROLLED,
		[154]						= State.HORDE_CONTESTED,
		[155]						= State.HORDE_CONTROLLED,
		-- Market
		[208]						= State.ALLY_CONTESTED,
		[205]						= State.ALLY_CONTROLLED,
		[209]						= State.HORDE_CONTESTED,
		[206]						= State.HORDE_CONTROLLED,
		-- Ruins
		[213]						= State.ALLY_CONTESTED,
		[210]						= State.ALLY_CONTROLLED,
		[214]						= State.HORDE_CONTESTED,
		[211]						= State.HORDE_CONTROLLED,
		-- Shrine
		[218]						= State.ALLY_CONTESTED,
		[215]						= State.ALLY_CONTROLLED,
		[219]						= State.HORDE_CONTESTED,
		[216]						= State.HORDE_CONTROLLED
	}
	local capTimer = mod:NewTimer(60, "TimerCap", "Interface\\AddOns\\DBM-PvP\\Textures\\Spell_Misc_HellifrePVPHonorHoldFavor")

	function mod:UPDATE_WORLD_STATES()
		local allyBases, hordeBases = 0, 0
		if subscribedMapID ~= 0 then
			for i = 1, GetNumMapLandmarks(), 1 do
				local infoName, _, infoTexture = GetMapLandmarkInfo(i)
				if infoName then
					-- work-around for a bug in the german localization of WoW: the graveyard seems to change its name depending on the state
					if infoName == "Friedhof des Sturmlanzen" then
						infoName = "Friedhof der Sturmlanzen"
					end
					local isAllyCapping, isHordeCapping
					if infoTexture then
						isAllyCapping = icons[infoTexture] == State.ALLY_CONTESTED
						isHordeCapping = icons[infoTexture] == State.HORDE_CONTESTED
					end
					if objectivesStore[infoName] ~= infoTexture then
						capTimer:Stop(infoName)
						objectivesStore[infoName] = infoTexture
						if isAllyCapping or isHordeCapping then
							capTimer:Start(overrideTimers[subscribedMapID] or 60, infoName)
							if isAllyCapping then
								capTimer:SetColor({r=0, g=0, b=1}, infoName)
								capTimer:UpdateIcon("Interface\\Icons\\INV_BannerPVP_02", infoName)
							else
								capTimer:SetColor({r=1, g=0, b=0}, infoName)
								capTimer:UpdateIcon("Interface\\Icons\\INV_BannerPVP_01", infoName)
							end
						end
					end
				end
			end
			if subscribedMapID == 462 or subscribedMapID == 483 then -- Arathi Basin | Eye of the Storm
				for _, v in pairs(objectivesStore) do
					if icons[v] == State.ALLY_CONTROLLED then
						allyBases = allyBases + 1
					elseif icons[v] == State.HORDE_CONTROLLED then
						hordeBases = hordeBases + 1
					end
				end

				local isEotS = subscribedMapID == 483
				local allyIndex = isEotS and 2 or 1
				local hordeIndex = isEotS and 3 or 2

				-- ex ab: "Bases: 0 Resources: 0/1600"
				local allyScoreText = select(3, GetWorldStateUIInfo(allyIndex)) or ""
				local hordeScoreText = select(3, GetWorldStateUIInfo(hordeIndex)) or ""

				local allyCurrent, maxResources = smatch(allyScoreText, "(%d+)/(%d+)")
				allyCurrent = tonumber(allyCurrent) or 0
				maxResources = tonumber(maxResources) or 1600

				local hordeCurrent = smatch(hordeScoreText, "(%d+)/")
				hordeCurrent = tonumber(hordeCurrent) or 0

				self:UpdateWinTimer(maxResources, allyCurrent, hordeCurrent, allyBases, hordeBases)
			end
		end
	end
end
