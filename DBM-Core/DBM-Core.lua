-- *********************************************************
-- **               Deadly Boss Mods - Core               **
-- **            http://www.deadlybossmods.com            **
-- *********************************************************
--
-- This addon is written and copyrighted by:
--    * Paul Emmerich (Tandanu @ EU-Aegwynn) (DBM-Core)
--    * Martin Verges (Nitram @ EU-Azshara) (DBM-GUI)
--
-- The localizations are written by:
--    * enGB/enUS: Tandanu				http://www.deadlybossmods.com
--    * deDE: Tandanu					http://www.deadlybossmods.com
--    * zhCN: Diablohu					http://wow.gamespot.com.cn
--    * ruRU: BootWin					bootwin@gmail.com
--    * ruRU: Vampik					admin@vampik.ru
--    * zhTW: Hman						herman_c1@hotmail.com
--    * zhTW: Azael/kc10577				kc10577@hotmail.com
--    * koKR: BlueNyx					bluenyx@gmail.com
--    * esES: Interplay/1nn7erpLaY      http://www.1nn7erpLaY.com
--
-- Special thanks to:
--    * Arta (DBM-Party)
--    * Omegal @ US-Whisperwind (continuing mod support for 3.2+)
--    * Tennberg (a lot of fixes in the enGB/enUS localization)
--
--
-- The code of this addon is licensed under a Creative Commons Attribution-Noncommercial-Share Alike 3.0 License. (see license.txt)
-- All included textures and sounds are copyrighted by their respective owners, license information for these media files can be found in the modules that make use of them.
--
--
--  You are free:
--    * to Share - to copy, distribute, display, and perform the work
--    * to Remix - to make derivative works
--  Under the following conditions:
--    * Attribution. You must attribute the work in the manner specified by the author or licensor (but not in any way that suggests that they endorse you or your use of the work). (A link to http://www.deadlybossmods.com is sufficient)
--    * Noncommercial. You may not use this work for commercial purposes.
--    * Share Alike. If you alter, transform, or build upon this work, you may distribute the resulting work only under the same or similar license to this one.
--


----------------------
--  Combat log Fix  --
----------------------
--[[local tCLFix = 0

local function fCLFix(self,elapsed)
    tCLFix = tCLFix + elapsed
    if tCLFix >= 2 then --time (in seconds) it takes before it executes the command on line 6
		CombatLogClearEntries()
        tCLFix = 0 --resets the timer
    end
end

local f = CreateFrame("frame")
f:SetScript("OnUpdate", fCLFix)
--]]
-------------------------------
--  Globals/Default Options  --
-------------------------------
DBM = {
	Revision = ("$Revision: 6011 $"):sub(12, -3),
	Version = "6.11",
	DisplayVersion = "6.11 DBM-WoWCircle by Barsoom for WoWCircle WotLK (https://github.com/Barsoomx/DBM-wowcircle)", -- the string that is shown as version
	ReleaseRevision = 6011 -- the revision of the latest stable version that is available (for /dbm ver2)
}

DBM_SavedOptions = {}

DBM.DefaultOptions = {
	WarningColors = {
		{r = 0.41, g = 0.80, b = 0.94}, -- Color 1 - #69CCF0 - Turqoise
		{r = 0.95, g = 0.95, b = 0.00}, -- Color 2 - #F2F200 - Yellow
		{r = 1.00, g = 0.50, b = 0.00}, -- Color 3 - #FF8000 - Orange
		{r = 1.00, g = 0.10, b = 0.10}, -- Color 4 - #FF1A1A - Red
	},
	RaidWarningSound = "Sound\\Doodad\\BellTollNightElf.wav",
	SpecialWarningSound = "Sound\\Spells\\PVPFlagTaken.wav",
	RaidWarningPosition = {
		Point = "TOP",
		X = 0,
		Y = -185,
	},
	StatusEnabled = true,
	AutoRespond = true,
	Enabled = true,
	ShowWarningsInChat = true,
	ShowFakedRaidWarnings = false,
	WarningIconLeft = true,
	WarningIconRight = true,
	HideBossEmoteFrame = false,
	SpamBlockRaidWarning = true,
	SpamBlockBossWhispers = false,
	ShowMinimapButton = true,
	FixCLEUOnCombatStart = true,
	BlockVersionUpdatePopup = true,
	ShowSpecialWarnings = true,
	AlwaysShowHealthFrame = false,
	ShowBigBrotherOnCombatStart = false,
	RangeFrameFrames = "radar",
	RangeFrameUpdates = "Average",
	RangeFramePoint = "CENTER",
	RangeFrameX = 50,
	RangeFrameY = -50,
	RangeFrameSound1 = "none",
	RangeFrameSound2 = "none",
	RangeFrameLocked = false,
	RangeFrameRadarPoint = "CENTER",
	RangeFrameRadarX = 100,
	RangeFrameRadarY = -100,
	HPFramePoint = "CENTER",
	HPFrameX = -50,
	HPFrameY = 50,
	HPFrameMaxEntries = 5,
	SpecialWarningPoint = "CENTER",
	SpecialWarningX = 0,
	SpecialWarningY = 75,
	SpecialWarningFont = STANDARD_TEXT_FONT,
	SpecialWarningFontSize = 50,
	SpecialWarningFontColor = {0.0, 0.0, 1.0},
	HealthFrameGrowUp = false,
	HealthFrameLocked = false,
	HealthFrameWidth = 200,
	ArrowPosX = 0,
	ArrowPosY = 0,
	ArrowPoint = "CENTER",
	-- global boss mod settings (overrides mod-specific settings for some options)
	DontShowBossAnnounces = false,
	DontSendBossAnnounces = false,
	DontSendBossWhispers = false,
	DontSetIcons = false,
	LatencyThreshold = 250,
	BigBrotherAnnounceToRaid = false,
	DisableCinematics = true,
	AudioPull = true,
	DontSendYells = false,
	DebugMode = false,
	DebugLevel = 1,
	SilentMode = false,
--	HelpMessageShown = false,
}

DBM.Bars = DBT:New()
DBM.Mods = {}
DBM.ModLists = {}
------------------------
-- Global Identifiers --
------------------------
DBM_DISABLE_ZONE_DETECTION = newproxy(false)
DBM_OPTION_SPACER = newproxy(false)

--------------
--  Locals  --
--------------
local inCombat = {}
local oocBWComms = {}
local combatInfo = {}
local bossIds = {}
local updateFunctions = {}
local raid = {}
local modSyncSpam = {}
local autoRespondSpam = {}
local chatPrefix = "<Deadly Boss Mods> "
local chatPrefixShort = "<DBM> "
local ver = ("%s (r%d)"):format(DBM.DisplayVersion, DBM.Revision)
local mainFrame = CreateFrame("Frame", "DBMMainFrame")
local newerVersionPerson = {}
local newerRevisionPerson = {}
local showedUpdateReminder = true
local combatInitialized = false
local healthCombatInitialized = false
local pformat
local schedulerFrame = CreateFrame("Frame", "DBMScheduler")
schedulerFrame:Hide()
local startScheduler
local schedule
local unschedule
local unscheduleAll
local scheduleCountdown
local loadOptions
local loadModOptions
local checkWipe
local checkBossHealth
local checkCustomBossHealth
local fireEvent
local playerName = UnitName("player")
local playerLevel = UnitLevel("player")
local _, playerClass = UnitClass("player")
local playerRealm = GetRealmName()
local LastInstanceMapID = -1
local LastGroupSize = 0
local iconFolder = "Interface\\AddOns\\DBM-Core\\icon\\"
local LastInstanceType = nil
local watchFrameRestore = false
local bossHealth = {}
local bossHealthuIdCache = {}
local bossuIdCache = {}
local savedDifficulty, difficultyText, difficultyIndex
local lastBossEngage = {}
local lastBossDefeat = {}
local timerRequestInProgress = false
local updateNotificationDisplayed = 0
local showConstantReminder = 0
local tooltipsHidden = false
local SWFilterDisabed = 3
local currentSpecName, currentSpecGroup
local cSyncSender = {}
local cSyncReceived = 0
local canSetIcons = {}
local iconSetRevision = {}
local iconSetPerson = {}
local addsGUIDs = {}
local targetEventsRegistered = false
local statusWhisperDisabled = false
local statusGuildDisabled = false
local UpdateChestTimer
local breakTimerStart
local delayedFunction
local dataBroker
local voiceSessionDisabled = false
local handleSync
local targetMonitor = {}
local wowVersion = select(4, GetBuildInfo())

local enableIcons = true -- set to false when a raid leader or a promoted player has a newer version of DBM

local bannedMods = { -- a list of "banned" (meaning they are replaced by another mod like DBM-Battlegrounds (replaced by DBM-PvP)) boss mods, these mods will not be loaded by DBM (and they wont show up in the GUI)
	"DBM_API",
	"DBM-Outlands",
	"DBM-Battlegrounds", --replaced by DBM-PvP
}

--------------------------------------------------------
--  Cache frequently used global variables in locals  --
--------------------------------------------------------
local DBM = DBM
-- these global functions are accessed all the time by the event handler
-- so caching them is worth the effort
local ipairs, pairs, next = ipairs, pairs, next
local tinsert, tremove, twipe, tsort, tconcat = table.insert, table.remove, table.wipe, table.sort, table.concat
local type, select, tonumber = type, select, tonumber
local GetTime = GetTime
local bband = bit.band
local floor, mhuge, mmin, mmax = math.floor, math.huge, math.min, math.max
local GetNumPartyMembers, GetNumRaidMembers, GetRaidRosterInfo = GetNumPartyMembers, GetNumRaidMembers, GetRaidRosterInfo
local UnitName, GetUnitName = UnitName, GetUnitName
local IsInInstance = IsInInstance
local UnitAffectingCombat, InCombatLockdown, IsFalling, UnitPlayerOrPetInRaid, UnitPlayerOrPetInParty = UnitAffectingCombat, InCombatLockdown, IsFalling, UnitPlayerOrPetInRaid, UnitPlayerOrPetInParty
local UnitGUID, UnitHealth, UnitHealthMax, UnitBuff, UnitDebuff = UnitGUID, UnitHealth, UnitHealthMax, UnitBuff, UnitDebuff
local UnitExists, UnitIsDead, UnitIsFriend, UnitIsUnit, UnitIsAFK = UnitExists, UnitIsDead, UnitIsFriend, UnitIsUnit, UnitIsAFK
local GetInstanceInfo = GetInstanceInfo
local GetSpellInfo, GetSpellTexture, GetSpellCooldown = GetSpellInfo, GetSpellTexture, GetSpellCooldown

local GetActiveTalentGroup = C_Talent and C_Talent.GetActiveTalentGroup or GetActiveTalentGroup

local UnitDetailedThreatSituation = UnitDetailedThreatSituation
local UnitIsPartyLeader, UnitIsRaidOfficer = UnitIsPartyLeader, UnitIsRaidOfficer
local PlaySoundFile, PlaySound = PlaySoundFile, PlaySound

local SendAddonMessage = SendAddonMessage

-- for Phanx' Class Colors
local RAID_CLASS_COLORS = CUSTOM_CLASS_COLORS or RAID_CLASS_COLORS

---------------------------------
--  General (local) functions  --
---------------------------------
-- checks if a given value is in an array
-- returns true if it finds the value, false otherwise
local function checkEntry(t, val)
	for i, v in ipairs(t) do
		if v == val then
			return true
		end
	end
	return false
end

local function findEntry(t, val)
	for i, v in ipairs(t) do
		if v and val and val:find(v) then
			return true
		end
	end
	return false
end

-- removes all occurrences of a value in an array
-- returns true if at least one occurrence was remove, false otherwise
local function removeEntry(t, val)
	local existed = false
	for i = #t, 1, -1 do
		if t[i] == val then
			tremove(t, i)
			existed = true
		end
	end
	return existed
end

-- automatically sends an addon message to the appropriate channel (BATTLEGROUND, RAID or PARTY)
local function sendSync(prefix, msg)
	msg = msg or ""
	local zoneType = select(2, IsInInstance())
	if zoneType == "pvp" or zoneType == "arena" then
		SendAddonMessage(prefix, msg, "BATTLEGROUND")
	elseif GetRealNumRaidMembers() > 0 then
		SendAddonMessage(prefix, msg, "RAID")
	elseif GetRealNumPartyMembers() > 0 then
		SendAddonMessage(prefix, msg, "PARTY")
	end
end

--
local function strFromTime(time)
	if type(time) ~= "number" then time = 0 end
	time = floor(time)
	if time < 60 then
		return DBM_CORE_TIMER_FORMAT_SECS:format(time)
	elseif time % 60 == 0 then
		return DBM_CORE_TIMER_FORMAT_MINS:format(time/60)
	else
		return DBM_CORE_TIMER_FORMAT:format(time/60, time % 60)
	end
end

do
	-- fail-safe format, replaces missing arguments with unknown
	-- note: doesn't handle cases like %%%s correctly at the moment (should become %unknown, but becomes %%s)
	-- also, the end of the format directive is not detected in all cases, but handles everything that occurs in our boss mods ;)
	--> not suitable for general-purpose use, just for our warnings and timers (where an argument like a spell-target might be nil due to missing target information from unreliable detection methods)
	local function replace(cap1, cap2)
		return cap1 == "%" and DBM_CORE_UNKNOWN
	end

	function pformat(fstr, ...)
		local ok, str = pcall(format, fstr, ...)
		return ok and str or fstr:gsub("(%%+)([^%%%s<]+)", replace):gsub("%%%%", "%%")
	end
end

-- sends a whisper to a player by his or her character name or BNet presence id
-- returns true if the message was sent, nil otherwise
local function sendWhisper(target, msg)
	if type(target) == "number" then
		if not BNIsSelf(target) then -- never send BNet whispers to ourselves
			BNSendWhisper(target, msg)
			return true
		end
	elseif type(target) == "string" then
		-- whispering to ourselves here is okay and somewhat useful for whisper-warnings
		SendChatMessage(msg, "WHISPER", nil, target)
		return true
	end
end
local BNSendWhisper = sendWhisper

local function stripServerName(cap)
	return cap:sub(2, -2)
end

--------------
--  Events  --
--------------
do
	local registeredEvents = {}
	local registeredSpellIds = {}
	local unfilteredCLEUEvents = {}
	local registeredUnitEventIds = {}
	local argsMT = {__index = {}}
	local args = setmetatable({}, argsMT)

	function argsMT.__index:IsSpellID(a1, a2, a3, a4, a5)
		local v = self.spellId
		return v == a1 or v == a2 or v == a3 or v == a4 or v == a5
	end

	function argsMT.__index:IsPlayer()
		return bband(args.destFlags, COMBATLOG_OBJECT_AFFILIATION_MINE) ~= 0 and bband(args.destFlags, COMBATLOG_OBJECT_TYPE_PLAYER) ~= 0
	end

	function argsMT.__index:IsPlayerSource()
		return bband(args.sourceFlags, COMBATLOG_OBJECT_AFFILIATION_MINE) ~= 0 and bband(args.sourceFlags, COMBATLOG_OBJECT_TYPE_PLAYER) ~= 0
	end

	function argsMT.__index:IsNPC()
		return bband(args.destFlags, COMBATLOG_OBJECT_TYPE_NPC) ~= 0
	end

	function argsMT.__index:IsPet()
		return bband(args.destFlags, COMBATLOG_OBJECT_TYPE_PET) ~= 0
	end

	function argsMT.__index:IsPetSource()
		return bband(args.sourceFlags, COMBATLOG_OBJECT_TYPE_PET) ~= 0
	end

	function argsMT.__index:IsSrcTypePlayer()
		return bband(args.sourceFlags, COMBATLOG_OBJECT_TYPE_PLAYER) ~= 0
	end

	function argsMT.__index:IsDestTypePlayer()
		return bband(args.destFlags, COMBATLOG_OBJECT_TYPE_PLAYER) ~= 0
	end

	function argsMT.__index:IsSrcTypeHostile()
		return bband(args.sourceFlags, COMBATLOG_OBJECT_REACTION_HOSTILE) ~= 0
	end

	function argsMT.__index:IsDestTypeHostile()
		return bband(args.destFlags, COMBATLOG_OBJECT_REACTION_HOSTILE) ~= 0
	end

	function argsMT.__index:GetSrcCreatureID()
		return DBM:GetCIDFromGUID(self.sourceGUID)
	end

	function argsMT.__index:GetDestCreatureID()
		return DBM:GetCIDFromGUID(self.destGUID)
	end

	local function handleEvent(self, event, ...)
		if not registeredEvents[event] or DBM.Options and not DBM.Options.Enabled then return end
		for i, v in ipairs(registeredEvents[event]) do
			if type(v[event]) == "function" and (not v.zones or checkEntry(v.zones, GetRealZoneText()) or checkEntry(v.zones, GetCurrentMapAreaID())) and (not v.Options or v.Options.Enabled) then
				v[event](v, ...)
			end
		end
	end

	function DBM:RegisterEvents(...)
		for i = 1, select("#", ...) do
			local event = select(i, ...)
			registeredEvents[event] = registeredEvents[event] or {}
			tinsert(registeredEvents[event], self)
			mainFrame:RegisterEvent(event)
		end
	end

	DBM:RegisterEvents("ADDON_LOADED")

	function DBM:FilterRaidBossEmote(msg, ...)
		return handleEvent(nil, "CHAT_MSG_RAID_BOSS_EMOTE_FILTERED", msg:gsub("\124c%x+(.-)\124r", "%1"), ...)
	end

	function DBM:COMBAT_LOG_EVENT_UNFILTERED(timestamp, event, sourceGUID, sourceName, sourceFlags, destGUID, destName, destFlags, ...)
		if not registeredEvents[event] then return end
		twipe(args)
		args.timestamp = timestamp
		args.event = event
		args.sourceGUID = sourceGUID
		args.sourceName = sourceName
		args.sourceFlags = sourceFlags
		args.destGUID = destGUID
		args.destName = destName
		args.destFlags = destFlags
		-- taken from Blizzard_CombatLog.lua
		if event == "SWING_DAMAGE" then
			args.amount, args.overkill, args.school, args.resisted, args.blocked, args.absorbed, args.critical, args.glancing, args.crushing = select(1, ...)
		elseif event == "SWING_MISSED" then
			args.spellName = ACTION_SWING
			args.missType = select(1, ...)
		elseif event:sub(1, 5) == "RANGE" then
			args.spellId, args.spellName, args.spellSchool = select(1, ...)
			if event == "RANGE_DAMAGE" then
				args.amount, args.overkill, args.school, args.resisted, args.blocked, args.absorbed, args.critical, args.glancing, args.crushing = select(4, ...)
			elseif event == "RANGE_MISSED" then
				args.missType = select(4, ...)
			end
		elseif event:sub(1, 5) == "SPELL" then
			args.spellId, args.spellName, args.spellSchool = select(1, ...)
			if event == "SPELL_DAMAGE" then
				args.amount, args.overkill, args.school, args.resisted, args.blocked, args.absorbed, args.critical, args.glancing, args.crushing = select(4, ...)
			elseif event == "SPELL_MISSED" then
				args.missType, args.amountMissed = select(4, ...)
			elseif event == "SPELL_HEAL" then
				args.amount, args.overheal, args.absorbed, args.critical = select(4, ...)
				args.school = args.spellSchool
			elseif event == "SPELL_ENERGIZE" then
				args.valueType = 2
				args.amount, args.powerType = select(4, ...)
			elseif event:sub(1, 14) == "SPELL_PERIODIC" then
				if event == "SPELL_PERIODIC_MISSED" then
					args.missType = select(4, ...)
				elseif event == "SPELL_PERIODIC_DAMAGE" then
					args.amount, args.overkill, args.school, args.resisted, args.blocked, args.absorbed, args.critical, args.glancing, args.crushing = select(4, ...)
				elseif event == "SPELL_PERIODIC_HEAL" then
					args.amount, args.overheal, args.absorbed, args.critical = select(4, ...)
					args.school = args.spellSchool
				elseif event == "SPELL_PERIODIC_DRAIN" then
					args.amount, args.powerType, args.extraAmount = select(4, ...)
					args.valueType = 2
				elseif event == "SPELL_PERIODIC_LEECH" then
					args.amount, args.powerType, args.extraAmount = select(4, ...)
					args.valueType = 2
				elseif event == "SPELL_PERIODIC_ENERGIZE" then
					args.amount, args.powerType = select(4, ...)
					args.valueType = 2
				end
			elseif event == "SPELL_DRAIN" then
				args.amount, args.powerType, args.extraAmount = select(4, ...)
				args.valueType = 2
			elseif event == "SPELL_LEECH" then
				args.amount, args.powerType, args.extraAmount = select(4, ...)
				args.valueType = 2
			elseif event == "SPELL_INTERRUPT" then
				args.extraSpellId, args.extraSpellName, args.extraSpellSchool = select(4, ...)
			elseif event == "SPELL_EXTRA_ATTACKS" then
				args.amount = select(4, ...)
			elseif event == "SPELL_DISPEL_FAILED" then
				args.extraSpellId, args.extraSpellName, args.extraSpellSchool = select(4, ...)
			elseif event == "SPELL_AURA_DISPELLED" then
				args.extraSpellId, args.extraSpellName, args.extraSpellSchool = select(4, ...)
				args.auraType = select(7, ...)
			elseif event == "SPELL_AURA_STOLEN" then
				args.extraSpellId, args.extraSpellName, args.extraSpellSchool = select(4, ...)
				args.auraType = select(7, ...)
			elseif event == "SPELL_AURA_APPLIED" or event == "SPELL_AURA_REMOVED" then
				args.auraType = select(4, ...)
				args.sourceName = args.destName
				args.sourceGUID = args.destGUID
				args.sourceFlags = args.destFlags
			elseif event == "SPELL_AURA_APPLIED_DOSE" or event == "SPELL_AURA_REMOVED_DOSE" then
				args.auraType, args.amount = select(4, ...)
				args.sourceName = args.destName
				args.sourceGUID = args.destGUID
				args.sourceFlags = args.destFlags
			elseif event == "SPELL_CAST_FAILED" then
				args.missType = select(4, ...)
			end
		elseif event == "DAMAGE_SHIELD" then
			args.spellId, args.spellName, args.spellSchool = select(1, ...)
			args.amount, args.school, args.resisted, args.blocked, args.absorbed, args.critical, args.glancing, args.crushing = select(4, ...)
		elseif event == "DAMAGE_SHIELD_MISSED" then
			args.spellId, args.spellName, args.spellSchool = select(1, ...)
			args.missType = select(4, ...)
		elseif event == "ENCHANT_APPLIED" then
			args.spellName = select(1,...)
			args.itemId, args.itemName = select(2,...)
		elseif event == "ENCHANT_REMOVED" then
			args.spellName = select(1,...)
			args.itemId, args.itemName = select(2,...)
		elseif event == "UNIT_DIED" or event == "UNIT_DESTROYED" then
			args.sourceName = args.destName
			args.sourceGUID = args.destGUID
			args.sourceFlags = args.destFlags
		elseif event == "ENVIRONMENTAL_DAMAGE" then
			args.environmentalType = select(1,...)
			args.amount, args.overkill, args.school, args.resisted, args.blocked, args.absorbed, args.critical, args.glancing, args.crushing = select(2, ...)
			args.spellName = _G["ACTION_"..event.."_"..args.environmentalType]
			args.spellSchool = args.school
		elseif event == "DAMAGE_SPLIT" then
			args.spellId, args.spellName, args.spellSchool = select(1, ...)
			args.amount, args.school, args.resisted, args.blocked, args.absorbed, args.critical, args.glancing, args.crushing = select(4, ...)
		end
		return handleEvent(nil, event, args)
	end
	mainFrame:SetScript("OnEvent", handleEvent)
end

--------------
--  OnLoad  --
--------------
do
	local isLoaded = false
	local onLoadCallbacks = {}
	local disabledMods = {}
	local function showOldVerWarning()
		StaticPopupDialogs["DBM_OLD_VERSION"] = {
			text = DBM_CORE_ERROR_DBMV3_LOADED,
			button1 = DBM_CORE_OK,
			OnAccept = function()
				DisableAddOn("DBM_API")
				ReloadUI()
			end,
			timeout = 0,
			exclusive = 1,
			whileDead = 1,
		}
		StaticPopup_Show("DBM_OLD_VERSION")
	end

	local function setCombatInitialized()
		combatInitialized = true
	end

	-- register a callback that will be executed once the addon is fully loaded (ADDON_LOADED fired, saved vars are available)
	function DBM:RegisterOnLoadCallback(cb)
		if isLoaded then
			cb()
		else
			onLoadCallbacks[#onLoadCallbacks + 1] = cb
		end
	end

	function DBM:ADDON_LOADED(modname)
		if modname == "DBM-Core" and not isLoaded then
			isLoaded = true
			loadOptions()
			DBM.Bars:LoadOptions("DBM")
			DBM.Arrow:LoadPosition()
			if not DBM.Options.ShowMinimapButton then DBM:HideMinimapButton() end
			for i, v in ipairs(onLoadCallbacks) do
				xpcall(v, geterrorhandler())
			end
			onLoadCallbacks = nil
			self.AddOns = {}
			for i = 1, GetNumAddOns() do
				if GetAddOnMetadata(i, "X-DBM-Mod") and not checkEntry(bannedMods, GetAddOnInfo(i)) then
					tinsert(self.AddOns, {
						sort		= tonumber(GetAddOnMetadata(i, "X-DBM-Mod-Sort") or mhuge) or mhuge,
						category	= GetAddOnMetadata(i, "X-DBM-Mod-Category") or "Other",
						name		= GetAddOnMetadata(i, "X-DBM-Mod-Name") or "",
						zone		= {strsplit(",", GetAddOnMetadata(i, "X-DBM-Mod-LoadZone") or "")},
						zoneId		= {strsplit(",", GetAddOnMetadata(i, "X-DBM-Mod-LoadZoneID") or "")},
						subTabs		= GetAddOnMetadata(i, "X-DBM-Mod-SubCategories") and {strsplit(",", GetAddOnMetadata(i, "X-DBM-Mod-SubCategories"))},
						hasHeroic	= tonumber(GetAddOnMetadata(i, "X-DBM-Mod-Has-Heroic-Mode") or 1) == 1,
						modId		= GetAddOnInfo(i),
					})
					for k, v in ipairs(self.AddOns[#self.AddOns].zone) do
						self.AddOns[#self.AddOns].zone[k] = (self.AddOns[#self.AddOns].zone[k]):trim()
					end
					for i = #self.AddOns[#self.AddOns].zoneId, 1, -1 do
						local id = tonumber(self.AddOns[#self.AddOns].zoneId[i])
						if id then
							self.AddOns[#self.AddOns].zoneId[i] = id
						else
							tremove(self.AddOns[#self.AddOns].zoneId, i)
						end
					end
					if self.AddOns[#self.AddOns].subTabs then
						for k, v in ipairs(self.AddOns[#self.AddOns].subTabs) do
							self.AddOns[#self.AddOns].subTabs[k] = (self.AddOns[#self.AddOns].subTabs[k]):trim()
						end
					end
				end
			end
			tsort(self.AddOns, function(v1, v2) return v1.sort < v2.sort end)
			self:RegisterEvents(
				"COMBAT_LOG_EVENT_UNFILTERED",
				"ZONE_CHANGED_NEW_AREA",
				"RAID_ROSTER_UPDATE",
				"PARTY_MEMBERS_CHANGED",
				"CHAT_MSG_ADDON",
				"PLAYER_REGEN_DISABLED",
				"PLAYER_REGEN_ENABLED",
				"UNIT_DIED",
				"UNIT_DESTROYED",
				"CHAT_MSG_WHISPER",
				"CHAT_MSG_BN_WHISPER",
				"CHAT_MSG_MONSTER_YELL",
				"CHAT_MSG_MONSTER_EMOTE",
				"CHAT_MSG_MONSTER_SAY",
				"CHAT_MSG_RAID_BOSS_EMOTE",
				"PLAYER_ENTERING_WORLD",
				"SPELL_CAST_SUCCESS",
				"LFG_PROPOSAL_SHOW",
				"LFG_PROPOSAL_FAILED",
				"LFG_PROPOSAL_SUCCEEDED",
				"LFG_UPDATE",
				"PLAYER_TALENT_UPDATE"
			)
			self:ZONE_CHANGED_NEW_AREA()
			self:RAID_ROSTER_UPDATE()
			self:PARTY_MEMBERS_CHANGED()
			DBM:Schedule(1.5, setCombatInitialized)
			local enabled, loadable = select(4, GetAddOnInfo("DBM_API"))
			if enabled and loadable then showOldVerWarning() end
		end
	end
end

function DBM:LFG_PROPOSAL_SHOW()
	DBM.Bars:CreateBar(40, DBM_LFG_INVITE, "Interface\\Icons\\Spell_Holy_BorrowedTime")
end

function DBM:LFG_PROPOSAL_FAILED()
	DBM.Bars:CancelBar(DBM_LFG_INVITE)
end

function DBM:LFG_UPDATE()
	local _, joined = GetLFGInfoServer()
	if not joined then
		DBM.Bars:CancelBar(DBM_LFG_INVITE)
	end
end

-----------------
--  Callbacks  --
-----------------
do
	local callbacks = {}

	function fireEvent(event, ...)
		if not callbacks[event] then return end
		for i, v in ipairs(callbacks[event]) do
			local ok, err = pcall(v, event, ...)
			if not ok then DBM:AddMsg(("Error while executing callback %s for event %s: %s"):format(tostring(v), tostring(event), err)) end
		end
	end

	function DBM:FireEvent(event, ...)
		fireEvent(event, ...)
	end

	function DBM:IsCallbackRegistered(event, f)
		if not event or type(f) ~= "function" then
			error("Usage: IsCallbackRegistered(event, callbackFunc)", 2)
		end
		if not callbacks[event] then return end
		for i = 1, #callbacks[event] do
			if callbacks[event][i] == f then return true end
		end
		return false
	end

	function DBM:RegisterCallback(event, f)
		if not event or type(f) ~= "function" then
			error("Usage: DBM:RegisterCallback(event, callbackFunc)", 2)
		end
		callbacks[event] = callbacks[event] or {}
		tinsert(callbacks[event], f)
		return #callbacks[event]
	end

	function DBM:UnregisterCallback(event, f)
		if not event or not callbacks[event] then return end
		if f then
			if type(f) ~= "function" then
				error("Usage: UnregisterCallback(event, callbackFunc)", 2)
			end
			--> checking from the end to start and not stoping after found one result in case of a func being twice registered.
			for i = #callbacks[event], 1, -1 do
				if callbacks[event][i] == f then tremove (callbacks[event], i) end
			end
		else
			callbacks[event] = nil
		end
	end
end


--------------------------
--  OnUpdate/Scheduler  --
--------------------------
do
	-- stack that stores a few tables (up to 8) which will be recycled
	local popCachedTable, pushCachedTable
	local numChachedTables = 0
	do
		local tableCache = nil

		-- gets a table from the stack, it will then be recycled.
		function popCachedTable()
			local t = tableCache
			if t then
				tableCache = t.next
				numChachedTables = numChachedTables - 1
			end
			return t
		end

		-- tries to push a table on the stack
		-- only tables with <= 4 array entries are accepted as cached tables are only used for tasks with few arguments as we don't want to have big arrays wasting our precious memory space doing nothing...
		-- also, the maximum number of cached tables is limited to 8 as DBM rarely has more than eight scheduled tasks with less than 4 arguments at the same time
		-- this is just to re-use all the tables of the small tasks that are scheduled all the time (like the wipe detection)
		-- note that the cache does not use weak references anywhere for performance reasons, so a cached table will never be deleted by the garbage collector
		function pushCachedTable(t)
			if numChachedTables < 8 and #t <= 4 then
				twipe(t)
				t.next = tableCache
				tableCache = t
				numChachedTables = numChachedTables + 1
			end
		end
	end

	-- priority queue (min-heap) that stores all scheduled tasks.
	-- insert: O(log n)
	-- deleteMin: O(log n)
	-- getMin: O(1)
	-- removeAllMatching: O(n)
	local insert, removeAllMatching, getMin, deleteMin
	do
		local heap = {}
		local firstFree = 1

		-- gets the next task
		function getMin()
			return heap[1]
		end

		-- restores the heap invariant by moving an item up
		local function siftUp(n)
			local parent = floor(n / 2)
			while n > 1 and heap[parent].time > heap[n].time do -- move the element up until the heap invariant is restored, meaning the element is at the top or the element's parent is <= the element
				heap[n], heap[parent] = heap[parent], heap[n] -- swap the element with its parent
				n = parent
				parent = floor(n / 2)
			end
		end

		-- restores the heap invariant by moving an item down
		local function siftDown(n)
			local m -- position of the smaller child
			while 2 * n < firstFree do -- #children >= 1
				-- swap the element with its smaller child
				if 2 * n + 1 == firstFree then -- n does not have a right child --> it only has a left child as #children >= 1
					m = 2 * n -- left child
				elseif heap[2 * n].time < heap[2 * n + 1].time then -- #children = 2 and left child < right child
					m = 2 * n -- left child
				else -- #children = 2 and right child is smaller than the left one
					m = 2 * n + 1 -- right
				end
				if heap[n].time <= heap[m].time then -- n is <= its smallest child --> heap invariant restored
					return
				end
				heap[n], heap[m] = heap[m], heap[n]
				n = m
			end
		end

		-- inserts a new element into the heap
		function insert(ele)
			heap[firstFree] = ele
			siftUp(firstFree)
			firstFree = firstFree + 1
		end

		-- deletes the min element
		function deleteMin()
			local min = heap[1]
			firstFree = firstFree - 1
			heap[1] = heap[firstFree]
			heap[firstFree] = nil
			siftDown(1)
			return min
		end

		-- removes multiple scheduled tasks from the heap
		-- note that this function is comparatively slow by design as it has to check all tasks and allows partial matches
		function removeAllMatching(f, mod, ...)
			-- remove all elements that match the signature, this destroyes the heap and leaves a normal array
			local v, match
			local foundMatch = false
			for i = #heap, 1, -1 do -- iterate backwards over the array to allow usage of table.remove
				v = heap[i]
				if (not f or v.func == f) and (not mod or v.mod == mod) then
					match = true
					for j = 1, select("#", ...) do
						if select(j, ...) ~= v[j] then
							match = false
							break
						end
					end
					if match then
						tremove(heap, i)
						firstFree = firstFree - 1
						foundMatch = true
					end
				end
			end
			-- rebuild the heap from the array in O(n)
			if foundMatch then
				for i = floor((firstFree - 1) / 2), 1, -1 do
					siftDown(i)
				end
			end
		end
	end


	local wrappers = {}
	local function range(max, cur, ...)
		cur = cur or 1
		if cur > max then
			return ...
		end
		return cur, range(max, cur + 1, select(2, ...))
	end
	local function getWrapper(n)
		wrappers[n] = wrappers[n] or loadstring(([[
			return function(func, tbl)
				return func(]] .. ("tbl[%s], "):rep(n):sub(0, -3) .. [[)
			end
		]]):format(range(n)))()
		return wrappers[n]
	end

	local nextModSyncSpamUpdate = 0
	--mainFrame:SetScript("OnUpdate", function(self, elapsed)
	local function onUpdate(self, elapsed)
		local time = GetTime()

		-- execute scheduled tasks
		local nextTask = getMin()
		while nextTask and nextTask.func and nextTask.time <= time do
			deleteMin()
			local n = nextTask.n
			if n == #nextTask then
				nextTask.func(unpack(nextTask))
			else
				-- too many nil values (or a trailing nil)
				-- this is bad because unpack will not work properly
				-- TODO: is there a better solution?
				getWrapper(n)(nextTask.func, nextTask)
			end
			pushCachedTable(nextTask)
			nextTask = getMin()
		end

		-- execute OnUpdate handlers of all modules
		local foundModFunctions = 0
		for i, v in pairs(updateFunctions) do
			foundModFunctions = foundModFunctions + 1
			if i.Options.Enabled and (not i.zones or checkEntry(i.zones, GetRealZoneText()) or checkEntry(i.zones, GetCurrentMapAreaID())) then
				i.elapsed = (i.elapsed or 0) + elapsed
				if i.elapsed >= (i.updateInterval or 0) then
					v(i, i.elapsed)
					i.elapsed = 0
				end
			end
		end

		-- clean up sync spam timers and auto respond spam blockers
		if time > nextModSyncSpamUpdate then
			nextModSyncSpamUpdate = time + 20
			-- TODO: optimize this; using next(t, k) all the time on nearly empty hash tables is not a good idea...doesn't really matter here as modSyncSpam only very rarely contains more than 4 entries...
			-- we now do this just every 20 seconds since the earlier assumption about modSyncSpam isn't true any longer
			-- note that not removing entries at all would be just a small memory leak and not a problem (the sync functions themselves check the timestamp)
			local k, v = next(modSyncSpam, nil)
			if v and (time - v > 8) then
				modSyncSpam[k] = nil
			end
		end
		if not nextTask and foundModFunctions == 0 then--Nothing left, stop scheduler
			schedulerFrame:SetScript("OnUpdate", nil)
			schedulerFrame:Hide()
		end
	end

	function startScheduler()
		if not schedulerFrame:IsShown() then
			schedulerFrame:Show()
			schedulerFrame:SetScript("OnUpdate", onUpdate)
		end
	end

	function schedule(t, f, mod, ...)
		if type(f) ~= "function" then
			error("usage: schedule(time, func, [mod, args...])", 2)
		end
		startScheduler()
		local v
		if numChachedTables > 0 and select("#", ...) <= 4 then -- a cached table is available and all arguments fit into an array with four slots
			v = popCachedTable()
			v.time = GetTime() + t
			v.func = f
			v.mod = mod
			v.n = select("#", ...)
			for i = 1, v.n do
				v[i] = select(i, ...)
			end
			-- clear slots if necessary
			for i = v.n + 1, 4 do
				v[i] = nil
			end
		else -- create a new table
			v = {time = GetTime() + t, func = f, mod = mod, n = select("#", ...), ...}
		end
		insert(v)
	end

	function scheduleCountdown(time, numAnnounces, func, mod, self, ...)
		time = time or 5
		numAnnounces = numAnnounces or 3
		for i = 1, numAnnounces do
			schedule(time - i, func, mod, self, i, ...)
		end
	end

	function unschedule(f, mod, ...)
		if not f and not mod then
			-- you really want to kill the complete scheduler? call unscheduleAll
			--DBM:Debug("cannot unschedule everything, pass a function and/or a mod",3)
		end
		return removeAllMatching(f, mod, ...)
	end

	function unscheduleAll()
		return removeAllMatching()
	end
end

function DBM:Schedule(t, f, ...)
	if type(f) ~= "function" then
		error("usage: DBM:Schedule(time, func, [args...])", 2)
	end
	return schedule(t, f, nil, ...)
end

function DBM:Unschedule(f, ...)
	return unschedule(f, nil, ...)
end


----------------------
--  Slash Commands  --
----------------------
SLASH_DEADLYBOSSMODS1 = "/dbm"
SLASH_PULL1 = "/pull"
SlashCmdList["DEADLYBOSSMODS"] = function(msg)
	local cmd = msg:lower()
	if cmd == "ver" or cmd == "version" then
		DBM:ShowVersions(false)
	elseif cmd == "ver2" or cmd == "version2" then
		DBM:ShowVersions(true)
	elseif cmd == "rel" or cmd == "release" then  -- Added to broadcast the version check to raid chat
		DBM:ShowRelease()
	elseif cmd == "unlock" or cmd == "move" then
		DBM.Bars:ShowMovableBar()
	elseif cmd == "help" then
		for i, v in ipairs(DBM_CORE_SLASHCMD_HELP) do DBM:AddMsg(v) end
	elseif cmd:sub(1, 5) == "timer" then
		local time, text = msg:match("^%w+ ([%d:]+) (.+)$")
		if not (time and text) then
			DBM:AddMsg(DBM_PIZZA_ERROR_USAGE)
			return
		end
		local min, sec = string.split(":", time)
		min = tonumber(min or "") or 0
		sec = tonumber(sec or "")
		if min and not sec then
			sec = min
			min = 0
		end
		time = min * 60 + sec
		DBM:CreatePizzaTimer(time, text)
	elseif cmd:sub(1, 15) == "broadcast timer" then
		local time, text = msg:match("^%w+ %w+ ([%d:]+) (.+)$")
		if DBM:GetRaidRank() == 0 then
			DBM:AddMsg(DBM_ERROR_NO_PERMISSION)
		end
		if not (time and text) then
			DBM:AddMsg(DBM_PIZZA_ERROR_USAGE)
			return
		end
		local min, sec = string.split(":", time)
		min = tonumber(min or "") or 0
		sec = tonumber(sec or "")
		if min and not sec then
			sec = min
			min = 0
		end
		time = min * 60 + sec
		DBM:CreatePizzaTimer(time, text, true)
	elseif cmd:sub(0,5) == "break" then
		if DBM:GetRaidRank() == 0 then
			DBM:AddMsg(DBM_ERROR_NO_PERMISSION)
			return
		end
		local timer = tonumber(cmd:sub(6)) or 5
		timer = timer * 60
		local channel = ((GetNumRaidMembers() == 0) and "PARTY") or "RAID_WARNING"
		DBM:CreatePizzaTimer(timer, DBM_CORE_TIMER_BREAK, true)
		DBM:Unschedule(SendChatMessage)
		SendChatMessage(DBM_CORE_BREAK_START:format(timer/60), channel)
		if timer/60 > 5 then DBM:Schedule(timer - 5*60, SendChatMessage, DBM_CORE_BREAK_MIN:format(5), channel) end
		if timer/60 > 2 then DBM:Schedule(timer - 2*60, SendChatMessage, DBM_CORE_BREAK_MIN:format(2), channel) end
		if timer/60 > 1 then DBM:Schedule(timer - 1*60, SendChatMessage, DBM_CORE_BREAK_MIN:format(1), channel) end
		if timer > 30 then DBM:Schedule(timer - 30, SendChatMessage, DBM_CORE_BREAK_SEC:format(30), channel) end
		DBM:Schedule(timer, SendChatMessage, DBM_CORE_ANNOUNCE_BREAK_OVER, channel)
	elseif cmd:sub(1, 4) == "pull" then
		if DBM:GetRaidRank() == 0 then
			local timer = tonumber(cmd:sub(5)) or 10
			local channel = ((GetNumRaidMembers() == 0) and "PARTY") or "EMOTE"
			DBM:CreatePizzaTimer(timer, DBM_CORE_TIMER_PULL, false)
			SendChatMessage(DBM_CORE_ANNOUNCE_PULL:format(timer), channel)
			if timer > 7 then DBM:Schedule(timer - 7, SendChatMessage, DBM_CORE_ANNOUNCE_PULL:format(7), channel) end
			if timer > 5 then DBM:Schedule(timer - 5, SendChatMessage, DBM_CORE_ANNOUNCE_PULL:format(5), channel) end
			if timer > 3 then DBM:Schedule(timer - 3, SendChatMessage, DBM_CORE_ANNOUNCE_PULL:format(3), channel) end
			if timer > 2 then DBM:Schedule(timer - 2, SendChatMessage, DBM_CORE_ANNOUNCE_PULL:format(2), channel) end
			if timer > 1 then DBM:Schedule(timer - 1, SendChatMessage, DBM_CORE_ANNOUNCE_PULL:format(1), channel) end
			if timer >= 5 and DBM.Options.AudioPull then
				DBM:Schedule(timer - 5, PlaySoundFile, "Interface\\AddOns\\DBM-Core\\sounds\\5.mp3", "Master")
				DBM:Schedule(timer - 4, PlaySoundFile, "Interface\\AddOns\\DBM-Core\\sounds\\4.mp3", "Master")
				DBM:Schedule(timer - 3, PlaySoundFile, "Interface\\AddOns\\DBM-Core\\sounds\\3.mp3", "Master")
				DBM:Schedule(timer - 2, PlaySoundFile, "Interface\\AddOns\\DBM-Core\\sounds\\2.mp3", "Master")
				DBM:Schedule(timer - 1, PlaySoundFile, "Interface\\AddOns\\DBM-Core\\sounds\\1.mp3", "Master")
				DBM:Schedule(timer - 0.01, PlaySoundFile, "Interface\\AddOns\\DBM-Core\\sounds\\Alarm.ogg", "Master")
			end
			DBM:Schedule(timer, SendChatMessage, DBM_CORE_ANNOUNCE_PULL_NOW, channel)
			return DBM:AddMsg(DBM_ERROR_NO_PERMISSION)
		end
		local timer = tonumber(cmd:sub(5)) or 10
		local channel = ((GetNumRaidMembers() == 0) and "PARTY") or "RAID_WARNING"
		DBM:CreatePizzaTimer(timer, DBM_CORE_TIMER_PULL, true)
		SendChatMessage(DBM_CORE_ANNOUNCE_PULL:format(timer), channel)
		if timer > 7 then DBM:Schedule(timer - 7, SendChatMessage, DBM_CORE_ANNOUNCE_PULL:format(7), channel) end
		if timer > 5 then DBM:Schedule(timer - 5, SendChatMessage, DBM_CORE_ANNOUNCE_PULL:format(5), channel) end
		if timer > 3 then DBM:Schedule(timer - 3, SendChatMessage, DBM_CORE_ANNOUNCE_PULL:format(3), channel) end
		if timer > 2 then DBM:Schedule(timer - 2, SendChatMessage, DBM_CORE_ANNOUNCE_PULL:format(2), channel) end
		if timer > 1 then DBM:Schedule(timer - 1, SendChatMessage, DBM_CORE_ANNOUNCE_PULL:format(1), channel) end
		if timer >= 5 and DBM.Options.AudioPull then
			DBM:Schedule(timer - 5, PlaySoundFile, "Interface\\AddOns\\DBM-Core\\sounds\\5.mp3", "Master")
			DBM:Schedule(timer - 4, PlaySoundFile, "Interface\\AddOns\\DBM-Core\\sounds\\4.mp3", "Master")
			DBM:Schedule(timer - 3, PlaySoundFile, "Interface\\AddOns\\DBM-Core\\sounds\\3.mp3", "Master")
			DBM:Schedule(timer - 2, PlaySoundFile, "Interface\\AddOns\\DBM-Core\\sounds\\2.mp3", "Master")
			DBM:Schedule(timer - 1, PlaySoundFile, "Interface\\AddOns\\DBM-Core\\sounds\\1.mp3", "Master")
			DBM:Schedule(timer - 0.01, PlaySoundFile, "Interface\\AddOns\\DBM-Core\\sounds\\Alarm.ogg", "Master")
		end
		DBM:Schedule(timer, SendChatMessage, DBM_CORE_ANNOUNCE_PULL_NOW, channel)
	elseif cmd:sub(1, 5) == "arrow" then
		local x, y = string.split(" ", cmd:sub(6):trim())
		local xNum, yNum = tonumber(x or ""), tonumber(y or "")
		local success
		if xNum and yNum then
			DBM.Arrow:ShowRunTo(xNum / 100, yNum / 100, 0)
			success = true
		elseif type(x) == "string" and x:trim() ~= "" then
			local subCmd = x:trim()
			if subCmd:upper() == "HIDE" then
				DBM.Arrow:Hide()
				success = true
			elseif subCmd:upper() == "MOVE" then
				DBM.Arrow:Move()
				success = true
			elseif subCmd:upper() == "TARGET" then
				DBM.Arrow:ShowRunTo("target")
				success = true
			elseif subCmd:upper() == "FOCUS" then
				DBM.Arrow:ShowRunTo("focus")
				success = true
			elseif DBM:GetRaidUnitId(DBM:Capitalize(subCmd)) ~= "none" then
				DBM.Arrow:ShowRunTo(DBM:Capitalize(subCmd))
				success = true
			end
		end
		if not success then
			for i, v in ipairs(DBM_ARROW_ERROR_USAGE) do
				DBM:AddMsg(v)
			end
		end
	elseif cmd:sub(1, 10) == "debuglevel" then
		local level = tonumber(cmd:sub(11)) or 1
		if level < 1 or level > 4 then
			DBM:AddMsg("Invalid Value. Debug Level must be between 1 and 4.")
			return
		end
		DBM.Options.DebugLevel = level
		DBM:AddMsg("Debug Level is " .. level)
	elseif cmd:sub(1, 5) == "debug" then
		DBM.Options.DebugMode = DBM.Options.DebugMode == false and true or false
		DBM:AddMsg("Debug Message is " .. (DBM.Options.DebugMode and "ON" or "OFF"))
	elseif cmd:sub(1, 6) == "silent" then
		DBM.Options.SilentMode = DBM.Options.SilentMode == false and true or false
		DBM:AddMsg("Silent Mode is " .. (DBM.Options.SilentMode and "ON" or "OFF"), nil, true)
	else
		DBM:LoadGUI()
	end
end
SlashCmdList["PULL"] = function(msg) SlashCmdList["DEADLYBOSSMODS"]("pull "..msg) end
SLASH_DBMRANGE1 = "/range"
SLASH_DBMRANGE2 = "/distance"
SlashCmdList["DBMRANGE"] = function(msg)
	if DBM.RangeCheck:IsShown() then
		DBM.RangeCheck:Hide()
	else
		local r = tonumber(msg)
		if r then
			DBM.RangeCheck:Show(r)
		else
			DBM.RangeCheck:Show(10)
		end
	end
end

do
	local sortMe = {}
	local function sort(v1, v2)
		return (v1.revision or 0) > (v2.revision or 0)
	end

	function DBM:ShowVersions(notify)
		for i, v in pairs(raid) do
			tinsert(sortMe, v)
		end
		tsort(sortMe, sort)
		self:AddMsg(DBM_CORE_VERSIONCHECK_HEADER)
		local nreq = 1
		for i, v in ipairs(sortMe) do
			if v.displayVersion then
				self:AddMsg(DBM_CORE_VERSIONCHECK_ENTRY:format(v.name, v.displayVersion, v.revision))
				if notify and v.displayVersion ~= DBM.Version and v.revision < DBM.ReleaseRevision then
					DBM:Schedule(nreq*10,SendChatMessage, chatPrefixShort..DBM_CORE_YOUR_VERSION_OUTDATED, "WHISPER", nil, v.name)
					nreq = nreq + 1
				end
			else
				self:AddMsg(DBM_CORE_VERSIONCHECK_ENTRY_NO_DBM:format(v.name))
			end
		end
		for i = #sortMe, 1, -1 do
			if not sortMe[i].revision then
				tremove(sortMe, i)
			end
		end
		self:AddMsg(DBM_CORE_VERSIONCHECK_FOOTER:format(#sortMe))
		for i = #sortMe, 1, -1 do
			sortMe[i] = nil
		end
	end
	function DBM:ShowRelease()
			if DBM:GetRaidRank() == 0 then
			DBM:AddMsg(DBM_ERROR_NO_PERMISSION)
			return
		end
		for i, v in pairs(raid) do
			tinsert(sortMe, v)
		end
		tsort(sortMe, sort)
		SendChatMessage(DBM_CORE_VERSIONCHECK_HEADER, "RAID")
		for i, v in ipairs(sortMe) do
			if v.displayVersion then
				SendChatMessage(DBM_CORE_VERSIONCHECK_ENTRY:format(v.name, v.displayVersion, v.revision), "RAID")
			else
				SendChatMessage(DBM_CORE_VERSIONCHECK_ENTRY_NO_DBM:format(v.name), "RAID")
			end
		end
		for i = #sortMe, 1, -1 do
			if not sortMe[i].revision then
				tremove(sortMe, i)
			end
		end
		SendChatMessage(DBM_CORE_VERSIONCHECK_FOOTER:format(#sortMe), "RAID")
		for i = #sortMe, 1, -1 do
			sortMe[i] = nil
		end
	end
end

-------------------
--  Pizza Timer  --
-------------------
do
	local ignore = {}
	function DBM:CreatePizzaTimer(time, text, broadcast, sender)
		if sender and ignore[sender] then return end
		text = text:sub(1, 16)
		text = text:gsub("%%t", UnitName("target") or "<no target>")
		self.Bars:CreateBar(time, text)
		if broadcast and self:GetRaidRank() >= 1 then
			sendSync("DBMv4-Pizza", ("%s\t%s"):format(time, text))
		end
		if sender then DBM:ShowPizzaInfo(text, sender) end
	end

	function DBM:AddToPizzaIgnore(name)
		ignore[name] = true
	end
end

function DBM:ShowPizzaInfo(id, sender)
	self:AddMsg(DBM_PIZZA_SYNC_INFO:format(sender, id))
end



------------------
--  Hyperlinks  --
------------------
do
	local ignore, cancel
	StaticPopupDialogs["DBM_CONFIRM_IGNORE"] = {
		text = DBM_PIZZA_CONFIRM_IGNORE,
		button1 = YES,
		button2 = NO,
		OnAccept = function(self)
			DBM:AddToPizzaIgnore(ignore)
			DBM.Bars:CancelBar(cancel)
		end,
		timeout = 0,
		hideOnEscape = 1,
	}

	DEFAULT_CHAT_FRAME:HookScript("OnHyperlinkClick", function(self, link, string, button, ...)
		local linkType, arg1, arg2, arg3 = strsplit(":", link)
		if linkType == "DBM" and arg1 == "cancel" then
			DBM.Bars:CancelBar(link:match("DBM:cancel:(.+):nil$"))
		elseif linkType == "DBM" and arg1 == "ignore" then
			cancel = link:match("DBM:ignore:(.+):[^%s:]+$")
			ignore = link:match(":([^:]+)$")
			StaticPopup_Show("DBM_CONFIRM_IGNORE", ignore)
		elseif linkType == "DBM" and arg1 == "update" then
			DBM:ShowUpdateReminder(arg2, arg3) -- displayVersion, revision
		end
	end)
end

do
	local old = ItemRefTooltip.SetHyperlink -- we have to hook this function since the default ChatFrame code assumes that all links except for player and channel links are valid arguments for this function
	function ItemRefTooltip:SetHyperlink(link, ...)
		if link:match("^DBM") then return end
		return old(self, link, ...)
	end
end


-----------------
--  GUI Stuff  --
-----------------
do
	local callOnLoad = {}
	function DBM:LoadGUI()
		if not self.Options.Enabled then
			DBM:AddMsg(DBM_CORE_UPDATEREMINDER_DISABLE)
			return
		end
		if not IsAddOnLoaded("DBM-GUI") then
			local _, _, _, enabled = GetAddOnInfo("DBM-GUI")
			if not enabled then
				EnableAddOn("DBM-GUI")
			end
			local loaded, reason = LoadAddOn("DBM-GUI")
			if not loaded then
				if reason then
					self:AddMsg(DBM_CORE_LOAD_GUI_ERROR:format(tostring(_G["ADDON_"..reason or ""])))
				else
					self:AddMsg(DBM_CORE_LOAD_GUI_ERROR:format(DBM_CORE_UNKNOWN))
				end
				return false
			end
			tsort(callOnLoad, function(v1, v2) return v1[2] < v2[2] end)
			for i, v in ipairs(callOnLoad) do v[1]() end
			if not InCombatLockdown() and not UnitAffectingCombat("player") and not IsFalling() then--We loaded in combat but still need to avoid garbage collect in combat
				collectgarbage("collect")
			end
		end
		return DBM_GUI:ShowHide()
	end

	function DBM:RegisterOnGuiLoadCallback(f, sort)
		tinsert(callOnLoad, {f, sort or mhuge})
	end
end


----------------------
--  Minimap Button  --
----------------------
do
	local dragMode = nil

	local function moveButton(self)
		if dragMode == "free" then
			local centerX, centerY = Minimap:GetCenter()
			local x, y = GetCursorPosition()
			x, y = x / self:GetEffectiveScale() - centerX, y / self:GetEffectiveScale() - centerY
			self:ClearAllPoints()
			self:SetPoint("CENTER", x, y)
		else
			local centerX, centerY = Minimap:GetCenter()
			local x, y = GetCursorPosition()
			x, y = x / self:GetEffectiveScale() - centerX, y / self:GetEffectiveScale() - centerY
			centerX, centerY = math.abs(x), math.abs(y)
			centerX, centerY = (centerX / math.sqrt(centerX^2 + centerY^2)) * 80, (centerY / sqrt(centerX^2 + centerY^2)) * 80
			centerX = x < 0 and -centerX or centerX
			centerY = y < 0 and -centerY or centerY
			self:ClearAllPoints()
			self:SetPoint("CENTER", centerX, centerY)
		end
	end

	local button = CreateFrame("Button", "DBMMinimapButton", Minimap)
	button:SetHeight(32)
	button:SetWidth(32)
	button:SetFrameStrata("MEDIUM")
	button:SetPoint("CENTER", -65.35, -38.8)
	button:SetMovable(true)
	button:SetUserPlaced(true)
	button:SetNormalTexture("Interface\\AddOns\\DBM-Core\\textures\\Minimap-Button-Up")
	button:SetPushedTexture("Interface\\AddOns\\DBM-Core\\textures\\Minimap-Button-Down")
	button:SetHighlightTexture("Interface\\Minimap\\UI-Minimap-ZoomButton-Highlight")

	button:SetScript("OnMouseDown", function(self, button)
		if IsShiftKeyDown() and IsAltKeyDown() then
			dragMode = "free"
			self:SetScript("OnUpdate", moveButton)
		elseif IsShiftKeyDown() or button == "RightButton" then
			dragMode = nil
			self:SetScript("OnUpdate", moveButton)
		end
	end)
	button:SetScript("OnMouseUp", function(self)
		self:SetScript("OnUpdate", nil)
	end)
	button:SetScript("OnClick", function(self, button)
		if IsShiftKeyDown() or button == "RightButton" then return end
		DBM:LoadGUI()
	end)
	button:SetScript("OnEnter", function(self)
		GameTooltip_SetDefaultAnchor(GameTooltip, self)
		GameTooltip:SetText(DBM_CORE_MINIMAP_TOOLTIP_HEADER, 1, 1, 1)
		GameTooltip:AddLine(ver, NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b, 1)
		GameTooltip:AddLine(" ")
		GameTooltip:AddLine(DBM_CORE_MINIMAP_TOOLTIP_FOOTER, RAID_CLASS_COLORS.MAGE.r, RAID_CLASS_COLORS.MAGE.g, RAID_CLASS_COLORS.MAGE.b, 1)
		GameTooltip:Show()
	end)
	button:SetScript("OnLeave", function(self)
		GameTooltip:Hide()
	end)

	function DBM:ToggleMinimapButton()
		self.Options.ShowMinimapButton = not self.Options.ShowMinimapButton
		if self.Options.ShowMinimapButton then
			button:Show()
		else
			button:Hide()
		end
	end

	function DBM:HideMinimapButton()
		return button:Hide()
	end
end

-------------------------------------------------
--  Raid/Party Handling and Unit ID Utilities  --
-------------------------------------------------
do
	local inRaid = false

	local raidGuids = {}
	local iconSeter = {}

	--	save playerinfo into raid table on load. (for solo raid)
	DBM:RegisterOnLoadCallback(function()
		if not raid[playerName] then
			raid[playerName] = {}
			raid[playerName].name = playerName
			raid[playerName].guid = UnitGUID("player") or ""
			raid[playerName].rank = 0
			raid[playerName].class = playerClass
			raid[playerName].id = "player"
			raid[playerName].groupId = 0
			raid[playerName].revision = DBM.Revision
			raid[playerName].version = DBM.ReleaseRevision
			raid[playerName].displayVersion = DBM.DisplayVersion
			raid[playerName].enabledIcons = tostring(not DBM.Options.DontSetIcons)
			raidGuids[UnitGUID("player") or ""] = playerName
		end
	end)

	local function updateAllRoster(self)
		DBM:Debug("Updating roster",3)
		if GetNumRaidMembers() >= 1 then
			if not inRaid then
				inRaid = true
				sendSync("DBMv4-Ver", "Hi!")
				self:Schedule(2, DBM.RequestTimers, DBM)
				fireEvent("raidJoin", playerName)
			end
			for i = 1, GetNumRaidMembers() do
				local name, rank, subgroup, _, _, className = GetRaidRosterInfo(i)
				if name and name ~= UNKNOWN then
					local id = "raid"..i
					if (not raid[name]) and inRaid then
						fireEvent("raidJoin", name)
					end

					raid[name] = raid[name] or {}
					raid[name].name = name
					raid[name].rank = rank
					raid[name].subgroup = subgroup
					raid[name].class = className
					raid[name].id = id
					raid[name].groupId = i
					raid[name].guid = UnitGUID(id) or ""
					raid[name].updated = true
					raidGuids[UnitGUID(id) or ""] = name
				end
			end
--			enableIcons = false
			twipe(iconSeter)
			for i, v in pairs(raid) do
				if not v.updated then
					raidGuids[v.guid] = nil
					raid[i] = nil
					removeEntry(newerVersionPerson, i)
					fireEvent("raidLeave", i)
				else
					v.updated = nil
					if v.revision and v.rank > 0 and (v.enabledIcons or "") == "true" then
						iconSeter[#iconSeter + 1] = v.revision.." "..v.name
					end
				end
			end
			if #iconSeter > 0 then
				tsort(iconSeter, function(a, b) return a > b end)
				local elected = iconSeter[1]
				if playerName == elected:sub(elected:find(" ") + 1) then
					enableIcons = true
				end
			end
		elseif GetNumPartyMembers() >= 1 then
			if not inRaid then
				-- joined a new party
				inRaid = true
				sendSync("DBMv4-Ver", "Hi!")
				fireEvent("partyJoin", playerName)
			end
			for i = 0, GetNumPartyMembers() do
				local id
				if (i == 0) then
					id = "player"
				else
					id = "party"..i
				end
				local name, server = UnitName(id)
				local rank = UnitIsPartyLeader(id) and 2 or 0
				local _, className = UnitClass(id)
				if server and server ~= ""  then
					name = name.."-"..server
				end
				if (not raid[name]) and inRaid then
					fireEvent("partyJoin", name)
				end
				raid[name] = raid[name] or {}
				raid[name].name = name
				raid[name].guid = UnitGUID(id) or ""
				raid[name].rank = rank
				raid[name].class = className
				raid[name].id = id
				raid[name].groupId = i
				raid[name].updated = true
				raidGuids[UnitGUID(id) or ""] = name
			end
--			enableIcons = false
			twipe(iconSeter)
			for i, v in pairs(raid) do
				if not v.updated then
					raidGuids[v.guid] = nil
					raid[i] = nil
					removeEntry(newerVersionPerson, i)
					fireEvent("partyLeave", i)
				else
					v.updated = nil
					if v.revision and v.rank > 0 and (v.enabledIcons or "") == "true" then
						iconSeter[#iconSeter + 1] = v.revision.." "..v.name
					end
				end
			end
			if #iconSeter > 0 then
				tsort(iconSeter, function(a, b) return a > b end)
				local elected = iconSeter[1]
				if playerName == elected:sub(elected:find(" ") + 1) then
					enableIcons = true
				end
			end
		else
			-- left the current group/raid
			inRaid = false
			enableIcons = true
			fireEvent("raidLeave", playerName)
			twipe(raid)
			twipe(newerVersionPerson)
			-- restore playerinfo into raid table on raidleave. (for solo raid)
			raid[playerName] = {}
			raid[playerName].name = playerName
			raid[playerName].guid = UnitGUID("player") or ""
			raid[playerName].rank = 0
			raid[playerName].class = playerClass
			raid[playerName].id = "player"
			raid[playerName].groupId = 0
			raid[playerName].revision = DBM.Revision
			raid[playerName].version = DBM.ReleaseRevision
			raid[playerName].displayVersion = DBM.DisplayVersion
			raidGuids[UnitGUID("player") or ""] = playerName
		end
	end

	function DBM:RAID_ROSTER_UPDATE(force)
		self:Unschedule(updateAllRoster)
		if force then
			updateAllRoster(self)
		else
			self:Schedule(1.5, updateAllRoster, self)
		end
	end

	function DBM:PARTY_MEMBERS_CHANGED(force)
		self:Unschedule(updateAllRoster)
		if force then
			updateAllRoster(self)
		else
			self:Schedule(1.5, updateAllRoster, self)
		end
	end

	function DBM:IsInRaid()
		return inRaid
	end

	function DBM:GetRaidRank(name)
		name = name or playerName
		if name == playerName then--If name is player, try to get actual rank. Because raid[name].rank sometimes seems returning 0 even player is promoted.
			return UnitIsPartyLeader("player") and 2 or UnitIsRaidOfficer("player") and 1 or 0
		else
			return (raid[name] and raid[name].rank) or 0
		end
	end

	function DBM:GetRaidSubgroup(name)
		return (raid[name] and raid[name].subgroup) or 0
	end

	function DBM:GetRaidClass(name)
		return (raid[name] and raid[name].class) or "UNKNOWN"
	end

	function DBM:GetRaidUnitId(name)
		return raid[name] and raid[name].id
	end

	function DBM:GetEnemyUnitIdByGUID(guid)
		for i = 1, 4 do
			local unitId = "boss"..i
			local guid2 = UnitGUID(unitId)
			if guid == guid2 then
				return unitId
			end
		end

		local idType = ((GetNumRaidMembers() == 0) and "party") or "raid"
		for i = 0, mmax(GetNumRaidMembers(), GetNumPartyMembers()) do
			local unitId = ((i == 0) and "target") or idType..i.."target"
			local guid2 = UnitGUID(unitId)
			if guid == guid2 then
				return unitId
			end
		end
		return DBM_CORE_UNKNOWN
	end

	function DBM:GetPlayerGUIDByName(name)
		return raid[name] and raid[name].guid
	end

	function DBM:GetMyPlayerInfo()
		return playerName, playerLevel, playerRealm
	end

	function DBM:GetUnitFullName(uId)
		if not uId then return nil end
		return GetUnitName(uId, true)
	end

	function DBM:GetFullPlayerNameByGUID(guid)
		return raidGuids[guid]
	end

	function DBM:GetPlayerNameByGUID(guid)
		return raidGuids[guid] and raidGuids[guid]:gsub("%-.*$", "")
	end

	function DBM:GetGroupId(name)
		local raidMember = raid[name] or raid[GetUnitName(name) or ""]
		return raidMember and raidMember.groupId or 0
	end
end

do
	-- yes, we still do avoid memory allocations during fights; so we don't use a closure around a counter here
	-- this seems to be the easiest way to write an iterator that returns the unit id *string* as first argument without a memory allocation
	local function raidIterator(groupMembers, uId)
		local a, b = uId:byte(-2, -1)
		local i = (a >= 0x30 and a <= 0x39 and (a - 0x30) * 10 or 0) + b - 0x30
		if i < groupMembers then
			return "raid" .. i + 1, i + 1
		end
	end

	local function partyIterator(groupMembers, uId)
		if not uId then
			return "player", 0
		elseif uId == "player" then
			if groupMembers > 0 then
				return "party1", 1
			end
		else
			local i = uId:byte(-1) - 0x30
			if i < groupMembers then
				return "party" .. i + 1, i + 1
			end
		end
	end

	local function soloIterator(_, state)
		if not state then -- no state == first call
			return "player", 0
		end
	end

	-- returns the unit ids of all raid or party members, including the player's own id
	-- limitations: will break if there are ever raids with more than 99 players or partys with more than 10
	function DBM:GetGroupMembers()
		if GetNumRaidMembers() > 0 then
			return raidIterator, GetNumRaidMembers(), "raid0"
		elseif GetNumPartyMembers() > 0 then
			return partyIterator, GetNumPartyMembers(), nil
		else
			-- solo!
			return soloIterator, nil, nil
		end
	end
end
function DBM:GetUnitCreatureId(uId)
	local guid = UnitGUID(uId)
	return self:GetCIDFromGUID(guid)
end

function DBM:GetCIDFromGUID(guid)
	return guid and tonumber(guid:sub(9, 12), 16) or 0
end

function DBM:IsCreatureGUID(guid)
	if bband(guid:sub(1, 5), 0x00F) == 3 or bband(guid:sub(1, 5), 0x00F) == 5 then
		return true
	end
	return false
end

function DBM:GetBossUnitId(name, bossOnly)--Deprecated, only old mods use this
	local returnUnitID
	for i = 1, 4 do
		if UnitName("boss" .. i) == name then
			returnUnitID = "boss"..i
		end
	end
	if not returnUnitID and not bossOnly then
		for uId in self:GetGroupMembers() do
			if UnitName(uId .. "target") == name and not UnitIsPlayer(uId .. "target") then
				returnUnitID = uId.."target"
			end
		end
	end
	return returnUnitID
end

function DBM:GetUnitIdFromGUID(cidOrGuid, bossOnly)
	local returnUnitID
	for i = 1, 4 do
		local unitId = "boss"..i
		local bossGUID = UnitGUID(unitId)
		if type(cidOrGuid) == "number" then--CID passed
			local cid = self:GetCIDFromGUID(bossGUID)
			if cid == cidOrGuid then
				returnUnitID = unitId
			end
		else--GUID passed
			if bossGUID == cidOrGuid then
				returnUnitID = unitId
			end
		end
	end
	--Didn't find valid unitID from boss units, scan raid targets
	if not returnUnitID and not bossOnly then
		for uId in self:GetGroupMembers() do
			local unitId = uId .. "target"
			local bossGUID = UnitGUID(unitId)
			local cid = self:GetCIDFromGUID(cidOrGuid)
			if bossGUID == cidOrGuid or cid == cidOrGuid then
				returnUnitID = unitId
			end
		end
	end
	return returnUnitID
end

function DBM:CheckNearby(range, targetname)
	if not targetname and DBM.RangeCheck:GetDistanceAll(range) then
		return true--No target name means check if anyone is near self, period
	else
		local uId = DBM:GetRaidUnitId(targetname)
		if uId and not UnitIsUnit("player", uId) then
			local inRange = DBM.RangeCheck:GetDistance(uId)
			if inRange and inRange < range + 0.5 then
				return true
			end
		end
	end
	return false
end

---------------
--  Options  --
---------------
do
	local function addDefaultOptions(t1, t2)
		for i, v in pairs(t2) do
			if t1[i] == nil then
				t1[i] = v
			elseif type(v) == "table" then
				addDefaultOptions(v, t2[i])
			end
		end
	end

	local function setRaidWarningPositon()
		RaidWarningFrame:ClearAllPoints()
		RaidWarningFrame:SetPoint(DBM.Options.RaidWarningPosition.Point, UIParent, DBM.Options.RaidWarningPosition.Point, DBM.Options.RaidWarningPosition.X, DBM.Options.RaidWarningPosition.Y)
	end

	function loadOptions()
		DBM.Options = DBM_SavedOptions
		addDefaultOptions(DBM.Options, DBM.DefaultOptions)
		-- load special warning options
		DBM:UpdateSpecialWarningOptions()
		-- set this with a short delay to prevent issues with other addons also trying to do the same thing with another position ;)
		DBM:Schedule(5, setRaidWarningPositon)
	end

	function loadModOptions(modId)
		DBM:Debug("Loading default options for "..modId, 2)
		local savedOptions = _G[modId:gsub("-", "").."_SavedVars"] or {}
		local savedStats = _G[modId:gsub("-", "").."_SavedStats"] or {}
		for i, v in ipairs(DBM.Mods) do
			if v.modId == modId then
				savedOptions[v.id] = savedOptions[v.id] or v.Options
				for option, optionValue in pairs(v.Options) do
					if savedOptions[v.id][option] == nil then
						savedOptions[v.id][option] = optionValue
					end
				end
				v.Options = savedOptions[v.id] or {}
				savedStats[v.id] = savedStats[v.id] or {}
				v.stats = savedStats[v.id]

				-- for some reason some people have 0 kills as nil instead of 0.
				v.stats.kills = v.stats.kills or 0
				v.stats.pulls = v.stats.pulls or 0
				v.stats.heroicKills = v.stats.heroicKills or 0
				v.stats.heroicPulls = v.stats.heroicPulls or 0

				if v.OnInitialize then v:OnInitialize() end
				for i, cat in ipairs(v.categorySort) do -- temporary hack
					if cat == "misc" then
						tremove(v.categorySort, i)
						tinsert(v.categorySort, cat)
						break
					end
				end
			end
		end
		_G[modId:gsub("-", "").."_SavedVars"] = savedOptions
		_G[modId:gsub("-", "").."_SavedStats"] = savedStats
	end
end

function DBM:SpecChanged(force)
	--Load Options again.
	DBM:Debug("SpecChanged fired", 2)
	for i, v in ipairs(self.AddOns) do
		if IsAddOnLoaded(v.modId) then
			DBM:Schedule(0.5, DBM.LoadMod, DBM, v)
			loadModOptions(v.modId)
		end
	end
end

function DBM:PLAYER_TALENT_UPDATE()
	local lastSpecID = currentSpecGroup
	DBM:SetCurrentSpecInfo()
	if currentSpecGroup ~= lastSpecID then
		DBM:SpecChanged()
	end
end
--------------------------------
--  Load Boss Mods on Demand  --
--------------------------------
function DBM:ZONE_CHANGED_NEW_AREA()
	SetMapToCurrentZone()
	timerRequestInProgress = false
	self:Debug("ZONE_CHANGED_NEW_AREA fired")
	local zoneName = GetRealZoneText()
	local zoneId = GetCurrentMapAreaID()
	for i, v in ipairs(self.AddOns) do
		if not IsAddOnLoaded(v.modId) and (checkEntry(v.zone, zoneName) or checkEntry(v.zoneId, zoneId)) then
			-- srsly, wtf? LoadAddOn doesn't work properly on ZONE_CHANGED_NEW_AREA when reloading the UI
			-- TODO: is this still necessary? this was a WotLK beta bug
			DBM:Unschedule(DBM.LoadMod, DBM, v)
			DBM:Schedule(3, DBM.LoadMod, DBM, v)
		end
	end
	if select(2, IsInInstance()) == "pvp" and not DBM:GetModByName("AlteracValley") then
		for i, v in ipairs(DBM.AddOns) do
			if v.modId == "DBM-PvP" then
				DBM:LoadMod(v)
				break
			end
		end
	end
end

function DBM:LoadMod(mod)
	if type(mod) ~= "table" then
		self:Debug("LoadMod failed because mod table not valid")
		return false
	end
	local _, _, _, enabled = GetAddOnInfo(mod.modId)
	if not enabled then
		EnableAddOn(mod.modId)
	end

	local loaded, reason = LoadAddOn(mod.modId)
	if not loaded then
		if reason then
			self:AddMsg(DBM_CORE_LOAD_MOD_ERROR:format(tostring(mod.name), tostring(_G["ADDON_"..reason or ""])))
		else
			self:Debug("LoadAddOn failed and did not give reason")
		end
		return false
	else
		self:AddMsg(DBM_CORE_LOAD_MOD_SUCCESS:format(tostring(mod.name)))
		loadModOptions(mod.modId)
		for i, v in ipairs(DBM.Mods) do -- load the hasHeroic attribute from the toc into all boss mods as required by the GetDifficulty() method
			if v.modId == mod.modId then
				v.hasHeroic = mod.hasHeroic
			end
		end
		if DBM_GUI then
			DBM_GUI:UpdateModList()
		end
		local _, instanceType = IsInInstance()
		if instanceType ~= "pvp" and #inCombat == 0 and GetNumPartyMembers() > 0 then--do timer recovery only mod load
			if not timerRequestInProgress then
				timerRequestInProgress = true
				-- Request timer to 3 person to prevent failure.
				self:Unschedule(self.RequestTimers)
				self:Schedule(7, self.RequestTimers, self, 1)
				self:Schedule(10, self.RequestTimers, self, 2)
				self:Schedule(13, self.RequestTimers, self, 3)
				self:Schedule(15, function() timerRequestInProgress = false end)
				self:RAID_ROSTER_UPDATE(true)
			end
		end
		if not InCombatLockdown() and not UnitAffectingCombat("player") and not IsFalling() then--We loaded in combat but still need to avoid garbage collect in combat
			collectgarbage("collect")
		end
		return true
	end
end

do
	if select(4, GetAddOnInfo("DBM-PvP")) and select(5, GetAddOnInfo("DBM-PvP")) then
		local checkBG
		function checkBG()
			if not DBM:GetModByName("AlteracValley") and MAX_BATTLEFIELD_QUEUES then
				for i = 1, MAX_BATTLEFIELD_QUEUES do
					if GetBattlefieldStatus(i) == "confirm" then
						for _, v in ipairs(DBM.AddOns) do
							if v.modId == "DBM-PvP" then
								DBM:LoadMod(v)
								return
							end
						end
					end
				end
				DBM:Schedule(1, checkBG)
			end
		end
		DBM:Schedule(1, checkBG)
	end
end



-----------------------------
--  Handle Incoming Syncs  --
-----------------------------
do
	local syncHandlers = {}
	local whisperSyncHandlers = {}

	syncHandlers["DBMv4-Mod"] = function(msg, channel, sender)
		local mod, revision, event, arg = strsplit("\t", msg)
		mod = DBM:GetModByName(mod or "")
		if mod and event and arg and revision then
			revision = tonumber(revision) or 0
			mod:ReceiveSync(event, arg, sender, revision)
		end
	end

	syncHandlers["DBMv4-Pull"] = function(msg, channel, sender)
		if select(2, IsInInstance()) == "pvp" then return end
		local delay, mod, revision = strsplit("\t", msg)
		local lag = select(3, GetNetStats()) / 1000
		delay = tonumber(delay or 0) or 0
		revision = tonumber(revision or 0) or 0
		mod = DBM:GetModByName(mod or "")
		if mod and delay and (not mod.zones or #mod.zones == 0 or checkEntry(mod.zones, GetRealZoneText()) or checkEntry(mod.zones, GetCurrentMapAreaID())) and (not mod.minSyncRevision or revision >= mod.minSyncRevision) then
			DBM:StartCombat(mod, delay + lag, true)
		end
	end

	syncHandlers["DBMv4-Kill"] = function(msg, channel, sender)
		if select(2, IsInInstance()) == "pvp" then return end
		local cId = tonumber(msg)
		if cId then DBM:OnMobKill(cId, true) end
	end

	syncHandlers["DBMv4-Ver"] = function(msg, channel, sender)
		if msg == "Hi!" then
			DBM:Debug(("DBMv4-Ver Hi! %s %s %s %s"):format(DBM.Revision, DBM.Version, DBM.DisplayVersion, GetLocale()),4)
			sendSync("DBMv4-Ver", ("%s\t%s\t%s\t%s"):format(DBM.Revision, DBM.Version, DBM.DisplayVersion, GetLocale()))
		else
			local revision, version, displayVersion, locale = strsplit("\t", msg)
			DBM:Debug(("DBMv4-Ver received %s %s %s %s from %s"):format(revision, version, displayVersion, locale, sender),4)
			revision, version = tonumber(revision or ""), tonumber(version or "")
			if revision and version and displayVersion and raid[sender] then
				raid[sender].revision = revision
				raid[sender].version = version
				raid[sender].displayVersion = displayVersion
				raid[sender].locale = locale
				if version > tonumber(DBM.Version) then
					if raid[sender].rank >= 1 then
						enableIcons = false
					end
					if not showedUpdateReminder then
						local found = false
						for i, v in pairs(raid) do
							if v.version == version and v ~= raid[sender] then
								found = true
								break
							end
						end
						if found then
							showedUpdateReminder = true
							if not DBM.Options.BlockVersionUpdatePopup then
								DBM:ShowUpdateReminder(displayVersion, revision)
							else
								DBM:AddMsg(DBM_CORE_UPDATEREMINDER_HEADER:match("([^\n]*)"))
								DBM:AddMsg(DBM_CORE_UPDATEREMINDER_HEADER:match("\n(.*)"):format(displayVersion, revision))
								DBM:AddMsg(("|HDBM:update:%s:%s|h|cff3588ff[https://github.com/Barsoomx/DBM-wowcircle]"):format(displayVersion, revision))
							end
						end
					end
				end
			end
		end
	end

	syncHandlers["DBMv4-Pizza"] = function(msg, channel, sender)
		if select(2, IsInInstance()) == "pvp" then return end
		if DBM:GetRaidRank(sender) == 0 then return end
		if sender == UnitName("player") then return end
		local time, text = strsplit("\t", msg)
		time = tonumber(time or 0)
		text = tostring(text)
		if time and text then
			DBM:CreatePizzaTimer(time, text, nil, sender)
			if text == tostring(DBM_CORE_TIMER_PULL) and time >= 5 and DBM.Options.AudioPull then
				DBM:Schedule(time - 5, PlaySoundFile, "Interface\\AddOns\\DBM-Core\\sounds\\5to1.mp3", "Master")
				DBM:Schedule(time, PlaySoundFile, "Interface\\AddOns\\DBM-Core\\sounds\\Alarm.ogg", "Master")
			end
		end
	end

	syncHandlers["DBMv4-IS"] = function(msg, channel, sender)
		local guid, ver, optionName = strsplit("\t", msg)
		DBM:Debug(("DBMv4-IS received %s %s %s"):format(guid, ver, optionName),3)
		ver = tonumber(ver) or 0
		if ver > (iconSetRevision[optionName] or 0) then--Save first synced version and person, ignore same version. refresh occurs only above version (fastest person)
			iconSetRevision[optionName] = ver
			iconSetPerson[optionName] = guid
		end
		if iconSetPerson[optionName] == UnitGUID("player") then--Check if that highest version was from ourself
			canSetIcons[optionName] = true
		else--Not from self, it means someone with a higher version than us probably sent it
			canSetIcons[optionName] = false
		end
		local name = DBM:GetFullPlayerNameByGUID(iconSetPerson[optionName]) or DBM_CORE_UNKNOWN
		DBM:Debug(name.." was elected icon setter for "..optionName, 2)
	end

	whisperSyncHandlers["DBMv4-RequestTimers"] = function(msg, channel, sender)
		DBM:SendTimers(sender)
	end

	whisperSyncHandlers["DBMv4-BTR3"] = function(msg, channel, sender)
		local timer, maxtime, id, text, texture = strsplit("\t", msg)
		timer = tonumber(timer or 0)
		maxtime = tonumber(maxtime or 0)
		if timer > 3600 then return end
		if id   == nil then id = DBM_CORE_TIMER_BREAK end--old ver compat
		if text == nil then text = DBM_CORE_TIMER_BREAK end--old ver compat
		local combaticon = select(3, GetSpellInfo(texture)) or texture or "Interface\\Icons\\Spell_Nature_WispSplode"
		DBM:Unschedule(DBM.RequestTimers)--IF we got BTR3 sync, then we know immediately RequestTimers was successful, so abort others
		if #inCombat >= 1 then return end
		if DBM.Bars:GetBar(id) then return end--Already recovered. Prevent duplicate recovery
		DBM:Debug("Calling createbar "..maxtime..id.." icon "..combaticon,3)
		DBM.Bars:CreateBar(maxtime, id, combaticon)
		DBM.Bars:GetBar(id):SetText(text)
		DBM.Bars:UpdateBar(id, maxtime-timer, maxtime)
	end

	whisperSyncHandlers["DBMv4-CombatInfo"] = function(msg, channel, sender)
		local mod, time = strsplit("\t", msg)
		mod = DBM:GetModByName(mod or "")
		time = tonumber(time or 0)
		if mod and time then
			DBM:ReceiveCombatInfo(sender, mod, time)
		end
	end

	whisperSyncHandlers["DBMv4-TimerInfo"] = function(msg, channel, sender)
		local mod, timeLeft, totalTime, id = strsplit("\t", msg)
		mod = DBM:GetModByName(mod or "")
		timeLeft = tonumber(timeLeft or 0)
		totalTime = tonumber(totalTime or 0)
		if mod and timeLeft and timeLeft > 0 and totalTime and totalTime > 0 and id then
			DBM:ReceiveTimerInfo(sender, mod, timeLeft, totalTime, id, select(5, strsplit("\t", msg)))
		end
	end

	whisperSyncHandlers["DBMv4-VarInfo"] = function(msg, channel, sender)
		local mod, name, value = strsplit("\t", msg)
		mod = DBM:GetModByName(mod or "")
		value = tonumber(value) or value
		if mod and name and value then
			DBM:ReceiveVariableInfo(sender, mod, name, value)
		end
	end

	function DBM:CHAT_MSG_ADDON(prefix, msg, channel, sender)
		if msg and channel ~= "WHISPER" and channel ~= "GUILD" then
			local handler = syncHandlers[prefix]
			if handler then handler(msg, channel, sender) end
		elseif msg and channel == "WHISPER" and self:GetRaidUnitId(sender) ~= "none" then
			local handler = whisperSyncHandlers[prefix]
			if handler then handler(msg, channel, sender) end
		end
		if msg:find("spell:") and (DBM.Options.DebugLevel > 2) then
			local spellId = string.match(msg, "spell:(%d+)") or "UNKNOWN"
			local spellName = string.match(msg, "h%[(.-)%]|h") or "UNKNOWN"
			local message = "RAID_BOSS_WHISPER on "..sender.." with spell of "..spellName.." ("..spellId..")"
			DBM:Debug(message)
		end
	end
end


-----------------------
--  Update Reminder  --
-----------------------
function DBM:ShowUpdateReminder(newVersion, newRevision)
	local frame = CreateFrame("Frame", nil, UIParent)
	frame:SetFrameStrata("DIALOG")
	frame:SetWidth(430)
	frame:SetHeight(155)
	frame:SetPoint("TOP", 0, -230)
	frame:SetBackdrop({
		bgFile = "Interface\\DialogFrame\\UI-DialogBox-Background",
		edgeFile = "Interface\\DialogFrame\\UI-DialogBox-Border", tile = true, tileSize = 32, edgeSize = 32,
		insets = {left = 11, right = 12, top = 12, bottom = 11},
	})
	local fontstring = frame:CreateFontString(nil, "ARTWORK", "GameFontNormal")
	fontstring:SetWidth(410)
	fontstring:SetHeight(0)
	fontstring:SetPoint("TOP", 0, -16)
	fontstring:SetText(DBM_CORE_UPDATEREMINDER_HEADER:format(newVersion, newRevision))
	local editBox = CreateFrame("EditBox", nil, frame)
	do
		local editBoxLeft = editBox:CreateTexture(nil, "BACKGROUND")
		local editBoxRight = editBox:CreateTexture(nil, "BACKGROUND")
		local editBoxMiddle = editBox:CreateTexture(nil, "BACKGROUND")
		editBoxLeft:SetTexture("Interface\\ChatFrame\\UI-ChatInputBorder-Left")
		editBoxLeft:SetHeight(32)
		editBoxLeft:SetWidth(32)
		editBoxLeft:SetPoint("LEFT", -14, 0)
		editBoxLeft:SetTexCoord(0, 0.125, 0, 1)
		editBoxRight:SetTexture("Interface\\ChatFrame\\UI-ChatInputBorder-Right")
		editBoxRight:SetHeight(32)
		editBoxRight:SetWidth(32)
		editBoxRight:SetPoint("RIGHT", 6, 0)
		editBoxRight:SetTexCoord(0.875, 1, 0, 1)
		editBoxMiddle:SetTexture("Interface\\ChatFrame\\UI-ChatInputBorder-Right")
		editBoxMiddle:SetHeight(32)
		editBoxMiddle:SetWidth(1)
		editBoxMiddle:SetPoint("LEFT", editBoxLeft, "RIGHT")
		editBoxMiddle:SetPoint("RIGHT", editBoxRight, "LEFT")
		editBoxMiddle:SetTexCoord(0, 0.9375, 0, 1)
	end
	editBox:SetHeight(32)
	editBox:SetWidth(250)
	editBox:SetPoint("TOP", fontstring, "BOTTOM", 0, -4)
	editBox:SetFontObject("GameFontHighlight")
	editBox:SetTextInsets(0, 0, 0, 1)
	editBox:SetFocus()
	editBox:SetText("https://github.com/Barsoomx/DBM-wowcircle")
	editBox:HighlightText()
	editBox:SetScript("OnTextChanged", function(self)
		editBox:SetText("https://github.com/Barsoomx/DBM-wowcircle")
		editBox:HighlightText()
	end)
	fontstring = frame:CreateFontString(nil, "ARTWORK", "GameFontNormal")
	fontstring:SetWidth(410)
	fontstring:SetHeight(0)
	fontstring:SetPoint("TOP", editBox, "BOTTOM", 0, 0)
	fontstring:SetText(DBM_CORE_UPDATEREMINDER_FOOTER)
	local button = CreateFrame("Button", nil, frame)
	button:SetHeight(24)
	button:SetWidth(75)
	button:SetPoint("BOTTOM", 0, 13)
	button:SetNormalFontObject("GameFontNormal")
	button:SetHighlightFontObject("GameFontHighlight")
	button:SetNormalTexture(button:CreateTexture(nil, nil, "UIPanelButtonUpTexture"))
	button:SetPushedTexture(button:CreateTexture(nil, nil, "UIPanelButtonDownTexture"))
	button:SetHighlightTexture(button:CreateTexture(nil, nil, "UIPanelButtonHighlightTexture"))
	button:SetText(DBM_CORE_OK)
	button:SetScript("OnClick", function(self)
		frame:Hide()
	end)
end

----------------------
--  Pull Detection  --
----------------------
do
	local targetList = {}
	local function buildTargetList()
		local uId = ((GetNumRaidMembers() == 0) and "party") or "raid"
		for i = 0, mmax(GetNumRaidMembers(), GetNumPartyMembers()) do
			local id = (i == 0 and "target") or uId..i.."target"
			local guid = UnitGUID(id)
			if guid and DBM:IsCreatureGUID(guid) then
				local cId = DBM:GetCIDFromGUID(guid)
				targetList[cId] = id
			end
		end
	end

	local function clearTargetList()
		twipe(targetList)
	end

	local function scanForCombat(mod, mob)
		if not checkEntry(inCombat, mod) then
			buildTargetList()
			if targetList[mob] and UnitAffectingCombat(targetList[mob]) then
				DBM:StartCombat(mod, 3)
			end
			clearTargetList()
		end
	end

	local function checkForPull(mob, combatInfo)
		local uId = targetList[mob]
		if uId and UnitAffectingCombat(uId) then
			DBM:StartCombat(combatInfo.mod, 0)
			return true
		elseif uId then
			DBM:Schedule(3, scanForCombat, combatInfo.mod, mob)
		end
	end

	function DBM:PLAYER_REGEN_DISABLED()
		if not combatInitialized then return end
		if self.Options.Enabled and combatInfo[GetRealZoneText()] or combatInfo[GetCurrentMapAreaID()] then
			buildTargetList()
			if combatInfo[GetRealZoneText()] then
				for i, v in ipairs(combatInfo[GetRealZoneText()]) do
					if v.type == "combat" then
						if v.multiMobPullDetection then
							for _, mob in ipairs(v.multiMobPullDetection) do
								if checkForPull(mob, v) then
									break
								end
							end
						else
							checkForPull(v.mob, v)
						end
					end
				end
			end
			-- copy & paste, lol
			if combatInfo[GetCurrentMapAreaID()] then
				for i, v in ipairs(combatInfo[GetCurrentMapAreaID()]) do
					if v.type == "combat" then
						if v.multiMobPullDetection then
							for _, mob in ipairs(v.multiMobPullDetection) do
								if checkForPull(mob, v) then
									break
								end
							end
						else
							checkForPull(v.mob, v)
						end
					end
				end
			end
			clearTargetList()
		end
	end
end

do
	-- called for all mob chat events
	local function onMonsterMessage(type, msg)
		-- pull detection
		if combatInfo[GetRealZoneText()] then
			for i, v in ipairs(combatInfo[GetRealZoneText()]) do
				if v.type == type and checkEntry(v.msgs, msg) then
					DBM:StartCombat(v.mod, 0)
				end
			end
		end
		-- copy & paste, lol
		if combatInfo[GetCurrentMapAreaID()] then
			for i, v in ipairs(combatInfo[GetCurrentMapAreaID()]) do
				if v.type == type and checkEntry(v.msgs, msg) then
					DBM:StartCombat(v.mod, 0)
				end
			end
		end
		-- kill detection (wipe detection would also be nice to have)
		-- todo: add sync
		for i = #inCombat, 1, -1 do
			local v = inCombat[i]
			if not v.combatInfo then return end
			if v.combatInfo.killType == type and v.combatInfo.killMsgs[msg] then
				DBM:EndCombat(v)
			end
		end
	end

	function DBM:CHAT_MSG_MONSTER_YELL(msg)
		return onMonsterMessage("yell", msg)
	end

	function DBM:CHAT_MSG_MONSTER_EMOTE(msg)
		return onMonsterMessage("emote", msg)
	end

	function DBM:CHAT_MSG_RAID_BOSS_EMOTE(msg, ...)
		onMonsterMessage("emote", msg)
		return self:FilterRaidBossEmote(msg, ...)
	end

	function DBM:CHAT_MSG_MONSTER_SAY(msg)
		return onMonsterMessage("say", msg)
	end
end


---------------------------
--  Kill/Wipe Detection  --
---------------------------
function checkWipe(confirm)
	if #inCombat > 0 then
		if not savedDifficulty or not difficultyText or not difficultyIndex then--prevent error if savedDifficulty or difficultyText is nil
			savedDifficulty, difficultyText, difficultyIndex, LastGroupSize = DBM:GetCurrentInstanceDifficulty()
		end
		local wipe = true
		local uId = ((GetNumRaidMembers() == 0) and "party") or "raid"
		for i = 0, mmax(GetNumRaidMembers(), GetNumPartyMembers()) do
			local id = (i == 0 and "player") or uId..i
			if UnitAffectingCombat(id) and not UnitIsDeadOrGhost(id) then
				wipe = false
				break
			end
		end
		if not wipe then
			DBM:Schedule(3, checkWipe)
		elseif confirm then
			for i = #inCombat, 1, -1 do
				local reason = (wipe and "No combat unit found in your party.")
				DBM:Debug("You wiped. Reason : "..reason)
				DBM:EndCombat(inCombat[i], true)
			end
		else
			local maxDelayTime = 5
			for i, v in ipairs(inCombat) do
				maxDelayTime = v.combatInfo and v.combatInfo.wipeTimer and v.combatInfo.wipeTimer > maxDelayTime and v.combatInfo.wipeTimer or maxDelayTime
			end
			DBM:Schedule(maxDelayTime, checkWipe, true)
		end
	end
end

function DBM:FireCustomEvent(event, ...)
	fireEvent(event, ...)
end

function DBM:StartCombat(mod, delay, synced, event)
	fireEvent("pull", mod, delay, synced)
	if not checkEntry(inCombat, mod) then
		if not mod.combatInfo then return end
		if mod.combatInfo.noCombatInVehicle and UnitInVehicle("player") then -- HACK
			return
		end
		if event then
			DBM:Debug("StartCombat called by : "..event..". LastInstanceMapID is (skipped)")
		else
			DBM:Debug("StartCombat called by individual mod or unknown reason. LastInstanceMapID is (skipped)")
		end
		tinsert(inCombat, mod)
		self:AddMsg(DBM_CORE_COMBAT_STARTED:format(mod.combatInfo.name))
		if mod:IsDifficulty("heroic5", "heroic25") then
			mod.stats.heroicPulls = mod.stats.heroicPulls + 1
		elseif mod:IsDifficulty("normal5", "heroic10") then
			mod.stats.pulls = mod.stats.pulls + 1
		end
		mod.inCombat = true
		mod.blockSyncs = nil
		mod.combatInfo.pull = GetTime() - (delay or 0)
		self:Schedule(mod.minCombatTime or 3, checkWipe)
		if (DBM.Options.AlwaysShowHealthFrame or mod.Options.HealthFrame) and mod.Options.Enabled then
			DBM.BossHealth:Show(mod.localization.general.name)
			if mod.bossHealthInfo then
				for i = 1, #mod.bossHealthInfo, 2 do
					DBM.BossHealth:AddBoss(mod.bossHealthInfo[i], mod.bossHealthInfo[i + 1])
				end
			else
				DBM.BossHealth:AddBoss(mod.combatInfo.mob, mod.localization.general.name)
			end
		end
		if mod.OnCombatStart and mod.Options.Enabled then mod:OnCombatStart(delay or 0) end
		if not synced then
			sendSync("DBMv4-Pull", (delay or 0).."\t"..mod.id.."\t"..(mod.revision or 0))
		end
		if mod.findFastestComputer and not DBM.Options.DontSetIcons then
			if DBM:GetRaidRank() > 0 then
				for i = 1, #mod.findFastestComputer do
					local option = mod.findFastestComputer[i]
					if mod.Options[option] then
						DBM:Debug(("DBMv4-IS sending %s %s %s"):format(UnitGUID("player"), tostring(DBM.Revision), option),3)
						sendSync("DBMv4-IS", UnitGUID("player").."\t"..tostring(DBM.Revision).."\t"..option)
					end
				end
			elseif GetNumPartyMembers() == 0 then
				for i = 1, #mod.findFastestComputer do
					local option = mod.findFastestComputer[i]
					if mod.Options[option] then
						canSetIcons[option] = true
					end
				end
			end
		end
		-- http://www.deadlybossmods.com/forum/viewtopic.php?t=1464
		if DBM.Options.ShowBigBrotherOnCombatStart and BigBrother and type(BigBrother.ConsumableCheck) == "function" then
			if DBM.Options.BigBrotherAnnounceToRaid then
				BigBrother:ConsumableCheck("RAID")
			else
				BigBrother:ConsumableCheck("SELF")
			end
		end
		if DBM.Options.FixCLEUOnCombatStart then
			CombatLogClearEntries()
		end
	end
end


function DBM:EndCombat(mod, wipe)
	if removeEntry(inCombat, mod) then
		mod:Stop()
		mod.inCombat = false
		mod.blockSyncs = true
		if mod.combatInfo.killMobs then
			for i, v in pairs(mod.combatInfo.killMobs) do
				mod.combatInfo.killMobs[i] = true
			end
		end
		if wipe then
			local thisTime = GetTime() - mod.combatInfo.pull
			if thisTime < 30 then
				if mod:IsDifficulty("heroic5", "heroic25") then
					mod.stats.heroicPulls = mod.stats.heroicPulls - 1
				elseif mod:IsDifficulty("normal5", "heroic10") then
					mod.stats.pulls = mod.stats.pulls - 1
				end
				twipe(mod.iconRestore)
			end
			self:AddMsg(DBM_CORE_COMBAT_ENDED:format(mod.combatInfo.name, strFromTime(thisTime)))
			local msg
			for k, v in pairs(autoRespondSpam) do
				msg = msg or chatPrefixShort..DBM_CORE_WHISPER_COMBAT_END_WIPE:format(UnitName("player"), (mod.combatInfo.name or ""))
				sendWhisper(k, msg)
			end
			fireEvent("wipe", mod)
		else
			local thisTime = GetTime() - mod.combatInfo.pull
			local lastTime = (mod:IsDifficulty("heroic5", "heroic25") and mod.stats.heroicLastTime) or mod:IsDifficulty("normal5", "heroic10") and mod.stats.lastTime
			local bestTime = (mod:IsDifficulty("heroic5", "heroic25") and mod.stats.heroicBestTime) or mod:IsDifficulty("normal5", "heroic10") and mod.stats.bestTime
			if mod:IsDifficulty("heroic5", "heroic25") then
				mod.stats.heroicKills = mod.stats.heroicKills + 1
				mod.stats.heroicLastTime = thisTime
				mod.stats.heroicBestTime = mmin(bestTime or mhuge, thisTime)
			elseif mod:IsDifficulty("normal5", "heroic10") then
				mod.stats.kills = mod.stats.kills + 1
				mod.stats.lastTime = thisTime
				mod.stats.bestTime = mmin(bestTime or mhuge, thisTime)
			end
			if not lastTime then
				self:AddMsg(DBM_CORE_BOSS_DOWN:format(mod.combatInfo.name, strFromTime(thisTime)))
			elseif thisTime < (bestTime or mhuge) then
				self:AddMsg(DBM_CORE_BOSS_DOWN_NEW_RECORD:format(mod.combatInfo.name, strFromTime(thisTime), strFromTime(bestTime)))
			else
				self:AddMsg(DBM_CORE_BOSS_DOWN_LONG:format(mod.combatInfo.name, strFromTime(thisTime), strFromTime(lastTime), strFromTime(bestTime)))
			end
			local msg
			for k, v in pairs(autoRespondSpam) do
				msg = msg or chatPrefixShort..DBM_CORE_WHISPER_COMBAT_END_KILL:format(UnitName("player"), (mod.combatInfo.name or ""))
				sendWhisper(k, msg)
			end
			fireEvent("kill", mod)
		end
		twipe(autoRespondSpam)
		twipe(bossHealth)
		twipe(bossHealthuIdCache)
		twipe(bossuIdCache)
		--sync table
		twipe(canSetIcons)
		twipe(iconSetRevision)
		twipe(iconSetPerson)
		twipe(addsGUIDs)
		if mod.OnCombatEnd then mod:OnCombatEnd(wipe) end
		DBM.BossHealth:Hide()
		DBM.Arrow:Hide(true)
	end
end

function DBM:OnMobKill(cId, synced)
	for i = #inCombat, 1, -1 do
		local v = inCombat[i]
		if not v.combatInfo then
			return
		end
		if v.combatInfo.killMobs and v.combatInfo.killMobs[cId] then
			if not synced then
				sendSync("DBMv4-Kill", cId)
			end
			v.combatInfo.killMobs[cId] = false
			local allMobsDown = true
			for i, v in pairs(v.combatInfo.killMobs) do
				if v then
					allMobsDown = false
					break
				end
			end
			if allMobsDown then
				self:EndCombat(v)
			end
		elseif cId == v.combatInfo.mob and not v.combatInfo.killMobs and not v.combatInfo.multiMobPullDetection then
			if not synced then
				sendSync("DBMv4-Kill", cId)
			end
			self:EndCombat(v)
		end
	end
end

function DBM:SetCurrentSpecInfo()
	currentSpecGroup = GetActiveTalentGroup() or 1

	local maxPoints, specName = 0

	for i = 1, MAX_TALENT_TABS do
		local name, _, pointsSpent = GetTalentTabInfo(i, nil, nil, currentSpecGroup)
		if maxPoints <= pointsSpent then
			maxPoints = pointsSpent
			specName = name
		end
	end

	currentSpecName = specName
end

function DBM:GetCurrentInstanceDifficulty()
	local _, instanceType, difficulty, _, _, playerDifficulty, isDynamicInstance = GetInstanceInfo()
	if instanceType == "raid" and isDynamicInstance then -- "new" instance (ICC)
		if difficulty == 1 then -- 10 men
			return playerDifficulty == 0 and "normal10" or playerDifficulty == 1 and "heroic10" or "unknown"
		elseif difficulty == 2 then -- 25 men
			return playerDifficulty == 0 and "normal25" or playerDifficulty == 1 and "heroic25" or "unknown"
		end
	else -- support for "old" instances
		if GetInstanceDifficulty() == 1 then
			return (self.modId == "DBM-Party-WotLK" or self.modId == "DBM-Party-BC") and "normal5" or
			self.hasHeroic and "normal10" or "heroic10"
		elseif GetInstanceDifficulty() == 2 then
			return (self.modId == "DBM-Party-WotLK" or self.modId == "DBM-Party-BC") and "heroic5" or
			self.hasHeroic and "normal25" or "heroic25"
		elseif GetInstanceDifficulty() == 3 then
			return "heroic10"
		elseif GetInstanceDifficulty() == 4 then
			return "heroic25"
		end
	end
end

function DBM:GetGroupSize()
	return LastGroupSize
end

function DBM:HasMapRestrictions()
	local mapName = GetMapInfo()
	local level = GetCurrentMapDungeonLevel()
	if level == 0 then level = 1 end
	local playerX, playerY = GetPlayerMapPosition("player")
	if (playerX == 0 or playerY == 0) or (self.MapSizes[mapName] and not self.MapSizes[mapName][level]) then
		return true
	end
	return false
end

--Handle new spell name requesting with wrapper, to make api changes easier to handle
function DBM:GetSpellInfo(spellId)
	local name, rank, icon, cost, isFunnel, powerType, castingTime, minRange, maxRange = GetSpellInfo(spellId)
	if not name then--Bad request all together
		DBM:Debug("|cffff0000Invalid call to GetSpellInfo for spellID: |r"..spellId)
		return nil
	else--Good request, return now
		return name, rank, icon, cost, isFunnel, powerType, castingTime, minRange, maxRange
	end
end

function DBM:UnitDebuff(uId, spellInput, spellInput2, spellInput3, spellInput4)
	if not uId then return end
	for i = 1, 60 do
		local spellName, rank, icon, count, debuffType, duration, expirationTime, unitCaster, isStealable, shouldConsolidate, spellId = UnitDebuff(uId, i)
		if not spellName then return end
		if spellInput == spellName or spellInput == spellId or spellInput2 == spellName or spellInput2 == spellId or spellInput3 == spellName or spellInput3 == spellId or spellInput4 == spellName or spellInput4 == spellId then
			return spellName, rank, icon, count, debuffType, duration, expirationTime, unitCaster, isStealable, shouldConsolidate, spellId
		end
	end
end

function DBM:UnitBuff(uId, spellInput, spellInput2, spellInput3, spellInput4)
	if not uId then return end
	for i = 1, 60 do
		local spellName, rank, icon, count, debuffType, duration, expirationTime, unitCaster, isStealable, shouldConsolidate, spellId = UnitBuff(uId, i)
		if not spellName then return end
		if spellInput == spellName or spellInput == spellId or spellInput2 == spellName or spellInput2 == spellId or spellInput3 == spellName or spellInput3 == spellId or spellInput4 == spellName or spellInput4 == spellId then
			return spellName, rank, icon, count, debuffType, duration, expirationTime, unitCaster, isStealable, shouldConsolidate, spellId
		end
	end
end

function DBM:UNIT_DIED(args)
	local GUID = args.destGUID
	if self:IsCreatureGUID(GUID) then
		self:OnMobKill(self:GetCIDFromGUID(GUID))
	end
end
DBM.UNIT_DESTROYED = DBM.UNIT_DIED


----------------------
--  Timer recovery  --
----------------------
do
	local requestedFrom = {}
	local requestTime = 0
	local clientUsed = {}
	local sortMe = {}

	local function sort(v1, v2)
		if v1.revision and not v2.revision then
			return true
		elseif v2.revision and not v1.revision then
			return false
		elseif v1.revision and v2.revision then
			return v1.revision > v2.revision
		end
	end

	function DBM:RequestTimers(requestNum)
		twipe(sortMe)
		for i, v in pairs(raid) do
			tinsert(sortMe, v)
		end
		tsort(sortMe, sort)
		self:Debug("RequestTimers Running", 2)
		local selectedClient
		local listNum = 0
		for i, v in ipairs(sortMe) do
			-- If selectedClient player's realm is not same with your's, timer recovery by selectedClient not works at all.
			-- SendAddonMessage target channel is "WHISPER" and target player is other realm, no msg sends at all. At same realm, message sending works fine. (Maybe bliz bug or SendAddonMessage function restriction?)
			if v.revision then
				if v.name ~= playerName and tonumber(v.revision) >= 6010 and UnitIsConnected(v.id) and (not UnitIsGhost(v.id)) and (GetTime() - (clientUsed[v.name] or 0)) > 10 then
					listNum = listNum + 1
					if listNum == requestNum then
						selectedClient = v
						clientUsed[v.name] = GetTime()
						break
					end
				end
			end
		end
		if not selectedClient then return end
		self:Debug("Requesting timer recovery to "..selectedClient.name)
		requestedFrom[selectedClient.name] = true
		requestTime = GetTime()
		SendAddonMessage("DBMv4-RequestTimers", "", "WHISPER", selectedClient.name)
	end

	function DBM:ReceiveCombatInfo(sender, mod, time)
		if DBM.Options.Enabled and requestedFrom[sender] and (GetTime() - requestTime) < 5 and #inCombat == 0 then
			--self:StartCombat(mod, time, true, "TIMER_RECOVERY")
			--Recovery successful, someone sent info, abort other recovery requests
			--self:Unschedule(self.RequestTimers)
			--twipe(requestedFrom)
			local lag = select(3, GetNetStats()) / 1000
			if not mod.combatInfo then return end
			tinsert(inCombat, mod)
			mod.inCombat = true
			mod.blockSyncs = nil
			mod.combatInfo.pull = GetTime() - time + lag
			self:Schedule(3, checkWipe)
		end
	end

	function DBM:ReceiveTimerInfo(sender, mod, timeLeft, totalTime, id, ...)
		DBM:Debug(("Receiving Timer Info: %s %s %s %s from %s"):format(mod.id, timeLeft, totalTime, "123", sender),3)
		if requestedFrom[sender] and (GetTime() - requestTime) < 5 then
			local lag = select(3, GetNetStats()) / 1000
			for i, v in ipairs(mod.timers) do
				if v.id == id then
					v:Start(totalTime, ...)
					v:Update(totalTime - timeLeft + lag, totalTime, ...)
				end
			end
		end
	end

	function DBM:ReceiveVariableInfo(sender, mod, name, value)
		if requestedFrom[sender] and (GetTime() - requestTime) < 5 then
			if value == "true" then
				mod.vb[name] = true
			elseif value == "false" then
				mod.vb[name] = false
			else
				mod.vb[name] = value
			end
		end
	end
end

do
	local spamProtection = {}
	function DBM:SendTimers(target)
		self:Debug("SendTimers requested by "..target, 2)
		local spamForTarget = spamProtection[target] or 0
		-- just try to clean up the table, that should keep the hash table at max. 4 entries or something :)
		for k, v in pairs(spamProtection) do
			if GetTime() - v >= 1 then
				spamProtection[k] = nil
			end
		end
		if GetTime() - spamForTarget < 1 then -- just to prevent players from flooding this on purpose
			return
		end
		spamProtection[target] = GetTime()
		if #inCombat < 1 then
			self:Debug("Sending Break timer to "..target, 2)
			--Break timer is up, so send that
			--But only if we are not in combat with a boss
			local breakBar = self.Bars:GetBar("%s\t"..DBM_CORE_TIMER_BREAK) or self.Bars:GetBar(DBM_CORE_TIMER_BREAK)
			if breakBar then
				SendAddonMessage("DBMv4-BTR3", ("%s\t%s\t%s\t%s"):format(breakBar.timer, breakBar.totalTime, breakBar.id, DBM_CORE_TIMER_BREAK), "WHISPER", target)
			end
			breakBar = self.Bars:GetBar("TimerCombatStart")
			if breakBar then
				SendAddonMessage("DBMv4-BTR3", ("%s\t%s\t%s\t%s\t%s"):format(breakBar.timer, breakBar.totalTime, breakBar.id, DBM_TimerCombatStart, 2457), "WHISPER", target)
			end
			return
		end
		local mod
		for i, v in ipairs(inCombat) do
			mod = not v.isCustomMod and v
		end
		mod = mod or inCombat[1]
		self:SendCombatInfo(mod, target)
		self:SendVariableInfo(mod, target)
		self:SendTimerInfo(mod, target)
	end
end

function DBM:SendBGTimers(target)
	local mod
	if IsActiveBattlefieldArena() then
		mod = self:GetModByName("Arenas")
	else
		-- FIXME: this doesn't work for non-english clients
		local zone = GetRealZoneText():gsub(" ", "")
		mod = self:GetModByName(zone)
	end
	if mod and mod.timers then
		self:SendTimerInfo(mod, target)
	end
end

function DBM:SendCombatInfo(mod, target)
	return SendAddonMessage("DBMv4-CombatInfo", ("%s\t%s"):format(mod.id, GetTime() - mod.combatInfo.pull), "WHISPER", target)
end

function DBM:SendTimerInfo(mod, target)
	for i, v in ipairs(mod.timers) do
		--Pass on any timer that has no type, or has one that isn't an ai timer
		if not v.type or v.type and v.type ~= "ai" then
			for _, uId in ipairs(v.startedTimers) do
				local elapsed, totalTime, timeLeft
				if select("#", string.split("\t", uId)) > 1 then
					elapsed, totalTime = v:GetTime(select(2, string.split("\t", uId)))
				else
					elapsed, totalTime = v:GetTime()
				end
				timeLeft = totalTime - elapsed
				if timeLeft > 0 and totalTime > 0 then
					DBM:Debug(("Sending Timer Info: %s %s %s %s to %s"):format(mod.id, timeLeft, totalTime, uId, target),3)
					SendAddonMessage("DBMv4-TimerInfo", ("%s\t%s\t%s\t%s"):format(mod.id, timeLeft, totalTime, uId), "WHISPER", target)
				end
			end
		end
	end
end

function DBM:SendVariableInfo(mod, target)
	for vname, v in pairs(mod.vb) do
		local v2 = tostring(v)
		if v2 then
			SendAddonMessage("DBMv4-VarInfo", ("%s\t%s\t%s"):format(mod.id, vname, v2), "WHISPER", target)
		end
	end
end

do

	function DBM:PLAYER_ENTERING_WORLD()
		if #inCombat == 0 then
			DBM:Schedule(0, self.RequestTimers, self, 1)
		end
		self:LFG_UPDATE()
--		self:Schedule(10, function() if not DBM.Options.HelpMessageShown then DBM.Options.HelpMessageShown = true DBM:AddMsg(DBM_CORE_NEED_SUPPORT) end end)
		if DBM.Options.DisableCinematics then
			MovieFrame:SetScript("OnEvent", function() GameMovieFinished() end)
		end
	end
end


------------------------------------
--  Auto-respond/Status whispers  --
------------------------------------
do
	local function getNumAlivePlayers()
		local alive = 0
		if GetNumRaidMembers() > 0 then
			for i = 1, GetNumRaidMembers() do
				alive = alive + ((UnitIsDeadOrGhost("raid"..i) and 0) or 1)
			end
		else
			alive = (UnitIsDeadOrGhost("player") and 0) or 1
			for i = 1, GetNumPartyMembers() do
				alive = alive + ((UnitIsDeadOrGhost("party"..i) and 0) or 1)
			end
		end
		return alive
	end


	local function isOnSameServer(presenceId)
		local toonID, client = select(5, BNGetFriendInfoByID(presenceId))
		if client ~= "WoW" then
			return false
		end
		return GetRealmName() == select(4, BNGetToonInfo(toonID))
	end

	-- sender is a presenceId for real id messages, a character name otherwise
	local function onWhisper(msg, sender, isRealIdMessage)
		if msg == "status" and #inCombat > 0 and DBM.Options.StatusEnabled then
			local mod
			for i, v in ipairs(inCombat) do
				mod = not v.isCustomMod and v
			end
			mod = mod or inCombat[1]
			sendWhisper(sender, chatPrefix..DBM_CORE_STATUS_WHISPER:format((mod.combatInfo.name or ""), mod:GetHP() or "unknown", getNumAlivePlayers(), mmax(GetNumRaidMembers(), GetNumPartyMembers() + 1)))
		elseif #inCombat > 0 and DBM.Options.AutoRespond and
		(isRealIdMessage and (not isOnSameServer(sender) or DBM:GetRaidUnitId((select(4, BNGetFriendInfoByID(sender)))) == "none") or not isRealIdMessage and DBM:GetRaidUnitId(sender) == "none") then
			local mod
			for i, v in ipairs(inCombat) do
				mod = not v.isCustomMod and v
			end
			mod = mod or inCombat[1]
			if not autoRespondSpam[sender] then
				sendWhisper(sender, chatPrefix..DBM_CORE_AUTO_RESPOND_WHISPER:format(UnitName("player"), mod.combatInfo.name or "", mod:GetHP() or "unknown", getNumAlivePlayers(), mmax(GetNumRaidMembers(), GetNumPartyMembers() + 1)))
				DBM:AddMsg(DBM_CORE_AUTO_RESPONDED)
			end
			autoRespondSpam[sender] = true
		end
	end

	function DBM:CHAT_MSG_WHISPER(msg, name)
		return onWhisper(msg, name, false)
	end

	function DBM:CHAT_MSG_BN_WHISPER(msg, ...)
		local presenceId = select(12, ...) -- srsly?
		return onWhisper(msg, presenceId, true)
	end
end


-------------------
--  Chat Filter  --
-------------------
do
	local function filterOutgoing(self, event, ...)
		local msg = ...
		if not msg and self then -- compatibility mode!
			-- we also check if self exists to prevent a possible freeze if the function is called without arguments at all
			-- as this would be even worse than the issue with missing whisper messages ;)
			return filterOutgoing(nil, nil, self, event)
		end
		return msg:sub(1, chatPrefix:len()) == chatPrefix or msg:sub(1, chatPrefixShort:len()) == chatPrefixShort, ...
	end

	local function filterIncoming(self, event, ...)
		local msg = ...
		if not msg and self then -- compatibility mode!
			return filterIncoming(nil, nil, self, event)
		end
		if DBM.Options.SpamBlockBossWhispers then
			return #inCombat > 0 and (msg == "status" or msg:sub(1, chatPrefix:len()) == chatPrefix or msg:sub(1, chatPrefixShort:len()) == chatPrefixShort), ...
		else
			return msg == "status" and #inCombat > 0, ...
		end
	end

	local function filterRaidWarning(self, event, ...)
		local msg = ...
		if not msg and self then -- compatibility mode!
			return filterRaidWarning(nil, nil, self, event)
		end
		return DBM.Options.SpamBlockRaidWarning and type(msg) == "string" and (not not msg:match("^%s*%*%*%*")), ...
	end

	ChatFrame_AddMessageEventFilter("CHAT_MSG_WHISPER_INFORM", filterOutgoing)
	ChatFrame_AddMessageEventFilter("CHAT_MSG_BN_WHISPER_INFORM", filterOutgoing)
	ChatFrame_AddMessageEventFilter("CHAT_MSG_WHISPER", filterIncoming)
	ChatFrame_AddMessageEventFilter("CHAT_MSG_BN_WHISPER", filterIncoming)
	ChatFrame_AddMessageEventFilter("CHAT_MSG_RAID_WARNING", filterRaidWarning)
	ChatFrame_AddMessageEventFilter("CHAT_MSG_PARTY", filterRaidWarning)
	ChatFrame_AddMessageEventFilter("CHAT_MSG_PARTY_LEADER", filterRaidWarning)
end


do
	local old = RaidWarningFrame:GetScript("OnEvent")
	RaidWarningFrame:SetScript("OnEvent", function(self, event, msg, ...)
		if DBM.Options.SpamBlockRaidWarning and msg:find("%*%*%* .* %*%*%*") then
			return
		end
		return old(self, event, msg, ...)
	end)
end

do
	local old = RaidBossEmoteFrame:GetScript("OnEvent")
	RaidBossEmoteFrame:SetScript("OnEvent", function(...)
		if DBM.Options.HideBossEmoteFrame and #inCombat > 0 then
			return
		end
		return old(...)
	end)
end


--------------------------
--  Enable/Disable DBM  --
--------------------------
function DBM:Disable()
	unscheduleAll()
	self.Options.Enabled = false
end

function DBM:Enable()
	self.Options.Enabled = true
end

function DBM:IsEnabled()
	return self.Options.Enabled
end


-----------------------
--  Misc. Functions  --
-----------------------
function DBM:AddMsg(text, prefix, force)
	local tag = prefix or (self.localization and self.localization.general.name) or "DBM"
	local frame = _G[tostring(DBM.Options.ChatFrame)]
	local f = force or false
	frame = frame and frame:IsShown() and frame or DEFAULT_CHAT_FRAME
	if prefix ~= false and not DBM.Options.SilentMode then
		frame:AddMessage(("|cffff7d0a<|r|cffffd200%s|r|cffff7d0a>|r %s"):format(tostring(tag), tostring(text)), 0.41, 0.8, 0.94)
	elseif not DBM.Options.SilentMode then
		frame:AddMessage(text, 0.41, 0.8, 0.94)
	elseif f then
		frame:AddMessage(("|cffff7d0a<|r|cffffd200%s|r|cffff7d0a>|r %s"):format(tostring(tag), tostring(text)), 0.41, 0.8, 0.94)
	end
end
AddMsg = DBM.AddMsg

function DBM:Debug(text, level)
	if not self.Options or not self.Options.DebugMode then return end
	if (level or 1) <= DBM.Options.DebugLevel then
		local frame = _G[tostring(DBM.Options.ChatFrame)]
		frame = frame and frame:IsShown() and frame or DEFAULT_CHAT_FRAME
		frame:AddMessage("|cffff7d0aDBM Debug:|r "..text, 1, 1, 1)
		fireEvent("DBM_Debug", text, level)
	end
end

do
	local testMod
	local testWarning1, testWarning2, testWarning3
	local testTimer
	local testSpecialWarning
	function DBM:DemoMode()
		if not testMod then
			testMod = DBM:NewMod("TestMod", "DBM-PvP")	-- temp fix, as it requires a modId
			testWarning1 = testMod:NewAnnounce("%s", 1, "Interface\\Icons\\Spell_Nature_WispSplode")
			testWarning2 = testMod:NewAnnounce("%s", 2, "Interface\\Icons\\Spell_Shadow_ShadesOfDarkness")
			testWarning3 = testMod:NewAnnounce("%s", 3, "Interface\\Icons\\Spell_Fire_SelfDestruct")
			testTimer = testMod:NewTimer(20, "%s")
			testSpecialWarning = testMod:NewSpecialWarning("%s")
		end
		testTimer:Start(20, "Pew Pew Pew...")
		testTimer:UpdateIcon("Interface\\Icons\\Spell_Nature_Starfall", "Pew Pew Pew...")
		testTimer:Start(10, "Test Bar")
		testTimer:UpdateIcon("Interface\\Icons\\Spell_Nature_WispSplode", "Test Bar")
		testTimer:Start(43, "Evil Spell")
		testTimer:UpdateIcon("Interface\\Icons\\Spell_Shadow_ShadesOfDarkness", "Evil Spell")
		testTimer:Start(60, "Boom!")
		testTimer:UpdateIcon("Interface\\Icons\\Spell_Fire_SelfDestruct", "Boom!")
		testWarning1:Cancel()
		testWarning2:Cancel()
		testWarning3:Cancel()
		testSpecialWarning:Cancel()
		testWarning1:Show("Test-mode started...")
		testWarning1:Schedule(62, "Test-mode finished!")
		testWarning3:Schedule(50, "Boom in 10 sec!")
		testWarning3:Schedule(20, "Pew Pew Laser Owl!")
		testWarning2:Schedule(38, "Evil Spell in 5 sec!")
		testWarning2:Schedule(43, "Evil Spell!")
		testWarning1:Schedule(10, "Test bar expired!")
		testSpecialWarning:Schedule(60, "Boom!")
	end
end

DBM.Bars:SetAnnounceHook(function(bar)
	local prefix
	if bar.color and bar.color.r == 1 and bar.color.g == 0 and bar.color.b == 0 then
		prefix = DBM_CORE_HORDE
	elseif bar.color and bar.color.r == 0 and bar.color.g == 0 and bar.color.b == 1 then
		prefix = DBM_CORE_ALLIANCE
	end
	if prefix then
		return ("%s: %s  %d:%02d"):format(prefix, _G[bar.frame:GetName().."BarName"]:GetText(), floor(bar.timer / 60), bar.timer % 60)
	end
end)

function DBM:Capitalize(str)
	local firstByte = str:byte(1, 1)
	local numBytes = 1
	if firstByte >= 0xF0 then -- firstByte & 0b11110000
		numBytes = 4
	elseif firstByte >= 0xE0 then -- firstByte & 0b11100000
		numBytes = 3
	elseif firstByte >= 0xC0 then  -- firstByte & 0b11000000
		numBytes = 2
	end
	return str:sub(1, numBytes):upper()..str:sub(numBytes + 1):lower()
end

-- An anti spam function to throttle spammy events (e.g. SPELL_AURA_APPLIED on all group members)
-- @param time the time to wait between two events (optional, default 2.5 seconds)
-- @param id the id to distinguish different events (optional, only necessary if your mod keeps track of two different spam events at the same time)
function DBM:AntiSpam(time, id)
	if GetTime() - (id and (self["lastAntiSpam" .. tostring(id)] or 0) or self.lastAntiSpam or 0) > (time or 2.5) then
		if id then
			self["lastAntiSpam" .. tostring(id)] = GetTime()
		else
			self.lastAntiSpam = GetTime()
		end
		return true
	else
		return false
	end
end

function DBM:GetTOC()
	return wowTOC, wowVersionString, wowBuild
end

function DBM:InCombat()
	if #inCombat > 0 then
		return true
	end
	return false
end

do
	local iconStrings = {[1] = RAID_TARGET_1, [2] = RAID_TARGET_2, [3] = RAID_TARGET_3, [4] = RAID_TARGET_4, [5] = RAID_TARGET_5, [6] = RAID_TARGET_6, [7] = RAID_TARGET_7, [8] = RAID_TARGET_8,}
	function DBM:IconNumToString(number)
		return iconStrings[number] or number
	end
	function DBM:IconNumToTexture(number)
		return "|TInterface\\TargetingFrame\\UI-RaidTargetingIcon_"..number..".blp:12:12|t" or number
	end
end

-----------------
--  Map Sizes  --
-----------------
DBM.MapSizes = {}

function DBM:RegisterMapSize(zone, ...)
	if not DBM.MapSizes[zone] then
		DBM.MapSizes[zone] = {}
	end
	for i = 1, select("#", ...), 3 do
		local level, width, height = select(i, ...)
		DBM.MapSizes[zone][level] = {width, height}
	end
end


--------------------------
--  Boss Mod Prototype  --
--------------------------
local bossModPrototype = {}


----------------------------
--  Boss Mod Constructor  --
----------------------------
do
	local modsById = setmetatable({}, {__mode = "v"})
	local mt = {__index = bossModPrototype}

	function DBM:NewMod(name, modId, modSubTab)
		if modsById[name] then error("DBM:NewMod(): Mod names are used as IDs and must therefore be unique.", 2) end
		local obj = setmetatable(
			{
				Options = {
					Enabled = true,
					Announce = false,
				},
				subTab = modSubTab,
				optionCategories = {
				},
				categorySort = {},
				id = name,
				announces = {},
				specwarns = {},
				timers = {},
				vb = {},
				iconRestore = {},
				modId = modId,
				revision = 0,
				localization = self:GetModLocalization(name)
			},
			mt
		)
		for i, v in ipairs(self.AddOns) do
			if v.modId == modId then
				obj.addon = v
				break
			end
		end
		if obj.localization.general.name == "name" then obj.localization.general.name = name end
		tinsert(self.Mods, obj)
		if modId then
			self.ModLists[modId] = self.ModLists[modId] or {}
			tinsert(self.ModLists[modId], name)
		end
		modsById[name] = obj
		obj:AddBoolOption("HealthFrame", false, "misc")
		obj:SetZone()
		return obj
	end

	function DBM:GetModByName(name)
		return modsById[tostring(name)]
	end
end


-----------------------
--  General Methods  --
-----------------------
bossModPrototype.RegisterEvents = DBM.RegisterEvents
bossModPrototype.AddMsg = DBM.AddMsg

function bossModPrototype:SetZone(...)
	if select("#", ...) == 0 then
		if self.addon and self.addon.zone then
			self.zones = {}
			for i, v in ipairs(self.addon.zone) do
				self.zones[#self.zones + 1] = v
			end
		end
		if self.addon and self.addon.zoneId then
			for i, v in ipairs(self.addon.zoneId) do
				self.zones[#self.zones + 1] = v
			end
		end
	elseif select(1, ...) ~= DBM_DISABLE_ZONE_DETECTION then
		self.zones = {...}
	else -- disable zone detection
		self.zones = nil
	end
end

function bossModPrototype:SetCreatureID(...)
	self.creatureId = ...
	if select("#", ...) > 1 then
		self.multiMobPullDetection = {...}
		if self.combatInfo then
			self.combatInfo.multiMobPullDetection = self.multiMobPullDetection
		end
	end
end

function bossModPrototype:Toggle()
	if self.Options.Enabled then
		self:DisableMod()
	else
		self:EnableMod()
	end
end

function bossModPrototype:EnableMod()
	self.Options.Enabled = true
end

function bossModPrototype:DisableMod()
	self:Stop()
	self.Options.Enabled = false
end

function bossModPrototype:Stop()
	for i, v in ipairs(self.timers) do
		v:Stop()
	end
	self:Unschedule()
end


function bossModPrototype:RegisterOnUpdateHandler(func, interval)
	startScheduler()
	if type(func) ~= "function" then return end
	self.elapsed = 0
	self.updateInterval = interval or 0
	updateFunctions[self] = func
end

function bossModPrototype:SetRevision(revision)
	self.revision = revision
end

function bossModPrototype:SendWhisper(msg, target)
	return not DBM.Options.DontSendBossWhispers and sendWhisper(target, chatPrefixShort..msg)
end

function bossModPrototype:GetUnitCreatureId(uId)
	local guid = UnitGUID(uId)
	return (guid and tonumber(guid:sub(9, 12), 16)) or 0
end

function bossModPrototype:GetCIDFromGUID(guid)
	return (guid and tonumber(guid:sub(9, 12), 16)) or 0
end

DBM.GetUnitCreatureId = bossModPrototype.GetUnitCreatureId

do
	local bossTargetuIds = {
		"boss1", "boss2", "boss3", "boss4", "boss5", "focus", "target", "mouseover"
	}
	local targetScanCount = {}
	local repeatedScanEnabled = {}

	local function getBossTarget(guid, scanOnlyBoss)
		local name, uid, bossuid
		local cacheuid = bossuIdCache[guid] or "boss1"
		if UnitGUID(cacheuid) == guid then
			bossuid = cacheuid
			name = DBM:GetUnitFullName(cacheuid.."target")
			uid = cacheuid.."target"
			bossuIdCache[guid] = bossuid
		end
		if name then return name, uid, bossuid end
		for _, uId in ipairs(bossTargetuIds) do
			if UnitGUID(uId) == guid then
				bossuid = uId
				name = DBM:GetUnitFullName(uId.."target")
				uid = uId.."target"
				bossuIdCache[guid] = bossuid
				break
			end
		end
		if name or scanOnlyBoss then return name, uid, bossuid end
		-- failed to detect from default uIds, scan all group members's target.
		if IsInRaid() then
			for i = 1, GetNumRaidMembers() do
				if UnitGUID("raid"..i.."target") == guid then
					bossuid = "raid"..i.."target"
					name = DBM:GetUnitFullName("raid"..i.."targettarget")
					uid = "raid"..i.."targettarget"
					bossuIdCache[guid] = bossuid
					break
				end
			end
		end
		return name, uid, bossuid
	end

	function bossModPrototype:GetBossTarget(cidOrGuid, scanOnlyBoss)
		local name, uid, bossuid
		if type(cidOrGuid) == "number" then
			cidOrGuid = cidOrGuid or self.creatureId
			local cacheuid = bossuIdCache[cidOrGuid] or "boss1"
			if self:GetUnitCreatureId(cacheuid) == cidOrGuid then
				bossuIdCache[cidOrGuid] = cacheuid
				bossuIdCache[UnitGUID(cacheuid)] = cacheuid
				name, uid, bossuid = getBossTarget(UnitGUID(cacheuid), scanOnlyBoss)
			else
				local found = false
				for _, uId in ipairs(bossTargetuIds) do
					if self:GetUnitCreatureId(uId) == cidOrGuid then
						found = true
						bossuIdCache[cidOrGuid] = uId
						bossuIdCache[UnitGUID(uId)] = uId
						name, uid, bossuid = getBossTarget(UnitGUID(uId), scanOnlyBoss)
						break
					end
				end
				if not found and not scanOnlyBoss then
					if IsInRaid() then
						for i = 1, GetNumRaidMembers() do
							if self:GetUnitCreatureId("raid"..i.."target") == cidOrGuid then
								bossuIdCache[cidOrGuid] = "raid"..i.."target"
								bossuIdCache[UnitGUID("raid"..i.."target")] = "raid"..i.."target"
								name, uid, bossuid = getBossTarget(UnitGUID("raid"..i.."target"))
								break
							end
						end
					end
				end
			end
		else
			name, uid, bossuid = getBossTarget(cidOrGuid, scanOnlyBoss)
		end
		if uid then
			local cid = DBM:GetUnitCreatureId(uid)
			if cid == 24207 or cid == 80258 or cid == 87519 then--filter army of the dead/Garrison Footman (basically same thing as army)
				return nil, nil, nil
			end
		end
		return name, uid, bossuid
	end

	function bossModPrototype:BossTargetScannerAbort(cidOrGuid, returnFunc)
		targetScanCount[cidOrGuid] = nil--Reset count for later use.
		self:UnscheduleMethod("BossTargetScanner", cidOrGuid, returnFunc)
		DBM:Debug("Boss target scan for "..cidOrGuid.." should be aborting.", 3)
	end

	function bossModPrototype:BossUnitTargetScannerAbort(uId)
		if not uId then--Not called with unit, means mod requested to clear all used units
			DBM:Debug("BossUnitTargetScannerAbort called without unit, clearing all targetMonitor units", 2)
			twipe(targetMonitor)
			return
		end
		if targetMonitor[uId] and targetMonitor[uId].allowTank and UnitExists(uId.."target") and UnitPlayerOrPetInRaid(uId.."target") then
			DBM:Debug("targetMonitor unit exists, allowTank target exists", 2)
			local modId, returnFunc = targetMonitor[uId].modid, targetMonitor[uId].returnFunc
			DBM:Debug("targetMonitor: "..modId..", "..uId..", "..returnFunc, 2)
			local mod = self:GetModByName(modId)
			DBM:Debug("targetMonitor found a target that probably is a tank", 2)
			mod[returnFunc](mod, DBM:GetUnitFullName(uId.."target"), uId.."target", uId)--Return results to warning function with all variables.
		end
		targetMonitor[uId] = nil
		DBM:Debug("Boss unit target scan should be aborting for "..uId, 3)
	end

	function bossModPrototype:BossUnitTargetScanner(uId, returnFunc, scanTime, allowTank)
		--UNIT_TARGET event monitor target scanner. Will instantly detect a target change of a registered Unit
		--If target change occurs before this method is called (or if boss doesn't change target because cast ends up actually being on the tank, target scan will fail completely
		--If allowTank is passed, it basically tells this scanner to return current target of unitId at time of failure/abort when scanTime is complete
		local scanDuration = scanTime or 1.5
		targetMonitor[uId] = {}
		targetMonitor[uId].modid, targetMonitor[uId].returnFunc, targetMonitor[uId].allowTank = self.id, returnFunc, allowTank
		self:ScheduleMethod(scanDuration, "BossUnitTargetScannerAbort", uId)--In case of BossUnitTargetScanner firing too late, and boss already having changed target before monitor started, it needs to abort after x seconds
	end

	function bossModPrototype:BossTargetScanner(cidOrGuid, returnFunc, scanInterval, scanTimes, scanOnlyBoss, isEnemyScan, isFinalScan, targetFilter, tankFilter, onlyPlayers)
		--Increase scan count
		cidOrGuid = cidOrGuid or self.creatureId
		if not cidOrGuid then return end
		if not targetScanCount[cidOrGuid] then targetScanCount[cidOrGuid] = 0 end
		targetScanCount[cidOrGuid] = targetScanCount[cidOrGuid] + 1
		--Set default values
		scanInterval = scanInterval or 0.05
		scanTimes = scanTimes or 16
		local targetname, targetuid, bossuid = self:GetBossTarget(cidOrGuid, scanOnlyBoss)
		DBM:Debug("Boss target scan "..targetScanCount[cidOrGuid].." of "..scanTimes..", found target "..(targetname or "nil").." using "..(bossuid or "nil"), 3)--Doesn't hurt to keep this, as level 3
		--Do scan
		if targetname and targetname ~= DBM_CORE_UNKNOWN and (not targetFilter or (targetFilter and targetFilter ~= targetname)) then
			if not IsInRaid() then scanTimes = 1 end--Solo, no reason to keep scanning, give faster warning. But only if first scan is actually a valid target, which is why i have this check HERE
			if (isEnemyScan and UnitIsFriend("player", targetuid) or (onlyPlayers and not UnitIsPlayer("player", targetuid)) or self:IsTanking(targetuid, bossuid)) and not isFinalScan then--On player scan, ignore tanks. On enemy scan, ignore friendly player. On Only player, ignore npcs and pets
				if targetScanCount[cidOrGuid] < scanTimes then--Make sure no infinite loop.
					self:ScheduleMethod(scanInterval, "BossTargetScanner", cidOrGuid, returnFunc, scanInterval, scanTimes, scanOnlyBoss, isEnemyScan, nil, targetFilter, tankFilter, onlyPlayers)--Scan multiple times to be sure it's not on something other then tank (or friend on enemy scan, or npc/pet on only person)
				else--Go final scan.
					self:BossTargetScanner(cidOrGuid, returnFunc, scanInterval, scanTimes, scanOnlyBoss, isEnemyScan, true, targetFilter, tankFilter, onlyPlayers)
				end
			else--Scan success. (or failed to detect right target.) But some spells can be used on tanks, anyway warns tank if player scan. (enemy scan block it)
				targetScanCount[cidOrGuid] = nil--Reset count for later use.
				self:UnscheduleMethod("BossTargetScanner", cidOrGuid, returnFunc)--Unschedule all checks just to be sure none are running, we are done.
				if (tankFilter and self:IsTanking(targetuid, bossuid)) or (isFinalScan and isEnemyScan) or onlyPlayers and not UnitIsPlayer("player", targetuid) then return end--If enemyScan and playerDetected, return nothing
				local scanningTime = (targetScanCount[cidOrGuid] or 1) * scanInterval
				self[returnFunc](self, targetname, targetuid, bossuid, scanningTime)--Return results to warning function with all variables.
			end
		else--target was nil, lets schedule a rescan here too.
			if targetScanCount[cidOrGuid] < scanTimes then--Make sure not to infinite loop here as well.
				self:ScheduleMethod(scanInterval, "BossTargetScanner", cidOrGuid, returnFunc, scanInterval, scanTimes, scanOnlyBoss, isEnemyScan, nil, targetFilter, tankFilter, onlyPlayers)
			else
				targetScanCount[cidOrGuid] = nil--Reset count for later use.
				self:UnscheduleMethod("BossTargetScanner", cidOrGuid, returnFunc)--Unschedule all checks just to be sure none are running, we are done.
			end
		end
	end

	--infinite scanner. so use this carefully.
	local function repeatedScanner(cidOrGuid, returnFunc, scanInterval, scanOnlyBoss, includeTank, mod)
		if repeatedScanEnabled[returnFunc] then
			cidOrGuid = cidOrGuid or mod.creatureId
			scanInterval = scanInterval or 0.1
			local targetname, targetuid, bossuid = mod:GetBossTarget(cidOrGuid, scanOnlyBoss)
			if targetname and (includeTank or not mod:IsTanking(targetuid, bossuid)) then
				mod[returnFunc](mod, targetname, targetuid, bossuid)
			end
			DBM:Schedule(scanInterval, repeatedScanner, cidOrGuid, returnFunc, scanInterval, scanOnlyBoss, includeTank, mod)
		end
	end

	function bossModPrototype:StartRepeatedScan(cidOrGuid, returnFunc, scanInterval, scanOnlyBoss, includeTank)
		repeatedScanEnabled[returnFunc] = true
		repeatedScanner(cidOrGuid, returnFunc, scanInterval, scanOnlyBoss, includeTank, self)
	end

	function bossModPrototype:StopRepeatedScan(returnFunc)
		repeatedScanEnabled[returnFunc] = nil
	end
end

do
	local bossCache = {}
	local lastTank

	function bossModPrototype:GetCurrentTank(cidOrGuid)
		if lastTank and GetTime() - (bossCache[cidOrGuid] or 0) < 2 then -- return last tank within 2 seconds of call
			return lastTank
		else
			cidOrGuid = cidOrGuid or self.creatureId--GetBossTarget supports GUID or CID and it will automatically return correct values with EITHER ONE
			local uId
			local _, fallbackuId, mobuId = self:GetBossTarget(cidOrGuid)
			if mobuId then--Have a valid mob unit ID
				--First, use trust threat more than fallbackuId and see what we pull from it first.
				--This is because for GetCurrentTank we want to know who is tanking it, not who it's targeting.
				local unitId = (IsInRaid() and "raid") or "party"
				for i = 0, GetNumGroupMembers() do
					local id = (i == 0 and "target") or unitId..i
					local tanking, status = UnitDetailedThreatSituation(id, mobuId)--Tanking may return 0 if npc is temporarily looking at an NPC (IE fracture) but status will still be 3 on true tank
					if tanking or (status == 3) then uId = id end--Found highest threat target, make them uId
					if uId then break end
				end
				--Did not get anything useful from threat, so use who the boss was looking at, at time of cast (ie fallbackuId)
				if fallbackuId and not uId then
					uId = fallbackuId
				end
			end
			if uId then--Now we have a valid uId
				bossCache[cidOrGuid] = GetTime()
				lastTank = UnitName(uId)
				return UnitName(lastTank), uId
			end
			return false
		end
	end
end

--Now this function works perfectly. But have some limitation due to DBM.RangeCheck:GetDistance() function.
--Unfortunely, DBM.RangeCheck:GetDistance() function cannot reflects altitude difference. This makes range unreliable.
--So, we need to cafefully check range in difference altitude (Especially, tower top and bottom)
do
	local rangeCache = {}
	local rangeUpdated = {}

	function bossModPrototype:CheckBossDistance(cidOrGuid, onlyBoss, itemId, defaultReturn)
		if not DBM.Options.DontShowFarWarnings then return true end--Global disable.
		cidOrGuid = cidOrGuid or self.creatureId
		local uId = DBM:GetUnitIdFromGUID(cidOrGuid, onlyBoss)
		if uId then
			itemId = itemId or 32698
			local inRange = IsItemInRange(itemId, uId)
			if inRange then--IsItemInRange was a success
				return inRange
			else--IsItemInRange doesn't work on all bosses/npcs, but tank checks do
				DBM:Debug("CheckBossDistance failed on IsItemInRange for: "..cidOrGuid, 2)
				return self:CheckTankDistance(cidOrGuid, nil, onlyBoss, defaultReturn)--Return tank distance check fallback
			end
		end
		DBM:Debug("CheckBossDistance failed on uId for: "..cidOrGuid, 2)
		return (defaultReturn == nil) or defaultReturn--When we simply can't figure anything out, return true and allow warnings using this filter to fire
	end

	function bossModPrototype:CheckTankDistance(cidOrGuid, distance, onlyBoss, defaultReturn)
		if not DBM.Options.DontShowFarWarnings then return true end--Global disable.
		distance = distance or 43
		if rangeCache[cidOrGuid] and (GetTime() - (rangeUpdated[cidOrGuid] or 0)) < 2 then -- return same range within 2 sec call
			if rangeCache[cidOrGuid] > distance then
				return false
			else
				return true
			end
		else
			cidOrGuid = cidOrGuid or self.creatureId--GetBossTarget supports GUID or CID and it will automatically return correct values with EITHER ONE
			local uId
			local _, fallbackuId, mobuId = self:GetBossTarget(cidOrGuid, onlyBoss)
			if mobuId then--Have a valid mob unit ID
				--First, use trust threat more than fallbackuId and see what we pull from it first.
				--This is because for CheckTankDistance we want to know who is tanking it, not who it's targeting.
				local unitId = (IsInRaid() and "raid") or "party"
				for i = 0, GetNumGroupMembers() do
					local id = (i == 0 and "target") or unitId..i
					local tanking, status = UnitDetailedThreatSituation(id, mobuId)--Tanking may return 0 if npc is temporarily looking at an NPC (IE fracture) but status will still be 3 on true tank
					if tanking or (status == 3) then uId = id end--Found highest threat target, make them uId
					if uId then break end
				end
				--Did not get anything useful from threat, so use who the boss was looking at, at time of cast (ie fallbackuId)
				if fallbackuId and not uId then
					uId = fallbackuId
				end
			end
			if uId then--Now we have a valid uId
				if UnitIsUnit(uId, "player") then return true end--If "player" is target, avoid doing any complicated stuff
				if not UnitIsPlayer(uId) then
					local inRange2, checkedRange = UnitInRange(uId)--43
					if checkedRange then--checkedRange only returns true if api worked, so if we get false, true then we are not near npc
						return inRange2 and true or false
					else--Its probably a totem or just something we can't assess. Fall back to no filtering
						return true
					end
				end
				local inRange =  DBM.RangeCheck:GetDistance("player", uId)--We check how far we are from the tank who has that boss
				rangeCache[cidOrGuid] = inRange
				rangeUpdated[cidOrGuid] = GetTime()
				if inRange and (inRange > distance) then--You are not near the person tanking boss
					return false
				end
				--Tank in range, return true.
				return true
			end
			DBM:Debug("CheckTankDistance failed on uId for: "..cidOrGuid, 2)
			return (defaultReturn == nil) or defaultReturn--When we simply can't figure anything out, return true and allow warnings using this filter to fire. But some spells will prefer not to fire(i.e : Galakras tower spell), we can define it on this function calling.
		end
	end
end

-----------------------
--  Utility Methods  --
-----------------------

function bossModPrototype:IsDifficulty(...)
	local diff = savedDifficulty or DBM:GetCurrentInstanceDifficulty()
	for i = 1, select("#", ...) do
		if diff == select(i, ...) then
			return true
		end
	end
	return false
end

-- hard coded party-mod support, yay :)
-- returns heroic for old instances that do not have a heroic mode (Naxx, Ulduar...)
function bossModPrototype:GetDifficulty() 
	local _, instanceType, difficulty, _, _, playerDifficulty, isDynamicInstance = GetInstanceInfo()
	if instanceType == "raid" and isDynamicInstance then -- "new" instance (ICC)
		if difficulty == 1 then -- 10 men
			return playerDifficulty == 0 and "normal10" or playerDifficulty == 1 and "heroic10" or "unknown"
		elseif difficulty == 2 then -- 25 men
			return playerDifficulty == 0 and "normal25" or playerDifficulty == 1 and "heroic25" or "unknown"
		end
	else -- support for "old" instances
		if GetInstanceDifficulty() == 1 then
			return (self.modId == "DBM-Party-WotLK" or self.modId == "DBM-Party-BC") and "normal5" or
			self.hasHeroic and "normal10" or "heroic10"
		elseif GetInstanceDifficulty() == 2 then
			return (self.modId == "DBM-Party-WotLK" or self.modId == "DBM-Party-BC") and "heroic5" or
			self.hasHeroic and "normal25" or "heroic25"
		elseif GetInstanceDifficulty() == 3 then
			return "heroic10"
		elseif GetInstanceDifficulty() == 4 then
			return "heroic25"
		end
	end
end

function bossModPrototype:IsDifficulty(...)
	local diff = self:GetDifficulty()
	for i = 1, select("#", ...) do
		if diff == select(i, ...) then
			return true
		end
	end
	return false
end

function bossModPrototype:IsTrivial(level)
	if UnitLevel("player") >= level then
		return true
	end
	return false
end

function bossModPrototype:SetUsedIcons(...)
	self.usedIcons = {}
	for i = 1, select("#", ...) do
		self.usedIcons[select(i, ...)] = true
	end
end

function bossModPrototype:LatencyCheck(custom)
	return select(3, GetNetStats()) < (custom or DBM.Options.LatencyThreshold)
end

bossModPrototype.AntiSpam = DBM.AntiSpam
bossModPrototype.IconNumToString = DBM.IconNumToString
bossModPrototype.IconNumToTexture = DBM.IconNumToTexture
bossModPrototype.AntiSpam = DBM.AntiSpam
bossModPrototype.HasMapRestrictions = DBM.HasMapRestrictions
bossModPrototype.GetUnitCreatureId = DBM.GetUnitCreatureId
bossModPrototype.GetCIDFromGUID = DBM.GetCIDFromGUID
bossModPrototype.IsCreatureGUID = DBM.IsCreatureGUID
bossModPrototype.GetUnitIdFromGUID = DBM.GetUnitIdFromGUID
bossModPrototype.CheckNearby = DBM.CheckNearby

local function getTalentpointsSpent(spellID)
	local spellName = GetSpellInfo(spellID)
	for tabIndex=1, GetNumTalentTabs() do
		for talentID=1, GetNumTalents(tabIndex) do
			local name, _, _, _, spent = GetTalentInfo(tabIndex, talentID)
			if(name == spellName) then
				return spent
			end
		end
	end
	return 0
end

local specFlags ={
	["Tank"] = "IsTank",
	["Healer"] = "IsHealer",
	["Melee"] = "IsMelee",
	["Ranged"] = "IsRanged",
	["Physical"] = "IsPhysical",
	["RemoveEnrage"] = "CanRemoveEnrage",
	["MagicDispeller"] = "IsMagicDispeller",
}

function bossModPrototype:GetRoleFlagValue(flag)
	if not flag then return false end
	local flags = {strsplit("|", flag)}
	for i = 1, #flags do
		local flagText = flags[i]
		local flagFunc = specFlags[flagText] and self[specFlags[flagText]]
		if flagFunc then
			if flagText:match("^-") then
				flagText = flagText:gsub("-", "")
				if not flagFunc() then
					return true
				end
			else
				if flagFunc() then
					return true
				end
			end
		end
	end
	return false
end

function bossModPrototype:IsMelee()
	return select(2, UnitClass("player")) == "ROGUE"
		or select(2, UnitClass("player")) == "WARRIOR"
		or select(2, UnitClass("player")) == "DEATHKNIGHT"
		or (select(2, UnitClass("player")) == "PALADIN" and select(3, GetTalentTabInfo(1)) < 51)
		or (select(2, UnitClass("player")) == "SHAMAN" and select(3, GetTalentTabInfo(2)) >= 50)
		or (select(2, UnitClass("player")) == "DRUID" and select(3, GetTalentTabInfo(2)) >= 51)
end

function bossModPrototype:IsRanged()
	return select(2, UnitClass("player")) == "MAGE"
		or select(2, UnitClass("player")) == "HUNTER"
		or select(2, UnitClass("player")) == "WARLOCK"
		or select(2, UnitClass("player")) == "PRIEST"
		or (select(2, UnitClass("player")) == "PALADIN" and select(3, GetTalentTabInfo(1)) >= 51)
		or (select(2, UnitClass("player")) == "SHAMAN" and select(3, GetTalentTabInfo(2)) < 51)
		or (select(2, UnitClass("player")) == "DRUID" and select(3, GetTalentTabInfo(2)) < 51)
end

function bossModPrototype:IsPhysical()
	return self:IsMelee() or select(2, UnitClass("player")) == "HUNTER"
end

function bossModPrototype:CanRemoveEnrage()
	return select(2, UnitClass("player")) == "HUNTER" or select(2, UnitClass("player")) == "ROGUE"
end

function bossModPrototype:IsMagicDispeller()
	return select(2, UnitClass("player")) == "MAGE"
		or select(2, UnitClass("player")) == "SHAMAN"
		or select(2, UnitClass("player")) == "PRIEST"
end

local function IsDeathKnightTank()
	-- idea taken from addon 'ElitistJerks'
	local tankTalents = (getTalentpointsSpent(16271) >= 5 and 1 or 0) +		-- Anticipation
		(getTalentpointsSpent(49042) >= 5 and 1 or 0) +						-- Toughness
		(getTalentpointsSpent(55225) >= 5 and 1 or 0)						-- Blade Barrier
	return tankTalents >= 2
end

local function IsDruidTank()
	-- idea taken from addon 'ElitistJerks'
	local tankTalents = (getTalentpointsSpent(57881) >= 2 and 1 or 0) +		-- Natural Reaction
		(getTalentpointsSpent(16929) >= 3 and 1 or 0) +						-- Thick Hide
		(getTalentpointsSpent(61336) >= 1 and 1 or 0) +						-- Survival Instincts
		(getTalentpointsSpent(57877) >= 3 and 1 or 0)						-- Protector of the Pack
	return tankTalents >= 3
end

function bossModPrototype:IsTank()
	return (select(2, UnitClass("player")) == "WARRIOR" and select(3, GetTalentTabInfo(3)) >= 13)
		or (select(2, UnitClass("player")) == "DEATHKNIGHT" and IsDeathKnightTank())
		or (select(2, UnitClass("player")) == "PALADIN" and select(3, GetTalentTabInfo(2)) >= 51)
		or (select(2, UnitClass("player")) == "DRUID" and select(3, GetTalentTabInfo(2)) >= 51 and IsDruidTank())
end

function bossModPrototype:IsHealer()
	return (select(2, UnitClass("player")) == "PALADIN" and select(3, GetTalentTabInfo(1)) >= 51)
		or (select(2, UnitClass("player")) == "SHAMAN" and select(3, GetTalentTabInfo(3)) >= 51)
		or (select(2, UnitClass("player")) == "DRUID" and select(3, GetTalentTabInfo(3)) >= 51)
		or (select(2, UnitClass("player")) == "PRIEST" and select(3, GetTalentTabInfo(3)) < 51)
end

function bossModPrototype:IsTanking(unit, boss, isName, onlyRequested, bossGUID, includeTarget)
	if isName then--Passed combat log name, so pull unit ID
		unit = DBM:GetRaidUnitId(unit)
	end
	if not unit then
		DBM:Debug("IsTanking passed with invalid unit", 2)
		return false
	end
	--Prefer threat target first
	if boss then--Only checking one bossID as requested
		--Check threat first
		local tanking, status = UnitDetailedThreatSituation(unit, boss)
		if tanking or (status == 3) then
			return true
		end
		--Non threat fallback
		if includeTarget and UnitExists(boss) then
			local guid = UnitGUID(boss)
			local _, targetuid = self:GetBossTarget(guid, true)
			if UnitIsUnit(unit, targetuid) then
				return true
			end
		end
	else--Check all of them if one isn't defined
		for i = 1, 5 do
			local unitID = "boss"..i
			local guid = UnitGUID(unitID)
			--No GUID, any unit having threat returns true, GUID, only specific unit matching guid
			if not bossGUID or (guid and guid == bossGUID) then
				--Check threat first
				local tanking, status = UnitDetailedThreatSituation(unit, unitID)
				if tanking or (status == 3) then
					return true
				end
				--Non threat fallback
				if includeTarget and UnitExists(unitID) then
					local _, targetuid = self:GetBossTarget(guid, true)
					if UnitIsUnit(unit, targetuid) then
						return true
					end
				end
			end
		end
		--Check group targets if no boss unitIDs found and bossGUID passed.
		--This allows IsTanking to be used in situations boss UnitIds don't exist
		if bossGUID then
			local groupType = (IsInRaid() and "raid") or "party"
			for i = 0, GetNumGroupMembers() do
				local unitID = (i == 0 and "target") or groupType..i.."target"
				local guid = UnitGUID(unitID)
				if guid and guid == bossGUID then
					--Check threat first
					local tanking, status = UnitDetailedThreatSituation(unit, unitID)
					if tanking or (status == 3) then
						return true
					end
					--Non threat fallback
					if includeTarget and UnitExists(unitID) then
						local _, targetuid = self:GetBossTarget(guid, true)
						if UnitIsUnit(unit, targetuid) then
							return true
						end
					end
				end
			end
		end
	end
	if not onlyRequested then
		--Use these as fallback if threat target not found
		if GetPartyAssignment("MAINTANK", unit, 1) then
			return true
		end
		if UnitGroupRolesAssigned(unit) == "TANK" then
			return true
		end
	end
	return false
end
function bossModPrototype:IsWeaponDependent(uId)
	return select(2, UnitClass(uId)) == "ROGUE"
		or (select(2, UnitClass(uId)) == "WARRIOR" and not (select(3, GetTalentTabInfo(3)) >= 20))
		or select(2, UnitClass(uId)) == "DEATHKNIGHT"
		or (select(2, UnitClass(uId)) == "PALADIN" and not (select(3, GetTalentTabInfo(1)) >= 51))
		or (select(2, UnitClass(uId)) == "SHAMAN" and (select(3, GetTalentTabInfo(2)) >= 50))
end


-------------------------
--  Boss Health Frame  --
-------------------------
function bossModPrototype:SetBossHealthInfo(...)
	self.bossHealthInfo = {...}
end

-----------------------
--  Utility Methods  --
-----------------------

function IsInGroup()
	return (GetNumRaidMembers() == 0 and GetNumPartyMembers() > 0)
end

function IsInRaid()
	return GetNumRaidMembers() > 0
end

function GetNumSubgroupMembers()
	return GetNumPartyMembers()
end

function GetNumGroupMembers()
	if IsInGroup() then
		return GetNumPartyMembers()
	else
		return GetNumRaidMembers()
	end
end

function bossModPrototype:IsDifficulty(...)
	local diff = savedDifficulty or DBM:GetCurrentInstanceDifficulty()
	for i = 1, select("#", ...) do
		if diff == select(i, ...) then
			return true
		end
	end
	return false
end

function bossModPrototype:IsLFR()
	local diff = savedDifficulty or DBM:GetCurrentInstanceDifficulty()
	if diff == "lfr" or diff == "lfr25" then
		return true
	end
	return false
end

--Dungeons: normal, heroic. (Raids excluded)
function bossModPrototype:IsEasyDungeon()
	local diff = savedDifficulty or DBM:GetCurrentInstanceDifficulty()
	if diff == "heroic5" or diff == "normal5" then
		return true
	end
	return false
end

----------------------------
--  Boss Health Function  --
----------------------------
function DBM:GetBossHP(cIdOrGUID)
	local uId = bossHealthuIdCache[cIdOrGUID] or "target"
	local guid = UnitGUID(uId)
	--Target or Cached (if already called with this cid or GUID before)
	if (self:GetCIDFromGUID(guid) == cIdOrGUID or guid == cIdOrGUID) and UnitHealthMax(uId) ~= 0 then
		if bossHealth[cIdOrGUID] and (UnitHealth(uId) == 0 and not UnitIsDead(uId)) then return bossHealth[cIdOrGUID], uId, UnitName(uId) end--Return last non 0 value if value is 0, since it's last valid value we had.
		local hp = UnitHealth(uId) / UnitHealthMax(uId) * 100
		bossHealth[cIdOrGUID] = hp
		return hp, uId, UnitName(uId)
	--Focus
	elseif (self:GetCIDFromGUID(UnitGUID("focus")) == cIdOrGUID or UnitGUID("focus") == cIdOrGUID) and UnitHealthMax("focus") ~= 0 then
		if bossHealth[cIdOrGUID] and (UnitHealth("focus") == 0  and not UnitIsDead("focus")) then return bossHealth[cIdOrGUID], "focus", UnitName("focus") end--Return last non 0 value if value is 0, since it's last valid value we had.
		local hp = UnitHealth("focus") / UnitHealthMax("focus") * 100
		bossHealth[cIdOrGUID] = hp
		return hp, "focus", UnitName("focus")
	else
		--Boss UnitIds
		for i = 1, 4 do
			local unitID = "boss"..i
			local bossguid = UnitGUID(unitID)
			if (self:GetCIDFromGUID(bossguid) == cIdOrGUID or bossguid == cIdOrGUID) and UnitHealthMax(unitID) ~= 0 then
				if bossHealth[cIdOrGUID] and (UnitHealth(unitID) == 0 and not UnitIsDead(unitID)) then return bossHealth[cIdOrGUID], unitID, UnitName(unitID) end--Return last non 0 value if value is 0, since it's last valid value we had.
				local hp = UnitHealth(unitID) / UnitHealthMax(unitID) * 100
				bossHealth[cIdOrGUID] = hp
				bossHealthuIdCache[cIdOrGUID] = unitID
				return hp, unitID, UnitName(unitID)
			end
		end
		--Scan raid/party target frames
		local idType = (GetNumRaidMembers() == 0 and "party") or "raid"
		for i = 0, mmax(GetNumRaidMembers(), GetNumPartyMembers()) do
			local unitId = ((i == 0) and "target") or idType..i.."target"
			local bossguid = UnitGUID(unitId)
			if (self:GetCIDFromGUID(bossguid) == cIdOrGUID or bossguid == cIdOrGUID) and UnitHealthMax(unitId) ~= 0 then
				if bossHealth[cIdOrGUID] and (UnitHealth(unitId) == 0 and not UnitIsDead(unitId)) then return bossHealth[cIdOrGUID], unitId, UnitName(unitId) end--Return last non 0 value if value is 0, since it's last valid value we had.
				local hp = UnitHealth(unitId) / UnitHealthMax(unitId) * 100
				bossHealth[cIdOrGUID] = hp
				bossHealthuIdCache[cIdOrGUID] = unitId
				return hp, unitId, UnitName(unitId)
			end
		end
	end
	return nil
end

function DBM:GetBossHPByUnitID(uId)
	if UnitHealthMax(uId) ~= 0 then
		local hp = UnitHealth(uId) / UnitHealthMax(uId) * 100
		bossHealth[uId] = hp
		return hp, uId, UnitName(uId)
	end
	return nil
end

function bossModPrototype:SetMainBossID(cid)
	self.mainBoss = cid
end

function bossModPrototype:SetBossHPInfoToHighest(numBoss)
	if numBoss ~= false then
		self.numBoss = numBoss or (self.multiMobPullDetection and #self.multiMobPullDetection)
	end
	self.highesthealth = true
end

function bossModPrototype:GetHighestBossHealth()
	local hp
	if not self.multiMobPullDetection or self.mainBoss then
		hp = bossHealth[self.mainBoss or self.combatInfo.mob or -1]
		if hp and (hp > 100 or hp <= 0) then
			hp = nil
		end
	else
		for _, mob in ipairs(self.multiMobPullDetection) do
			if (bossHealth[mob] or 0) > (hp or 0) and (bossHealth[mob] or 0) < 100 then-- ignore full health.
				hp = bossHealth[mob]
			end
		end
	end
	return hp
end

function bossModPrototype:GetLowestBossHealth()
	local hp
	if not self.multiMobPullDetection or self.mainBoss then
		hp = bossHealth[self.mainBoss or self.combatInfo.mob or -1]
		if hp and (hp > 100 or hp <= 0) then
			hp = nil
		end
	else
		for _, mob in ipairs(self.multiMobPullDetection) do
			if (bossHealth[mob] or 100) < (hp or 100) and (bossHealth[mob] or 100) > 0 then-- ignore zero health.
				hp = bossHealth[mob]
			end
		end
	end
	return hp
end

bossModPrototype.GetBossHP = DBM.GetBossHP

-----------------------
--  Announce Object  --
-----------------------
do
	local textureCode = " |T%s:12:12|t "
	local textureExp = " |T(%S+):12:12|t "
	local announcePrototype = {}
	local mt = {__index = announcePrototype}

	local cachedColorFunctions = setmetatable({}, {__mode = "kv"})

	function announcePrototype:Show(...) -- todo: reduce amount of unneeded strings
		if not self.option or self.mod.Options[self.option] then
			if self.mod.Options.Announce and not DBM.Options.DontSendBossAnnounces and (DBM:GetRaidRank() > 0 or (GetNumRaidMembers() == 0 and GetNumPartyMembers() >= 1)) then
				local message = pformat(self.text, ...)
				message = message:gsub("|3%-%d%((.-)%)", "%1") -- for |3-id(text) encoding in russian localization
				SendChatMessage(("*** %s ***"):format(message), GetNumRaidMembers() > 0 and "RAID_WARNING" or "PARTY")
			end
			if DBM.Options.DontShowBossAnnounces then return end	-- don't show the announces if the spam filter option is set
			local colorCode = ("|cff%.2x%.2x%.2x"):format(self.color.r * 255, self.color.g * 255, self.color.b * 255)
			local text = ("%s%s%s|r%s"):format(
				(DBM.Options.WarningIconLeft and self.icon and textureCode:format(self.icon)) or "",
				colorCode,
				pformat(self.text, ...),
				(DBM.Options.WarningIconRight and self.icon and textureCode:format(self.icon)) or ""
			)
			if not cachedColorFunctions[self.color] then
				local color = self.color -- upvalue for the function to colorize names, accessing self in the colorize closure is not safe as the color of the announce object might change (it would also prevent the announce from being garbage-collected but announce objects are never destroyed)
				cachedColorFunctions[color] = function(cap)
					cap = cap:sub(2, -2)
					if DBM:GetRaidClass(cap) then
						local playerColor = RAID_CLASS_COLORS[DBM:GetRaidClass(cap)] or color
						cap = ("|r|cff%.2x%.2x%.2x%s|r|cff%.2x%.2x%.2x"):format(playerColor.r * 255, playerColor.g * 255, playerColor.b * 255, cap, color.r * 255, color.g * 255, color.b * 255)
					end
					return cap
				end
			end
			text = text:gsub(">.-<", cachedColorFunctions[self.color])
			RaidNotice_AddMessage(RaidWarningFrame, text, ChatTypeInfo["RAID_WARNING"]) -- the color option doesn't work (at least it didn't work during the WotLK beta...todo: check this)
			if DBM.Options.ShowWarningsInChat then
				text = text:gsub(textureExp, "") -- textures @ chat frame can (and will) distort the font if using certain combinations of UI scale, resolution and font size
				if DBM.Options.ShowFakedRaidWarnings then
					for i = 1, select("#", GetFramesRegisteredForEvent("CHAT_MSG_RAID_WARNING")) do
						local frame = select(i, GetFramesRegisteredForEvent("CHAT_MSG_RAID_WARNING"))
						if frame ~= RaidWarningFrame and frame:GetScript("OnEvent") then
							frame:GetScript("OnEvent")(frame, "CHAT_MSG_RAID_WARNING", text, UnitName("player"), GetDefaultLanguage("player"), "", UnitName("player"), "", 0, 0, "", 0, 99, "")
						end
					end
				else
					self.mod:AddMsg(text, nil)
				end
			end
			PlaySoundFile(DBM.Options.RaidWarningSound)
			fireEvent("DBM_Announce", message, self.icon, self.type, self.spellId, self.mod.id, false)
		end
	end

	function announcePrototype:Schedule(t, ...)
		return schedule(t, self.Show, self.mod, self, ...)
	end

	function announcePrototype:Cancel(...)
		return unschedule(self.Show, self.mod, self, ...)
	end

	-- old constructor (no auto-localize)
	function bossModPrototype:NewAnnounce(text, color, icon, optionDefault, optionName)
		if not text then
			error("NewAnnounce: you must provide announce text", 2)
			return
		end
		if type(optionName) == "number" then
			DBM:Debug("Non auto localized optionNames cannot be numbers, fix this for "..text)
			optionName = nil
		end
		local obj = setmetatable(
			{
				text = self.localization.warnings[text],
				color = DBM.Options.WarningColors[color or 1] or DBM.Options.WarningColors[1],
				option = optionName or text,
				mod = self,
				icon = (type(icon) == "number" and ( icon <=8 and (iconFolder .. icon) or select(3, GetSpellInfo(icon)))) or icon or "Interface\\Icons\\Spell_Nature_WispSplode",
			},
			mt
		)
		if optionName == false then
			obj.option = nil
		else
			self:AddBoolOption(optionName or text, optionDefault, "announce")
		end
		tinsert(self.announces, obj)
		return obj
	end

	-- new constructor (auto-localized warnings and options, yay!)
	local function newAnnounce(self, announceType, spellId, color, icon, optionDefault, optionName, castTime, preWarnTime)
		local spellName = GetSpellInfo(spellId) or "unknown"
		icon = icon or spellId
		local text
		if announceType == "cast" then
			local spellHaste = select(7, GetSpellInfo(53142)) / 10000 -- 53142 = Dalaran Portal, should have 10000 ms cast time
			local timer = (select(7, GetSpellInfo(spellId)) or 1000) / spellHaste
			text = DBM_CORE_AUTO_ANNOUNCE_TEXTS[announceType]:format(spellName, castTime or (timer / 1000))
		elseif announceType == "prewarn" then
			if type(preWarnTime) == "string" then
				text = DBM_CORE_AUTO_ANNOUNCE_TEXTS[announceType]:format(spellName, preWarnTime)
			else
				text = DBM_CORE_AUTO_ANNOUNCE_TEXTS[announceType]:format(spellName, DBM_CORE_SEC_FMT:format(preWarnTime or 5))
			end
		elseif announceType == "stage" then
			text = DBM_CORE_AUTO_ANNOUNCE_TEXTS[announceType]:format(spellId)
		else
			text = DBM_CORE_AUTO_ANNOUNCE_TEXTS[announceType]:format(spellName)
		end
		local obj = setmetatable( -- todo: fix duplicate code
			{
				text = text,
				announceType = announceType,
				color = DBM.Options.WarningColors[color or 1] or DBM.Options.WarningColors[1],
				option = optionName or text,
				mod = self,
				icon = (type(icon) == "number" and (icon <=8 and (iconFolder .. icon) or select(3, GetSpellInfo(icon)))) or icon or "Interface\\Icons\\Spell_Nature_WispSplode",

			},
			mt
		)
		if optionName == false then
			obj.option = nil
		else
			local catType = "announce"--Default to General announce
			--Change if Personal or Other
			if announceType == "target" or announceType == "targetcount" or announceType == "stack" then
				catType = "announceother"
			end
			self:AddBoolOption(optionName or text, optionDefault, catType)
		end
		self.localization.options[text] = DBM_CORE_AUTO_ANNOUNCE_OPTIONS[announceType]:format(spellId, spellName)
		tinsert(self.announces, obj)
		return obj
	end

	function bossModPrototype:NewYouAnnounce(spellId, color, ...)
		return newAnnounce(self, "you", spellId, color or 1, ...)
	end

	function bossModPrototype:NewTargetAnnounce(spellId, color, ...)
		return newAnnounce(self, "target", spellId, color or 3, ...)
	end

	function bossModPrototype:NewTargetSourceAnnounce(spellId, color, ...)
		return newAnnounce(self, "targetsource", spellId, color or 3, ...)
	end

	function bossModPrototype:NewTargetCountAnnounce(spellId, color, ...)
		return newAnnounce(self, "targetcount", spellId, color or 3, ...)
	end

	function bossModPrototype:NewSpellAnnounce(spellId, color, ...)
		return newAnnounce(self, "spell", spellId, color or 2, ...)
	end

	function bossModPrototype:NewEndAnnounce(spellId, color, ...)
		return newAnnounce(self, "ends", spellId, color or 2, ...)
	end

	function bossModPrototype:NewEndTargetAnnounce(spellId, color, ...)
		return newAnnounce(self, "endtarget", spellId, color or 2, ...)
	end

	function bossModPrototype:NewFadesAnnounce(spellId, color, ...)
		return newAnnounce(self, "fades", spellId, color or 2, ...)
	end

	function bossModPrototype:NewAddsLeftAnnounce(spellId, color, ...)
		return newAnnounce(self, "adds", spellId, color or 3, ...)
	end

	function bossModPrototype:NewCountAnnounce(spellId, color, ...)
		return newAnnounce(self, "count", spellId, color or 2, ...)
	end

	function bossModPrototype:NewStackAnnounce(spellId, color, ...)
		return newAnnounce(self, "stack", spellId, color or 2, ...)
	end

	function bossModPrototype:NewCastAnnounce(spellId, color, castTime, icon, optionDefault, optionName)
		return newAnnounce(self, "cast", spellId, color or 3, icon, optionDefault, optionName, castTime)
	end

	function bossModPrototype:NewSoonAnnounce(spellId, color, ...)
		return newAnnounce(self, "soon", spellId, color or 2, ...)
	end

	function bossModPrototype:NewSoonCountAnnounce(spellId, color, ...)
		return newAnnounce(self, "sooncount", spellId, color or 2, ...)
	end

	function bossModPrototype:NewPreWarnAnnounce(spellId, time, color, icon, optionDefault, optionName)
		return newAnnounce(self, "prewarn", spellId, color or 1, icon, optionDefault, optionName, nil, time)
	end

	function bossModPrototype:NewBaitAnnounce(spellId, color, ...)
		return newAnnounce(self, "bait", spellId, color or 3, ...)
	end

	function bossModPrototype:NewPhaseAnnounce(stage, color, icon, ...)
		return newAnnounce(self, "stage", stage, color or 2, icon or "Interface\\Icons\\Spell_Shadow_ShadesOfDarkness", ...)
	end

	function bossModPrototype:NewPhaseChangeAnnounce(color, icon, ...)
		return newAnnounce(self, "stagechange", 0, color or 2, icon or "Interface\\Icons\\Spell_Nature_WispSplode", ...)
	end

	function bossModPrototype:NewPrePhaseAnnounce(stage, color, icon, ...)
		return newAnnounce(self, "prestage", stage, color or 2, icon or "Interface\\Icons\\Spell_Nature_WispSplode", ...)
	end

	function bossModPrototype:NewMoveToAnnounce(spellId, color, ...)
		return newAnnounce(self, "moveto", spellId, color or 3, ...)
	end
end

--------------------
--  Sound Object  --
--------------------
do
	local soundPrototype = {}
	local mt = { __index = soundPrototype }
	function bossModPrototype:NewSound(spellId, optionName, optionDefault)
		self.numSounds = self.numSounds and self.numSounds + 1 or 1
		local obj = setmetatable(
			{
				option = optionName or DBM_CORE_AUTO_SOUND_OPTION_TEXT:format(spellId),
				mod = self,
			},
			mt
		)
		if optionName == false then
			obj.option = nil
		else
			self:AddBoolOption(obj.option, optionDefault, "sound")
		end
		return obj
	end
	bossModPrototype.NewRunAwaySound = bossModPrototype.NewSound

	function soundPrototype:Play(file)
		if not self.option or self.mod.Options[self.option] then
			PlaySoundFile(file or "Sound\\Creature\\HoodWolf\\HoodWolfTransformPlayer01.wav", "Master")
		end
	end

	function soundPrototype:Schedule(t, ...)
		return schedule(t, self.Play, self.mod, self, ...)
	end

	function soundPrototype:Cancel(...)
		return unschedule(self.Play, self.mod, self, ...)
	end
end

do
	local soundPrototype5 = {}
	local mt = { __index = soundPrototype5 }
	function bossModPrototype:NewSound5(spellId, optionName, optionDefault)
		self.numSounds = self.numSounds and self.numSounds + 1 or 1
		local obj = setmetatable(
			{
				option = optionName or DBM_CORE_AUTO_SOUND_OPTION_TEXT5:format(spellId),
				mod = self,
			},
			mt
		)
		if optionName == false then
			obj.option = nil
		else
			self:AddBoolOption(obj.option, optionDefault, "sound")
		end
		return obj
	end

	function soundPrototype5:Play(file)
		if not self.option or self.mod.Options[self.option] then
			PlaySoundFile(file or "Interface\\AddOns\\DBM-Core\\sounds\\5to1.mp3", "Master")
		end
	end

	function soundPrototype5:Schedule(t, ...)
		return schedule(t, self.Play, self.mod, self, ...)
	end

	function soundPrototype5:Cancel(...)
		return unschedule(self.Play, self.mod, self, ...)
	end
end

do
	local soundPrototype3 = {}
	local mt = { __index = soundPrototype3 }
	function bossModPrototype:NewSound3(spellId, optionName, optionDefault)
		self.numSounds = self.numSounds and self.numSounds + 1 or 1
		local obj = setmetatable(
			{
				option = optionName or DBM_CORE_AUTO_SOUND_OPTION_TEXT3:format(spellId),
				mod = self,
			},
			mt
		)
		if optionName == false then
			obj.option = nil
		else
			self:AddBoolOption(obj.option, optionDefault, "sound")
		end
		return obj
	end

	function soundPrototype3:Play(file)
		if not self.option or self.mod.Options[self.option] then
			PlaySoundFile(file or "Interface\\AddOns\\DBM-Core\\sounds\\3to1.mp3", "Master")
		end
	end

	function soundPrototype3:Schedule(t, ...)
		return schedule(t, self.Play, self.mod, self, ...)
	end

	function soundPrototype3:Cancel(...)
		return unschedule(self.Play, self.mod, self, ...)
	end
end

--------------------
--  Yell Object  --
--------------------
do
	local yellPrototype = {}
	local mt = { __index = yellPrototype }
	local function newYell(self, yellType, spellId, yellText, optionDefault, optionName, chatType)
		if not spellId and not yellText then
			error("NewYell: you must provide either spellId or yellText", 2)
			return
		end
		if type(spellId) == "string" and spellId:match("OptionVersion") then
			DBM:Debug("newYell for: "..yellText.." is using OptionVersion hack. This is depricated", 2)
			return
		end
		local optionVersion
		if type(optionName) == "number" then
			optionVersion = optionName
			optionName = nil
		end
		local displayText
		if not yellText then
			displayText = DBM_CORE_AUTO_YELL_ANNOUNCE_TEXT[yellType]:format(DBM:GetSpellInfo(spellId) or DBM_CORE_UNKNOWN)
		end
		--Passed spellid as yellText.
		--Auto localize spelltext using yellText instead
		if yellText and type(yellText) == "number" then
			displayText = DBM_CORE_AUTO_YELL_ANNOUNCE_TEXT[yellType]:format(DBM:GetSpellInfo(yellText) or DBM_CORE_UNKNOWN)
		end
		local obj = setmetatable(
			{
				text = displayText or yellText,
				mod = self,
				chatType = chatType,
				yellType = yellType
			},
			mt
		)
		if optionName then
			obj.option = optionName
			self:AddBoolOption(obj.option, optionDefault, "yell")
		elseif not (optionName == false) then
			obj.option = "Yell"..(spellId or yellText)..(yellType ~= "yell" and yellType or "")..(optionVersion or "")
			self:AddBoolOption(obj.option, optionDefault, "yell")
			self.localization.options[obj.option] = DBM_CORE_AUTO_YELL_OPTION_TEXT[yellType]:format(spellId)
		end
		return obj
	end

	function yellPrototype:Yell(...)
		if DBM.Options.DontSendYells or self.yellType and self.yellType == "position" then return end
		if not self.option or self.mod.Options[self.option] then
			if self.yellType == "combo" then
				SendChatMessage(pformat(self.text, ...), self.chatType or "YELL")
			else
				SendChatMessage(pformat(self.text, ...), self.chatType or "SAY")
			end
		end
	end
	yellPrototype.Show = yellPrototype.Yell

	--Force override to use say message, even when object defines "YELL"
	function yellPrototype:Say(...)
		if DBM.Options.DontSendYells or self.yellType and self.yellType == "position" then return end
		if not self.option or self.mod.Options[self.option] then
			SendChatMessage(pformat(self.text, ...), "SAY")
		end
	end

	function yellPrototype:Schedule(t, ...)
		return schedule(t, self.Yell, self.mod, self, ...)
	end

	function yellPrototype:Countdown(time, numAnnounces, ...)
		if time > 60 then--It's a spellID not a time
			local _, _, _, _, _, _, expireTime = DBM:UnitDebuff("player", time)
			if expireTime then
				local remaining = expireTime-GetTime()
				scheduleCountdown(remaining, numAnnounces, self.Yell, self.mod, self, ...)
			end
		else
			scheduleCountdown(time, numAnnounces, self.Yell, self.mod, self, ...)
		end
	end

	function yellPrototype:Cancel(...)
		return unschedule(self.Yell, self.mod, self, ...)
	end

	function bossModPrototype:NewYell(...)
		return newYell(self, "yell", ...)
	end

	function bossModPrototype:NewYellMe(...)
		return newYell(self, "yellme", ...)
	end

	function bossModPrototype:NewShortYell(...)
		return newYell(self, "shortyell", ...)
	end

	function bossModPrototype:NewCountYell(...)
		return newYell(self, "count", ...)
	end

	function bossModPrototype:NewFadesYell(...)
		return newYell(self, "fade", ...)
	end

	function bossModPrototype:NewShortFadesYell(...)
		return newYell(self, "shortfade", ...)
	end

	function bossModPrototype:NewIconFadesYell(...)
		return newYell(self, "iconfade", ...)
	end

	function bossModPrototype:NewPosYell(...)
		return newYell(self, "position", ...)
	end

	function bossModPrototype:NewComboYell(...)
		return newYell(self, "combo", ...)
	end
end


------------------------------
--  Special Warning Object  --
------------------------------
do
	local frame = CreateFrame("Frame", nil, UIParent)
	local font = frame:CreateFontString(nil, "OVERLAY", "ZoneTextFont")
	frame:SetMovable(1)
	frame:SetWidth(1)
	frame:SetHeight(1)
	frame:SetFrameStrata("HIGH")
	frame:SetClampedToScreen()
	frame:Hide()
	font:SetWidth(1024)
	font:SetHeight(0)
	font:SetPoint("CENTER", 0, 0)

	local moving
	local specialWarningPrototype = {}
	local mt = {__index = specialWarningPrototype}

	function DBM:UpdateSpecialWarningOptions()
		frame:ClearAllPoints()
		frame:SetPoint(DBM.Options.SpecialWarningPoint, UIParent, DBM.Options.SpecialWarningPoint, DBM.Options.SpecialWarningX, DBM.Options.SpecialWarningY)
		font:SetFont(DBM.Options.SpecialWarningFont, DBM.Options.SpecialWarningFontSize, "THICKOUTLINE")
		font:SetTextColor(unpack(DBM.Options.SpecialWarningFontColor))
	end

	local shakeFrame = CreateFrame("Frame")
	shakeFrame:SetScript("OnUpdate", function(self, elapsed)
		self.timer = self.timer - elapsed
	end)
	shakeFrame:Hide()

	frame:SetScript("OnUpdate", function(self, elapsed)
		self.timer = self.timer - elapsed
		if self.timer >= 3 and self.timer <= 4 then
			LowHealthFrame:SetAlpha(self.timer - 3)
		elseif self.timer <= 2 then
			frame:SetAlpha(self.timer/2)
		elseif self.timer <= 0 then
			frame:Hide()
		end
	end)

	function specialWarningPrototype:Show(...)
		if DBM.Options.ShowSpecialWarnings and (not self.option or self.mod.Options[self.option]) and not moving and frame then
			font:SetText(pformat(self.text, ...))
			LowHealthFrame:Show()
			LowHealthFrame:SetAlpha(1)
			frame:Show()
			frame:SetAlpha(1)
			frame.timer = 5
			if self.sound then
				PlaySoundFile(DBM.Options.SpecialWarningSound)
			end
			fireEvent("DBM_Announce", message, self.icon, self.type, self.spellId, self.mod.id, false)
		end
	end

	function specialWarningPrototype:Schedule(t, ...)
		return schedule(t, self.Show, self.mod, self, ...)
	end

	function specialWarningPrototype:Countdown(time, numAnnounces, ...)
		scheduleCountdown(time, numAnnounces, self.Show, self.mod, self, ...)
	end

	function specialWarningPrototype:Cancel(t, ...)
		return unschedule(self.Show, self.mod, self, ...)
	end

	function bossModPrototype:NewSpecialWarning(text, optionDefault, optionName, noSound, runSound)
		local obj = setmetatable(
			{
				text = self.localization.warnings[text],
				option = optionName or text,
				mod = self,
				sound = not noSound,
			},
			mt
		)
		if optionName == false then
			obj.option = nil
		else
			self:AddBoolOption(optionName or text, optionDefault, "announce")
		end
		tinsert(self.specwarns, obj)
		return obj
	end

	local function newSpecialWarning(self, announceType, spellId, stacks, optionDefault, optionName, noSound, runSound)
		local spellName = GetSpellInfo(spellId) or "unknown"
		local text = DBM_CORE_AUTO_SPEC_WARN_TEXTS[announceType]:format(spellName)
		local obj = setmetatable( -- todo: fix duplicate code
			{
				text = text,
				announceType = announceType,
				option = optionName or text,
				mod = self,
				sound = not noSound,
			},
			mt
		)
		if optionName == false then
			obj.option = nil
		else
			local catType = "announce"--Default to General announce
			--Directly affects another target (boss or player) that you need to know about
			if announceType == "target" or announceType == "targetcount" or announceType == "close" or announceType == "reflect" then
				catType = "announceother"
			--Directly affects you
			elseif announceType == "you" or announceType == "youcount" or announceType == "youpos" or announceType == "move" or announceType == "dodge" or announceType == "dodgecount" or announceType == "moveaway" or announceType == "moveawaycount" or announceType == "keepmove" or announceType == "stopmove" or announceType == "run" or announceType == "stack" or announceType == "moveto" or announceType == "soak" or announceType == "soakpos" then
				catType = "announcepersonal"
			--Things you have to do to fulfil your role
			elseif announceType == "taunt" or announceType == "dispel" or announceType == "interrupt" or announceType == "interruptcount" or announceType == "switch" or announceType == "switchcount" then
				catType = "announcerole"
			end
			self:AddBoolOption(optionName or text, optionDefault, catType)		-- todo cleanup core code from that indexing type using options[text] is very bad!!! ;)
		end
		tinsert(self.specwarns, obj)
		if announceType == "stack" then
			self.localization.options[text] = DBM_CORE_AUTO_SPEC_WARN_OPTIONS[announceType]:format(stacks or 3, spellId)
		elseif announceType == "prewarn" then
			self.localization.options[text] = DBM_CORE_AUTO_SPEC_WARN_OPTIONS[announceType]:format(tostring(stacks or 5), spellId)
		else
			self.localization.options[text] = DBM_CORE_AUTO_SPEC_WARN_OPTIONS[announceType]:format(spellId)
		end
		return obj
	end

	function bossModPrototype:NewSpecialWarningSpell(text, optionDefault, ...)
		return newSpecialWarning(self, "spell", text, nil, optionDefault, ...)
	end

	function bossModPrototype:NewSpecialWarningEnd(text, optionDefault, ...)
		return newSpecialWarning(self, "ends", text, nil, optionDefault, ...)
	end

	function bossModPrototype:NewSpecialWarningFades(text, optionDefault, ...)
		return newSpecialWarning(self, "fades", text, nil, optionDefault, ...)
	end

	function bossModPrototype:NewSpecialWarningSoon(text, optionDefault, ...)
		return newSpecialWarning(self, "soon", text, nil, optionDefault, ...)
	end

	function bossModPrototype:NewSpecialWarningBait(text, optionDefault, ...)
		return newSpecialWarning(self, "bait", text, nil, optionDefault, ...)
	end

	function bossModPrototype:NewSpecialWarningDispel(text, optionDefault, ...)
		return newSpecialWarning(self, "dispel", text, nil, optionDefault, ...)
	end

	function bossModPrototype:NewSpecialWarningInterrupt(text, optionDefault, ...)
		return newSpecialWarning(self, "interrupt", text, nil, optionDefault, ...)
	end

	function bossModPrototype:NewSpecialWarningInterruptCount(text, optionDefault, ...)
		return newSpecialWarning(self, "interruptcount", text, nil, optionDefault, ...)
	end

	function bossModPrototype:NewSpecialWarningYou(text, optionDefault, ...)
		return newSpecialWarning(self, "you", text, nil, optionDefault, ...)
	end

	function bossModPrototype:NewSpecialWarningYouCount(text, optionDefault, ...)
		return newSpecialWarning(self, "youcount", text, nil, optionDefault, ...)
	end

	function bossModPrototype:NewSpecialWarningYouPos(text, optionDefault, ...)
		return newSpecialWarning(self, "youpos", text, nil, optionDefault, ...)
	end

	function bossModPrototype:NewSpecialWarningSoakPos(text, optionDefault, ...)
		return newSpecialWarning(self, "soakpos", text, nil, optionDefault, ...)
	end

	function bossModPrototype:NewSpecialWarningTarget(text, optionDefault, ...)
		return newSpecialWarning(self, "target", text, nil, optionDefault, ...)
	end

	function bossModPrototype:NewSpecialWarningTargetCount(text, optionDefault, ...)
		return newSpecialWarning(self, "targetcount", text, nil, optionDefault, ...)
	end

	function bossModPrototype:NewSpecialWarningDefensive(text, optionDefault, ...)
		return newSpecialWarning(self, "defensive", text, nil, optionDefault, ...)
	end

	function bossModPrototype:NewSpecialWarningTaunt(text, optionDefault, ...)
		return newSpecialWarning(self, "taunt", text, nil, optionDefault, ...)
	end

	function bossModPrototype:NewSpecialWarningClose(text, optionDefault, ...)
		return newSpecialWarning(self, "close", text, nil, optionDefault, ...)
	end

	function bossModPrototype:NewSpecialWarningMove(text, optionDefault, ...)
		return newSpecialWarning(self, "move", text, nil, optionDefault, ...)
	end

	function bossModPrototype:NewSpecialWarningKeepMove(text, optionDefault, ...)
		return newSpecialWarning(self, "keepmove", text, nil, optionDefault, ...)
	end

	function bossModPrototype:NewSpecialWarningStopMove(text, optionDefault, ...)
		return newSpecialWarning(self, "stopmove", text, nil, optionDefault, ...)
	end

	function bossModPrototype:NewSpecialWarningGTFO(text, optionDefault, ...)
		return newSpecialWarning(self, "gtfo", text, nil, optionDefault, ...)
	end

	function bossModPrototype:NewSpecialWarningDodge(text, optionDefault, ...)
		return newSpecialWarning(self, "dodge", text, nil, optionDefault, ...)
	end

	function bossModPrototype:NewSpecialWarningDodgeCount(text, optionDefault, ...)
		return newSpecialWarning(self, "dodgecount", text, nil, optionDefault, ...)
	end

	function bossModPrototype:NewSpecialWarningDodgeLoc(text, optionDefault, ...)
		return newSpecialWarning(self, "dodgeloc", text, nil, optionDefault, ...)
	end

	function bossModPrototype:NewSpecialWarningMoveAway(text, optionDefault, ...)
		return newSpecialWarning(self, "moveaway", text, nil, optionDefault, ...)
	end

	function bossModPrototype:NewSpecialWarningMoveAwayCount(text, optionDefault, ...)
		return newSpecialWarning(self, "moveawaycount", text, nil, optionDefault, ...)
	end

	function bossModPrototype:NewSpecialWarningMoveTo(text, optionDefault, ...)
		return newSpecialWarning(self, "moveto", text, nil, optionDefault, ...)
	end

	function bossModPrototype:NewSpecialWarningSoak(text, optionDefault, ...)
		return newSpecialWarning(self, "soak", text, nil, optionDefault, ...)
	end

	function bossModPrototype:NewSpecialWarningJump(text, optionDefault, ...)
		return newSpecialWarning(self, "jump", text, nil, optionDefault, ...)
	end

	function bossModPrototype:NewSpecialWarningRun(text, optionDefault, ...)
		return newSpecialWarning(self, "run", text, nil, optionDefault, ...)
	end

	function bossModPrototype:NewSpecialWarningCast(text, optionDefault, ...)
		return newSpecialWarning(self, "cast", text, nil, optionDefault, ...)
	end

	function bossModPrototype:NewSpecialWarningLookAway(text, optionDefault, ...)
		return newSpecialWarning(self, "lookaway", text, nil, optionDefault, ...)
	end

	function bossModPrototype:NewSpecialWarningReflect(text, optionDefault, ...)
		return newSpecialWarning(self, "reflect", text, nil, optionDefault, ...)
	end

	function bossModPrototype:NewSpecialWarningCount(text, optionDefault, ...)
		return newSpecialWarning(self, "count", text, nil, optionDefault, ...)
	end

	function bossModPrototype:NewSpecialWarningSoonCount(text, optionDefault, ...)
		return newSpecialWarning(self, "sooncount", text, nil, optionDefault, ...)
	end

	function bossModPrototype:NewSpecialWarningStack(text, optionDefault, stacks, ...)
		return newSpecialWarning(self, "stack", text, stacks, optionDefault, ...)
	end

	function bossModPrototype:NewSpecialWarningSwitch(text, optionDefault, ...)
		return newSpecialWarning(self, "switch", text, nil, optionDefault, ...)
	end

	function bossModPrototype:NewSpecialWarningSwitchCount(text, optionDefault, ...)
		return newSpecialWarning(self, "switchcount", text, nil, optionDefault, ...)
	end

	function bossModPrototype:NewSpecialWarningAdds(text, optionDefault, ...)
		return newSpecialWarning(self, "adds", text, nil, optionDefault, ...)
	end

	function bossModPrototype:NewSpecialWarningAddsCustom(text, optionDefault, ...)
		return newSpecialWarning(self, "addscustom", text, nil, optionDefault, ...)
	end

	function bossModPrototype:NewSpecialWarningTargetChange(text, optionDefault, ...)
		return newSpecialWarning(self, "targetchange", text, nil, optionDefault, ...)
	end

	function bossModPrototype:NewSpecialWarningPreWarn(text, optionDefault, time, ...)
		return newSpecialWarning(self, "prewarn", text, time, optionDefault, ...)
	end
	do
		local anchorFrame
		local function moveEnd()
			moving = false
			anchorFrame:Hide()
			frame.timer = 1.5 -- fade out
			frame:SetFrameStrata("HIGH")
			DBM:Unschedule(moveEnd)
			DBM.Bars:CancelBar(DBM_CORE_MOVE_SPECIAL_WARNING_BAR)
		end

		function DBM:MoveSpecialWarning()
			if not anchorFrame then
				anchorFrame = CreateFrame("Frame", nil, frame)
				anchorFrame:SetWidth(32)
				anchorFrame:SetHeight(32)
				anchorFrame:EnableMouse(true)
				anchorFrame:SetPoint("CENTER", 0, -32)
				anchorFrame:RegisterForDrag("LeftButton")
				anchorFrame:SetClampedToScreen()
				anchorFrame:Hide()
				local texture = anchorFrame:CreateTexture()
				texture:SetTexture("Interface\\Addons\\DBM-GUI\\textures\\dot.blp")
				texture:SetPoint("CENTER", anchorFrame, "CENTER", 0, 0)
				texture:SetWidth(32)
				texture:SetHeight(32)
				anchorFrame:SetScript("OnDragStart", function()
					frame:StartMoving()
					DBM:Unschedule(moveEnd)
					DBM.Bars:CancelBar(DBM_CORE_MOVE_SPECIAL_WARNING_BAR)
				end)
				anchorFrame:SetScript("OnDragStop", function()
					frame:StopMovingOrSizing()
					local point, _, _, xOfs, yOfs = frame:GetPoint(1)
					DBM.Options.SpecialWarningPoint = point
					DBM.Options.SpecialWarningX = xOfs
					DBM.Options.SpecialWarningY = yOfs
					DBM:Schedule(15, moveEnd)
					DBM.Bars:CreateBar(15, DBM_CORE_MOVE_SPECIAL_WARNING_BAR)
				end)
			end
			if anchorFrame:IsShown() then
				moveEnd()
			else
				moving = true
				anchorFrame:Show()
				self:Schedule(15, moveEnd)
				DBM.Bars:CreateBar(15, DBM_CORE_MOVE_SPECIAL_WARNING_BAR)
				font:SetText(DBM_CORE_MOVE_SPECIAL_WARNING_TEXT)
				frame:Show()
				frame:SetFrameStrata("TOOLTIP")
				frame:SetAlpha(1)
				frame.timer = mhuge
			end
		end
	end

	local function testWarningEnd()
		frame:SetFrameStrata("HIGH")
	end

	function DBM:ShowTestSpecialWarning(text)
		if moving then
			return
		end
		font:SetText(DBM_CORE_MOVE_SPECIAL_WARNING_TEXT)
		frame:Show()
		frame:SetAlpha(1)
		frame:SetFrameStrata("TOOLTIP")
		self:Unschedule(testWarningEnd)
		self:Schedule(3, testWarningEnd)
		frame.timer = 3
	end
end


--------------------
--  Timer Object  --
--------------------
do
	local timerPrototype = {}
	local mt = {__index = timerPrototype}

	function timerPrototype:Start(timer, ...)
		if timer and type(timer) ~= "number" then
			return self:Start(nil, timer, ...) -- first argument is optional!
		end
		if not self.option or self.mod.Options[self.option] then
			if self.type and (self.type == "cdcount" or self.type == "nextcount") then--remove previous timer.
				for i = #self.startedTimers, 1, -1 do
					if DBM.Options.DebugMode and DBM.Options.DebugLevel > 1 then
						local bar = DBM.Bars:GetBar(self.startedTimers[i])
						if bar then
							local remaining = ("%.1f"):format(bar.timer)
							local ttext = _G[bar.frame:GetName().."BarName"]:GetText() or ""
							ttext = ttext.."("..self.id..")"
							if bar.timer > 0.2 then
								DBM:Debug("Timer "..ttext.. " refreshed before expired. Remaining time is : "..remaining, 2)
							end
						end
					end
					DBM.Bars:CancelBar(self.startedTimers[i])
					fireEvent("DBM_Announce", message, self.icon, self.type, self.spellId, self.mod.id, false)
					self.startedTimers[i] = nil
				end
			end
			local timer = timer and ((timer > 0 and timer) or self.timer + timer) or self.timer
			local id = self.id..pformat((("\t%s"):rep(select("#", ...))), ...)
			if self.type == "ai" then--A learning timer
				if not DBM.Options.AITimer then return end
				if timer > 4 then--Normal behavior.
					local newPhase = false
					for i = 1, 4 do
						--Check for any phase timers that are strings, if a string it means last cast of this ability was first case of a given stage
						if self["phase"..i.."CastTimer"] and type(self["phase"..i.."CastTimer"]) == "string" then--This is first cast of spell, we need to generate self.firstPullTimer
							self["phase"..i.."CastTimer"] = tonumber(self["phase"..i.."CastTimer"])
							self["phase"..i.."CastTimer"] = GetTime() - self["phase"..i.."CastTimer"]--We have generated a self.phase1CastTimer! Next pull, DBM should know timer for first cast next pull. FANCY!
							DBM:Debug("AI timer learned a first timer for current phase of "..self["phase"..i.."CastTimer"], 2)
							newPhase = true
						end
					end
					if self.lastCast and not newPhase then--We have a GetTime() on last cast and it's not affected by a phase change
						local timeLastCast = GetTime() - self.lastCast--Get time between current cast and last cast
						if timeLastCast > 4 then--Prevent infinite loop cpu hang. Plus anything shorter than 5 seconds doesn't need a timer
							if not self.lowestSeenCast or (self.lowestSeenCast and self.lowestSeenCast > timeLastCast) then--Always use lowest seen cast for a timer
								self.lowestSeenCast = timeLastCast
								DBM:Debug("AI timer learned a new lowest timer of "..self.lowestSeenCast, 2)
							end
						end
					end
					self.lastCast = GetTime()
					if self.lowestSeenCast then--Always use lowest seen cast for timer
						timer = self.lowestSeenCast
					else
						return--Don't start the bogus timer shoved into timer field in the mod
					end
				else--AI timer passed with 4 or less is indicating phase change, with timer as phase number
					if self["phase"..timer.."CastTimer"] and type(self["phase"..timer.."CastTimer"]) == "number" then
						--Check if timer is shorter than previous learned first timer by scanning remaining time on existing bar
						local bar = DBM.Bars:GetBar(id)
						if bar then
							local remaining = ("%.1f"):format(bar.timer)
							if bar.timer > 0.2 then
								self["phase"..timer.."CastTimer"] = self["phase"..timer.."CastTimer"] - remaining
								DBM:Debug("AI timer learned a lower first timer for current phase of "..self["phase"..timer.."CastTimer"], 2)
							end
						end
						timer = self["phase"..timer.."CastTimer"]
					else--No first pull timer generated yet, set it to GetTime, as a string
						self["phase"..timer.."CastTimer"] = tostring(GetTime())
						return--Don't start the x second timer
					end
				end
			end
			if DBM.Options.DebugMode and DBM.Options.DebugLevel > 1 then
				if not self.type or (self.type ~= "target" and self.type ~= "active" and self.type ~= "fades" and self.type ~= "ai") then
					local bar = DBM.Bars:GetBar(id)
					if bar then
						local remaining = ("%.1f"):format(bar.timer)
						local ttext = _G[bar.frame:GetName().."BarName"]:GetText() or ""
						ttext = ttext.."("..self.id..")"
						if bar.timer > 0.2 then
							DBM:Debug("Timer "..ttext.. " refreshed before expired. Remaining time is : "..remaining, 2)
						end
					end
				end
			end
			local bar = DBM.Bars:CreateBar(timer, id, self.icon)
			if not bar then
				return false, "error" -- creating the timer failed somehow, maybe hit the hard-coded timer limit of 15
			end
			if self.type and not self.text then
				bar:SetText(pformat(self.mod:GetLocalizedTimerText(self.type, self.spellId, self.name), ...))
			else
				bar:SetText(pformat(self.text, ...))
			end
			tinsert(self.startedTimers, id)
			self.mod:Unschedule(removeEntry, self.startedTimers, id)
			self.mod:Schedule(timer, removeEntry, self.startedTimers, id)
			self.mod:Schedule(timer, fireEvent, "DBM_Announce", message, self.icon, self.type, self.spellId, self.mod.id, false)
			return bar
		else
			return false, "disabled"
		end
	end
	timerPrototype.Show = timerPrototype.Start

	--A way to set the fade to yes or no, overriding hardcoded value in NewTimer object with temporary one
	--If this method is used, it WILL persist until reload or changing it back
	function timerPrototype:SetFade(fadeOn, ...)
		--Done this way so SetFade can be used with :Start without needless performance cost (ie, ApplyStyle won't run unless it needs to)
		if fadeOn and not self.fade then
			self.fade = true--set timer object metatable, which will make sure next bar started uses fade
			--Find and Update an existing bar that's already started
			local id = self.id..pformat((("\t%s"):rep(select("#", ...))), ...)
			local bar = DBM.Bars:GetBar(id)
			if bar and not bar.fade then
				fireEvent("DBM_TimerFadeUpdate", id, self.spellId, self.mod.id, true)--Timer ID, spellId, modId, true/nil (new callback only needed if we update an existing timers fade, self.fade is passed in timer start object for new timers)
				bar.fade = true--Set bar object metatable, which is copied from timer metatable at bar start only
				bar:ApplyStyle()
				if bar.countdown then--Cancel countdown, because we just enabled a bar fade
					--DBM:Unschedule(playCountSound, id)
					DBM:Debug("Disabling a countdown on bar ID: "..id.." after a SetFade enable call")
				end
			end
		elseif not fadeOn and self.fade then
			self.fade = nil--set timer object metatable, which will make sure next bar started does NOT use fade
			--Find and Update an existing bar that's already started
			local id = self.id..pformat((("\t%s"):rep(select("#", ...))), ...)
			local bar = DBM.Bars:GetBar(id)
			if bar and bar.fade then
				fireEvent("DBM_TimerFadeUpdate", id, self.spellId, self.mod.id, nil)--Timer ID, spellId, modId, true/nil (new callback only needed if we update an existing timers fade, self.fade is passed in timer start object for new timers)
				bar.fade = nil--Set bar object metatable, which is copied from timer metatable at bar start only
				bar:ApplyStyle()
				if bar.countdown then--Unfading bar, start countdown
					--DBM:Unschedule(playCountSound, id)
					--playCountdown(id, bar.timer, bar.countdown, bar.countdownMax)--timerId, timer, voice, count
					DBM:Debug("Re-enabling a countdown on bar ID: "..id.." after a SetFade disable call")
				end
			end
		end
	end

	--This version does NOT set timer object meta, only started bar meta
	--Use this if you only want to alter an already STARTED temporarily
	--As such it also only needs fadeOn. fadeoff isn't needed since this temp alter never affects newly started bars
	function timerPrototype:SetSTFade(fadeOn, ...)
		local id = self.id..pformat((("\t%s"):rep(select("#", ...))), ...)
		local bar = DBM.Bars:GetBar(id)
		if bar then
			if fadeOn and not bar.fade then
				fireEvent("DBM_TimerFadeUpdate", id, self.spellId, self.mod.id, true)--Timer ID, spellId, modId, true/nil (new callback only needed if we update an existing timers fade, self.fade is passed in timer start object for new timers)
				bar.fade = true--Set bar object metatable, which is copied from timer metatable at bar start only
				bar:ApplyStyle()
				if bar.countdown then--Cancel countdown, because we just enabled a bar fade
					--DBM:Unschedule(playCountSound, id)
					DBM:Debug("Disabling a countdown on bar ID: "..id.." after a SetSTFade enable call")
				end
			elseif not fadeOn and bar.fade then
				fireEvent("DBM_TimerFadeUpdate", id, self.spellId, self.mod.id, nil)
				bar.fade = false
				bar:ApplyStyle()
				if bar.countdown then--Unfading bar, start countdown
					--DBM:Unschedule(playCountSound, id)
					--playCountdown(id, bar.timer, bar.countdown, bar.countdownMax)--timerId, timer, voice, count
					DBM:Debug("Re-enabling a countdown on bar ID: "..id.." after a SetSTFade disable call")
				end
			end
		end
	end

	function timerPrototype:DelayedStart(delay, ...)
		unschedule(self.Start, self.mod, self, ...)
		schedule(delay or 0.5, self.Start, self.mod, self, ...)
	end
	timerPrototype.DelayedShow = timerPrototype.DelayedStart

	function timerPrototype:Schedule(t, ...)
		return schedule(t, self.Start, self.mod, self, ...)
	end

	function timerPrototype:Unschedule(...)
		return unschedule(self.Start, self.mod, self, ...)
	end

	function timerPrototype:Stop(...)
		fireEvent("DBM_Announce", message, self.icon, self.type, self.spellId, self.mod.id, false)
		if select("#", ...) == 0 then
			for i = #self.startedTimers, 1, -1 do
				fireEvent("DBM_TimerStop", self.startedTimers[i])
				DBM.Bars:CancelBar(self.startedTimers[i])
				--DBM:Unschedule(playCountSound, self.startedTimers[i])--Unschedule countdown by timerId
				self.startedTimers[i] = nil
			end
		else
			local id = self.id..pformat((("\t%s"):rep(select("#", ...))), ...)
			for i = #self.startedTimers, 1, -1 do
				if self.startedTimers[i] == id then
					fireEvent("DBM_TimerStop", id)
					DBM.Bars:CancelBar(id)
					--DBM:Unschedule(playCountSound, id)--Unschedule countdown by timerId
					tremove(self.startedTimers, i)
				end
			end
		end
		if self.type == "ai" then--A learning timer
			if not DBM.Options.AITimer then return end
			self.lastCast = nil
			for i = 1, 4 do
				--Check for any phase timers that are strings and never got a chance to become AI timers, then wipe them
				if self["phase"..i.."CastTimer"] and type(self["phase"..i.."CastTimer"]) == "string" then
					self["phase"..i.."CastTimer"] = nil
					DBM:Debug("Wiping incomplete new timer of stage "..i, 2)
				end
			end
		end
	end

	function timerPrototype:Cancel(...)
		self:Stop(...)
		self:Unschedule(...)
	end

	function timerPrototype:GetTime(...)
		local id = self.id..pformat((("\t%s"):rep(select("#", ...))), ...)
		local bar = DBM.Bars:GetBar(id)
		return bar and (bar.totalTime - bar.timer) or 0, (bar and bar.totalTime) or 0
	end

	function timerPrototype:GetRemaining(...)
		local id = self.id..pformat((("\t%s"):rep(select("#", ...))), ...)
		local bar = DBM.Bars:GetBar(id)
		return bar and bar.timer or 0
	end

	function timerPrototype:Time(...)
		local id = self.id..pformat((("\t%s"):rep(select("#", ...))), ...)
		local bar = DBM.Bars:GetBar(id)
		return bar.totalTime or 0
	end

	function timerPrototype:IsStarted(...)
		local id = self.id..pformat((("\t%s"):rep(select("#", ...))), ...)
		local bar = DBM.Bars:GetBar(id)
		return bar and true
	end

	function timerPrototype:SetTimer(timer)
		self.timer = timer
	end

	function timerPrototype:Update(elapsed, totalTime, ...)
		if self:GetTime(...) == 0 then
			self:Start(totalTime, ...)
		end
		local id = self.id..pformat((("\t%s"):rep(select("#", ...))), ...)
		return DBM.Bars:UpdateBar(id, elapsed, totalTime)
	end

	function timerPrototype:AddTime(time, ...)
		local id = self.id..pformat((("\t%s"):rep(select("#", ...))), ...)
		local timer = self:GetTime(...) - time -- GetTime() = elapsed time on timer
		if timer then
			return DBM.Bars:UpdateBar(id, timer)
		end
	end

	function timerPrototype:UpdateIcon(icon, ...)
		local id = self.id..pformat((("\t%s"):rep(select("#", ...))), ...)
		local bar = DBM.Bars:GetBar(id)
		if bar then
			return bar:SetIcon((type(icon) == "number" and ( icon <=8 and (iconFolder .. icon) or select(3, GetSpellInfo(icon)))) or icon or "Interface\\Icons\\Spell_Nature_WispSplode")
		end
	end

	function timerPrototype:UpdateInline(newInline, ...)
		local id = self.id..pformat((("\t%s"):rep(select("#", ...))), ...)
		local bar = DBM.Bars:GetBar(id)
		if bar then
			local ttext = _G[bar.frame:GetName().."BarName"]:GetText() or ""
			return bar:SetText(ttext, newInline or self.inlineIcon)
		end
	end

	function timerPrototype:UpdateName(name, ...)
		local id = self.id..pformat((("\t%s"):rep(select("#", ...))), ...)
		local bar = DBM.Bars:GetBar(id)
		if bar then
			return bar:SetText(name)
		end
	end

	function timerPrototype:SetColor(c, ...)
		local id = self.id..pformat((("\t%s"):rep(select("#", ...))), ...)
		local bar = DBM.Bars:GetBar(id)
		if bar then
			return bar:SetColor(c)
		end
	end

	function timerPrototype:DisableEnlarge(...)
		local id = self.id..pformat((("\t%s"):rep(select("#", ...))), ...)
		local bar = DBM.Bars:GetBar(id)
		if bar then
			bar.small = true
		end
	end

	function timerPrototype:AddOption(optionDefault, optionName)
		if optionName ~= false then
			self.option = optionName or self.id
			self.mod:AddBoolOption(self.option, optionDefault, "timer")
		end
	end

	function bossModPrototype:NewTimer(timer, name, texture, optionDefault, optionName, r, g, b)
		local icon = type(texture) == "number" and ( texture <=8 and (iconFolder .. texture) or select(3, GetSpellInfo(texture))) or texture or "Interface\\Icons\\Spell_Nature_WispSplode"
		local obj = setmetatable(
			{
				text = self.localization.timers[name],
				timer = timer,
				id = name,
				icon = icon,
				r = r,
				g = g,
				b = b,
				startedTimers = {},
				mod = self,
			},
			mt
		)
		obj:AddOption(optionDefault, optionName)
		tinsert(self.timers, obj)
		return obj
	end

	-- new constructor for the new auto-localized timer types
	-- note that the function might look unclear because it needs to handle different timer types, especially achievement timers need special treatment
	-- todo: disable the timer if the player already has the achievement and when the ACHIEVEMENT_EARNED event is fired
	-- problem: heroic/normal achievements :[
	-- local achievementTimers = {}
	local function newTimer(self, timerType, timer, spellId, timerText, optionDefault, optionName, texture, r, g, b)
		-- new argument timerText is optional (usually only required for achievement timers as they have looooong names)
		if type(timerText) == "boolean" or type(optionDefault) == "string" then -- check if the argument was skipped
			return newTimer(self, timerType, timer, spellId, nil, timerText, optionDefault, optionName, texture, r, g, b)
		end
		local spellName, icon
		if timerType == "achievement" then
			spellName = select(2, GetAchievementInfo(spellId))
			icon = type(texture) == "number" and select(10, GetAchievementInfo(texture)) or texture or spellId and select(10, GetAchievementInfo(spellId))
		elseif timerType == "cdspecial" or timerType == "nextspecial" or timerType == "stage" then
			icon = type(texture) == "number" and select(3, GetSpellInfo(texture)) or texture or (type(spellId) == "number" and select(3, GetSpellInfo(texture))) or "Interface\\Icons\\Spell_Nature_WispSplode"
--			if optionDefault == nil then
--				local completed = select(4, GetAchievementInfo(spellId))
--				optionDefault = not completed
--			end
		else
			spellName = DBM:GetSpellInfo(spellId or 0)
			if spellName then
				icon = type(texture) == "number" and ( texture <=8 and (iconFolder .. texture) or select(3, GetSpellInfo(texture))) or texture or spellId and select(3, GetSpellInfo(spellId))
			else
				icon = nil
			end
		end
		spellName = spellName or tostring(spellId)
		local id = "Timer"..(spellId or 0)..self.id..#self.timers
		local obj = setmetatable(
			{
				text = self.localization.timers[timerText],
				type = timerType,
				spellId = spellId,
				name = spellName,
				timer = timer,
				id = id,
				icon = icon,
				r = r,
				g = g,
				b = b,
				allowdouble = allowdouble,
				startedTimers = {},
				mod = self,
			},
			mt
		)
		obj:AddOption(optionDefault, optionName)
		tinsert(self.timers, obj)
		-- todo: move the string creation to the GUI with SetFormattedString...
		if timerType == "achievement" then
			self.localization.options[id] = DBM_CORE_AUTO_TIMER_OPTIONS[timerType]:format(GetAchievementLink(spellId):gsub("%[(.+)%]", "%1"))
		elseif timerType == "cdspecial" or timerType == "nextspecial" or timerType == "stage" or timerType == "roleplay" then--Timers without spellid, generic
			self.localization.options[id] = DBM_CORE_AUTO_TIMER_OPTIONS[timerType]--Using more than 1 stage timer or more than 1 special timer will break this, fortunately you should NEVER use more than 1 of either in a mod
		else
			self.localization.options[id] = DBM_CORE_AUTO_TIMER_OPTIONS[timerType]:format(spellId, spellName)
		end
		return obj
	end

	function bossModPrototype:NewTargetTimer(...)
		return newTimer(self, "target", ...)
	end

	--Buff/Debuff/event on boss
	function bossModPrototype:NewBuffActiveTimer(...)
		return newTimer(self, "active", ...)
	end

	----Buff/Debuff on players
	function bossModPrototype:NewBuffFadesTimer(...)
		return newTimer(self, "fades", ...)
	end

	function bossModPrototype:NewCastTimer(timer, ...)
		if tonumber(timer) and timer > 1000 then -- hehe :) best hack in DBM. This makes the first argument optional, so we can omit it to use the cast time from the spell id ;)
			local spellId = timer
			timer = select(7, DBM:GetSpellInfo(spellId)) or 1000 -- GetSpellInfo takes YOUR spell haste into account...WTF?
			local spellHaste = select(7, DBM:GetSpellInfo(53142)) / 10000 -- 53142 = Dalaran Portal, should have 10000 ms cast time
			timer = timer / spellHaste -- calculate the real cast time of the spell...
			return self:NewCastTimer(timer / 1000, spellId, ...)
		end
		return newTimer(self, "cast", timer, ...)
	end

	function bossModPrototype:NewCastCountTimer(timer, ...)
		if tonumber(timer) and timer > 1000 then -- hehe :) best hack in DBM. This makes the first argument optional, so we can omit it to use the cast time from the spell id ;)
			local spellId = timer
			timer = select(7, DBM:GetSpellInfo(spellId)) or 1000 -- GetSpellInfo takes YOUR spell haste into account...WTF?
			local spellHaste = select(7, DBM:GetSpellInfo(53142)) / 10000 -- 53142 = Dalaran Portal, should have 10000 ms cast time
			timer = timer / spellHaste -- calculate the real cast time of the spell...
			return self:NewCastTimer(timer / 1000, spellId, ...)
		end
		return newTimer(self, "castcount", timer, ...)
	end

	function bossModPrototype:NewCastSourceTimer(timer, ...)
		if tonumber(timer) and timer > 1000 then -- hehe :) best hack in DBM. This makes the first argument optional, so we can omit it to use the cast time from the spell id ;)
			local spellId = timer
			timer = select(7, DBM:GetSpellInfo(spellId)) or 1000 -- GetSpellInfo takes YOUR spell haste into account...WTF?
			local spellHaste = select(7, DBM:GetSpellInfo(53142)) / 10000 -- 53142 = Dalaran Portal, should have 10000 ms cast time
			timer = timer / spellHaste -- calculate the real cast time of the spell...
			return self:NewCastSourceTimer(timer / 1000, spellId, ...)
		end
		return newTimer(self, "castsource", timer, ...)
	end

	function bossModPrototype:NewCDTimer(...)
		return newTimer(self, "cd", ...)
	end

	function bossModPrototype:NewCDCountTimer(...)
		return newTimer(self, "cdcount", ...)
	end

	function bossModPrototype:NewCDSourceTimer(...)
		return newTimer(self, "cdsource", ...)
	end

	function bossModPrototype:NewNextTimer(...)
		return newTimer(self, "next", ...)
	end

	function bossModPrototype:NewNextCountTimer(...)
		return newTimer(self, "nextcount", ...)
	end

	function bossModPrototype:NewNextSourceTimer(...)
		return newTimer(self, "nextsource", ...)
	end

	function bossModPrototype:NewAchievementTimer(...)
		return newTimer(self, "achievement", ...)
	end

	function bossModPrototype:NewCDSpecialTimer(...)
		return newTimer(self, "cdspecial", ...)
	end

	function bossModPrototype:NewNextSpecialTimer(...)
		return newTimer(self, "nextspecial", ...)
	end

	function bossModPrototype:NewPhaseTimer(...)
		return newTimer(self, "stage", ...)
	end

	function bossModPrototype:NewRPTimer(...)
		return newTimer(self, "roleplay", ...)
	end

	function bossModPrototype:NewAddsTimer(...)
		return newTimer(self, "adds", ...)
	end

	function bossModPrototype:NewAddsCustomTimer(...)
		return newTimer(self, "addscustom", ...)
	end

	function bossModPrototype:NewAITimer(...)
		return newTimer(self, "ai", ...)
	end

	function bossModPrototype:GetLocalizedTimerText(timerType, spellId, Name)
		local spellName
		if Name then
			spellName = Name--Pull from name stored in object
		elseif spellId then
			DBM:Debug("|cffff0000GetLocalizedTimerText fallback, this should not happen and is a bug. this fallback should be deleted if this message is never seen after async code is live|r")
			if timerType == "achievement" then
				spellName = select(2, GetAchievementInfo(spellId))
			else
				spellName = DBM:GetSpellInfo(spellId)
			end
		end
		if DBM_CORE_AUTO_TIMER_TEXTS[timerType.."short"] and DBM.Bars:GetOption("StripCDText") then
			return pformat(DBM_CORE_AUTO_TIMER_TEXTS[timerType.."short"], spellName)
		else
			return pformat(DBM_CORE_AUTO_TIMER_TEXTS[timerType], spellName)
		end
	end
end

------------------------------
--  Berserk/Combat Objects  --
------------------------------
do
	local enragePrototype = {}
	local mt = {__index = enragePrototype}

	function enragePrototype:Start(timer)
		timer = timer or self.timer or 600
		timer = timer <= 0 and self.timer - timer or timer
		self.bar:SetTimer(timer)
		self.bar:Start()
		if self.warning1 then
			if timer > 660 then self.warning1:Schedule(timer - 600, 10, DBM_CORE_MIN) end
			if timer > 300 then self.warning1:Schedule(timer - 300, 5, DBM_CORE_MIN) end
			if timer > 180 then self.warning2:Schedule(timer - 180, 3, DBM_CORE_MIN) end
		end
		if self.warning2 then
			if timer > 60 then self.warning2:Schedule(timer - 60, 1, DBM_CORE_MIN) end
			if timer > 30 then self.warning2:Schedule(timer - 30, 30, DBM_CORE_SEC) end
			if timer > 10 then self.warning2:Schedule(timer - 10, 10, DBM_CORE_SEC) end
		end
	end

	function enragePrototype:Schedule(t)
		return self.owner:Schedule(t, self.Start, self)
	end

	function enragePrototype:Cancel()
		self.owner:Unschedule(self.Start, self)
		if self.warning1 then
			self.warning1:Cancel()
		end
		if self.warning2 then
			self.warning2:Cancel()
		end
		self.bar:Stop()
	end
	enragePrototype.Stop = enragePrototype.Cancel

	function bossModPrototype:NewBerserkTimer(timer, text, barText, barIcon)
		timer = timer or 600
		local warning1 = self:NewAnnounce(text or DBM_CORE_GENERIC_WARNING_BERSERK, 1, nil, "warning_berserk", false)
		local warning2 = self:NewAnnounce(text or DBM_CORE_GENERIC_WARNING_BERSERK, 4, nil, "warning_berserk", false)
		local bar = self:NewTimer(timer, barText or DBM_CORE_GENERIC_TIMER_BERSERK, barIcon or 28131, nil, "timer_berserk")
		local obj = setmetatable(
			{
				warning1 = warning1,
				warning2 = warning2,
				bar = bar,
				timer = timer,
				owner = self
			},
			mt
		)
		return obj
	end

	function bossModPrototype:NewCombatTimer(timer, text, barText, barIcon)
		timer = timer or 10
		--NewTimer(timer, name, texture, optionDefault, optionName, colorType, inlineIcon, keep, countdown, countdownMax, r, g, b)
		local bar = self:NewTimer(timer, barText or DBM_CORE_GENERIC_TIMER_COMBAT, barIcon or "Interface\\Icons\\Ability_Warrior_OffensiveStance", nil, "timer_combat", nil, nil, nil, 1, 5)
		local obj = setmetatable(
			{
				bar = bar,
				timer = timer,
				owner = self
			},
			mt
		)
		return obj
	end
end


---------------
--  Options  --
---------------
function bossModPrototype:AddBoolOption(name, default, cat, func)
	cat = cat or "misc"
	DBM.DefaultOptions[name] = (default == nil) or default
	if default and type(default) == "string" then
		default = self:GetRoleFlagValue(default)
	end
	self.Options[name] = (default == nil) or default
	self:SetOptionCategory(name, cat)
	if func then
		self.optionFuncs = self.optionFuncs or {}
		self.optionFuncs[name] = func
	end
	if cat == "icon" then
		if not self.findFastestComputer then
			self.findFastestComputer = {}
		end
		self.findFastestComputer[#self.findFastestComputer + 1] = name
	end
end

function bossModPrototype:RemoveOption(name)
	self.Options[name] = nil
	for i, options in pairs(self.optionCategories) do
		removeEntry(options, name)
		if #options == 0 then
			self.optionCategories[i] = nil
			removeEntry(self.categorySort, i)
		end
	end
	if self.optionFuncs then
		self.optionFuncs[name] = nil
	end
end

function bossModPrototype:AddSliderOption(name, minValue, maxValue, valueStep, default, cat, func)
	cat = cat or "misc"
	self.Options[name] = default or 0
	self:SetOptionCategory(name, cat)
	self.sliders = self.sliders or {}
	self.sliders[name] = {
		minValue = minValue,
		maxValue = maxValue,
		valueStep = valueStep,
	}
	if func then
		self.optionFuncs = self.optionFuncs or {}
		self.optionFuncs[name] = func
	end
end

function bossModPrototype:AddButton(name, onClick, cat, func)
	cat = cat or "misc"
	self:SetOptionCategory(name, cat)
	self.buttons = self.buttons or {}
	self.buttons[name] = onClick
	if func then
		self.optionFuncs = self.optionFuncs or {}
		self.optionFuncs[name] = func
	end
end

function bossModPrototype:AddDropdownOption(name, options, default, cat, func)
	cat = cat or "misc"
	self.Options[name] = default
	self:SetOptionCategory(name, cat)
	self.dropdowns = self.dropdowns or {}
	self.dropdowns[name] = options
	if func then
		self.optionFuncs = self.optionFuncs or {}
		self.optionFuncs[name] = func
	end
end

function bossModPrototype:AddOptionSpacer(cat)
	cat = cat or "misc"
	if self.optionCategories[cat] then
		tinsert(self.optionCategories[cat], DBM_OPTION_SPACER)
	end
end

function bossModPrototype:AddOptionLine(text, cat)
	cat = cat or "misc"
	if not self.optionCategories[cat] then
		self.optionCategories[cat] = {}
	end
	if self.optionCategories[cat] then
		tinsert(self.optionCategories[cat], {line = true, text = text})
	end
end

function bossModPrototype:AddAnnounceSpacer()
	return self:AddOptionSpacer("announce")
end

function bossModPrototype:AddTimerSpacer()
	return self:AddOptionSpacer("timer")
end

function bossModPrototype:AddAnnounceLine(text)
	return self:AddOptionLine(text, "announce")
end

function bossModPrototype:AddTimerLine(text)
	return self:AddOptionLine(text, "timer")
end

function bossModPrototype:AddMiscLine(text)
	return self:AddOptionLine(text, "misc")
end

function bossModPrototype:SetOptionCategory(name, cat)
	for _, options in pairs(self.optionCategories) do
		removeEntry(options, name)
	end
	if not self.optionCategories[cat] then
		self.optionCategories[cat] = {}
		tinsert(self.categorySort, cat)
	end
	tinsert(self.optionCategories[cat], name)
end


--------------
--  Combat  --
--------------
function bossModPrototype:RegisterCombat(cType, ...)
	if cType then
		cType = cType:lower()
	end
	local info = {
		type = cType,
		mob = self.creatureId,
		name = self.localization.general.name or self.id,
		msgs = (cType ~= "combat") and {...},
		mod = self
	}
	if self.multiMobPullDetection then
		info.multiMobPullDetection = self.multiMobPullDetection
	end
	local addedKillMobs = false
	for i = 1, select("#", ...) do
		local v = select(i, ...)
		if type(v) == "number" then
			info.killMobs = info.killMobs or {}
			info.killMobs[select(i, ...)] = true
			addedKillMobs = true
		end
	end
	if not addedKillMobs and self.multiMobPullDetection then
		for i, v in ipairs(self.multiMobPullDetection) do
			info.killMobs = info.killMobs or {}
			info.killMobs[v] = true
		end
	end
	self.combatInfo = info
	if not self.zones then return end
	for i, v in ipairs(self.zones) do
		combatInfo[v] = combatInfo[v] or {}
		tinsert(combatInfo[v], info)
	end
end

-- needs to be called _AFTER_ RegisterCombat
function bossModPrototype:RegisterKill(msgType, ...)
	if msgType then
		msgType = msgType:lower()
	end
	if not self.combatInfo then
		DBM:Debug("mod.combatInfo not yet initialized, use mod:RegisterCombat before using this method", 3)
		return
	end
	self.combatInfo.killType = msgType
	self.combatInfo.killMsgs = {}
	for i = 1, select("#", ...) do
		local v = select(i, ...)
		self.combatInfo.killMsgs[v] = true
	end
end

-- needs to be called _AFTER_ RegisterCombat
function bossModPrototype:SetDetectCombatInVehicle(flag)
	if not self.combatInfo then
		DBM:Debug("mod.combatInfo not yet initialized, use mod:RegisterCombat before using this method", 3)
		return
	end
	self.combatInfo.noCombatInVehicle = not flag
end

function bossModPrototype:IsInCombat()
	return self.inCombat
end

function bossModPrototype:IsAlive()
	return not UnitIsDeadOrGhost("player")
end

function bossModPrototype:SetMinCombatTime(t)
	self.minCombatTime = t
end

-- needs to be called after RegisterCombat
function bossModPrototype:SetWipeTime(t)
	if not self.combatInfo then
		DBM:Debug("mod.combatInfo not yet initialized, use mod:RegisterCombat before using this method", 3)
	end
	self.combatInfo.wipeTimer = t
end

function bossModPrototype:GetBossHPString(cId)
	local idType = (GetNumRaidMembers() == 0 and "party") or "raid"
	for i = 0, mmax(GetNumRaidMembers(), GetNumPartyMembers()) do
		local unitId = ((i == 0) and "target") or idType..i.."target"
		local guid = UnitGUID(unitId)
		if guid and tonumber(guid:sub(9, 12), 16) == cId then
			return floor(UnitHealth(unitId)/UnitHealthMax(unitId) * 100).."%"
		end
	end
	return DBM_CORE_UNKNOWN
end

function bossModPrototype:GetHP()
	return self:GetBossHPString((self.combatInfo and self.combatInfo.mob) or self.creatureId)
end

function bossModPrototype:IsWipe()
	local wipe = true
	local uId = ((GetNumRaidMembers() == 0) and "party") or "raid"
	for i = 0, mmax(GetNumRaidMembers(), GetNumPartyMembers()) do
		local id = (i == 0 and "player") or uId..i
		if UnitAffectingCombat(id) and not UnitIsDeadOrGhost(id) then
			wipe = false
			break
		end
	end
	return wipe
end



-----------------------
--  Synchronization  --
-----------------------
function bossModPrototype:SendSync(event, arg)
	event = event or ""
	arg = arg or ""
	local str = ("%s\t%s\t%s\t%s"):format(self.id, self.revision or 0, event, arg)
	local spamId = self.id..event..arg
	local time = GetTime()
	if not modSyncSpam[spamId] or (time - modSyncSpam[spamId]) > 2.5 then
		self:ReceiveSync(event, arg, nil, self.revision or 0)
		sendSync("DBMv4-Mod", str)
	end
end

function bossModPrototype:ReceiveSync(event, arg, sender, revision)
	local spamId = self.id..event..arg
	local time = GetTime()
	if (not modSyncSpam[spamId] or (time - modSyncSpam[spamId]) > 2.5) and self.OnSync and (not (self.blockSyncs and sender)) and (not sender or (not self.minSyncRevision or revision >= self.minSyncRevision)) then
		modSyncSpam[spamId] = time
		self:OnSync(event, arg, sender)
	end
end

function bossModPrototype:SetRevision(revision)
	revision = revision or ""
	if not revision then
		revision = DBM.Revision
	end
	self.revision = revision
end

--Either treat it as a valid number, or a curse string that needs to be made into a valid number
function bossModPrototype:SetMinSyncRevision(revision)
	self.minSyncRevision = revision
end

function bossModPrototype:SetHotfixNoticeRev(revision)
	self.hotfixNoticeRev = (type(revision or "") == "number") and revision or revision
end

-----------------
--  Scheduler  --
-----------------
function bossModPrototype:Schedule(t, f, ...)
	return schedule(t, f, self, ...)
end

function bossModPrototype:Unschedule(f, ...)
	return unschedule(f, self, ...)
end

function bossModPrototype:ScheduleMethod(t, method, ...)
	if not self[method] then
		error(("Method %s does not exist"):format(tostring(method)), 2)
	end
	return self:Schedule(t, self[method], self, ...)
end
bossModPrototype.ScheduleEvent = bossModPrototype.ScheduleMethod

function bossModPrototype:UnscheduleMethod(method, ...)
	if not self[method] then
		error(("Method %s does not exist"):format(tostring(method)), 2)
	end
	return self:Unschedule(self[method], self, ...)
end
bossModPrototype.UnscheduleEvent = bossModPrototype.UnscheduleMethod


-------------
--  Icons  --
-------------
function bossModPrototype:SetIcon(target, icon, timer)
	if not target then return end --prevent error if called on mob etc(lichking)
	if DBM.Options.DontSetIcons or not enableIcons or DBM:GetRaidRank() == 0 then
		return
	end
	icon = icon and icon >= 0 and icon <= 8 and icon or 8
	local oldIcon = self:GetIcon(target) or 0
	local uId = DBM:GetRaidUnitId(target) or target
	SetRaidTarget(uId, icon)
	self:UnscheduleMethod("SetIcon", target)
	if timer then
		self:ScheduleMethod(timer, "RemoveIcon", target)
		if oldIcon then
			self:ScheduleMethod(timer + 1, "SetIcon", target, oldIcon)
		end
	end
end

function bossModPrototype:GetIcon(target)
	local uId = DBM:GetRaidUnitId(target) or target
	return GetRaidTargetIndex(uId)
end

function bossModPrototype:RemoveIcon(target, timer)
	return self:SetIcon(target, 0, timer)
end

function bossModPrototype:ClearIcons()
	if GetNumRaidMembers() > 0 then
		for i = 1, GetNumRaidMembers() do
			if UnitExists("raid"..i) and GetRaidTargetIndex("raid"..i) then
				SetRaidTarget("raid"..i, 0)
			end
		end
	else
		for i = 1, GetNumPartyMembers() do
			if UnitExists("party"..i) and GetRaidTargetIndex("party"..i) then
				SetRaidTarget("party"..i, 0)
			end
		end
	end
end

function bossModPrototype:CanSetIcon(optionName)
	if canSetIcons[optionName] then
		return true
	end
	return false
end

do
	local scanExpires = {}
	local addsIcon = {}
	local addsIconSet = {}
	local mobUids = {"mouseover", "target", "boss1", "boss2", "boss3", "boss4", "boss5"}
	function bossModPrototype:ScanForMobs(creatureID, iconSetMethod, mobIcon, maxIcon, scanInterval, scanningTime, optionName, isFriendly, secondCreatureID, skipMarked)
		if not optionName then optionName = self.findFastestComputer[1] end
		if canSetIcons[optionName] then
			--Declare variables.
			DBM:Debug("canSetIcons true", 4)
			local timeNow = GetTime()
			if not creatureID then--This function must not be used to boss, so remove self.creatureId. Accepts cid, guid and cid table
				error("DBM:ScanForMobs calld without creatureID")
				return
			end
			iconSetMethod = iconSetMethod or 0--Set IconSetMethod -- 0: Descending / 1:Ascending / 2: Force Set / 9:Force Stop
			scanningTime = scanningTime or 8
			maxIcon = maxIcon or 8 --We only have 8 icons.
			isFriendly = isFriendly or false
			secondCreatureID = secondCreatureID or 0
			scanInterval = scanInterval or 0.2
			--With different scanID, this function can support multi scanning same time. Required for Nazgrim.
			local scanID = 0
			if type(creatureID) == "number" then
				scanID = creatureID --guid and table no not supports multi scanning. only cid supports multi scanning
			end
			if iconSetMethod == 9 then--Force stop scanning
				--clear variables
				scanExpires[scanID] = nil
				addsIcon[scanID] = nil
				addsIconSet[scanID] = nil
				return
			end
			if not addsIcon[scanID] then addsIcon[scanID] = mobIcon or 8 end
			if not addsIconSet[scanID] then addsIconSet[scanID] = 0 end
			if not scanExpires[scanID] then scanExpires[scanID] = timeNow + scanningTime end
			--DO SCAN NOW
			for _, unitid2 in ipairs(mobUids) do
				local guid2 = UnitGUID(unitid2)
				local cid2 = self:GetCIDFromGUID(guid2)
				local isEnemy = UnitIsEnemy("player", unitid2) or true--If api returns nil, assume it's an enemy
				local isFiltered = false
				if (not isFriendly and not isEnemy) or (skipMarked and not GetRaidTargetIndex(unitid2)) then
					isFiltered = true
					DBM:Debug("A unit skipped because it's a filtered mob", 3)
				end
				if not isFiltered then
					if guid2 and type(creatureID) == "table" and creatureID[cid2] and not addsGUIDs[guid2] then
						DBM:Debug("Match found, SHOULD be setting icon", 2)
						if type(creatureID[cid2]) == "number" then
							SetRaidTarget(unitid2, creatureID[cid2])
						else
							SetRaidTarget(unitid2, addsIcon[scanID])
							if iconSetMethod == 1 then
								addsIcon[scanID] = addsIcon[scanID] + 1
							else
								addsIcon[scanID] = addsIcon[scanID] - 1
							end
						end
						addsGUIDs[guid2] = true
						addsIconSet[scanID] = addsIconSet[scanID] + 1
						if addsIconSet[scanID] >= maxIcon then--stop scan immediately to save cpu
							--clear variables
							scanExpires[scanID] = nil
							addsIcon[scanID] = nil
							addsIconSet[scanID] = nil
							return
						end
					elseif guid2 and (guid2 == creatureID or cid2 == creatureID or cid2 == secondCreatureID) and not addsGUIDs[guid2] then
						DBM:Debug("Match found, SHOULD be setting icon", 2)
						if iconSetMethod == 2 then
							SetRaidTarget(unitid2, mobIcon)
						else
							SetRaidTarget(unitid2, addsIcon[scanID])
							if iconSetMethod == 1 then
								addsIcon[scanID] = addsIcon[scanID] + 1
							else
								addsIcon[scanID] = addsIcon[scanID] - 1
							end
						end
						addsGUIDs[guid2] = true
						addsIconSet[scanID] = addsIconSet[scanID] + 1
						if addsIconSet[scanID] >= maxIcon then--stop scan immediately to save cpu
							--clear variables
							scanExpires[scanID] = nil
							addsIcon[scanID] = nil
							addsIconSet[scanID] = nil
							return
						end
					end
				end
			end
			for uId in DBM:GetGroupMembers() do
				local unitid = uId.."target"
				local guid = UnitGUID(unitid)
				local cid = self:GetCIDFromGUID(guid)
				local isEnemy = UnitIsEnemy("player", unitid) or true--If api returns nil, assume it's an enemy
				local isFiltered = false
				if (not isFriendly and not isEnemy) or (skipMarked and not GetRaidTargetIndex(unitid)) then
					isFiltered = true
					DBM:Debug("ScanForMobs aborting because filtered mob", 2)
				end
				if not isFiltered then
					if guid and type(creatureID) == "table" and creatureID[cid] and not addsGUIDs[guid] then
						DBM:Debug("Match found, SHOULD be setting icon", 2)
						if type(creatureID[cid]) == "number" then
							SetRaidTarget(unitid, creatureID[cid])
						else
							SetRaidTarget(unitid, addsIcon[scanID])
							if iconSetMethod == 1 then
								addsIcon[scanID] = addsIcon[scanID] + 1
							else
								addsIcon[scanID] = addsIcon[scanID] - 1
							end
						end
						addsGUIDs[guid] = true
						addsIconSet[scanID] = addsIconSet[scanID] + 1
						if addsIconSet[scanID] >= maxIcon then--stop scan immediately to save cpu
							--clear variables
							scanExpires[scanID] = nil
							addsIcon[scanID] = nil
							addsIconSet[scanID] = nil
							return
						end
					elseif guid and (guid == creatureID or cid == creatureID or cid == secondCreatureID) and not addsGUIDs[guid] then
						DBM:Debug("Match found, SHOULD be setting icon", 2)
						if iconSetMethod == 2 then
							SetRaidTarget(unitid, mobIcon)
						else
							SetRaidTarget(unitid, addsIcon[scanID])
							if iconSetMethod == 1 then
								addsIcon[scanID] = addsIcon[scanID] + 1
							else
								addsIcon[scanID] = addsIcon[scanID] - 1
							end
						end
						addsGUIDs[guid] = true
						addsIconSet[scanID] = addsIconSet[scanID] + 1
						if addsIconSet[scanID] >= maxIcon then--stop scan immediately to save cpu
							--clear variables
							scanExpires[scanID] = nil
							addsIcon[scanID] = nil
							addsIconSet[scanID] = nil
							return
						end
					end
				end
			end
			if timeNow < scanExpires[scanID] then--scan for limited times.
				self:ScheduleMethod(scanInterval, "ScanForMobs", creatureID, iconSetMethod, mobIcon, maxIcon, scanInterval, scanningTime, optionName, isFriendly, secondCreatureID)
			else
				DBM:Debug("Stopping ScanForMobs for: "..(optionName or "nil"), 2)
				--clear variables
				scanExpires[scanID] = nil
				addsIcon[scanID] = nil
				addsIconSet[scanID] = nil
				--Do not wipe adds GUID table here, it's wiped by :Stop() which is called by EndCombat
			end
		else
			DBM:Debug("Not elected to set icons for "..(optionName or "nil"), 2)
		end
	end
end

-----------------------
--  Model Functions  --
-----------------------
function bossModPrototype:SetModelScale(scale)
	self.modelScale = scale
end

function bossModPrototype:SetModelOffset(x, y, z)
	self.modelOffsetX = x
	self.modelOffsetY = y
	self.modelOffsetZ = z
end

function bossModPrototype:SetModelRotation(r)
	self.modelRotation = r
end

function bossModPrototype:SetModelMoveSpeed(v)
	self.modelMoveSpeed = v
end

function bossModPrototype:SetModelID(id)
	self.modelId = id
end

function bossModPrototype:SetModelSound(long, short)--PlaySoundFile prototype for model viewer, long is long sound, short is a short clip, configurable in UI, both sound paths defined in boss mods.
	self.modelSoundLong = long
	self.modelSoundShort = short
end

function bossModPrototype:EnableModel()
	self.modelEnabled = true
end

function bossModPrototype:DisableModel()
	self.modelEnabled = nil
end


--------------------
--  Localization  --
--------------------
function bossModPrototype:GetLocalizedStrings()
	return self.localization.miscStrings
end

-- Not really good, needs a few updates
do
	local modLocalizations = {}
	local modLocalizationPrototype = {}
	local mt = {__index = modLocalizationPrototype}
	local returnKey = {__index = function(t, k) return k end}
	local defaultCatLocalization = {
		__index = setmetatable({
			timer				= DBM_CORE_OPTION_CATEGORY_TIMERS,
			announce			= DBM_CORE_OPTION_CATEGORY_WARNINGS,
			announceother		= DBM_CORE_OPTION_CATEGORY_WARNINGS_OTHER,
			announcepersonal	= DBM_CORE_OPTION_CATEGORY_WARNINGS_YOU,
			announcerole		= DBM_CORE_OPTION_CATEGORY_WARNINGS_ROLE,
			sound				= DBM_CORE_OPTION_CATEGORY_SOUNDS,
			yell				= DBM_CORE_OPTION_CATEGORY_YELLS,
			icon				= DBM_CORE_OPTION_CATEGORY_ICONS,
			misc				= MISCELLANEOUS
		}, returnKey)
	}
	local defaultTimerLocalization = {
		__index = setmetatable({
			timer_berserk = DBM_CORE_GENERIC_TIMER_BERSERK,
			TimerSpeedKill = DBM_CORE_ACHIEVEMENT_TIMER_SPEED_KILL
		}, returnKey)
	}
	local defaultAnnounceLocalization = {
		__index = setmetatable({
			warning_berserk = DBM_CORE_GENERIC_WARNING_BERSERK
		}, returnKey)
	}
	local defaultOptionLocalization = {
		__index = setmetatable({
			timer_berserk = DBM_CORE_OPTION_TIMER_BERSERK,
			HealthFrame = DBM_CORE_OPTION_HEALTH_FRAME
		}, returnKey)
	}
	local defaultMiscLocalization = {
		__index = function(t, k)
			return t.misc.general[k] or t.misc.options[k] or t.misc.warnings[k] or t.misc.timers[k] or t.misc.cats[k] or k
		end
	}

	function modLocalizationPrototype:SetGeneralLocalization(t)
		for i, v in pairs(t) do
			self.general[i] = v
		end
	end

	function modLocalizationPrototype:SetWarningLocalization(t)
		for i, v in pairs(t) do
			self.warnings[i] = v
		end
	end

	function modLocalizationPrototype:SetTimerLocalization(t)
		for i, v in pairs(t) do
			self.timers[i] = v
		end
	end

	function modLocalizationPrototype:SetOptionLocalization(t)
		for i, v in pairs(t) do
			self.options[i] = v
		end
	end

	function modLocalizationPrototype:SetOptionCatLocalization(t)
		for i, v in pairs(t) do
			self.cats[i] = v
		end
	end

	function modLocalizationPrototype:SetMiscLocalization(t)
		for i, v in pairs(t) do
			self.miscStrings[i] = v
		end
	end

	function DBM:CreateModLocalization(name)
		name = tostring(name)
		local obj = {
			general = setmetatable({}, returnKey),
			warnings = setmetatable({}, defaultAnnounceLocalization),
			options = setmetatable({}, defaultOptionLocalization),
			timers = setmetatable({}, defaultTimerLocalization),
			miscStrings = setmetatable({}, defaultMiscLocalization),
			cats = setmetatable({}, defaultCatLocalization),
		}
		obj.miscStrings.misc = obj
		setmetatable(obj, mt)
		modLocalizations[name] = obj
		return obj
	end

	function DBM:GetModLocalization(name)
		name = tostring(name)
		return modLocalizations[name] or self:CreateModLocalization(name)
	end
end

