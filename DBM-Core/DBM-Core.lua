-- *********************************************************
-- **               Deadly Boss Mods - Core               **
-- **            http://www.deadlybossmods.com            **
-- *********************************************************
--
-- This addon is written and copyrighted by:
--    * Paul Emmerich (Tandanu @ EU-Aegwynn) (DBM-Core)
--    * Martin Verges (Nitram @ EU-Azshara) (DBM-GUI)
--    * Adam Williams (Omegal @ US-Whisperwind) (Primary boss mod author & DBM maintainer)
--
-- The localizations are written by:
--    * enGB/enUS: Omegal				Twitter @MysticalOS
--    * deDE: Ebmor
--    * ruRU: TOM_RUS					https://curseforge.com/profiles/TOM_RUS/
--    * zhTW: Whyv						ultrashining@gmail.com
--    * koKR: Elnarfim					---
--    * zhCN: Mini Dragon				projecteurs@gmail.com
--
--
-- Special thanks to:
--    * Arta
--    * Tennberg (a lot of fixes in the enGB/enUS localization)
--    * nBlueWiz (a lot of previous fixes in the koKR localization as well as boss mod work) Contact: everfinale@gmail.com
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
local _, private = ...

local wowVersionString, wowBuild, _, wowTOC = GetBuildInfo()
local testBuild = false -- no API for 3.3.5a, just assume false since it's a final build for private servers

local DBMPrefix = "DBMv4"
private.DBMPrefix = DBMPrefix

local L = DBM_CORE_L
local CL = DBM_COMMON_L

-------------------------------
--  Globals/Default Options  --
-------------------------------
local function releaseDate(year, month, day, hour, minute, second)
	hour = hour or 0
	minute = minute or 0
	second = second or 0
	return second + minute * 10^2 + hour * 10^4 + day * 10^6 + month * 10^8 + year * 10^10
end

local function parseCurseDate(date)
	date = tostring(date)
	if #date == 13 then
		-- support for broken curse timestamps: leading 0 in hours is missing...
		date = date:sub(1, 8) .. "0" .. date:sub(9, #date)
	end
	local year, month, day, hour, minute, second = tonumber(date:sub(1, 4)), tonumber(date:sub(5, 6)), tonumber(date:sub(7, 8)), tonumber(date:sub(9, 10)), tonumber(date:sub(11, 12)), tonumber(date:sub(13, 14))
	if year and month and day and hour and minute and second then
		return releaseDate(year, month, day, hour, minute, second)
	end
end

local function showRealDate(curseDate)
	curseDate = tostring(curseDate)
	local year, month, day, hour, minute, second = curseDate:sub(1, 4), curseDate:sub(5, 6), curseDate:sub(7, 8), curseDate:sub(9, 10), curseDate:sub(11, 12), curseDate:sub(13, 14)
	if year and month and day and hour and minute and second then
		return year.."/"..month.."/"..day.." "..hour..":"..minute..":"..second
	end
end

local function currentFullDate()
	local datetable = date("*t")
	return releaseDate(datetable.year, datetable.month, datetable.day, datetable.hour, datetable.min, datetable.sec)
end

DBM = {
	Revision = parseCurseDate("20250928190008"),
	DisplayVersion = "10.1.13 alpha", -- the string that is shown as version
	ReleaseRevision = releaseDate(2024, 07, 20) -- the date of the latest stable version that is available, optionally pass hours, minutes, and seconds for multiple releases in one day
}

local fakeBWVersion = 7558
local bwVersionResponseString = "%d"
DBM.HighestRelease = DBM.ReleaseRevision --Updated if newer version is detected, used by update nags to reflect critical fixes user is missing on boss pulls

-- support for github downloads, which doesn't support curse keyword expansion
-- just use the latest release revision
if not DBM.Revision then
	DBM.Revision = DBM.ReleaseRevision
end

function DBM:ShowRealDate(curseDate)
	return showRealDate(curseDate)
end

function DBM:ReleaseDate(year, month, day, hour, minute, second)
	return releaseDate(year, month, day, hour, minute, second)
end

function DBM:GetTOC()
	return wowTOC, wowVersionString, wowBuild
end

-- dual profile setup
local _, playerClass = UnitClass("player")
DBM_UseDualProfile = false -- Having this as true requires user to know how mod profiles work and auto-generate new ones for new specs
-- if playerClass == "MAGE" or playerClass == "WARLOCK" or playerClass == "ROGUE" or playerClass == "HUNTER" then
--	DBM_UseDualProfile = false
-- end
DBM_CharSavedRevision = 2

--Hard code STANDARD_TEXT_FONT since skinning mods like to taint it (or worse, set it to nil, wtf?)
local standardFont
if LOCALE_koKR then
	standardFont = "Fonts\\2002.TTF"
elseif LOCALE_zhCN then
	standardFont = "Fonts\\ARKai_T.ttf"
elseif LOCALE_zhTW then
	standardFont = "Fonts\\blei00d.TTF"
elseif LOCALE_ruRU then
	standardFont = "Fonts\\FRIZQT___CYR.TTF"
else
	standardFont = "Fonts\\FRIZQT__.TTF"
end

DBM.DefaultOptions = {
	WarningColors = {
		{r = 0.41, g = 0.80, b = 0.94}, -- Color 1 - #69CCF0 - Turqoise
		{r = 0.95, g = 0.95, b = 0.00}, -- Color 2 - #F2F200 - Yellow
		{r = 1.00, g = 0.50, b = 0.00}, -- Color 3 - #FF8000 - Orange
		{r = 1.00, g = 0.10, b = 0.10}, -- Color 4 - #FF1A1A - Red
	},
	RaidWarningSound = "Sound\\Doodad\\BellTollNightElf.wav",
	SpecialWarningSound = "Sound\\Spells\\PVPFlagTaken.wav",
	SpecialWarningSound2 = "Sound\\Creature\\AlgalonTheObserver\\UR_Algalon_BHole01.wav",
	SpecialWarningSound3 = "Interface\\AddOns\\DBM-Core\\sounds\\AirHorn.ogg",
	SpecialWarningSound4 = "Sound\\Creature\\HoodWolf\\HoodWolfTransformPlayer01.wav",
	SpecialWarningSound5 = "Sound\\Creature\\Loathstare\\Loa_Naxx_Aggro02.wav",
	ModelSoundValue = "Short",
	CountdownVoice = "Corsica",
	CountdownVoice2 = "Kolt",
	CountdownVoice3 = "Smooth",
	PullVoice = "Corsica",
	ChosenVoicePack2 = (GetLocale() == "enUS" or GetLocale() == "enGB") and "VEM" or "None",
	VPReplacesAnnounce = true,
	VPReplacesSA1 = true,
	VPReplacesSA2 = true,
	VPReplacesSA3 = true,
	VPReplacesSA4 = true,
	VPReplacesGTFO = true,
	VPReplacesCustom = false,
	AlwaysPlayVoice = false,
	VPDontMuteSounds = false,
	EventSoundVictory2 = "None", --"Interface\\AddOns\\DBM-Core\\sounds\\Victory\\SmoothMcGroove_Fanfare.ogg",
	EventSoundWipe = "None",
	EventSoundPullTimer = "None",
	EventSoundEngage2 = "None",
	EventSoundMusic = "None",
	EventSoundDungeonBGM = "None",
	EventSoundMusicCombined = false,
	EventDungMusicMythicFilter = true,
	EventMusicMythicFilter = true,
	Enabled = true,
	ShowWarningsInChat = true,
	ShowFakedRaidWarnings = false,
	ShowSWarningsInChat = true,
	WarningIconLeft = true,
	WarningIconRight = true,
	WarningIconChat = true,
	WarningAlphabetical = true,
	WarningShortText = true,
	StripServerName = true,
	ShowAllVersions = true,
	ShowReminders = true,
	ShowPizzaMessage = true,
	ShowEngageMessage = true,
	ShowDefeatMessage = true,
	ShowGuildMessages = true,
	ShowGuildMessagesPlus = false,
	AutoRespond = true,
	EnableWBSharing = true,
	WhisperStats = false,
	DisableStatusWhisper = false,
	DisableGuildStatus = false,
	DisableRaidIcons = false,
	DisableChatBubbles = false,
	OverrideBossAnnounce = false,
	OverrideBossTimer = false,
	OverrideBossIcon = false,
	OverrideBossSay = false,
	NoAnnounceOverride = true,
	NoTimerOverridee = true,
	ReplaceMyConfigOnOverride = false,
	HideBossEmoteFrame2 = false,
	SWarningAlphabetical = true,
	SWarnNameInNote = true,
	CustomSounds = 0,
	SpamBlockRaidWarning = true,
	SpamBlockBossWhispers = false,
	FixCLEUOnCombatStart = true,
	AlwaysShowHealthFrame = false,
	ShowBigBrotherOnCombatStart = false,
	FilterTankSpec = true,
	FilterBTargetFocus = true,
	FilterBInterruptCooldown = true,
	FilterBInterruptHealer = false,
	FilterInterruptNoteName = false,
	FilterTTargetFocus = true,
	FilterTInterruptCooldown = true,
	FilterTInterruptHealer = false,
	FilterDispel = true,
	FilterTrashWarnings2 = true,
	FilterVoidFormSay = true,
	--FilterSelfHud = true,
	AutologBosses = false,
	AdvancedAutologBosses = false,
	RecordOnlyBosses = false,
	DoNotLogLFG = true,
	LogCurrentMythicRaids = true,
	LogCurrentRaids = true,
	LogCurrentMPlus = true,
	LogCurrentMythicZero = false,
	LogCurrentHeroic = false,
	LogCurrentNormal = false,
	LogTrivialRaids = false,
	LogTWRaids = false,
	LogTrivialDungeons = false,
	LogTWDungeons = false,
	UseSoundChannel = "Master",
	LFDEnhance = true,
	WorldBossNearAlert = false,
	RLReadyCheckSound = true,
	AFKHealthWarning = false,
	AutoReplySound = true,
	HideObjectivesFrame = false, --true,
	HideGarrisonToasts = true,
	HideGuildChallengeUpdates = true,
	HideTooltips = false,
	DisableSFX = false,
	EnableModels = true,
	GUIWidth = 800,
	GUIHeight = 600,
	GroupOptionsBySpell = true,
	GroupOptionsExcludeIcon = false,
	AutoExpandSpellGroups = false,
	--ShowSpellDescWhenExpanded = false,
	RangeFrameFrames = "radar",
	RangeFrameUpdates = "Fast",
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
	HPFrameX = -150,
	HPFrameY = 300,
	HPFrameMaxEntries = 5,
	InfoFramePoint = "CENTER",
	InfoFrameX = 75,
	InfoFrameY = -75,
	InfoFrameShowSelf = false,
	InfoFrameLines = 0,
	InfoFrameCols = 0,
	InfoFrameLocked = false,
	InfoFrameFont = "standardFont",
	InfoFrameFontSize = 12,
	InfoFrameFontStyle = "None",
	WarningDuration2 = 5,
	WarningPoint = "CENTER",
	WarningX = 0,
	WarningY = 260,
	WarningFont = "standardFont",
	WarningFontSize = 20,
	WarningFontStyle = "None",
	WarningFontShadow = true,
	SpecialWarningDuration2 = 1.5,
	SpecialWarningPoint = "CENTER",
	SpecialWarningX = 0,
	SpecialWarningY = 75,
	SpecialWarningFont = "standardFont",
	SpecialWarningFontSize2 = 35,
	SpecialWarningFontStyle = "THICKOUTLINE",
	SpecialWarningFontShadow = false,
	SpecialWarningIcon = true,
	SpecialWarningShortText = true,
	SpecialWarningFontCol = {1.0, 0.7, 0.0},--Yellow, with a tint of orange
	SpecialWarningFlashCol1 = {1.0, 1.0, 0.0},--Yellow
	SpecialWarningFlashCol2 = {1.0, 0.5, 0.0},--Orange
	SpecialWarningFlashCol3 = {1.0, 0.0, 0.0},--Red
	SpecialWarningFlashCol4 = {1.0, 0.0, 1.0},--Purple
	SpecialWarningFlashCol5 = {0.2, 1.0, 1.0},--Tealish
	SpecialWarningFlashDura1 = 0.3,
	SpecialWarningFlashDura2 = 0.4,
	SpecialWarningFlashDura3 = 1,
	SpecialWarningFlashDura4 = 0.7,
	SpecialWarningFlashDura5 = 1,
	SpecialWarningFlashAlph1 = 0.3,
	SpecialWarningFlashAlph2 = 0.3,
	SpecialWarningFlashAlph3 = 0.4,
	SpecialWarningFlashAlph4 = 0.4,
	SpecialWarningFlashAlph5 = 0.5,
	SpecialWarningFlash1 = false,
	SpecialWarningFlash2 = false,
	SpecialWarningFlash3 = false,
	SpecialWarningFlash4 = false,
	SpecialWarningFlash5 = false,
	SpecialWarningFlashCount1 = 1,
	SpecialWarningFlashCount2 = 1,
	SpecialWarningFlashCount3 = 3,
	SpecialWarningFlashCount4 = 2,
	SpecialWarningFlashCount5 = 3,
--	SpecialWarningVibrate1 = false,
--	SpecialWarningVibrate2 = false,
--	SpecialWarningVibrate3 = true,
--	SpecialWarningVibrate4 = true,
--	SpecialWarningVibrate5 = true,
	SWarnClassColor = true,
	HealthFrameGrowUp = false,
	HealthFrameLocked = false,
	HealthFrameWidth = 200,
	ArrowPosX = 0,
	ArrowPosY = -150,
	ArrowPoint = "TOP",
	-- global boss mod settings (overrides mod-specific settings for some options)
	DontShowBossAnnounces = false,
	DontShowTargetAnnouncements = false,
	DontShowSpecialWarningText = false,
	DontShowSpecialWarningFlash = false,
--	DontDoSpecialWarningVibrate = false,
	DontPlaySpecialWarningSound = false,
	DontPlayTrivialSpecialWarningSound = true,
	SpamSpecInformationalOnly = false,
	SpamSpecRoledispel = false,
	SpamSpecRoleinterrupt = false,
	SpamSpecRoledefensive = false,
	SpamSpecRoletaunt = false,
	SpamSpecRolesoak = false,
	SpamSpecRolestack = false,
	SpamSpecRoleswitch = false,
	SpamSpecRolegtfo = false,
	DontShowBossTimers = false,
	DontShowTrashTimers = false,
	DontShowEventTimers = false,
	DontShowUserTimers = false,
	DontShowFarWarnings = true,
	DontSetIcons = false,
	DontRestoreIcons = false,
	DontShowRangeFrame = false,
	DontRestoreRange = false,
	DontShowInfoFrame = false,
	DontShowHudMap2 = false,
	DontShowNameplateIcons = false,
	DontSendBossGUIDs = false,
	DontShowTimersWithNameplates = true,
	UseNameplateHandoff = true,
	NPAuraSize = 40,
	DontPlayCountdowns = false,
	DontSendYells = false,
	BlockNoteShare = false,
	DontShowPT2 = false,
	DontShowPTCountdownText = false,
	DontPlayPTCountdown = false,
	DontShowPTText = false,
	DontShowPTNoID = false,
	PTCountThreshold2 = 5,
	PlayTT = true,
	PlayTTCountdown = false,
	PlayTTCountdownFinished = false,
	EnableBB = true,
	PlayBBLoot = true,
	PlayBBSound = false,
	OverrideBBFont = false,
	BBFont = "standardFont",
	BBFontStyle = "OUTLINE",
	BBFontShadow = true,
	BBFontSize = 0,
	LatencyThreshold = 250,
	BigBrotherAnnounceToRaid = false,
	SettingsMessageShown = false,
	NewsMessageShown2 = 1,--Apparently variable without 2 can still exist in some configs (config cleanup of no longer existing variables not working?)
	AlwaysShowSpeedKillTimer2 = false,
	ShowRespawn = true,
	ShowQueuePop = true,
	HelpMessageVersion = 3,
	MoviesSeen = {},
	MovieFilter2 = "Never",
	LastRevision = 0,
	DebugMode = false,
	DebugLevel = 1,
	RoleSpecAlert = true,
	CheckGear = true,
	WorldBossAlert = false,
	WorldBuffAlert = false,
	BadTimerAlert = false,
	BadIDAlert = false,
	AutoAcceptFriendInvite = false,
	AutoAcceptGuildInvite = false,
	FakeBWVersion = false,
	AITimer = true,
	ShortTimerText = true,
	ChatFrame = "DEFAULT_CHAT_FRAME",
	CoreSavedRevision = 1,
	SilentMode = false,
	ReportRecount = false,
	ReportSkada = false,
	PerCharacterSettings = false,
}

DBM.Mods = {}
DBM.ModLists = {}
local checkDuplicateObjects = {}

------------------------
-- Global Identifiers --
------------------------
DBM_DISABLE_ZONE_DETECTION = newproxy(false)
DBM_OPTION_SPACER = newproxy(false)

--------------
--  Privates  --
--------------
private.modSyncSpam = {}
private.updateFunctions = {}
--Raid Leader Disable variables
private.statusGuildDisabled, private.statusWhisperDisabled, private.raidIconsDisabled, private.chatBubblesDisabled = false, false, false, false

--------------
--  Locals  --
--------------
local bossModPrototype = {}
local mainFrame, unitMainFrame = CreateFrame("Frame", "DBMMainFrame"), CreateFrame("Frame", "DBMUnitMainFrame")
local playerName = UnitName("player")
local playerLevel = UnitLevel("player")
local playerRealm = GetRealmName()
--local lastCombatStarted = GetTime()
local chatPrefix = "<Deadly Boss Mods> "
local chatPrefixShort = "<" .. L.DBM .. "> "
local usedProfile = "Default"
local dbmIsEnabled = true
private.dbmIsEnabled = dbmIsEnabled
-- Table variables
local newerVersionPerson, cSyncSender, iconSetRevision, iconSetPerson, loadcIds, inCombat, oocBWComms, combatInfo, bossIds, raid, autoRespondSpam, queuedBattlefield, bossHealth, bossHealthuIdCache, lastBossEngage, lastBossDefeat = {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}
-- False variables
local voiceSessionDisabled, targetEventsRegistered, combatInitialized, healthCombatInitialized, watchFrameRestore, bossuIdFound, timerRequestInProgress, encounterInProgress = false, false, false, false, false, false, false, false
-- Nil variables
local currentModProfileScope, currentModProfileName, currentSpecID, currentSpecName, currentSpecGroup, pformat, loadOptions, checkWipe, checkBossHealth, checkCustomBossHealth, fireEvent, LastInstanceType, breakTimerStart, AddMsg, delayedFunction, handleSync, savedDifficulty, difficultyText, difficultyIndex, encounterDifficulty, encounterDifficultyText, encounterDifficultyIndex, lastGroupLeader
-- 0 variables
local dbmToc, cSyncReceived, showConstantReminder, updateNotificationDisplayed, LastGroupSize = 0, 0, 0, 0
local LastInstanceMapID = -1
local LastInstanceZoneName = ""
local SWFilterDisabled = 12
local iconFolder = "Interface\\AddOns\\DBM-Core\\icon\\"

local bannedMods = { -- a list of "banned" (meaning they are replaced by another mod or discontinued). These mods will not be loaded by DBM (and they wont show up in the GUI)
	"DBM_API",
	"DBM-Outlands",
	"DBM-Battlegrounds", --replaced by DBM-PvP
	"DBM-Profiles" -- replaced by inline module since 7.00
}

--[InstanceID]={level,zoneType}
--zoneType: 1 = outdoor, 2 = dungeon, 3 = raid
local instanceDifficultyBylevel = {
	--World
	[27]={60, 1},[35]={60, 1},[44]={60, 1},[122]={60, 1},[182]={60, 1},--Eastern Kingdoms and Kalimdor world bosses.
	[162]={70, 1},[466]={70, 1},[474]={70, 1},[482]={70, 1},--Outlands World Bosses
	--Raids
	[718]={60, 3},[767]={60, 3},[756]={60, 3},[697]={60, 3},[698]={60, 3},--Classic Raids
	[797]={70, 3},[776]={70, 3},[800]={70, 3},[777]={70, 3},[780]={70, 3},[781]={70, 3},[790]={70, 3},[783]={70, 3},[782]={70, 3},--BC Raids
	[532]={80, 3},[610]={80, 3},[544]={80, 3},[528]={80, 3},[605]={80, 3},[536]={80, 3},[719]={80, 3},[530]={80, 3},[533]={80, 3},--Wrath Raids
	--Dungeons
	[700]={45, 2},[681]={18, 2},[751]={52, 2},[766]={60, 2},[764]={60, 2},[705]={60, 2},[722]={60, 2},[687]={54, 2},[763]={45, 2},[761]={47, 2},[688]={60, 2},[692]={34, 2},[693]={52, 2},[689]={32, 2},[762]={42, 2},[750]={27, 2},[757]={25, 2},[691]={32, 2},[765]={30, 2},--Classic Dungeons
	[711]={70, 2},[723]={70, 2},[724]={70, 2},[725]={70, 2},[726]={70, 2},[727]={70, 2},[728]={70, 2},[729]={70, 2},[730]={70, 2},[731]={70, 2},[732]={70, 2},[733]={70, 2},[734]={70, 2},[735]={70, 2},[798]={70, 2},[799]={70, 2},--BC Dungeons
	[523]={80, 2},[534]={80, 2},[522]={80, 2},[535]={80, 2},[531]={80, 2},[526]={80, 2},[527]={80, 2},[521]={80, 2},[529]={80, 2},[524]={80, 2},[525]={80, 2},[537]={80, 2},[603]={80, 2},[602]={80, 2},[604]={80, 2},[543]={80, 2},--Wrath Dungeons
}

-----------------
--  Libraries  --
-----------------
local LibStub = _G["LibStub"]
local AceTimer = LibStub("AceTimer-3.0")
local LGT = LibStub("LibGroupTalents-1.0", true)

--------------------------------------------------------
--  Cache frequently used global variables in locals  --
--------------------------------------------------------
local DBM = DBM
-- these global functions are accessed all the time by the event handler
-- so caching them is worth the effort
local ipairs, pairs, next = ipairs, pairs, next
local tonumber, tostring = tonumber, tostring
local tinsert, tremove, twipe, tsort, tconcat = table.insert, table.remove, table.wipe, table.sort, table.concat
local type, select = type, select
local GetTime = GetTime
local bband = bit.band
local mabs, floor, mhuge, mmin, mmax, mrandom = math.abs, math.floor, math.huge, math.min, math.max, math.random
local GetNumGroupMembers, GetNumSubgroupMembers, GetNumPartyMembers, GetNumRaidMembers, GetRaidRosterInfo = private.GetNumGroupMembers, private.GetNumSubgroupMembers, GetNumPartyMembers, GetNumRaidMembers, GetRaidRosterInfo -- with compat.lua
local UnitName, GetUnitName = UnitName, GetUnitName
local IsInRaid, IsInGroup, IsInInstance, IsOutdoors = private.IsInRaid, private.IsInGroup, IsInInstance, IsOutdoors -- with compat.lua
local UnitAffectingCombat, InCombatLockdown, IsFalling, UnitPlayerOrPetInRaid, UnitPlayerOrPetInParty = UnitAffectingCombat, InCombatLockdown, IsFalling, UnitPlayerOrPetInRaid, UnitPlayerOrPetInParty
local UnitGUID, UnitHealth, UnitHealthMax, UnitBuff, UnitDebuff, UnitAura = UnitGUID, UnitHealth, UnitHealthMax, UnitBuff, UnitDebuff, UnitAura
local UnitExists, UnitIsDead, UnitIsFriend, UnitIsUnit = UnitExists, UnitIsDead, UnitIsFriend, UnitIsUnit
local GetSpellInfo, GetSpellTexture, GetSpellCooldown = GetSpellInfo, GetSpellTexture, GetSpellCooldown
local GetInstanceInfo = GetInstanceInfo
local GetActiveTalentGroup = GetActiveTalentGroup
local GetMapInfo, GetCurrentMapDungeonLevel, DungeonUsesTerrainMap, GetPlayerMapPosition, SetMapToCurrentZone = GetMapInfo, GetCurrentMapDungeonLevel, DungeonUsesTerrainMap, GetPlayerMapPosition, SetMapToCurrentZone
local UnitDetailedThreatSituation = UnitDetailedThreatSituation
local UnitIsPartyLeader, UnitIsRaidOfficer = UnitIsPartyLeader, UnitIsRaidOfficer
local PlaySoundFile, PlaySound = PlaySoundFile, PlaySound

local SendAddonMessage = SendAddonMessage

-- for Phanx' Class Colors
local RAID_CLASS_COLORS = CUSTOM_CLASS_COLORS or RAID_CLASS_COLORS

---------------------------
--  Retail API backport  --
---------------------------
-- prevent other addons from messing with the global function from compat.lua
function DBM:tIndexOf(tbl, item)
	return private.tIndexOf(tbl, item)
end

function DBM:IsInGroup()
	return private.IsInGroup()
end

function DBM:IsInRaid()
	return private.IsInRaid()
end

function DBM:GetNumSubgroupMembers()
	return private.GetNumSubgroupMembers()
end

function DBM:GetNumGroupMembers()
	return private.GetNumGroupMembers()
end

---------------------------------
--  General (local) functions  --
---------------------------------
-- checks if a given value is in an array
-- returns true if it finds the value, false otherwise
local function checkEntry(t, val)
	for _, v in ipairs(t) do
		if v == val then
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

local function OrderedTable()
	local nextkey, firstkey = {}, {}
	nextkey[nextkey] = firstkey

	local function onext(self, key)
		while key ~= nil do
			key = nextkey[key]
			local val = self[key]
			if val ~= nil then
				return key, val
			end
		end
	end

	local selfmeta = firstkey
	selfmeta.__nextkey = nextkey

	function selfmeta:__newindex(key, val)
		rawset(self, key, val)
		if nextkey[key] == nil then
			nextkey[nextkey[nextkey]] = key
			nextkey[nextkey] = key
		end
	end

	function selfmeta:__pairs() return
		onext, self, firstkey
	end

	return setmetatable({}, selfmeta)
end

--Whisper/Whisper Sync filter function
local function checkForSafeSender(sender, checkFriends, checkGuild, filterRaid)
	if checkFriends then
		--Check if it's a non bnet friend
		for i = 1, GetNumFriends() do
			local name = GetFriendInfo(i)
			if name == sender then
				return not (filterRaid and DBM:GetRaidUnitId(name)) -- Person is in raid group and filter raid enabled
			end
		end
	end
	--Check Guildies (not used by whisper syncs, but used by status whispers)
	if checkGuild then
		local totalMembers = GetNumGuildMembers()
		for i = 1, totalMembers do
			local name = GetGuildRosterInfo(i)
			if not name then break end
			if name == sender then
				return not (filterRaid and DBM:GetRaidUnitId(name))
			end
		end
	end
	return false
end

-- automatically sends an addon message to the appropriate channel (BATTLEGROUND, RAID or PARTY)
local function sendSync(prefix, msg)
	if dbmIsEnabled or prefix == "DBMv4-V" or prefix == "DBMv4-H" then--Only show version checks if force disabled, nothing else
		msg = msg or ""
		local zoneType = select(2, IsInInstance())
		if zoneType == "pvp" or zoneType == "arena" then
			SendAddonMessage(prefix, msg, "BATTLEGROUND")
		elseif GetRealNumRaidMembers() > 0 then
			SendAddonMessage(prefix, msg, "RAID")
		elseif GetRealNumPartyMembers() > 0 then
			SendAddonMessage(prefix, msg, "PARTY")
		else
			handleSync("SOLO", playerName, prefix, strsplit("\t", msg))
		end
		DBM:Debug(prefix.." "..tostring(msg):gsub("\t", " "), 3)
	end
end
private.sendSync = sendSync

local function sendGuildSync(prefix, msg)
	if IsInGuild() and (dbmIsEnabled or prefix == "DBMv4-V" or prefix == "DBMv4-H") then--Only show version checks if force disabled, nothing else
		msg = msg or ""
		SendAddonMessage(prefix, msg, "GUILD")--Even guild syncs send realm so we can keep antispam the same across realid as well.
	end
end
private.sendGuildSync = sendGuildSync

--Reworked BNet friends to ingame friends since BNet doesn't exist on private servers
--Sync Object specifically for out in the world sync messages that have different rules than standard syncs
local function SendWorldSync(self, prefix, msg, noBNet)
	if not dbmIsEnabled then return end--Block all world syncs if force disabled
	DBM:Debug("SendWorldSync running for "..prefix)
	if GetNumRaidMembers() > 0 then
		SendAddonMessage(DBMPrefix .. "-" .. prefix, msg, "RAID")
	elseif IsInGroup(1) then
		SendAddonMessage(DBMPrefix .. "-" .. prefix, msg, "PARTY")
	else--for solo raid
		handleSync("SOLO", playerName, DBMPrefix .. "-" .. prefix, strsplit("\t", msg))
	end
	if IsInGuild() then
		SendAddonMessage(DBMPrefix .. "-" .. prefix, msg, "GUILD")--Even guild syncs send realm so we can keep antispam the same across realid as well.
	end
	if self.Options.EnableWBSharing and not noBNet then
		local _, numFriendsOnline = GetNumFriends()
		for i = 1, numFriendsOnline do
			local name, _, _, _, isOnline = GetFriendInfo(i)
			if name and isOnline then
				SendAddonMessage(DBMPrefix .. "-" .. prefix, msg, "WHISPER", name)--Just send users realm for pull, so we can eliminate connectedServers checks on sync handler
			end
		end
	end
end

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

function DBM:strFromTime(time)
	return strFromTime(time)
end

do
	-- fail-safe format, replaces missing arguments with unknown
	-- note: doesn't handle cases like %%%s correctly at the moment (should become %unknown, but becomes %%s)
	-- also, the end of the format directive is not detected in all cases, but handles everything that occurs in our boss mods ;)
	--> not suitable for general-purpose use, just for our warnings and timers (where an argument like a spell-target might be nil due to missing target information from unreliable detection methods)
	local function replace(cap1)
		return cap1 == "%" and CL.UNKNOWN
	end

	function pformat(fstr, ...)
		local ok, str = pcall(format, fstr, ...)
		return ok and str or fstr:gsub("(%%+)([^%%%s%)<]+)", replace):gsub("%%%%", "%%")
	end
end

-- sends a whisper to a player by his or her character name or BNet presence id
-- returns true if the message was sent, nil otherwise
local function sendWhisper(target, msg)
	if type(target) == "number" then
		if not BNIsSelf(target) then -- Never send BNet whispers to ourselves
			BNSendWhisper(target, msg)
		end
	elseif type(target) == "string" then
		SendChatMessage(msg, "WHISPER", nil, target) -- Whispering to ourselves here is okay and somewhat useful for whisper-warnings
	end
end

--Another custom server name strip function that first strips out the "><" DBM wraps around playernames
local function stripServerName(cap)
	return DBM:GetShortServerName(cap:sub(2, -2))
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

	function argsMT.__index:IsSpellID(...)
		return DBM:tIndexOf({...}, args.spellId) ~= nil
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
		local isUnitEvent = event:sub(0, 5) == "UNIT_" and event ~= "UNIT_DIED" and event ~= "UNIT_DESTROYED"
		if self == mainFrame and isUnitEvent then
			-- UNIT_* events that come from mainFrame are _UNFILTERED variants and need their suffix
			event = event .. "_UNFILTERED"
			isUnitEvent = false -- not actually a real unit id for this function...
		end
		if not registeredEvents[event] or not dbmIsEnabled then return end
		for _, v in ipairs(registeredEvents[event]) do
			local zones = v.zones
			local handler = v[event]
			local modEvents = v.registeredUnitEvents
			--if isUnitEvent --[[and v.id == DBM.currentModId]] then -- Me and Kader initially coded a current mod check to save some CPU but noticed it would not work with RegisterEvents (to be listened out of modCombat) since currentModId is being set on StartCombat
				-- Workaround for retail-like mod:RegisterEvents("UNIT_SPELLCAST_START boss1"). Check if we have valid units registered and filter out everything else.
				-- v is mod here... so we check registered mods for registered events with registered uIds (v.registeredUnitEvents[event]).
				-- then we check if we have our unit (args) in the table ... self.registeredUnitEvents[event] = args which is defined below
				--if modEvents and modEvents[event] and not checkEntry(modEvents[event], ...) then return end
			--end

			if not (isUnitEvent and modEvents and modEvents[event] and not checkEntry(modEvents[event], ...)) then
				if handler and (not zones or zones[LastInstanceMapID] or zones[LastInstanceZoneName]) and not (not v.isTrashModBossFightAllowed and v.isTrashMod and #inCombat > 0) then
					handler(v, ...)
				end
			end
		end
	end

	local registerUnitEvent, unregisterUnitEvent, registerSpellId, unregisterSpellId, registerCLEUEvent, unregisterCLEUEvent
	do
		function registerUnitEvent(mod, event, uIds)
			-- Since RegisterUnitEvent does not exist in WotLK, Unit Events will be registered only once in a dedicated frame, to avoid mainFrame logic in handleEvents.
			-- mod.RegisteredUnitEvents will also be saved differently, in a table of the Event with each uID in the value pair instead of event..uId strings.
			-- Register valid units for retail-like mod:RegisterEvents("UNIT_SPELLCAST_START boss1")
			mod.registeredUnitEvents = mod.registeredUnitEvents or {}
			if next(uIds) then
				registeredUnitEventIds[event] = (registeredUnitEventIds[event] or 0) + 1
				mod.registeredUnitEvents[event] = uIds
			end
			unitMainFrame:RegisterEvent(event)
		end

		function unregisterUnitEvent(mod, event, ...)
			for i = 1, select("#", ...) do
				local uId = select(i, ...)
				if not uId then break end
				local refs = (registeredUnitEventIds[event] or 1) - 1
				registeredUnitEventIds[event] = refs
				if refs <= 0 then
					registeredUnitEventIds[event] = nil
					if unitMainFrame then
						unitMainFrame:UnregisterEvent(event)
					end
				end
				if mod.registeredUnitEvents and mod.registeredUnitEvents[event] then
					for k, v in ipairs(mod.registeredUnitEvents[event]) do
						if v == uId then
							tremove(mod.registeredUnitEvents[event], k)
							break
						end
					end
					-- Remove empty event uId table
					if #mod.registeredUnitEvents[event] <= 0 then
						mod.registeredUnitEvents[event] = nil
					end
					-- Remove empty registered unit events table
					local count = 0
					for _ in pairs(mod.registeredUnitEvents) do
						count = count + 1
					end
					if count <= 0 then
						mod.registeredUnitEvents = nil
					end
				end
			end
			for i = #registeredEvents[event], 1, -1 do
				if registeredEvents[event][i] == mod then
					tremove(registeredEvents[event], i)
				end
			end
			if #registeredEvents[event] == 0 then
				registeredEvents[event] = nil
			end
		end

		function registerSpellId(event, spellId)
			if type(spellId) == "string" then--Something is screwed up, like SPELL_AURA_APPLIED DOSE
				DBM:Debug("DBM RegisterEvents Warning: "..spellId.." is not a number!")
				return
			end
			if spellId and not DBM:GetSpellInfo(spellId) then
				DBM:Debug("DBM RegisterEvents Warning: "..spellId.." spell id does not exist!")
				return
			end
			if not registeredSpellIds[event] then
				registeredSpellIds[event] = {}
			end
			registeredSpellIds[event][spellId] = (registeredSpellIds[event][spellId] or 0) + 1
		end

		function unregisterSpellId(event, spellId)
			if not registeredSpellIds[event] then return end
			if spellId and not DBM:GetSpellInfo(spellId) then
				DBM:Debug("DBM unregisterSpellId Warning: "..spellId.." spell id does not exist!")
				return
			end
			local refs = (registeredSpellIds[event][spellId] or 1) - 1
			registeredSpellIds[event][spellId] = refs
			if refs <= 0 then
				registeredSpellIds[event][spellId] = nil
			end
		end

		--There are 2 tables. unfilteredCLEUEvents and registeredSpellIds table.
		--unfilteredCLEUEvents saves UNFILTERED cleu event count. this is count table to prevent bad unregister.
		--registeredSpellIds tables filtered table. this saves event and spell ids. works smiliar with unfilteredCLEUEvents table.
		function registerCLEUEvent(mod, event)
			local argTable = {strsplit(" ", event)}
			-- filtered cleu event. save information in registeredSpellIds table.
			if #argTable > 1 then
				event = argTable[1]
				for i = 2, #argTable do
					registerSpellId(event, tonumber(argTable[i]))
				end
			-- no args. works as unfiltered. save information in unfilteredCLEUEvents table.
			else
				unfilteredCLEUEvents[event] = (unfilteredCLEUEvents[event] or 0) + 1
			end
			registeredEvents[event] = registeredEvents[event] or {}
			tinsert(registeredEvents[event], mod)
		end

		function unregisterCLEUEvent(mod, event)
			local argTable = {strsplit(" ", event)}
			local eventCleared = false
			-- filtered cleu event. save information in registeredSpellIds table.
			if #argTable > 1 then
				event = argTable[1]
				for i = 2, #argTable do
					unregisterSpellId(event, tonumber(argTable[i]))
				end
				local remainingSpellIdCount = 0
				if registeredSpellIds[event] then
					for _, _ in pairs(registeredSpellIds[event]) do
						remainingSpellIdCount = remainingSpellIdCount + 1
					end
				end
				if remainingSpellIdCount == 0 then
					registeredSpellIds[event] = nil
					-- if unfilteredCLEUEvents and registeredSpellIds do not exists, clear registeredEvents.
					if not unfilteredCLEUEvents[event] then
						eventCleared = true
					end
				end
			-- no args. works as unfiltered. save information in unfilteredCLEUEvents table.
			else
				local refs = (unfilteredCLEUEvents[event] or 1) - 1
				unfilteredCLEUEvents[event] = refs
				if refs <= 0 then
					unfilteredCLEUEvents[event] = nil
					-- if unfilteredCLEUEvents and registeredSpellIds do not exists, clear registeredEvents.
					if not registeredSpellIds[event] then
						eventCleared = true
					end
				end
			end
			for i = #registeredEvents[event], 1, -1 do
				if registeredEvents[event][i] == mod then
					registeredEvents[event][i] = {}
					break
				end
			end
			if eventCleared then
				registeredEvents[event] = nil
			end
		end
	end

	-- UNIT_* events are special: they can take 'parameters' like this: "UNIT_HEALTH boss1 boss2" which only trigger the event for the given unit ids
	function DBM:RegisterEvents(...)
		for _, event in ipairs({...}) do
			-- spell events with special care.
			if event:sub(0, 6) == "SPELL_" and event ~= "SPELL_NAME_UPDATE" or event:sub(0, 6) == "RANGE_" or event:sub(0, 6) == "SWING_" or event == "UNIT_DIED" or event == "UNIT_DESTROYED" or event == "PARTY_KILL" then
				registerCLEUEvent(self, event)
			else
				local eventWithArgs = event
				if event:sub(0, 5) == "UNIT_" then
					local uIds = {strsplit(" ", event)}
					event = tremove(uIds, 1)
					if event:sub(-11) == "_UNFILTERED" then
						-- we really want *all* unit ids
						mainFrame:RegisterEvent(event:sub(0, -12))
					else
						registerUnitEvent(self, event, uIds)
					end
				-- spell events with filter
				else
					-- normal events
					mainFrame:RegisterEvent(event)
				end
				registeredEvents[eventWithArgs] = registeredEvents[eventWithArgs] or {}
				tinsert(registeredEvents[eventWithArgs], self)
				if event ~= eventWithArgs then
					registeredEvents[event] = registeredEvents[event] or {}
					tinsert(registeredEvents[event], self)
				end
			end
		end
	end

	local function unregisterUEvent(mod, event)
		if event:sub(0, 5) == "UNIT_" and event ~= "UNIT_DIED" and event ~= "UNIT_DESTROYED" then
			local eventName, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8 = strsplit(" ", event)
			if eventName:sub(eventName:len() - 10) == "_UNFILTERED" then
				mainFrame:UnregisterEvent(eventName:sub(0, -12))
			else
				unregisterUnitEvent(mod, eventName, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8)
			end
		end
	end

	local function findRealEvent(t, val)
		for _, v in ipairs(t) do
			local event = strsplit(" ", v)
			if event == val then
				return v
			end
		end
	end

	function DBM:UnregisterInCombatEvents(srmOnly, srmIncluded)
		for event, mods in pairs(registeredEvents) do
			if srmOnly then
				local i = 1
				while mods[i] do
					if mods[i] == self and event == "SPELL_AURA_REMOVED" then
						local findEvent = findRealEvent(self.inCombatOnlyEvents, "SPELL_AURA_REMOVED")
						if findEvent then
							unregisterCLEUEvent(self, findEvent)
							break
						end
					end
					i = i +1
				end
			elseif (event:sub(0, 6) == "SPELL_"and event ~= "SPELL_NAME_UPDATE" or event:sub(0, 6) == "RANGE_") then
				local i = 1
				while mods[i] do
					if mods[i] == self and (srmIncluded or event ~= "SPELL_AURA_REMOVED") then
						local findEvent = findRealEvent(self.inCombatOnlyEvents, event)
						if findEvent then
							unregisterCLEUEvent(self, findEvent)
							break
						end
					end
					i = i +1
				end
			else
				local match = false
				for i = #mods, 1, -1 do
					if mods[i] == self and checkEntry(self.inCombatOnlyEvents, event) then
						tremove(mods, i)
						match = true
					end
				end
				if #mods == 0 or (match and event:sub(0, 5) == "UNIT_" and event:sub(0, -10) ~= "_UNFILTERED" and event ~= "UNIT_DIED" and event ~= "UNIT_DESTROYED") then -- unit events have their own reference count
					unregisterUEvent(self, event)
				end
				if #mods == 0 then
					registeredEvents[event] = nil
				end
			end
		end
	end

	function DBM:RegisterShortTermEvents(...)
		DBM:Debug("RegisterShortTermEvents fired", 2)
		local _shortTermRegisterEvents = {...}
		for k, v in pairs(_shortTermRegisterEvents) do
			if v:sub(0, 5) == "UNIT_" and v:sub(v:len() - 10) ~= "_UNFILTERED" and not v:find(" ") and v ~= "UNIT_DIED" and v ~= "UNIT_DESTROYED" then
				-- legacy event, oh noes
				_shortTermRegisterEvents[k] = v--[[ .. " boss1 boss2 boss3 boss4 boss5 target focus"]] -- don't preassign units if the event does not state them. LK Ice Spheres scanner requires listening to the entire raid units
			end
		end
		self.shortTermEventsRegistered = 1
		self:RegisterEvents(unpack(_shortTermRegisterEvents))
		-- Fix so we can register multiple short term events. Use at your own risk, as unsucribing will cause
		-- all short term events to unregister.
		if not self.shortTermRegisterEvents then
			self.shortTermRegisterEvents = {}
		end
		for k, v in pairs(_shortTermRegisterEvents) do
			if #self.shortTermRegisterEvents ~= 0 then
				if not checkEntry(self.shortTermRegisterEvents, v) then -- check to prevent event duplication
					tinsert(self.shortTermRegisterEvents, v) -- use tinsert instead to achieve numeric order for checkEntry ipairs to work
				end
			else
				self.shortTermRegisterEvents[k] = v
			end
		end
		-- End fix
	end

	function DBM:UnregisterShortTermEvents()
		DBM:Debug("UnregisterShortTermEvents fired", 2)
		if self.shortTermRegisterEvents then
			DBM:Debug("UnregisterShortTermEvents found registered shortTermRegisterEvents", 2)
			for event, mods in pairs(registeredEvents) do
				if event:sub(0, 6) == "SPELL_" or event:sub(0, 6) == "RANGE_" then
					local i = 1
					while mods[i] do
						if mods[i] == self then
							local findEvent = findRealEvent(self.shortTermRegisterEvents, event)
							if findEvent then
								unregisterCLEUEvent(self, findEvent)
								break
							end
						end
						i = i +1
					end
				else
					local match = false
					for i = #mods, 1, -1 do
						if mods[i] == self then
							local findEvent = findRealEvent(self.shortTermRegisterEvents, event)
							if findEvent then
								tremove(mods, i)
								match = true
							end
						end
					end
					if #mods == 0 or (match and event:sub(0, 5) == "UNIT_" and event:sub(0, -10) ~= "_UNFILTERED" and event ~= "UNIT_DIED" and event ~= "UNIT_DESTROYED") then
						unregisterUEvent(self, event)
						DBM:Debug("unregisterUEvent for unit event "..event.." unregistered", 3)
					end
					if #mods == 0 then
						registeredEvents[event] = nil
						DBM:Debug("registeredEvents for event "..event.." nilled", 3)
					end
				end
			end
			self.shortTermEventsRegistered = nil
			self.shortTermRegisterEvents = nil
		end
	end

	DBM:RegisterEvents("ADDON_LOADED")

	function DBM:FilterRaidBossEmote(msg, ...)
		return handleEvent(nil, "CHAT_MSG_RAID_BOSS_EMOTE_FILTERED", msg:gsub("\124c%x+(.-)\124r", "%1"), ...)
	end

	local noArgTableEvents = {
		SWING_DAMAGE = true,
		SWING_MISSED = true,
		RANGE_DAMAGE = true,
		RANGE_MISSED = true,
		SPELL_DAMAGE = true,
		SPELL_BUILDING_DAMAGE = true,
		SPELL_MISSED = true,
		SPELL_ABSORBED = true,
		SPELL_HEAL = true,
		SPELL_ENERGIZE = true,
		SPELL_PERIODIC_ENERGIZE = true,
		SPELL_PERIODIC_MISSED = true,
		SPELL_PERIODIC_DAMAGE = true,
		SPELL_PERIODIC_DRAIN = true,
		SPELL_PERIODIC_LEECH = true,
		SPELL_DRAIN = true,
		SPELL_LEECH = true,
		SPELL_CAST_FAILED = true
	}
	function DBM:COMBAT_LOG_EVENT_UNFILTERED(timestamp, event, sourceGUID, sourceName, sourceFlags, destGUID, destName, destFlags, extraArg1, extraArg2, extraArg3, extraArg4, extraArg5, extraArg6, extraArg7, extraArg8, extraArg9, extraArg10, extraArg11, extraArg12)
		if not registeredEvents[event] then return end
		local eventSub6 = event:sub(0, 6)
		if (eventSub6 == "SPELL_" or eventSub6 == "RANGE_") --[[and not unfilteredCLEUEvents[event]--]] and registeredSpellIds[event] then -- why is unfilteredCLEUEvents event count even needed here? Just broke the function altogether
			if not registeredSpellIds[event][extraArg1] then return end
		end
		-- process some high volume events without building the whole table which is somewhat faster
		-- this prevents work-around with mods that used to have their own event handler to prevent this overhead
		if noArgTableEvents[event] then
			return handleEvent(nil, event, sourceGUID, sourceName, sourceFlags, destGUID, destName, destFlags, extraArg1, extraArg2, extraArg3, extraArg4, extraArg5, extraArg6, extraArg7, extraArg8, extraArg9, extraArg10, extraArg11, extraArg12)
		else
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
			if eventSub6 == "SPELL_" then
				args.spellId, args.spellName, args.spellSchool = extraArg1, extraArg2, extraArg3
				if event == "SPELL_AURA_APPLIED" or event == "SPELL_AURA_REFRESH" or event == "SPELL_AURA_REMOVED" or event == "SPELL_AURA_BROKEN" then
					args.auraType = extraArg4
					if not args.sourceName then
						args.sourceName = args.destName
						args.sourceGUID = args.destGUID
						args.sourceFlags = args.destFlags
					end
				elseif event == "SPELL_AURA_APPLIED_DOSE" or event == "SPELL_AURA_REMOVED_DOSE" then
					args.auraType = extraArg4
					args.amount = extraArg5
					if not args.sourceName then
						args.sourceName = args.destName
						args.sourceGUID = args.destGUID
						args.sourceFlags = args.destFlags
					end
				elseif event == "SPELL_CAST_FAILED" then
					args.failedType = extraArg4
				elseif event == "SPELL_INTERRUPT" or event == "SPELL_DISPEL_FAILED" then
					args.extraSpellId, args.extraSpellName, args.extraSpellSchool = extraArg4, extraArg5, extraArg6
				elseif event == "SPELL_EXTRA_ATTACKS" then
					args.amount = extraArg4
				elseif event == "SPELL_DISPEL" or event == "SPELL_STOLEN" or event == "SPELL_AURA_BROKEN_SPELL" then
					args.extraSpellId, args.extraSpellName, args.extraSpellSchool, args.auraType = extraArg4, extraArg5, extraArg6, extraArg7
				end
			elseif event == "DAMAGE_SHIELD" or event == "DAMAGE_SPLIT" then
				args.spellId, args.spellName, args.spellSchool, args.amount, args.overkill, args.school, args.resisted, args.blocked, args.absorbed, args.critical, args.glancing, args.crushing = extraArg1, extraArg2, extraArg3, extraArg4, extraArg5, extraArg6, extraArg7, extraArg8, extraArg9, extraArg10, extraArg11, extraArg12
			elseif event == "DAMAGE_SHIELD_MISSED" then
				args.spellId, args.spellName, args.spellSchool, args.missType = extraArg1, extraArg2, extraArg3, extraArg4
			elseif event == "ENCHANT_APPLIED" or event == "ENCHANT_REMOVED" then
				args.spellName,	args.itemId, args.itemName = extraArg1, extraArg2, extraArg3
			elseif event == "UNIT_DIED" or event == "UNIT_DESTROYED" then
				args.sourceName = args.destName
				args.sourceGUID = args.destGUID
				args.sourceFlags = args.destFlags
			elseif event == "ENVIRONMENTAL_DAMAGE" then
				args.environmentalType, args.amount, args.overkill, args.school, args.resisted, args.blocked, args.absorbed, args.critical, args.glancing, args.crushing = extraArg1, extraArg2, extraArg3, extraArg4, extraArg5, extraArg6, extraArg7, extraArg8, extraArg9, extraArg10
				args.spellName = _G["ACTION_"..event.."_"..args.environmentalType]
				args.spellSchool = args.school
			end
			return handleEvent(nil, event, args)
		end
	end
	unitMainFrame:SetScript("OnEvent", handleEvent)
	mainFrame:SetScript("OnEvent", handleEvent)
end

--------------
--  OnLoad  --
--------------
do
	local isLoaded = false
	local onLoadCallbacks, disabledMods = {}, {}

	local function runDelayedFunctions(self)
		--Check if voice pack missing
		local activeVP = self.Options.ChosenVoicePack2
		if activeVP ~= "None" then
			if not self.VoiceVersions[activeVP] or (self.VoiceVersions[activeVP] and self.VoiceVersions[activeVP] == 0) then--A voice pack is selected that does not belong
				voiceSessionDisabled = true
				--Since VEM is now bundled, users may elect to disable it by simply disabling the module
				--let's not nag them, only remind for 3rd party because then we know user installed it themselves
				if activeVP ~= "VEM" then
					AddMsg(self, L.VOICE_MISSING)
				end
			end
		end
		--Check if any of countdown sounds are using missing voice pack
		local found1, found2, found3, found4 = false, false, false, false
		for _, count in pairs(DBM:GetCountSounds()) do
			local voice = count.value
			if voice == self.Options.CountdownVoice then
				found1 = true
			end
			if voice == self.Options.CountdownVoice2 then
				found2 = true
			end
			if voice == self.Options.CountdownVoice3 then
				found3 = true
			end
			if voice == self.Options.PullVoice then
				found4 = true
			end
		end
		if not found1 then
			AddMsg(self, L.VOICE_COUNT_MISSING:format(1, self.DefaultOptions.CountdownVoice))
			self.Options.CountdownVoice = self.DefaultOptions.CountdownVoice
		end
		if not found2 then
			AddMsg(self, L.VOICE_COUNT_MISSING:format(2, self.DefaultOptions.CountdownVoice2))
			self.Options.CountdownVoice2 = self.DefaultOptions.CountdownVoice2
		end
		if not found3 then
			AddMsg(self, L.VOICE_COUNT_MISSING:format(3, self.DefaultOptions.CountdownVoice3))
			self.Options.CountdownVoice3 = self.DefaultOptions.CountdownVoice3
		end
		if not found4 then
			AddMsg(self, L.VOICE_COUNT_MISSING:format(4, self.DefaultOptions.PullVoice))
			self.Options.PullVoice = self.DefaultOptions.PullVoice
		end
		self:BuildVoiceCountdownCache()
		--Break timer recovery
		--Try local settings
		if self.Options.RestoreSettingBreakTimer then
			local timer, startTime = string.split("/", self.Options.RestoreSettingBreakTimer)
			local elapsed = time() - tonumber(startTime)
			local remaining = timer - elapsed
			if remaining > 0 then
				breakTimerStart(DBM, remaining, playerName)
			else--It must have ended while we were offline, kill variable.
				self.Options.RestoreSettingBreakTimer = nil
			end
		end
		sendGuildSync("DBMv4-GH", "Hi!")
		if not savedDifficulty or not difficultyText or not difficultyIndex then--prevent error if savedDifficulty or difficultyText is nil
			savedDifficulty, difficultyText, difficultyIndex, LastGroupSize = self:GetCurrentInstanceDifficulty()
		end
		DBM:Debug("Delayed functions finished", 3)
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
			dbmToc = tonumber(GetAddOnMetadata("DBM-Core", "X-Min-Interface"))
			isLoaded = true
			for _, v in ipairs(onLoadCallbacks) do
				xpcall(v, geterrorhandler())
			end
			onLoadCallbacks = nil
			loadOptions(self)
			DBT:LoadOptions("DBM")
			self.AddOns = {}
			private:OnModuleLoad()
			self.Arrow:LoadPosition()
			-- LibDBIcon setup
			if type(DBM_MinimapIcon) ~= "table" then
				DBM_MinimapIcon = {}
			end
			if LibStub("LibDBIcon-1.0", true) then
				LibStub("LibDBIcon-1.0"):Register("DBM", private.dataBroker, DBM_MinimapIcon)
			end
			self.Voices = { {text = "None",value = "None"}, }--Create voice table, with default "None" value
			self.VoiceVersions = {}
			for i = 1, GetNumAddOns() do
				local addonName, _, _, enabled = GetAddOnInfo(i)
				if GetAddOnMetadata(i, "X-DBM-Mod") then
					if enabled then
						if checkEntry(bannedMods, addonName) then
							AddMsg(self, "The mod " .. addonName .. " is deprecated and will not be available. Please remove the folder " .. addonName .. " from your Interface" .. (IsWindowsClient() and "\\" or "/") .. "AddOns folder to get rid of this message. Check for an updated version of " .. addonName .. " that is compatible with your game version.")
						else
							local minToc = tonumber(GetAddOnMetadata(i, "X-Min-Interface") or 0)

							tinsert(self.AddOns, {
								sort			= tonumber(GetAddOnMetadata(i, "X-DBM-Mod-Sort") or math.huge) or math.huge,
								type			= GetAddOnMetadata(i, "X-DBM-Mod-Type") or "OTHER",
								category		= GetAddOnMetadata(i, "X-DBM-Mod-Category") or "Other",
								statTypes		= GetAddOnMetadata(i, "X-DBM-StatTypes") or "",
								oldOptions		= tonumber(GetAddOnMetadata(i, "X-DBM-OldOptions") or 0) == 1,
								name			= GetAddOnMetadata(i, "X-DBM-Mod-Name") or "",
								zone			= {strsplit(",", GetAddOnMetadata(i, "X-DBM-Mod-LoadZone") or CL.UNKNOWN)},
								mapId			= {strsplit(",", GetAddOnMetadata(i, "X-DBM-Mod-MapID") or "")},
								realm			= {strsplit(",", GetAddOnMetadata(i, "X-DBM-Mod-LoadRealm") or "")},
								blockRealm		= {strsplit(",", GetAddOnMetadata(i, "X-DBM-Mod-BlockRealm") or "None")}, -- meant to prevent double load by blocking mod if it exists in different expansions
								subTabs			= GetAddOnMetadata(i, "X-DBM-Mod-SubCategoriesID") and {strsplit(",", GetAddOnMetadata(i, "X-DBM-Mod-SubCategoriesID"))} or GetAddOnMetadata(i, "X-DBM-Mod-SubCategories") and {strsplit(",", GetAddOnMetadata(i, "X-DBM-Mod-SubCategories"))},
								oneFormat		= tonumber(GetAddOnMetadata(i, "X-DBM-Mod-Has-Single-Format") or 0) == 1, -- Deprecated
								hasLFR			= tonumber(GetAddOnMetadata(i, "X-DBM-Mod-Has-LFR") or 0) == 1, -- Deprecated
								hasChallenge	= tonumber(GetAddOnMetadata(i, "X-DBM-Mod-Has-Challenge") or 0) == 1, -- Deprecated
								hasHeroic		= tonumber(GetAddOnMetadata(i, "X-DBM-Mod-Has-Heroic-Mode") or 1) == 1, -- Deprecated
								noHeroic		= tonumber(GetAddOnMetadata(i, "X-DBM-Mod-No-Heroic") or 0) == 1, -- Deprecated
								hasMythic		= tonumber(GetAddOnMetadata(i, "X-DBM-Mod-Has-Mythic") or 0) == 1, -- Deprecated
								hasTimeWalker	= tonumber(GetAddOnMetadata(i, "X-DBM-Mod-Has-TimeWalker") or 0) == 1, -- Deprecated
								noStatistics	= tonumber(GetAddOnMetadata(i, "X-DBM-Mod-No-Statistics") or 0) == 1,
								isWorldBoss		= tonumber(GetAddOnMetadata(i, "X-DBM-Mod-World-Boss") or 0) == 1,
								isExpedition	= tonumber(GetAddOnMetadata(i, "X-DBM-Mod-Expedition") or 0) == 1,
								minRevision		= tonumber(GetAddOnMetadata(i, "X-DBM-Mod-MinCoreRevision") or 0),
								minExpansion	= tonumber(GetAddOnMetadata(i, "X-DBM-Mod-MinExpansion") or 0),
								minToc			= minToc,
								modId			= addonName,
							})
							for k, _ in ipairs(self.AddOns[#self.AddOns].zone) do
								self.AddOns[#self.AddOns].zone[k] = (self.AddOns[#self.AddOns].zone[k]):trim()
							end
							for j = #self.AddOns[#self.AddOns].mapId, 1, -1 do
								local id = tonumber(self.AddOns[#self.AddOns].mapId[j])
								if id then
									self.AddOns[#self.AddOns].mapId[j] = id
								else
									tremove(self.AddOns[#self.AddOns].mapId, j)
								end
							end
							for k, _ in ipairs(self.AddOns[#self.AddOns].realm) do
								self.AddOns[#self.AddOns].realm[k] = (self.AddOns[#self.AddOns].realm[k]):trim()
							end
							for k, _ in ipairs(self.AddOns[#self.AddOns].blockRealm) do
								self.AddOns[#self.AddOns].blockRealm[k] = (self.AddOns[#self.AddOns].blockRealm[k]):trim()
							end
							if self.AddOns[#self.AddOns].subTabs then
								local subTabs = self.AddOns[#self.AddOns].subTabs
								for k, _ in ipairs(subTabs) do
									self.AddOns[#self.AddOns].subTabs[k] = (subTabs[k]):trim()
								end
							end
							if GetAddOnMetadata(i, "X-DBM-Mod-LoadCID") then
								local idTable = {strsplit(",", GetAddOnMetadata(i, "X-DBM-Mod-LoadCID"))}
								for j = 1, #idTable do
									loadcIds[tonumber(idTable[j]) or ""] = addonName
								end
							end
						end
					else
						disabledMods[#disabledMods+1] = addonName
					end
				end
				if GetAddOnMetadata(i, "X-DBM-Voice") and enabled then
					if checkEntry(bannedMods, addonName) then
						AddMsg(self, "The mod " .. addonName .. " is deprecated and will not be available. Please remove the folder " .. addonName .. " from your Interface" .. (IsWindowsClient() and "\\" or "/") .. "AddOns folder to get rid of this message. Check for an updated version of " .. addonName .. " that is compatible with your game version.")
					else
						self:Schedule(0.01, function()
							local voiceValue = GetAddOnMetadata(i, "X-DBM-Voice-ShortName")
							local voiceVersion = tonumber(GetAddOnMetadata(i, "X-DBM-Voice-Version") or 0)
							if voiceVersion > 0 then--Do not insert voice version 0 into THIS table. 0 should be used by voice packs that insert only countdown
								tinsert(self.Voices, { text = GetAddOnMetadata(i, "X-DBM-Voice-Name"), value = voiceValue })
							end
							self.VoiceVersions[voiceValue] = voiceVersion
							self:Schedule(10, self.CheckVoicePackVersion, self, voiceValue)--Still at 1 since the count sounds won't break any mods or affect filter. V2 if support countsound path
							if GetAddOnMetadata(i, "X-DBM-Voice-HasCount") then--Supports adding countdown options, insert new countdown into table
								DBM:AddCountSound(GetAddOnMetadata(i, "X-DBM-Voice-Name"), "VP:"..voiceValue, "Interface\\AddOns\\DBM-VP"..voiceValue.."\\count\\")
							end
						end)
					end
				end
				if GetAddOnMetadata(i, "X-DBM-CountPack") and enabled ~= 0 then
					if checkEntry(bannedMods, addonName) then
						AddMsg(self, "The mod " .. addonName .. " is deprecated and will not be available. Please remove the folder " .. addonName .. " from your Interface" .. (IsWindowsClient() and "\\" or "/") .. "AddOns folder to get rid of this message. Check for an updated version of " .. addonName .. " that is compatible with your game version.")
					else
						local loaded = LoadAddOn(addonName)
						self:Schedule(0.01, function()
							local voiceGlobal = GetAddOnMetadata(i, "X-DBM-CountPack-GlobalName")
							local insertFunction = _G[voiceGlobal]
							if loaded and insertFunction then
								insertFunction()
							else
								self:Debug(addonName.." failed to load at time CountPack function "..voiceGlobal.."ran", 2)
							end
						end)
					end
				end
				if GetAddOnMetadata(i, "X-DBM-VictoryPack") and enabled then
					if checkEntry(bannedMods, addonName) then
						AddMsg(self, "The mod " .. addonName .. " is deprecated and will not be available. Please remove the folder " .. addonName .. " from your Interface" .. (IsWindowsClient() and "\\" or "/") .. "AddOns folder to get rid of this message. Check for an updated version of " .. addonName .. " that is compatible with your game version.")
					else
						local loaded = LoadAddOn(addonName)
						self:Schedule(0.01, function()
							local victoryGlobal = GetAddOnMetadata(i, "X-DBM-VictoryPack-GlobalName")
							local insertFunction = _G[victoryGlobal]
							if loaded and insertFunction then
								insertFunction()
							else
								self:Debug(addonName.." failed to load at time VictoryPack function "..victoryGlobal.." ran", 2)
							end
						end)
					end
				end
				if GetAddOnMetadata(i, "X-DBM-DefeatPack") and enabled then
					if checkEntry(bannedMods, addonName) then
						AddMsg(self, "The mod " .. addonName .. " is deprecated and will not be available. Please remove the folder " .. addonName .. " from your Interface" .. (IsWindowsClient() and "\\" or "/") .. "AddOns folder to get rid of this message. Check for an updated version of " .. addonName .. " that is compatible with your game version.")
					else
						local loaded = LoadAddOn(addonName)
						self:Schedule(0.01, function()
							local defeatGlobal = GetAddOnMetadata(i, "X-DBM-DefeatPack-GlobalName")
							local insertFunction = _G[defeatGlobal]
							if loaded and insertFunction then
								insertFunction()
							else
								self:Debug(addonName.." failed to load at time DefeatPack function "..defeatGlobal.." ran", 2)
							end
						end)
					end
				end
				if GetAddOnMetadata(i, "X-DBM-MusicPack") and enabled then
					if checkEntry(bannedMods, addonName) then
						AddMsg(self, "The mod " .. addonName .. " is deprecated and will not be available. Please remove the folder " .. addonName .. " from your Interface" .. (IsWindowsClient() and "\\" or "/") .. "AddOns folder to get rid of this message. Check for an updated version of " .. addonName .. " that is compatible with your game version.")
					else
						local loaded = LoadAddOn(addonName)
						self:Schedule(0.01, function()
							local musicGlobal = GetAddOnMetadata(i, "X-DBM-MusicPack-GlobalName")
							local insertFunction = _G[musicGlobal]
							if loaded and insertFunction then
								insertFunction()
							else
								self:Debug(addonName.." failed to load at time MusicPack function "..musicGlobal.." ran", 2)
							end
						end)
					end
				end
			end
			tsort(self.AddOns, function(v1, v2) return v1.sort < v2.sort end)
			self:RegisterEvents(
				"COMBAT_LOG_EVENT_UNFILTERED",
				"ZONE_CHANGED_NEW_AREA",
				"ZONE_CHANGED_INDOORS",
				"ZONE_CHANGED",
				"RAID_ROSTER_UPDATE",
				"PARTY_MEMBERS_CHANGED",
				"CHAT_MSG_ADDON",
				"PLAYER_REGEN_DISABLED",
				"PLAYER_REGEN_ENABLED",
				"INSTANCE_ENCOUNTER_ENGAGE_UNIT",
				"UNIT_DIED",
				"UNIT_DESTROYED",
				"UNIT_HEALTH mouseover target focus player",
				"CHAT_MSG_WHISPER",
				"CHAT_MSG_BN_WHISPER",
				"CHAT_MSG_MONSTER_YELL",
				"CHAT_MSG_MONSTER_EMOTE",
				"CHAT_MSG_MONSTER_SAY",
				"CHAT_MSG_RAID_BOSS_EMOTE",
				"CHAT_MSG_RAID_BOSS_WHISPER",
				"PLAYER_ENTERING_WORLD",
				"SPELL_CAST_SUCCESS",
				"LFG_PROPOSAL_SHOW",
				"LFG_PROPOSAL_FAILED",
				"READY_CHECK",
				"UPDATE_BATTLEFIELD_STATUS",
				"PLAY_MOVIE",
				"CINEMATIC_START",
				"CINEMATIC_STOP",
				"PARTY_INVITE_REQUEST",
				"LFG_PROPOSAL_SUCCEEDED",
				"LFG_UPDATE",
				"CHARACTER_POINTS_CHANGED",
				"PLAYER_TALENT_UPDATE"
			)
			self:ZONE_CHANGED_NEW_AREA()
			self:RAID_ROSTER_UPDATE()
			self:Schedule(1.5, function()
				combatInitialized = true
			end)
			self:Schedule(20, function()
				healthCombatInitialized = true
			end)
			self:Schedule(10, runDelayedFunctions, self)
			if DBM and TT then
				TT:Initialize(true)
			end
		end
	end
end

-----------------
--  Callbacks  --
-----------------
do
	local callbacks = {}

	function fireEvent(event, ...)
		if not callbacks[event] then return end
		for _, v in ipairs(callbacks[event]) do
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
local DBMScheduler = private:GetModule("DBMScheduler")

function DBM:Schedule(t, f, ...)
	return DBMScheduler:Schedule(t, f, nil, ...)
end

function DBM:Unschedule(f, ...)
	return DBMScheduler:Unschedule(f, nil, ...)
end

---------------
--  Profile  --
---------------
function DBM:CreateProfile(name)
	if not name or name == "" or name:find(" ") then
		self:AddMsg(L.PROFILE_CREATE_ERROR)
		return
	end
	if DBM_AllSavedOptions[name] then
		self:AddMsg(L.PROFILE_CREATE_ERROR_D:format(name))
		return
	end
	-- create profile
	usedProfile = name
	DBM_UsedProfile = usedProfile
	DBM_AllSavedOptions[usedProfile] = DBM_AllSavedOptions[usedProfile] or {}
	self:AddDefaultOptions(DBM_AllSavedOptions[usedProfile], self.DefaultOptions)
	self.Options = DBM_AllSavedOptions[usedProfile]
	-- rearrange position
	DBT:CreateProfile("DBM")
	self:RepositionFrames()
	self:AddMsg(L.PROFILE_CREATED:format(name))
end

function DBM:ApplyProfile(name)
	if not name or not DBM_AllSavedOptions[name] then
		self:AddMsg(L.PROFILE_APPLY_ERROR:format(name or CL.UNKNOWN))
		return
	end
	usedProfile = name
	DBM_UsedProfile = usedProfile
	self:AddDefaultOptions(DBM_AllSavedOptions[usedProfile], self.DefaultOptions)
	self.Options = DBM_AllSavedOptions[usedProfile]
	-- rearrange position
	DBT:ApplyProfile("DBM")
	self:RepositionFrames()
	self:AddMsg(L.PROFILE_APPLIED:format(name))
end

function DBM:CopyProfile(name)
	if not name or not DBM_AllSavedOptions[name] then
		self:AddMsg(L.PROFILE_COPY_ERROR:format(name or CL.UNKNOWN))
		return
	elseif name == usedProfile then
		self:AddMsg(L.PROFILE_COPY_ERROR_SELF)
		return
	end
	DBM_AllSavedOptions[usedProfile] = DBM_AllSavedOptions[name]
	self:AddDefaultOptions(DBM_AllSavedOptions[usedProfile], self.DefaultOptions)
	self.Options = DBM_AllSavedOptions[usedProfile]
	-- rearrange position
	DBT:CopyProfile(name, "DBM", true)
	self:RepositionFrames()
	self:AddMsg(L.PROFILE_COPIED:format(name))
end

function DBM:DeleteProfile(name)
	if not name or not DBM_AllSavedOptions[name] then
		self:AddMsg(L.PROFILE_DELETE_ERROR:format(name or CL.UNKNOWN))
		return
	elseif name == "Default" then-- Default profile cannot be deleted.
		self:AddMsg(L.PROFILE_CANNOT_DELETE)
		return
	end
	--Delete
	DBM_AllSavedOptions[name] = nil
	usedProfile = "Default"--Restore to default
	DBM_UsedProfile = usedProfile
	self.Options = DBM_AllSavedOptions[usedProfile]
	if not self.Options then
		-- the default profile got lost somehow (maybe WoW crashed and the saved variables file got corrupted)
		self:CreateProfile("Default")
	end
	-- rearrange position
	DBT:DeleteProfile(name, "DBM")
	self:RepositionFrames()
	self:AddMsg(L.PROFILE_DELETED:format(name))
end

function DBM:RepositionFrames()
	-- rearrange position
	self:UpdateWarningOptions()
	self:UpdateSpecialWarningOptions()
	self.Arrow:LoadPosition()
	local rangeCheck = _G["DBMRangeCheck"]
	if rangeCheck then
		rangeCheck:ClearAllPoints()
		rangeCheck:SetPoint(self.Options.RangeFramePoint, UIParent, self.Options.RangeFramePoint, self.Options.RangeFrameX, self.Options.RangeFrameY)
	end
	local rangeCheckRadar = _G["DBMRangeCheckRadar"]
	if rangeCheckRadar then
		rangeCheckRadar:ClearAllPoints()
		rangeCheckRadar:SetPoint(self.Options.RangeFrameRadarPoint, UIParent, self.Options.RangeFrameRadarPoint, self.Options.RangeFrameRadarX, self.Options.RangeFrameRadarY)
	end
	local infoFrame = _G["DBMInfoFrame"]
	if infoFrame then
		infoFrame:ClearAllPoints()
		infoFrame:SetPoint(self.Options.InfoFramePoint, UIParent, self.Options.InfoFramePoint, self.Options.InfoFrameX, self.Options.InfoFrameY)
	end
end

----------------------
--  Slash Commands  --
----------------------

do
	local function Sort(v1, v2)
		if v1.revision and not v2.revision then
			return true
		elseif v2.revision and not v1.revision then
			return false
		elseif v1.revision and v2.revision then
			return v1.revision > v2.revision
		else
			return (v1.bwversion or 0) > (v2.bwversion or 0)
		end
	end

	function DBM:ShowVersions(notify)
		local sortMe, outdatedUsers = {}, {}
		for _, v in pairs(raid) do
			tinsert(sortMe, v)
		end
		tsort(sortMe, Sort)
		self:AddMsg(L.VERSIONCHECK_HEADER)
		local nreq = 1
		for _, v in ipairs(sortMe) do
			local name = v.name
			local playerColor = RAID_CLASS_COLORS[DBM:GetRaidClass(name)]
			if playerColor then
				name = ("|r|cff%.2x%.2x%.2x%s|r|cff%.2x%.2x%.2x"):format(playerColor.r * 255, playerColor.g * 255, playerColor.b * 255, name, 0.41 * 255, 0.8 * 255, 0.94 * 255)
			end
			if v.displayVersion and not v.bwversion then--DBM, no BigWigs
				if self.Options.ShowAllVersions then
					self:AddMsg(L.VERSIONCHECK_ENTRY:format(name, L.DBM.." "..v.displayVersion, showRealDate(v.revision), v.VPVersion or ""), false)--Only display VP version if not running two mods
				end
				if notify and v.revision < self.ReleaseRevision then
					DBM:Schedule(nreq*10, SendChatMessage, chatPrefixShort..L.YOUR_VERSION_OUTDATED, "WHISPER", nil, v.name)
					nreq = nreq + 1
				end
			elseif self.Options.ShowAllVersions and v.displayVersion and v.bwversion then--DBM & BigWigs
				self:AddMsg(L.VERSIONCHECK_ENTRY_TWO:format(name, L.DBM.." "..v.displayVersion, showRealDate(v.revision), L.BIG_WIGS, bwVersionResponseString:format(v.bwversion)), false)
			elseif self.Options.ShowAllVersions and not v.displayVersion and v.bwversion then--BigWigs, No DBM
				self:AddMsg(L.VERSIONCHECK_ENTRY:format(name, L.BIG_WIGS, bwVersionResponseString:format(v.bwversion), ""), false)
			else
				if self.Options.ShowAllVersions then
					self:AddMsg(L.VERSIONCHECK_ENTRY_NO_DBM:format(name), false)
				end
			end
		end
		local NoDBM = 0
		local NoBigwigs = 0
		local OldMod = 0
		for i = #sortMe, 1, -1 do
			if not sortMe[i].revision then
				NoDBM = NoDBM + 1
			end
			if not (sortMe[i].bwversion) then
				NoBigwigs = NoBigwigs + 1
			end
			--Table sorting sorts dbm to top, bigwigs underneath. Highest version dbm always at top. so sortMe[1]
			--This check compares all dbm version to highest RELEASE version in raid.
			if sortMe[i].revision and (sortMe[i].revision < sortMe[1].version) or sortMe[i].bwversion and (sortMe[i].bwversion < fakeBWVersion) then
				OldMod = OldMod + 1
				local name = sortMe[i].name
				local playerColor = RAID_CLASS_COLORS[DBM:GetRaidClass(name)]
				if playerColor then
					name = ("|r|cff%.2x%.2x%.2x%s|r|cff%.2x%.2x%.2x"):format(playerColor.r * 255, playerColor.g * 255, playerColor.b * 255, name, 0.41 * 255, 0.8 * 255, 0.94 * 255)
				end
				tinsert(outdatedUsers, name)
			end
		end
		local TotalUsers = #sortMe
		self:AddMsg("---", false)
		self:AddMsg(L.VERSIONCHECK_FOOTER:format(TotalUsers - NoDBM, TotalUsers - NoBigwigs), false)
		self:AddMsg(L.VERSIONCHECK_OUTDATED:format(OldMod, #outdatedUsers > 0 and tconcat(outdatedUsers, ", ") or NONE), false)
	end
end

-------------------
--  Pizza Timer  --
-------------------
do

	local function loopTimer(time, text, broadcast, sender)
		DBM:CreatePizzaTimer(time, text, broadcast, sender, true)
	end

	local ignore = {}
	--Standard Pizza Timer
	function DBM:CreatePizzaTimer(time, text, broadcast, sender, loop, terminate)
		if terminate or time == 0 then
			self:Unschedule(loopTimer)
			DBT:CancelBar(text)
			fireEvent("DBM_TimerStop", "DBMPizzaTimer")
			return
		end
		if sender and ignore[sender] then return end
--		text = text:sub(1, 16) -- I don't see any point in limiting text to 16 char string
		text = text:gsub("%%t", UnitName("target") or "<no target>")
		if time < 3 then
			self:AddMsg(L.PIZZA_ERROR_USAGE)
			return
		end
		DBT:CreateBar(time, text, "Interface\\Icons\\SPELL_HOLY_BORROWEDTIME")
		fireEvent("DBM_TimerBegin", "DBMPizzaTimer", text, time, "Interface\\Icons\\SPELL_HOLY_BORROWEDTIME", "pizzatimer", nil, 0, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, true)
		fireEvent("DBM_TimerStart", "DBMPizzaTimer", text, time, "Interface\\Icons\\SPELL_HOLY_BORROWEDTIME", "pizzatimer", nil, 0)
		if broadcast and self:GetRaidRank() >= 1 then
			sendSync("DBMv4-Pizza", ("%s\t%s"):format(time, text))
		end
		if sender then self:ShowPizzaInfo(text, sender) end
		if loop then
			self:Unschedule(loopTimer)--Only one loop timer supported at once doing this, but much cleaner this way
			self:Schedule(time, loopTimer, time, text, broadcast, sender)
		end
	end

	function DBM:AddToPizzaIgnore(name)
		ignore[name] = true
	end
end

function DBM:ShowPizzaInfo(id, sender)
	if self.Options.ShowPizzaMessage then
		self:AddMsg(L.PIZZA_SYNC_INFO:format(sender, id))
	end
end

-----------------
--  GUI Stuff  --
-----------------
do
	local callOnLoad = {}
	function DBM:LoadGUI()
		if not dbmIsEnabled then
			self:ForceDisableSpam()
			return
		end
		if self.NewerVersion and showConstantReminder >= 1 then
			AddMsg(self, L.UPDATEREMINDER_HEADER:format(self.NewerVersion, showRealDate(self.HighestRelease)))
		end
		local firstLoad = false
		if not IsAddOnLoaded("DBM-GUI") then
			local _, _, _, enabled = GetAddOnInfo("DBM-GUI")
			if not enabled then
				EnableAddOn("DBM-GUI")
			end
			local loaded, reason = LoadAddOn("DBM-GUI")
			if not loaded then
				if reason then
					self:AddMsg(L.LOAD_GUI_ERROR:format(tostring(_G["ADDON_"..reason or ""])))
				else
					self:AddMsg(L.LOAD_GUI_ERROR:format(CL.UNKNOWN))
				end
				return false
			end
			if not InCombatLockdown() and not UnitAffectingCombat("player") and not IsFalling() then--We loaded in combat but still need to avoid garbage collect in combat
				collectgarbage("collect")
			end
			firstLoad = true
		end
		DBM_GUI:ShowHide()
		if firstLoad then
			tsort(callOnLoad, function(v1, v2) return v1[2] < v2[2] end)
			for _, v in ipairs(callOnLoad) do v[1]() end
		end
	end

	function DBM:RegisterOnGuiLoadCallback(f, sort)
		tinsert(callOnLoad, {f, sort or mhuge})
	end
end

-------------------------------------------------
--  Raid/Party Handling and Unit ID Utilities  --
-------------------------------------------------
do
	local bwVersionQueryString = "%d"--Only used here
	local inRaid = false

	local raidGuids = {}
	local iconSeter = {}

	--	save playerinfo into raid table on load. (for solo raid)
	DBM:RegisterOnLoadCallback(function()
		AceTimer:ScheduleTimer(function()
			if not raid[playerName] then
				raid[playerName] = {}
				raid[playerName].name = playerName
				raid[playerName].shortname = playerName
				raid[playerName].guid = UnitGUID("player") or ""
				raid[playerName].rank = 0
				raid[playerName].class = playerClass
				raid[playerName].id = "player"
				raid[playerName].groupId = 0
				raid[playerName].revision = DBM.Revision
				raid[playerName].version = DBM.ReleaseRevision
				raid[playerName].displayVersion = DBM.DisplayVersion
				raid[playerName].locale = GetLocale()
				raid[playerName].enabledIcons = tostring(not DBM.Options.DontSetIcons)
				raidGuids[UnitGUID("player") or ""] = playerName
			end
		end, 6)
	end)

	local function updateAllRoster(self)
		DBM:Debug("Updating roster", 3)
		if GetNumRaidMembers() >= 1 then
			if not inRaid then
				twipe(newerVersionPerson)--Wipe guild syncs on group join so we trigger a new out of date notice on raid join even if one triggered on login
				inRaid = true
				sendSync("DBMv4-Ver", "Hi!")
				if dbmIsEnabled then
					SendAddonMessage("BWVQ3", bwVersionQueryString:format(0), "RAID")
				end
				self:Schedule(2, DBM.RequestTimers, DBM)
				fireEvent("raidJoin", playerName) -- backwards compatibility
				fireEvent("DBM_raidJoin", playerName)
				local bigWigs = _G["BigWigs"]
				if bigWigs and bigWigs.db.profile.raidicon and not self.Options.DontSetIcons and self:GetRaidRank() > 0 then--Both DBM and bigwigs have raid icon marking turned on.
					self:AddMsg(L.BIGWIGS_ICON_CONFLICT)--Warn that one of them should be turned off to prevent conflict (which they turn off is obviously up to raid leaders preference, dbm accepts either or turned off to stop this alert)
				end
			end
			for i = 1, GetNumRaidMembers() do
				local name, rank, subgroup, _, _, className = GetRaidRosterInfo(i)
				if name and name ~= UNKNOWN then
					local id = "raid" .. i
					local shortname = UnitName(id)
					if (not raid[name]) and inRaid then
						fireEvent("raidJoin", name) -- backwards compatibility
						fireEvent("DBM_raidJoin", name)
					end
					raid[name] = raid[name] or {}
					raid[name].name = name
					raid[name].shortname = shortname
					raid[name].rank = rank
					raid[name].subgroup = subgroup
					raid[name].class = className
					raid[name].id = id
					raid[name].groupId = i
					raid[name].guid = UnitGUID(id) or ""
					raid[name].updated = true
					raidGuids[UnitGUID(id) or ""] = name
					if rank == 2 then
						lastGroupLeader = name
					end
				end
			end
			private.enableIcons = false
			twipe(iconSeter)
			for i, v in pairs(raid) do
				if not v.updated then
					raidGuids[v.guid] = nil
					raid[i] = nil
					removeEntry(newerVersionPerson, i)
					fireEvent("raidLeave", i) -- backwards compatibility
					fireEvent("DBM_raidLeave", i)
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
				if playerName == elected:sub(elected:find(" ") + 1) then--Highest revision in raid, auto allow, period, even if out of date, you're revision in raid that has assist
					private.enableIcons = true
					DBM:Debug("You have been elected as primary icon setter for raid for having newest revision in raid that has assist/lead", 2)
				end
				--Initiate backups that at least have latest version, in case the main elect doesn't have icons enabled
				for i = 2, 3 do--Allow top 3 revisions in raid to set icons, instead of just top one
					local electedBackup = iconSeter[i]
					if updateNotificationDisplayed == 0 and electedBackup and playerName == electedBackup:sub(elected:find(" ") + 1) then
						private.enableIcons = true
						DBM:Debug("You have been elected as one of 2 backup icon setters in raid that have assist/lead", 2)
					end
				end
			end
		elseif IsInGroup() then
			if not inRaid then
				-- joined a new party
				twipe(newerVersionPerson)--Wipe guild syncs on group join so we trigger a new out of date notice on raid join even if one triggered on login
				inRaid = true
				sendSync("DBMv4-Ver", "Hi!")
				if dbmIsEnabled then
					SendAddonMessage("BWVQ3", bwVersionQueryString:format(0), "PARTY")
				end
				fireEvent("partyJoin", playerName) -- backwards compatibility
				fireEvent("DBM_partyJoin", playerName)
			end
			for i = 0, GetNumPartyMembers() do
				local id
				if (i == 0) then
					id = "player"
				else
					id = "party"..i
				end
				local name = GetUnitName(id, true)
				local shortname = UnitName(id)
				local rank = UnitIsPartyLeader(id) and 2 or 0
				local _, className = UnitClass(id)
				if (not raid[name]) and inRaid then
					fireEvent("partyJoin", name) -- backwards compatibility
					fireEvent("DBM_partyJoin", name)
				end
				raid[name] = raid[name] or {}
				raid[name].name = name
				raid[name].shortname = shortname
				raid[name].guid = UnitGUID(id) or ""
				raid[name].rank = rank
				raid[name].class = className
				raid[name].id = id
				raid[name].groupId = i
				raid[name].updated = true
				raidGuids[UnitGUID(id) or ""] = name
				if rank >= 1 then
					lastGroupLeader = name
				end
			end
			private.enableIcons = false
			twipe(iconSeter)
			for k, v in pairs(raid) do
				if not v.updated then
					raidGuids[v.guid] = nil
					raid[k] = nil
					removeEntry(newerVersionPerson, k)
					fireEvent("partyLeave", k) -- backwards compatibility
					fireEvent("DBM_partyLeave", k)
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
					private.enableIcons = true
				end
			end
		else
			-- left the current group/raid
			inRaid = false
			private.enableIcons = true
			fireEvent("raidLeave", playerName) -- backwards compatibility
			fireEvent("DBM_raidLeave", playerName)
			twipe(raid)
			twipe(newerVersionPerson)
			-- restore playerinfo into raid table on raidleave. (for solo raid)
			raid[playerName] = {}
			raid[playerName].name = playerName
			raid[playerName].shortname = playerName
			raid[playerName].guid = UnitGUID("player") or "" -- 2023/04/20: On Warmane, UnitGUID("player") can be nil
			raid[playerName].rank = 0
			raid[playerName].class = playerClass
			raid[playerName].id = "player"
			raid[playerName].groupId = 0
			raid[playerName].revision = DBM.Revision
			raid[playerName].version = DBM.ReleaseRevision
			raid[playerName].displayVersion = DBM.DisplayVersion
			raid[playerName].locale = GetLocale()
			raidGuids[UnitGUID("player") or ""] = playerName
			lastGroupLeader = nil
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

	function DBM:GetNumGuildPlayersInZone() -- Classic/BCC only
		if not IsInGroup() then return 1 end
		local total = 0
		local myGuild = GetGuildInfo("player")
		if IsInRaid() then
			for i = 1, GetNumGroupMembers() do
				local unitGuild = GetGuildInfo("raid"..i)--This api only works if unit is nearby, so don't even need to check location
				if unitGuild and unitGuild == myGuild then
					total = total + 1
				end
			end
		else
			total = 1--add player/self for "party" count
			for i = 1, GetNumSubgroupMembers() do
				local unitGuild = GetGuildInfo("party"..i)--This api only works if unit is nearby, so don't even need to check location
				if unitGuild and unitGuild == myGuild then
					total = total + 1
				end
			end
		end
		return total
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

	function DBM:GetRaidRoster(name)
		if name then
			return raid[name] ~= nil
		end
		return raid
	end

	function DBM:GetRaidClass(name)
		if raid[name] then
			return raid[name].class or "UNKNOWN", raid[name].id and GetRaidTargetIndex(raid[name].id) or 0
		else
			return "UNKNOWN", 0
		end
	end

	function DBM:GetRaidUnitId(name)
		for i = 1, 5 do
			local unitId = "boss"..i
			local bossName = UnitName(unitId)
			if bossName and bossName == name then
				return unitId
			end
		end
		return raid[name] and raid[name].id
	end

	local fullUids = {
		"boss1", "boss2", "boss3", "boss4", "boss5",
		"mouseover", "target", "focus", "focustarget", "targettarget", "mouseovertarget",
		"party1target", "party2target", "party3target", "party4target",
		"raid1target", "raid2target", "raid3target", "raid4target", "raid5target", "raid6target", "raid7target", "raid8target", "raid9target", "raid10target",
		"raid11target", "raid12target", "raid13target", "raid14target", "raid15target", "raid16target", "raid17target", "raid18target", "raid19target", "raid20target",
		"raid21target", "raid22target", "raid23target", "raid24target", "raid25target", "raid26target", "raid27target", "raid28target", "raid29target", "raid30target",
		"raid31target", "raid32target", "raid33target", "raid34target", "raid35target", "raid36target", "raid37target", "raid38target", "raid39target", "raid40target"
	}

	local bossTargetuIds = {
		"boss1", "boss2", "boss3", "boss4", "boss5", "focus", "target", "mouseover"
	}

	--Not to be confused with GetUnitIdFromCID
	function DBM:GetUnitIdFromGUID(guid, scanOnlyBoss)
		local usedTable = scanOnlyBoss and bossTargetuIds or fullUids
		for _, unitId in ipairs(usedTable) do
			local guid2 = UnitGUID(unitId)
			if guid == guid2 then
				return unitId
			end
		end
	end

	function DBM:GetPlayerGUIDByName(name)
		return raid[name] and raid[name].guid
	end

	function DBM:GetMyPlayerInfo()
		return playerName, playerLevel, playerRealm
	end

	--Intentionally grabs server name at all times, usually to make sure warning/infoframe target info can name match the combat log in the table
	function DBM:GetUnitFullName(uId)
		if not uId then return end
		return GetUnitName(uId, true)
	end

	--Shortens name but custom so we add * to off realmers instead of stripping it entirely like Ambiguate does
	--Technically GetUnitName without "true" can be used to shorten name to "name (*)" but "name*" is even shorter which is why we do this
	function DBM:GetShortServerName(name)
		if not self.Options.StripServerName then return name end--If strip is disabled, just return name
		local shortName, serverName = string.split("-", name)
		if serverName and serverName ~= playerRealm then
			return shortName.."*"
		else
			return name
		end
	end

	function DBM:GetFullPlayerNameByGUID(guid)
		return raidGuids[guid]
	end

	function DBM:GetPlayerNameByGUID(guid)
		return raidGuids[guid] and raidGuids[guid]:gsub("%-.*$", "")
	end

	function DBM:GetGroupId(name, higher)
		local raidMember = raid[name] or raid[GetUnitName(name, true) or ""]
		return raidMember and raidMember.groupId or UnitInRaid(name) or higher and 99 or 0
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
		if IsInRaid() then
			return raidIterator, GetNumGroupMembers(), "raid0"
		elseif IsInGroup() then
			return partyIterator, GetNumSubgroupMembers(), nil
		else
			-- solo!
			return soloIterator, nil, nil
		end
	end
end

function DBM:GetNumGroupMembers()
	return IsInGroup() and GetNumGroupMembers() or 1
end

--For returning the number of players actually in zone with us for status functions
--This is very touchy though and will fail if everyone isn't in same SUB zone (ie same room/area)
--It should work for pretty much any case but outdoor
function DBM:GetNumRealGroupMembers()
	if not IsInInstance() then--Not accurate outside of instances (such as world bosses)
		return IsInGroup() and GetNumGroupMembers() or 1--So just return regular group members.
	end
	local playerCurrentZone = GetRealZoneText()
	local realGroupMembers = 0
	if GetNumRaidMembers() > 0 then
		for i = 1, GetNumRaidMembers() do
			local _, _, _, _, _, _, targetCurrentZone = GetRaidRosterInfo(i)
			if targetCurrentZone == playerCurrentZone then
				realGroupMembers = realGroupMembers + 1
			end
		end
	elseif GetNumPartyMembers() > 0 then
		local numPartyMembers = GetRealNumPartyMembers() -- this function return is terrible, but I didn't find any workaround to check unit zone, so for now this will do
		realGroupMembers = numPartyMembers
	else
		return 1
	end
	return realGroupMembers
end

function DBM:GetUnitCreatureId(uId)
	return self:GetCIDFromGUID(UnitGUID(uId))
end

function DBM:GetCIDFromGUID(guid)
	return guid and tonumber(guid:sub(8, 12), 16) or 0
end

function DBM:IsNonPlayableGUID(guid)
	if not guid or type(guid) ~= "string" then return false end
	local guidType = tonumber(guid:sub(5,5), 16)
	return guidType and (guidType == 3 or guidType == 5) -- Creature and NPC. To determine, add pet or not?
end

function DBM:IsCreatureGUID(guid)
	if bband(guid:sub(1, 5), 0x00F) == 3 or bband(guid:sub(1, 5), 0x00F) == 5 then
		return true
	end
	return false
end

function DBM:GetBossUnitId(name, bossOnly)--Deprecated, only old mods use this
	local returnUnitID
	for i = 1, 5 do
		if UnitName("boss" .. i) == name then
			returnUnitID = "boss"..i
		end
	end
	if not returnUnitID and not bossOnly then
		for uId in DBM:GetGroupMembers() do
			if UnitName(uId .. "target") == name and not UnitIsPlayer(uId .. "target") then
				returnUnitID = uId.."target"
			end
		end
	end
	return returnUnitID
end

--Not to be confused with GetUnitIdFromGUID
function DBM:GetUnitIdFromCID(creatureID, bossOnly)
	local returnUnitID
	for i = 1, 5 do
		local unitId = "boss"..i
		local bossGUID = UnitGUID(unitId)
		local cid = self:GetCIDFromGUID(bossGUID)
		if cid == creatureID then
			returnUnitID = unitId
		end
	end
	--Didn't find valid unitID from boss units, scan raid targets
	if not returnUnitID and not bossOnly then
		for uId in DBM:GetGroupMembers() do -- Do not use self on this function, because self might be bossModPrototype
			local unitId = uId .. "target"
			local bossGUID = UnitGUID(unitId)
			local cid = self:GetCIDFromGUID(bossGUID)
			if cid == creatureID then
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
			DBM:Debug("CheckNearby fired for targetname: " .. targetname .. " (" .. uId .. ") and range: ".. range .. "yd. Actual distance found: " .. inRange, 3) -- self can be mod too
			if inRange and inRange < range + 0.5 then
				return true
			end
		end
	end
	return false
end

function DBM:IsTrivial(customLevel)
	--if timewalking or mythic it's always non trivial content
	if difficultyIndex == 24 or difficultyIndex == 33 or difficultyIndex == 23 then
		return false
	end
	--if custom level passed, we always hard check that level for trivial vs non trivial
	if customLevel then--Custom level parameter
		if playerLevel >= customLevel then
			return true
		end
	else
		--First, auto bail and return non trivial if it's an instance not in table to prevent nil error
		if not instanceDifficultyBylevel[LastInstanceMapID] then return false end
		--Content is trivial if player level is 10 higher than content involved
		if playerLevel >= (instanceDifficultyBylevel[LastInstanceMapID][1]+15) then
			return true
		end
	end
	return false
end

---------------
--  Options  --
---------------
function DBM:AddDefaultOptions(t1, t2)
	for i, v in pairs(t2) do
		if t1[i] == nil then
			t1[i] = v
		elseif type(v) == "table" and type(t1[i]) == "table" then
			self:AddDefaultOptions(t1[i], v)
		end
	end
end

function DBM:LoadModOptions(modId, inCombat, first, profileName, profileID)
	local oldSavedVarsName = modId:gsub("-", "").."_SavedVars"
	local savedVarsName = modId:gsub("-", "").."_AllSavedVars"
	local savedStatsName = modId:gsub("-", "").."_SavedStats"
	local fullname = profileName or self.Options.PerCharacterSettings and playerName.."-"..playerRealm or "Global"
	currentModProfileScope = fullname
	self:Debug("using profile namespace " .. fullname, 3)
	if not currentSpecID or not currentSpecGroup or (currentSpecName or "") == playerClass then
		self:SetCurrentSpecInfo()
	end
	local profileNum = profileID or playerLevel > 9 and DBM_UseDualProfile and currentSpecGroup or 0
	if not _G[savedVarsName] then _G[savedVarsName] = {} end
	local savedOptions = _G[savedVarsName][fullname] or {}
	local savedStats = _G[savedStatsName] or {}
	local existId = {}
	for _, id in ipairs(self.ModLists[modId]) do
		existId[id] = true
		-- init
		if not savedOptions[id] then savedOptions[id] = {} end
		local mod = self:GetModByName(id)
		-- migrate old option
		if _G[oldSavedVarsName] and _G[oldSavedVarsName][id] then
			self:Debug("LoadModOptions: Found old options, importing", 2)
			local oldTable = _G[oldSavedVarsName][id]
			_G[oldSavedVarsName][id] = nil
			savedOptions[id][profileNum] = oldTable
		end
		if not savedOptions[id][profileNum] and not first then--previous profile not found. load defaults
			self:Debug("LoadModOptions: No saved options, creating defaults for profile "..profileNum, 2)
			local defaultOptions = {}
			for option, optionValue in pairs(mod.DefaultOptions) do
				if type(optionValue) == "table" then
					optionValue = optionValue.value
				elseif type(optionValue) == "string" then
					optionValue = mod:GetRoleFlagValue(optionValue)
				end
				defaultOptions[option] = optionValue
			end
			savedOptions[id][profileNum] = defaultOptions
		else
			savedOptions[id][profileNum] = savedOptions[id][profileNum] or mod.Options
			--check new option
			for option, optionValue in pairs(mod.DefaultOptions) do
				if savedOptions[id][profileNum][option] == nil then
					if type(optionValue) == "table" then
						optionValue = optionValue.value
					elseif type(optionValue) == "string" then
						optionValue = mod:GetRoleFlagValue(optionValue)
					end
					savedOptions[id][profileNum][option] = optionValue
				end
			end
			--clean unused saved variables (do not work on combat load)
			if not inCombat then
				for option, _ in pairs(savedOptions[id][profileNum]) do
					if mod.DefaultOptions[option] == nil and not (option:find("talent") or option:find("FastestClear") or option:find("CVAR") or option:find("RestoreSetting") or option:find("Permanent")) then -- added Permanent for mod options that I want to keep between sessions e.g. Frame positions
						savedOptions[id][profileNum][option] = nil
					elseif mod.DefaultOptions[option] and (type(mod.DefaultOptions[option]) == "table") then--recover broken dropdown option
						if savedOptions[id][profileNum][option] and (type(savedOptions[id][profileNum][option]) == "boolean") then
							savedOptions[id][profileNum][option] = mod.DefaultOptions[option].value
						end
					--Fix default options for colored bar by type that were set to 0 because no defaults existed at time they were created, but do now.
					elseif option:find("TColor") then
						if savedOptions[id][profileNum][option] and savedOptions[id][profileNum][option] == 0 and mod.DefaultOptions[option] and mod.DefaultOptions[option] ~= 0 then
							savedOptions[id][profileNum][option] = mod.DefaultOptions[option]
							self:Debug("Migrated "..option.." to option defaults")
						end
					--Fix options for custom special warning sounds not in addons folder that are not using soundkit IDs
					--[[elseif option:find("SWSound") then
						if savedOptions[id][profileNum][option] and (type(savedOptions[id][profileNum][option]) == "string") and (savedOptions[id][profileNum][option] ~= "") and (savedOptions[id][profileNum][option] ~= "None") then
							local searchMsg = (savedOptions[id][profileNum][option]):lower()
							if not searchMsg:find("addons") then
								savedOptions[id][profileNum][option] = mod.DefaultOptions[option]
								self:Debug("Migrated "..option.." to option defaults")
							end
						end]]
					end
				end
			end
		end
		--apply saved option to actual option table
		mod.Options = savedOptions[id][profileNum]
		--stats init (only first load)
		if first then
			savedStats[id] = savedStats[id] or {}
			local stats = savedStats[id]
			stats.normalKills = stats.normalKills or 0
			stats.normalPulls = stats.normalPulls or 0
			stats.heroicKills = stats.heroicKills or 0
			stats.heroicPulls = stats.heroicPulls or 0
			stats.mythicKills = stats.mythicKills or 0
			stats.mythicPulls = stats.mythicPulls or 0
			stats.normal25Kills = stats.normal25Kills or 0
			stats.normal25Pulls = stats.normal25Pulls or 0
			stats.heroic25Kills = stats.heroic25Kills or 0
			stats.heroic25Pulls = stats.heroic25Pulls or 0
			stats.timewalkerKills = stats.timewalkerKills or 0
			stats.timewalkerPulls = stats.timewalkerPulls or 0
			mod.stats = stats
			--run OnInitialize function
			if mod.OnInitialize then mod:OnInitialize(mod) end
		end
	end
	--clean unused saved variables (do not work on combat load)
	--Why are saved options cleaned twice?
	if not inCombat then
		for id, _ in pairs(savedOptions) do
			if not existId[id] and not id:find("talent") then
				savedOptions[id] = nil
			end
		end
		for id, _ in pairs(savedStats) do
			if not existId[id] then
				savedStats[id] = nil
			end
		end
	end
	_G[savedVarsName][fullname] = savedOptions
	if profileNum > 0 then
		_G[savedVarsName][fullname]["talent"..profileNum] = currentSpecName
		currentModProfileName = ("%s (%s%d-%s)"):format(fullname, L.SPECIALIZATION, profileNum, currentSpecName) -- Example: Global (Specialization1-Holy)
		self:Debug("LoadModOptions-"..modId..": Finished loading "..(_G[savedVarsName][fullname]["talent"..profileNum] or CL.UNKNOWN))
	end
	_G[savedStatsName] = savedStats
	local optionsFrame = _G["DBM_GUI_OptionsFrame"]
	if not first and DBM_GUI and DBM_GUI.currentViewing and optionsFrame:IsShown() then
		optionsFrame:DisplayFrame(DBM_GUI.currentViewing)
	end
	table.wipe(checkDuplicateObjects)
end

function DBM:SpecChanged(force)
	if not force and not DBM_UseDualProfile then return end
	--Load Options again.
	self:Debug("SpecChanged fired", 2)
	for modId, _ in pairs(self.ModLists) do
		self:LoadModOptions(modId)
	end
end

function DBM:PLAYER_LEVEL_CHANGED()
	playerLevel = UnitLevel("player")
	if playerLevel < 15 and playerLevel > 9 then
		self:CHARACTER_POINTS_CHANGED()
	end
end

function DBM:LoadAllModDefaultOption(modId)
	-- modId is string like "DBM-Highmaul"
	if not modId or not self.ModLists[modId] then return end
	-- prevent error
	if not currentSpecID or not currentSpecGroup or (currentSpecName or "") == playerClass then
		self:SetCurrentSpecInfo()
	end
	-- variable init
	local savedVarsName = modId:gsub("-", "").."_AllSavedVars"
	local fullname = self.Options.PerCharacterSettings and playerName.."-"..playerRealm or "Global"
	local profileNum = playerLevel > 9 and DBM_UseDualProfile and currentSpecGroup or 0
	-- prevent nil table error
	if not _G[savedVarsName] then _G[savedVarsName] = {} end
	for _, id in ipairs(self.ModLists[modId]) do
		-- prevent nil table error
		if not _G[savedVarsName][fullname][id] then _G[savedVarsName][fullname][id] = {} end
		-- actual do load default option
		local mod = self:GetModByName(id)
		local defaultOptions = {}
		for option, optionValue in pairs(mod.DefaultOptions) do
			if type(optionValue) == "table" then
				optionValue = optionValue.value
			elseif type(optionValue) == "string" then
				optionValue = mod:GetRoleFlagValue(optionValue)
			end
			defaultOptions[option] = optionValue
		end
		mod.Options = {}
		mod.Options = defaultOptions
		_G[savedVarsName][fullname][id][profileNum] = {}
		_G[savedVarsName][fullname][id][profileNum] = mod.Options
	end
	self:AddMsg(L.ALLMOD_DEFAULT_LOADED)
	-- update gui if showing
	local optionsFrame = _G["DBM_GUI_OptionsFrame"]
	if DBM_GUI and DBM_GUI.currentViewing and optionsFrame:IsShown() then
		optionsFrame:DisplayFrame(DBM_GUI.currentViewing)
	end
end

function DBM:LoadModDefaultOption(mod)
	-- mod must be table
	if not mod then return end
	-- prevent error
	if not currentSpecID or not currentSpecGroup or (currentSpecName or "") == playerClass then
		self:SetCurrentSpecInfo()
	end
	-- variable init
	local savedVarsName = (mod.modId):gsub("-", "").."_AllSavedVars"
	local fullname = self.Options.PerCharacterSettings and playerName.."-"..playerRealm or "Global"
	local profileNum = playerLevel > 9 and DBM_UseDualProfile and currentSpecGroup or 0
	-- prevent nil table error
	if not _G[savedVarsName] then _G[savedVarsName] = {} end
	if not _G[savedVarsName][fullname] then _G[savedVarsName][fullname] = {} end
	if not _G[savedVarsName][fullname][mod.id] then _G[savedVarsName][fullname][mod.id] = {} end
	-- do load default
	local defaultOptions = {}
	for option, optionValue in pairs(mod.DefaultOptions) do
		if type(optionValue) == "table" then
			optionValue = optionValue.value
		elseif type(optionValue) == "string" then
			optionValue = mod:GetRoleFlagValue(optionValue)
		end
		defaultOptions[option] = optionValue
	end
	mod.Options = {}
	mod.Options = defaultOptions
	_G[savedVarsName][fullname][mod.id][profileNum] = {}
	_G[savedVarsName][fullname][mod.id][profileNum] = mod.Options
	self:AddMsg(L.MOD_DEFAULT_LOADED)
	-- update gui if showing
	local optionsFrame = _G["DBM_GUI_OptionsFrame"]
	if DBM_GUI and DBM_GUI.currentViewing and optionsFrame:IsShown() then
		optionsFrame:DisplayFrame(DBM_GUI.currentViewing)
	end
end

function DBM:CopyAllModOption(modId, sourceName, sourceProfile)
	-- modId is string like "DBM-Highmaul"
	if not modId or not sourceName or not sourceProfile or not DBM.ModLists[modId] then return end
	-- prevent error
	if not currentSpecID or not currentSpecGroup or (currentSpecName or "") == playerClass then
		self:SetCurrentSpecInfo()
	end
	-- variable init
	local savedVarsName = modId:gsub("-", "").."_AllSavedVars"
	local targetName = self.Options.PerCharacterSettings and playerName.."-"..playerRealm or "Global"
	local targetProfile = playerLevel > 9 and DBM_UseDualProfile and currentSpecGroup or 0
	-- do not copy setting itself
	if targetName == sourceName and targetProfile == sourceProfile then
		self:AddMsg(L.MPROFILE_COPY_SELF_ERROR)
		return
	end
	-- prevent nil table error
	if not _G[savedVarsName] then _G[savedVarsName] = {} end
	-- check source is exist
	if not _G[savedVarsName][sourceName] then
		self:AddMsg(L.MPROFILE_COPY_S_ERROR)
		return
	end
	for _, id in ipairs(self.ModLists[modId]) do
		-- check source is exist
		if not _G[savedVarsName][sourceName][id] then
			self:AddMsg(L.MPROFILE_COPY_S_ERROR)
			return
		end
		if not _G[savedVarsName][sourceName][id][sourceProfile] then
			self:AddMsg(L.MPROFILE_COPY_S_ERROR)
			return
		end
		-- prevent nil table error
		if not _G[savedVarsName][targetName][id] then _G[savedVarsName][targetName][id] = {} end
		-- copy table
		_G[savedVarsName][targetName][id][targetProfile] = {}--clear before copy
		_G[savedVarsName][targetName][id][targetProfile] = _G[savedVarsName][sourceName][id][sourceProfile]
		--check new option
		local mod = self:GetModByName(id)
		for option, optionValue in pairs(mod.Options) do
			if _G[savedVarsName][targetName][id][targetProfile][option] == nil then
				_G[savedVarsName][targetName][id][targetProfile][option] = optionValue
			end
		end
		-- apply to options table
		mod.Options = {}
		mod.Options = _G[savedVarsName][targetName][id][targetProfile]
	end
	if targetProfile > 0 then
		_G[savedVarsName][targetName]["talent"..targetProfile] = currentSpecName
	end
	self:AddMsg(L.MPROFILE_COPY_SUCCESS:format(sourceName, sourceProfile))
	-- update gui if showing
	local optionsFrame = _G["DBM_GUI_OptionsFrame"]
	if DBM_GUI and DBM_GUI.currentViewing and optionsFrame:IsShown() then
		optionsFrame:DisplayFrame(DBM_GUI.currentViewing)
	end
end

function DBM:CopyAllModTypeOption(modId, sourceName, sourceProfile, Type)
	-- modId is string like "DBM-Highmaul"
	if not modId or not sourceName or not sourceProfile or not self.ModLists[modId] or not Type then return end
	-- prevent error
	if not currentSpecID or not currentSpecGroup or (currentSpecName or "") == playerClass then
		self:SetCurrentSpecInfo()
	end
	-- variable init
	local savedVarsName = modId:gsub("-", "").."_AllSavedVars"
	local targetName = self.Options.PerCharacterSettings and playerName.."-"..playerRealm or "Global"
	local targetProfile = playerLevel > 9 and DBM_UseDualProfile and currentSpecGroup or 0
	-- do not copy setting itself
	if targetName == sourceName and targetProfile == sourceProfile then
		self:AddMsg(L.MPROFILE_COPYS_SELF_ERROR)
		return
	end
	-- prevent nil table error
	if not _G[savedVarsName] then _G[savedVarsName] = {} end
	-- check source is exist
	if not _G[savedVarsName][sourceName] then
		self:AddMsg(L.MPROFILE_COPYS_S_ERROR)
		return
	end
	for _, id in ipairs(self.ModLists[modId]) do
		-- check source is exist
		if not _G[savedVarsName][sourceName][id] then
			self:AddMsg(L.MPROFILE_COPYS_S_ERROR)
			return
		end
		if not _G[savedVarsName][sourceName][id][sourceProfile] then
			self:AddMsg(L.MPROFILE_COPYS_S_ERROR)
			return
		end
		-- prevent nil table error
		if not _G[savedVarsName][targetName][id] then _G[savedVarsName][targetName][id] = {} end
		-- copy table
		for option, optionValue in pairs(_G[savedVarsName][sourceName][id][sourceProfile]) do
			if option:find(Type) then
				_G[savedVarsName][targetName][id][targetProfile][option] = optionValue
			end
		end
		-- apply to options table
		local mod = self:GetModByName(id)
		mod.Options = {}
		mod.Options = _G[savedVarsName][targetName][id][targetProfile]
	end
	if targetProfile > 0 then
		_G[savedVarsName][targetName]["talent"..targetProfile] = currentSpecName
	end
	self:AddMsg(L.MPROFILE_COPYS_SUCCESS:format(sourceName, sourceProfile))
	-- update gui if showing
	local optionsFrame = _G["DBM_GUI_OptionsFrame"]
	if DBM_GUI and DBM_GUI.currentViewing and optionsFrame:IsShown() then
		optionsFrame:DisplayFrame(DBM_GUI.currentViewing)
	end
end

function DBM:DeleteAllModOption(modId, name, profile)
	-- modId is string like "DBM-Highmaul"
	if not modId or not name or not profile or not self.ModLists[modId] then return end
	-- prevent error
	if not currentSpecID or not currentSpecGroup or (currentSpecName or "") == playerClass then
		self:SetCurrentSpecInfo()
	end
	-- variable init
	local savedVarsName = modId:gsub("-", "").."_AllSavedVars"
	local fullname = self.Options.PerCharacterSettings and playerName.."-"..playerRealm or "Global"
	local profileNum = playerLevel > 9 and DBM_UseDualProfile and currentSpecGroup or 0
	-- cannot delete current profile.
	if fullname == name and profileNum == profile then
		self:AddMsg(L.MPROFILE_DELETE_SELF_ERROR)
		return
	end
	-- prevent nil table error
	if not _G[savedVarsName] then _G[savedVarsName] = {} end
	if not _G[savedVarsName][name] then
		self:AddMsg(L.MPROFILE_DELETE_S_ERROR)
		return
	end
	for _, id in ipairs(self.ModLists[modId]) do
		-- prevent nil table error
		if not _G[savedVarsName][name][id] then
			self:AddMsg(L.MPROFILE_DELETE_S_ERROR)
			return
		end
		-- delete
		_G[savedVarsName][name][id][profile] = nil
	end
	_G[savedVarsName][name]["talent"..profile] = nil
	self:AddMsg(L.MPROFILE_DELETE_SUCCESS:format(name, profile))
end

function DBM:ClearAllStats(modId)
	-- modId is string like "DBM-Highmaul"
	if not modId or not self.ModLists[modId] then return end
	-- variable init
	local savedStatsName = modId:gsub("-", "").."_SavedStats"
	-- prevent nil table error
	if not _G[savedStatsName] then _G[savedStatsName] = {} end
	for _, id in ipairs(self.ModLists[modId]) do
		local mod = self:GetModByName(id)
		-- prevent nil table error
		local defaultStats = {}
		defaultStats.normalKills = 0
		defaultStats.normalPulls = 0
		defaultStats.heroicKills = 0
		defaultStats.heroicPulls = 0
		defaultStats.mythicKills = 0
		defaultStats.mythicPulls = 0
		defaultStats.normal25Kills = 0
		defaultStats.normal25Pulls = 0
		defaultStats.heroic25Kills = 0
		defaultStats.heroic25Pulls = 0
		defaultStats.timewalkerKills = 0
		defaultStats.timewalkerPulls = 0
		mod.stats = {}
		mod.stats = defaultStats
		_G[savedStatsName][id] = {}
		_G[savedStatsName][id] = defaultStats
	end
	self:AddMsg(L.ALLMOD_STATS_RESETED)
	DBM_GUI:UpdateModList()
end

function DBM:CurrentModProfile()
	local profile = currentModProfileName or currentModProfileScope .. " (All)"
	-- Even though this function is not mod specific, the profile name is applied equally to all loaded mods in ModList.
	self:Debug("Currently loaded mod profile: " .. profile, 3)
	return profile
end

do
	local gsub = string.gsub

	local function FixElv(optionName)
		if DBM.Options[optionName]:lower():find("interface\\addons\\elvui\\core\\media\\") then -- Retail ElvUI structure
			DBM.Options[optionName] = gsub(DBM.Options[optionName], gsub("Interface\\AddOns\\ElvUI\\Core\\Media\\", "(%a)", function(v)
				return "[" .. v:upper() .. v:lower() .. "]"
			end), "Interface\\AddOns\\ElvUI\\Media\\") -- 3.3.5a ElvUI structure
		end
	end

	function loadOptions(self)
		--init
		if not DBM_AllSavedOptions then DBM_AllSavedOptions = {} end
		usedProfile = DBM_UsedProfile or usedProfile
		if not usedProfile or (usedProfile ~= "Default" and not DBM_AllSavedOptions[usedProfile]) then
			-- DBM.Option is not loaded. so use print function
			print(L.PROFILE_NOT_FOUND)
			usedProfile = "Default"
		end
		DBM_UsedProfile = usedProfile
		--migrate old options
		if DBM_SavedOptions and not DBM_AllSavedOptions[usedProfile] then
			DBM_AllSavedOptions[usedProfile] = DBM_SavedOptions
		end
		self.Options = DBM_AllSavedOptions[usedProfile] or {}
		self:Enable()
		self:AddDefaultOptions(self.Options, self.DefaultOptions)
		DBM_AllSavedOptions[usedProfile] = self.Options

		-- force enable dual profile (change default)
		--[[ Custom edit: disabled override, since having this as true requires user to know how mod profiles work and wonder why the mod profile they had previously configured is not "working"
		if DBM_CharSavedRevision < 12976 then
			if playerClass ~= "MAGE" and playerClass ~= "WARLOCK" and playerClass ~= "ROGUE" then
				DBM_UseDualProfile = true
			end
		end
		--]]
		DBM_CharSavedRevision = self.Revision
		-- load special warning options
		self:UpdateWarningOptions()
		self:UpdateSpecialWarningOptions()
		if BossBanner then
			BossBanner:UpdateStyle()
		end
		self.Options.CoreSavedRevision = self.Revision
		--Fix fonts if they are nil
		if not self.Options.WarningFont then
			self.Options.WarningFont = "standardFont"
		end
		if not self.Options.SpecialWarningFont then
			self.Options.SpecialWarningFont = "standardFont"
		end
		--If users previous voice pack was not set to none, don't force change it to VEM, honor whatever it was set to before
		if self.Options.ChosenVoicePack and self.Options.ChosenVoicePack ~= "None" then
			self.Options.ChosenVoicePack2 = self.Options.ChosenVoicePack
			self.Options.ChosenVoicePack = nil
		end
		-- Migrate ElvUI changes
		for _, setting in ipairs({
			-- Sounds
			"RaidWarningSound", "SpecialWarningSound", "SpecialWarningSound2", "SpecialWarningSound3", "SpecialWarningSound4", "SpecialWarningSound5", "EventSoundVictory2",
			"EventSoundWipe", "EventSoundEngage2", "EventSoundMusic", "EventSoundDungeonBGM", "RangeFrameSound1", "RangeFrameSound2",
			-- Fonts
			"InfoFrameFont", "WarningFont", "SpecialWarningFont"
		}) do
			if type(self.Options[setting]) == "string" and self.Options[setting]:lower() ~= "none" then
				FixElv(setting)
			end
		end
	end
end

function DBM:LFG_PROPOSAL_SHOW()
	local timerEnabled = self.Options.ShowQueuePop and not self.Options.DontShowEventTimers
	if timerEnabled then
		DBT:CreateBar(40, L.LFG_INVITE, "Interface\\Icons\\Spell_Holy_BorrowedTime")
		fireEvent("DBM_TimerStart", "DBMLFGTimer", L.LFG_INVITE, 40, "Interface\\Icons\\Spell_Holy_BorrowedTime", "extratimer", nil, 0)
	end
	fireEvent("DBM_TimerBegin", "DBMLFGTimer", L.LFG_INVITE, 40, "Interface\\Icons\\Spell_Holy_BorrowedTime", "extratimer", nil, 0, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, timerEnabled)
	if self.Options.LFDEnhance then
		self:FlashClientIcon(true)
		self:PlaySound(8960, true)--Because regular sound uses SFX channel which is too low of volume most of time
	end
end

function DBM:LFG_PROPOSAL_FAILED()
	DBT:CancelBar(L.LFG_INVITE)
	fireEvent("DBM_TimerStop", "DBMLFGTimer")
end

function DBM:LFG_PROPOSAL_SUCCEEDED()
	DBT:CancelBar(L.LFG_INVITE)
	fireEvent("DBM_TimerStop", "DBMLFGTimer")
end

function DBM:LFG_UPDATE()
	local _, joined = GetLFGInfoServer()
	if not joined then
		DBT:CancelBar(L.LFG_INVITE)
		fireEvent("DBM_TimerStop", "DBMLFGTimer")
	end
end

function DBM:READY_CHECK()
	if self.Options.RLReadyCheckSound then--readycheck sound, if ora3 not installed (bad to have 2 mods do it)
		self:FlashClientIcon(true)
		if not BINDING_HEADER_oRA3 then
			self:PlaySound(8960, true)--Because regular sound uses SFX channel which is too low of volume most of time
		end
	end
	self:TransitionToDungeonBGM(false, true)
	self:Schedule(4, self.TransitionToDungeonBGM, self)
end

do
	local function throttledTalentCheck(self)
		local lastSpecID = currentSpecID
		if GetNumTalentTabs() == 0 then
			self:Debug("No talents detected. Registering PLAYER_ALIVE for talent data")
			self:RegisterEvents("PLAYER_ALIVE")
		end
		self:SetCurrentSpecInfo() -- always delay a bit (previously had it at 0.1s) because Unit API like UnitExists and UnitClass were returning nil on this event.
		if not InCombatLockdown() then
			--Refresh entire spec table if not in combat
			DBMExtraGlobal:rebuildSpecTable()
		end
		if currentSpecID ~= lastSpecID then--Don't fire specchanged unless spec actually has changed.
			self:SpecChanged()
		end
	end

	--Throttle checks on talent point updates so that if multiple CHARACTER_POINTS_CHANGED fire in succession
	--It doesnt spam DBMs code and cause performance lag
	function DBM:CHARACTER_POINTS_CHANGED() -- Classic/BCC support
		self:Unschedule(throttledTalentCheck)
		self:Schedule(2, throttledTalentCheck, self)
	end
	--Throttle this api too.
	DBM.PLAYER_TALENT_UPDATE = DBM.CHARACTER_POINTS_CHANGED -- Wrath support

	-- This workaround is likely not needed anymore since talent check is now delayed by two seconds
	function DBM:PLAYER_ALIVE()
		self:CHARACTER_POINTS_CHANGED()
		mainFrame:UnregisterEvent("PLAYER_ALIVE")
	end
end

do
	local function AcceptPartyInvite()
		AcceptGroup()
		for i=1, STATICPOPUP_NUMDIALOGS do
			local whichDialog = _G["StaticPopup"..i].which
			if whichDialog == "PARTY_INVITE" or whichDialog == "PARTY_INVITE_XREALM" then
				_G["StaticPopup"..i].inviteAccepted = 1
				StaticPopup_Hide(whichDialog)
				break
			end
		end
	end

	function DBM:PARTY_INVITE_REQUEST(sender)
		--First off, if you are in queue for something, lets not allow guildies or friends boot you from it.
		if IsInInstance() or GetLFGMode() then return end
		--Checks friends and guildies
		if self.Options.AutoAcceptFriendInvite then
			if checkForSafeSender(sender, self.Options.AutoAcceptFriendInvite, self.Options.AutoAcceptGuildInvite) then
				AcceptPartyInvite()
			end
		end
	end
end

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

function DBM:UPDATE_BATTLEFIELD_STATUS(queueID)
	for i = 1, 2 do
		if GetBattlefieldStatus(i) == "confirm" then
			local timerEnabled = self.Options.ShowQueuePop and not self.Options.DontShowEventTimers
			queuedBattlefield[i] = select(2, GetBattlefieldStatus(i))
			local expiration = GetBattlefieldPortExpiration(queueID)
			local timerIcon = GetBattlefieldFaction("player") == "Alliance" and "Interface\\Icons\\INV_BannerPVP_02" or "Interface\\Icons\\INV_BannerPVP_01"
			if timerEnabled then
				DBT:CreateBar(expiration or 85, queuedBattlefield[i], timerIcon)
				self:FlashClientIcon()
				fireEvent("DBM_TimerStart", "DBMBFSTimer", queuedBattlefield[i], expiration or 85, tostring(timerIcon), "extratimer", nil, 0)
			end
			fireEvent("DBM_TimerBegin", "DBMBFSTimer", queuedBattlefield[i], expiration or 85, tostring(timerIcon), "extratimer", nil, 0, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, timerEnabled)
			if self.Options.LFDEnhance then
				self:PlaySound(8960, true)--Because regular sound uses SFX channel which is too low of volume most of time
			end
		elseif queuedBattlefield[i] then
			DBT:CancelBar(queuedBattlefield[i])
			fireEvent("DBM_TimerStop", "DBMBFSTimer")
			tremove(queuedBattlefield, i)
		end
	end
end

--------------------------------
--  Load Boss Mods on Demand  --
--------------------------------
do
	local pvpShown = false
	local classicZones = {[718]=true,[767]=true,[756]=true,[697]=true}
	local bcZones = {[797]=true,[776]=true,[800]=true,[777]=true,[780]=true,[781]=true,[790]=true,[783]=true,[782]=true}
	local wrathZones = {[532]=true,[610]=true,[544]=true,[528]=true,[605]=true,[536]=true,[719]=true,[530]=true,[533]=true}
	local pvpZones = {[402]=true,[444]=true,[462]=true,[483]=true,[513]=true,[541]=true}
	local oldDungeons = {
		[689]=true,[705]=true,[700]=true,[681]=true,[691]=true,--Classic
		[711]=true,[723]=true,[724]=true,[725]=true,[726]=true,[727]=true,[728]=true,[729]=true,[730]=true,[731]=true,[732]=true,[733]=true,[734]=true,[735]=true,[798]=true,[799]=true,--BC
		[523]=true,[534]=true,[522]=true,[535]=true,[531]=true,[526]=true,[527]=true,[521]=true,[529]=true,[524]=true,[825]=true,[537]=true,[603]=true,[602]=true,[604]=true,[543]=true,--Wrath
	}
	--This never wants to spam you to use mods for trivial content you don't need mods for.
	--It's intended to suggest mods for content that's relevant to your level (TW, leveling up in dungeons, or even older raids you can't just roll over)
	function DBM:CheckAvailableMods()
		if _G["BigWigs"] then return end--If they are running two boss mods at once, lets assume they are only using DBM for a specific feature (such as brawlers) and not nag
		if not self:IsTrivial() then
			if oldDungeons[LastInstanceMapID] and not GetAddOnInfo("DBM-Party-BC") then
				AddMsg(self, L.MOD_AVAILABLE:format("DBM Dungeon mods"))
			elseif (classicZones[LastInstanceMapID] or bcZones[LastInstanceMapID]) and not GetAddOnInfo("DBM-BlackTemple") then
				AddMsg(self, L.MOD_AVAILABLE:format("DBM BC/Vanilla mods"))
			elseif wrathZones[LastInstanceMapID] and not GetAddOnInfo("DBM-Ulduar") then
				AddMsg(self, L.MOD_AVAILABLE:format("DBM Wrath of the Lich King mods"))
			end
		end
		local _, instanceType = GetInstanceInfo()
		if (pvpZones[LastInstanceMapID] or instanceType == "arena") and not GetAddOnInfo("DBM-PvP") and not pvpShown then
			AddMsg(self, L.MOD_AVAILABLE:format("DBM-PvP"))
			pvpShown = true
		end
	end
	function DBM:TransitionToDungeonBGM(force, cleanup)
		if cleanup then--Runs on zone change/cinematic Start (first load delay) and combat end
			self:Unschedule(self.TransitionToDungeonBGM)
			if self.Options.RestoreSettingMusic then
				SetCVar("Sound_EnableMusic", self.Options.RestoreSettingMusic)
				self.Options.RestoreSettingMusic = nil
				self:Debug("Restoring Sound_EnableMusic CVAR")
			end
			if self.Options.musicPlaying then--Primarily so DBM doesn't call StopMusic unless DBM is one that started it. We don't want to screw with other addons
				StopMusic()
				self.Options.musicPlaying = nil
				self:Debug("Stopping music")
			end
			fireEvent("DBM_MusicStop", "ZoneOrCombatEndTransition")
			return
		end
		if LastInstanceType ~= "raid" and LastInstanceType ~= "party" and not force then return end
		fireEvent("DBM_MusicStart", "RaidOrDungeon")
		if self.Options.EventSoundDungeonBGM and self.Options.EventSoundDungeonBGM ~= "None" and self.Options.EventSoundDungeonBGM ~= "" and not (self.Options.EventDungMusicMythicFilter and (savedDifficulty == "mythic" or savedDifficulty == "challenge")) then
			if not self.Options.RestoreSettingMusic then
				self.Options.RestoreSettingMusic = tonumber(GetCVar("Sound_EnableMusic")) or 1
				if self.Options.RestoreSettingMusic == 0 then
					SetCVar("Sound_EnableMusic", 1)
				else
					self.Options.RestoreSettingMusic = nil--Don't actually need it
				end
			end
			local path = "MISSING"
			if self.Options.EventSoundDungeonBGM == "Random" then
				local usedTable = self.Options.EventSoundMusicCombined and DBM:GetMusic() or DBM:GetDungeonMusic()
				if #usedTable >= 3 then
					local random = random(3, #usedTable)
					path = usedTable[random].value
				end
			else
				path = self.Options.EventSoundDungeonBGM
			end
			if path ~= "MISSING" then
				PlayMusic(path)
				self.Options.musicPlaying = true
				self:Debug("Starting Dungeon music with file: "..path)
			end
		end
	end
	local function SecondaryLoadCheck(self)
		local zoneName = GetRealZoneText()
		local mapID = GetCurrentMapAreaID() > 4 and GetCurrentMapAreaID() or GetCurrentMapContinent() -- workaround to support world bosses mod loading
		local _, instanceType, difficulty, _, instanceGroupSize = GetInstanceInfo()
		local currentDifficulty, currentDifficultyText, currentDifficultyIndex = self:GetCurrentInstanceDifficulty()
		if currentDifficulty and currentDifficulty ~= savedDifficulty then -- added currentDifficulty nil check to prevent this from overriding savedDifficulty when outside instance
			savedDifficulty, difficultyText = currentDifficulty, currentDifficultyText
		end
		self:Debug("Instance Check fired with mapID "..mapID.." and difficulty "..difficulty, 2)
		-- Auto Logging for entire zone if record only bosses is off
		if not self.Options.RecordOnlyBosses then
			if LastInstanceType == "raid" or LastInstanceType == "party" then
				self:StartLogging(0)
			else
				self:StopLogging()
			end
		end
		if self.Options.FixCLEUOnCombatStart then
			self:Schedule(0.5, CombatLogClearEntries)
			self:Debug("Scheduled FixCLEU from SecondaryLoadCheck")
		end
		--These can still change even if mapID doesn't
		difficultyIndex = currentDifficultyIndex or difficulty
		LastGroupSize = instanceGroupSize
		if LastInstanceMapID == mapID and LastInstanceZoneName == zoneName then -- ZoneName check for non-patch users
			self:TransitionToDungeonBGM()
			self:Debug("No action taken because mapID hasn't changed since last check", 2)
			return
		end--ID hasn't changed, don't waste cpu doing anything else (example situation, porting into garrosh stage 4 is a loading screen)
		LastInstanceZoneName = zoneName
		LastInstanceMapID = mapID
		DBMScheduler:UpdateZone()--Also update zone in scheduler
		fireEvent("DBM_UpdateZone", mapID)
		if instanceType == "none" then
			LastInstanceType = "none"
			if not targetEventsRegistered then
				self:RegisterShortTermEvents("UPDATE_MOUSEOVER_UNIT", "UNIT_TARGET_UNFILTERED")
				targetEventsRegistered = true
			end
		else
			LastInstanceType = instanceType
			if targetEventsRegistered then
				self:UnregisterShortTermEvents()
				targetEventsRegistered = false
			end
			if savedDifficulty == "worldboss" then
				for i = #inCombat, 1, -1 do
					self:EndCombat(inCombat[i], true, nil, "Left zone of world boss")
				end
			end
		end
		-- LoadMod
		self:LoadModsOnDemand("zone", zoneName, playerRealm)
		self:LoadModsOnDemand("mapId", mapID, playerRealm)
--		if self.Options.ShowReminders then
			self:CheckAvailableMods()
--		end
		if self:HasMapRestrictions() then
			self.Arrow:Hide()
--			self.HudMap:Disable()
			if self.RangeCheck:IsRadarShown() then
				self.RangeCheck:Hide(true)
			end
		end
	end

	-- Check so that when viewing the world map, the zone doesn't "yank" to the current one
	local cachedZoneChangedEvent = ""
	local function IsWorldMapFrameOpen(event)
		if IsOutdoors() and WorldMapFrame:IsShown() then
			-- Prioritize ZONE_CHANGED_NEW_AREA if both events got fired over the course of the world map being open
			if cachedZoneChangedEvent ~= "ZONE_CHANGED_NEW_AREA" then
				cachedZoneChangedEvent = event
			end
			return true
		end
	end
	-- Hook World Map close event
	local function WorldMapFrameCloseHook()
		if cachedZoneChangedEvent == "ZONE_CHANGED_NEW_AREA" then
			DBM:ZONE_CHANGED_NEW_AREA()
		elseif cachedZoneChangedEvent == "ZONE_CHANGED_INDOORS" then
			DBM:ZONE_CHANGED_INDOORS()
		end
		cachedZoneChangedEvent = ""
	end
	WorldMapFrame:HookScript("OnHide", WorldMapFrameCloseHook)

	function DBM:ZONE_CHANGED_NEW_AREA()
		if IsWorldMapFrameOpen("ZONE_CHANGED_NEW_AREA") then return end
		SetMapToCurrentZone()
		timerRequestInProgress = false
		self:Debug("ZONE_CHANGED_NEW_AREA fired on zoneID: " .. GetCurrentMapAreaID())
		self:Unschedule(SecondaryLoadCheck)
		--SecondaryLoadCheck(self)
		self:Schedule(1, SecondaryLoadCheck, self)--Now delayed by one second to work around an issue on 8.x where spec info isn't available yet on reloadui
		self:TransitionToDungeonBGM(false, true)
		self:Schedule(5, SecondaryLoadCheck, self)
		if self.Options.FixCLEUOnCombatStart then
			self:Schedule(0.5, CombatLogClearEntries)
			self:Debug("Scheduled FixCLEU from ZONE_CHANGED_NEW_AREA")
		end
	end

	function DBM:ZONE_CHANGED_INDOORS()
		if IsWorldMapFrameOpen("ZONE_CHANGED_INDOORS") then return end
		SetMapToCurrentZone()
		self:Debug("Indoor/SubZone changed on zoneID: " .. GetCurrentMapAreaID() .. " and subZone: " .. GetSubZoneText())
	end
	DBM.ZONE_CHANGED = DBM.ZONE_CHANGED_INDOORS

	function DBM:LoadModsOnDemand(checkTable, checkValue, checkRealm)
		self:Debug("LoadModsOnDemand fired")
		for _, v in ipairs(self.AddOns) do
			local modTable = v[checkTable]
			local modRealm = v.realm
			local modBlockRealm = v.blockRealm
			local _, _, _, enabled = GetAddOnInfo(v.modId)
			--self:Debug(v.modId.." is "..enabled, 2)
			if not IsAddOnLoaded(v.modId) and modTable and checkEntry(modTable, checkValue) then
				if not checkEntry(modBlockRealm, checkRealm) and (modRealm[1] == "" or checkEntry(modRealm, checkRealm)) then -- custom realm check (for non-WotLK specific mods, like Vanilla Onyxia). Toc only filled if necessary for conditional mod load based on realm
					if enabled then
						self:LoadMod(v)
					else
						if self.Options.ShowReminders then
							self:AddMsg(L.LOAD_MOD_DISABLED:format(v.name))
						end
					end
				end
			end
		end
	end
end

function DBM:LoadMod(mod, force)
	if type(mod) ~= "table" then
		self:Debug("LoadMod failed because mod table not valid")
		return false
	end
	--Block loading world boss mods by zoneID
	if mod.isWorldBoss and not IsInInstance() and not force then
		return
	end
	if mod.minRevision > self.Revision then
		if self:AntiSpam(60, "VER_MISMATCH") then--Throttle message in case person keeps trying to load mod (or it's a world boss player keeps targeting
			self:AddMsg(L.LOAD_MOD_VER_MISMATCH:format(mod.name))
		end
		return
	end
	if mod.minExpansion > GetExpansionLevel() then
		self:AddMsg(L.LOAD_MOD_EXP_MISMATCH:format(mod.name))
		return
	elseif not testBuild and mod.minToc > wowTOC then
		self:AddMsg(L.LOAD_MOD_TOC_MISMATCH:format(mod.name, mod.minToc))
		return
	end
	if not currentSpecID or (currentSpecName or "") == playerClass then
		self:SetCurrentSpecInfo()
	end
	self:Debug("LoadAddOn should have fired for "..mod.name, 2)
	local loaded, reason = LoadAddOn(mod.modId)
	if not loaded then
		if reason then
			if reason == "DISABLED" then
				self:AddMsg(L.LOAD_MOD_DISABLED:format(mod.name))
			else
				self:AddMsg(L.LOAD_MOD_ERROR:format(tostring(mod.name), tostring(_G["ADDON_"..reason or ""])))
			end
		else
			self:Debug("LoadAddOn failed and did not give reason")
		end
		return false
	else
		self:Debug("LoadAddOn should have succeeded for "..mod.name, 2)
		self:AddMsg(L.LOAD_MOD_SUCCESS:format(tostring(mod.name)))
		if self.NewerVersion and showConstantReminder >= 1 then
			AddMsg(self, L.UPDATEREMINDER_HEADER:format(self.NewerVersion, showRealDate(self.HighestRelease)))
		end
		self:LoadModOptions(mod.modId, InCombatLockdown(), true)
		if DBM_GUI then
			DBM_GUI:UpdateModList()
		end
		if LastInstanceType ~= "pvp" and #inCombat == 0 and IsInGroup() then--do timer recovery only mod load
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
	local function loadModByUnit(uId)
		if IsInInstance() or not UnitIsFriend("player", uId) and UnitIsDead("player") or UnitIsDead(uId) then return end--If you're in an instance no reason to waste cpu. If THE BOSS dead, no reason to load a mod for it. To prevent rare lua error, needed to filter on player dead.
		local guid = UnitGUID(uId)
		if guid and DBM:IsCreatureGUID(guid) then
			local cId = DBM:GetCIDFromGUID(guid)
			for bosscId, addon in pairs(loadcIds) do
				local _, _, _, enabled = GetAddOnInfo(addon)
				if cId and bosscId and cId == bosscId and not IsAddOnLoaded(addon) and enabled ~= 0 then
					for _, v in ipairs(DBM.AddOns) do
						if v.modId == addon then
							DBM:LoadMod(v, true)
							break
						end
					end
				end
			end
		end
	end

	--Loading routines checks for world bosses based on target or mouseover.
	function DBM:UPDATE_MOUSEOVER_UNIT()
		loadModByUnit("mouseover")
	end

	function DBM:UNIT_TARGET_UNFILTERED(uId)
		loadModByUnit(uId.."target")
	end
end

-----------------------------
--  Handle Incoming Syncs  --
-----------------------------

do
	local function checkForActualPull()
		if DBM.Options.RecordOnlyBosses and #inCombat == 0 then
			DBM:StopLogging()
		end
	end

	local syncHandlers, whisperSyncHandlers, guildSyncHandlers = {}, {}, {}

	-- DBM uses the following prefixes since 4.1 as pre-4.1 sync code is going to be incompatible anways, so this is the perfect opportunity to throw away the old and long names
	-- M = Mod
	-- C = Combat start
	-- GC = Guild Combat Start
	-- IS = Icon set info
	-- K = Kill
	-- H = Hi!
	-- V = Incoming version information
	-- U = User Timer
	-- PT = Pull Timer (for sound effects, the timer itself is still sent as a normal timer)
	-- RT = Request Timers
	-- CI = Combat Info
	-- TR = Timer Recovery
	-- IR = Instance Info Request
	-- IRE = Instance Info Requested Ended/Canceled
	-- II = Instance Info
	-- WBE = World Boss engage info
	-- WBD = World Boss defeat info
	-- WBA = World Buff Activation
	-- RLO = Raid Leader Override
	-- NS = Note Share
	-- L = Boss Loot Info

	syncHandlers["DBMv4-Mod"] = function(sender, mod, revision, event, ...)
		mod = DBM:GetModByName(mod or "")
		if mod and event and revision then
			revision = tonumber(revision) or 0
			mod:ReceiveSync(event, sender, revision, ...)
		end
	end

	syncHandlers["DBMv4-NS"] = function(sender, modid, modvar, text, abilityName)
		if sender == playerName then return end
		if DBM.Options.BlockNoteShare or InCombatLockdown() or UnitAffectingCombat("player") or IsFalling() or DBM:GetRaidRank(sender) == 0 then return end
		local _, zoneType = IsInInstance()
		if zoneType == "pvp" or zoneType == "arena" then return end
		local mod = DBM:GetModByName(modid or "")
		local ability = abilityName or CL.UNKNOWN
		if mod and modvar and text and text ~= "" then
			if DBM:AntiSpam(5, modvar) then--Don't allow calling same note more than once per 5 seconds
				DBM:AddMsg(L.NOTE_SHARE_SUCCESS:format(sender, abilityName))
				DBM:ShowNoteEditor(mod, modvar, ability, text, sender)
			else
				DBM:Debug(sender.." is attempting to send too many notes so notes are being throttled")
			end
		else
			DBM:AddMsg(L.NOTE_SHARE_FAIL:format(sender, ability))
		end
	end

	syncHandlers["DBMv4-Pull"] = function(sender, delay, mod, modRevision, startHp, _, modHFRevision, event) -- sender, delay, mod, modRevision, startHp, dbmRevision, modHFRevision, event
		if not dbmIsEnabled or sender == playerName then return end
		if LastInstanceType == "pvp" then return end
		if LastInstanceType == "none" and (not UnitAffectingCombat("player") or #inCombat > 0) then--world boss
			local senderuId = DBM:GetRaidUnitId(sender)
			if not senderuId then return end--Should never happen, but just in case. If happens, MANY "C" syncs are sent. losing 1 no big deal.
			local x, y = GetPlayerMapPosition(senderuId)
			if x == 0 and y == 0 then return end--not same zone
			local range = DBM.RangeCheck:GetDistance("player", senderuId)--Same zone, so check range
			if not range or range > 120 then return end
		end
		if not cSyncSender[sender] then
			cSyncSender[sender] = true
			cSyncReceived = cSyncReceived + 1
			if cSyncReceived > 2 then -- need at least 3 sync to combat start. (for security)
				local lag = select(3, GetNetStats()) / 1000
				delay = tonumber(delay or 0) or 0
				mod = DBM:GetModByName(mod or "")
				modRevision = tonumber(modRevision or 0) or 0
				--dbmRevision = tonumber(dbmRevision or 0) or 0
				modHFRevision = tonumber(modHFRevision or 0) or 0
				startHp = tonumber(startHp or -1) or -1
				--if dbmRevision < 10481 then return end
				if mod and delay and (not mod.zones or mod.zones[LastInstanceMapID] or mod.zones[LastInstanceZoneName]) and (not mod.minSyncRevision or modRevision >= mod.minSyncRevision) and not (#inCombat > 0 and mod.noMultiBoss) then
					DBM:StartCombat(mod, delay + lag, "SYNC from - "..sender, true, startHp, event)
					if mod.revision < modHFRevision then--mod.revision because we want to compare to OUR revision not senders
						--There is a newer RELEASE version of DBM out that has this mods fixes that we do not possess
						if DBM.HighestRelease >= modHFRevision and DBM.ReleaseRevision < modHFRevision then
							showConstantReminder = 2
							if DBM:AntiSpam(3, "HOTFIX") then
								AddMsg(DBM, L.UPDATEREMINDER_HOTFIX)
							end
						else--This mods fixes are in an alpha version
							if DBM:AntiSpam(3, "HOTFIX") then
								AddMsg(DBM, L.UPDATEREMINDER_HOTFIX_ALPHA)
							end
						end
					end
				end
			end
		end
	end

	syncHandlers["DBMv4-RLO"] = function(sender, version, statusWhisper, guildStatus, raidIcons, chatBubbles)
		if (DBM:GetRaidRank(sender) ~= 2 or not IsInGroup()) then return end--If not on group, we're probably sender, don't disable status. IF not leader, someone is trying to spoof this, block that too
		if not version or version ~= "1" then return end--Ignore old versions
		DBM:Debug("Raid leader override comm Received")
		statusWhisper, guildStatus, raidIcons, chatBubbles = tonumber(statusWhisper) or 0, tonumber(guildStatus) or 0, tonumber(raidIcons) or 0, tonumber(chatBubbles) or 0
		local activated = false
		if statusWhisper == 1 then
			activated = true
			private.statusWhisperDisabled = true
		end
		if guildStatus == 1 then
			activated = true
			private.statusGuildDisabled = true
		end
		if raidIcons == 1 then
			activated = true
			private.raidIconsDisabled = true
		end
		if chatBubbles == 1 then
			activated = true
			private.chatBubblesDisabled = true
		end
		if activated then
			AddMsg(L.OVERRIDE_ACTIVATED)
		end
	end

	syncHandlers["DBMv4-IS"] = function(_, guid, ver, optionName)
		DBM:Debug(("DBMv4-IS received %s %s %s"):format(guid, ver, optionName), 3)
		ver = tonumber(ver) or 0
		if ver > (iconSetRevision[optionName] or 0) then--Save first synced version and person, ignore same version. refresh occurs only above version (fastest person)
			iconSetRevision[optionName] = ver
			iconSetPerson[optionName] = guid
		end
		if iconSetPerson[optionName] == UnitGUID("player") then--Check if that highest version was from ourself
			private.canSetIcons[optionName] = true
		else--Not from self, it means someone with a higher version than us probably sent it
			private.canSetIcons[optionName] = false
		end
		local name = DBM:GetFullPlayerNameByGUID(iconSetPerson[optionName]) or CL.UNKNOWN
		DBM:Debug(name.." was elected icon setter for "..optionName, 2)
		DBM:AddMsg(name.." was elected icon setter for "..optionName)
	end

	syncHandlers["DBMv4-Kill"] = function(_, cId)
		if select(2, IsInInstance()) == "pvp" or select(2, IsInInstance()) == "none" then return end
		cId = tonumber(cId or "")
		if cId then DBM:OnMobKill(cId, true) end
	end

	do
		local lootTableBySender = {}
		local function lootValidateAndSendEvent(encounterId, lootSourceName, lootSourceGUID, lootSourceID, itemID, itemLink, quantity, slot, texture, _, counter) -- finalItem
			-- build BossBanner encounter cache if needed
			BossBanner.encounterLootCache[encounterId] = BossBanner.encounterLootCache[encounterId] or {}
			BossBanner.encounterLootCache[encounterId][lootSourceID] = BossBanner.encounterLootCache[encounterId][lootSourceID] or {}
			BossBanner.encounterLootCache[encounterId][lootSourceID][itemID] = BossBanner.encounterLootCache[encounterId][lootSourceID][itemID] or {}

			if BossBanner.encounterLootCache[encounterId][lootSourceID][itemID][counter] == nil then -- only check for nil. false has different meaning (cached, not synced)
				tinsert(BossBanner.encounterLootCache[encounterId][lootSourceID][itemID], false)
			end

			-- check if BossBanner encounterLootCache already has the looted item
			if BossBanner.encounterLootCache[encounterId] and BossBanner.encounterLootCache[encounterId][lootSourceID] and BossBanner.encounterLootCache[encounterId][lootSourceID][itemID] then
				local foundUnsyncedItem = false
				for lootItemIdx, synced in ipairs(BossBanner.encounterLootCache[encounterId][lootSourceID][itemID]) do
					if not synced then
						foundUnsyncedItem = true
						BossBanner.encounterLootCache[encounterId][lootSourceID][itemID][lootItemIdx] = true
						break
					end
				end
				if not foundUnsyncedItem then
					DBM:Debug("BossBanner: item already cached and synced. Ending sync for encounterId: "..encounterId..", lootSourceName: "..lootSourceName..", lootSourceGUID: "..lootSourceGUID..", itemID: "..itemID..", itemLink: "..itemLink..", quantity: "..quantity..", slot: "..slot..", texture: "..texture, 3)
					return
				end
			end

			-- check if BossBanner.pendingLoot is empty or already has the looted item
			if next(BossBanner.pendingLoot) == nil then
				DBM:Debug("Sending BossBanner event, no pendingLoot: ENCOUNTER_LOOT_RECEIVED, with args: "..encounterId..", "..itemID..", "..itemLink..", "..quantity..", "..slot..", "..texture..", "..lootSourceName..", "..lootSourceGUID, 3)
				BossBanner:OnEvent("ENCOUNTER_LOOT_RECEIVED", encounterId, itemID, itemLink, quantity, slot, texture, lootSourceName, lootSourceGUID)
			else
				local sendLootEvent = true
				for _, lootEntry in ipairs(BossBanner.pendingLoot) do -- indexed table with each pair being a loot entry with { itemID = itemID, quantity = quantity, slot = slot, lootNameToDisplay = lootNameToDisplay, itemLink = itemLink }
					if lootEntry["itemID"] == itemID and lootEntry["slot"] == slot then -- item already added to pendingLoot, don't add it again
						sendLootEvent = false
					end
				end
				if sendLootEvent then
					DBM:Debug("Sending BossBanner event: ENCOUNTER_LOOT_RECEIVED, with args: "..encounterId..", "..itemID..", "..itemLink..", "..quantity..", "..slot..", "..texture..", "..lootSourceName..", "..lootSourceGUID, 3)
					BossBanner:OnEvent("ENCOUNTER_LOOT_RECEIVED", encounterId, itemID, itemLink, quantity, slot, texture, lootSourceName, lootSourceGUID)
				end
			end
		end

		local function lootDispatcher(sender, encounterId, lootSourceID, lootSourceName, lootSourceGUID, itemID, itemLink, quantity, slot, texture, finalItem)
			lootTableBySender[sender] = lootTableBySender[sender] or {}
			lootTableBySender[sender][encounterId] = lootTableBySender[sender][encounterId] or {}
			lootTableBySender[sender][encounterId][lootSourceID] = lootTableBySender[sender][encounterId][lootSourceID] or {}
			lootTableBySender[sender][encounterId][lootSourceID][slot] = { itemID = itemID, itemLink = itemLink, quantity = quantity, slot = slot, texture = texture, finalItem = finalItem }

			if finalItem then
				-- add counter of each itemID and max number of duplicates
				local lootCounter = {}
				for _, lootSlotTable in pairs(lootTableBySender[sender][encounterId][lootSourceID]) do
					lootCounter[lootSlotTable.itemID] = (lootCounter[lootSlotTable.itemID] or 0) + 1
					DBM:Debug("Dispatching BossBanner loot by sender "..sender..", with args: encounterId: "..encounterId..", lootSourceName: "..lootSourceName..", lootSourceGUID: "..lootSourceGUID..", itemID: "..lootSlotTable.itemID..", itemLink: "..lootSlotTable.itemLink..", quantity: "..lootSlotTable.quantity..", slot: "..lootSlotTable.slot..", texture: "..lootSlotTable.texture..", finalItem: "..tostring(lootSlotTable.finalItem)..", lootCounter: "..lootCounter[lootSlotTable.itemID], 3)
					lootValidateAndSendEvent(encounterId, lootSourceName, lootSourceGUID, lootSourceID, lootSlotTable.itemID, lootSlotTable.itemLink, lootSlotTable.quantity, lootSlotTable.slot, lootSlotTable.texture, lootSlotTable.finalItem, lootCounter[lootSlotTable.itemID])
				end
				twipe(lootCounter)
			end
		end

		syncHandlers["DBMv4-L"] = function(sender, version, locale, encounterId, _, lootSourceName, lootSourceGUID, itemID, itemLink, quantity, slot, texture, finalItem) -- version, locale, encounterId, encounterName, lootSourceName, lootSourceGUID, itemID, itemLink, tostring(quantity), tostring(slot), texture, finalItem
			if not BossBanner then return end
			DBM:Debug("Receiving BossBanner loot sync from "..sender..", with args --> version: "..tostring(version)..", locale: "..tostring(locale)..", encounterId: "..tostring(encounterId)..", lootSourceName: "..tostring(lootSourceName)..", lootSourceGUID: "..tostring(lootSourceGUID)..", itemID: "..tostring(itemID)..", itemLink: "..tostring(itemLink)..", quantity: "..tostring(quantity)..", slot: "..tostring(slot)..", texture: "..tostring(texture)..", finalItem: "..tostring(finalItem), 3)
			if not version or version ~= "3" then return end -- ignore old versions (previous sync had no version and antispam string changed during development)
			-- check BossBanner encounterLootCache for the looted item
			local isNPC = lootSourceGUID ~= "nil"
			local lootSourceID = isNPC and lootSourceGUID or lootSourceName
			if not isNPC and locale ~= GetLocale() then
				DBM:Debug("BossBanner: ignored loot from ("..lootSourceID..") with different locale ("..locale..").", 3)
				return
			end
			lootDispatcher(sender, encounterId, lootSourceID, lootSourceName, lootSourceGUID, itemID, itemLink, tonumber(quantity), tonumber(slot), texture, (finalItem == "true" and true or false))
		end
	end

	local dummyMod -- dummy mod for the pull timer
	syncHandlers["DBMv4-PT"] = function(sender, timer, senderMapID, target)
		if DBM.Options.DontShowUserTimers then return end
		local isTank = UnitGroupRolesAssigned(sender)
		local LFGTankException = IsPartyLFG() and isTank
		if (DBM:GetRaidRank(sender) == 0 and IsInGroup() and not LFGTankException) or select(2, IsInInstance()) == "pvp" then
			return
		end
		--Abort if mapID filter is enabled and sender actually sent a mapID. if no mapID is sent, it's always passed through (IE BW pull timers)
		if DBM.Options.DontShowPTNoID and senderMapID and tonumber(senderMapID) ~= LastInstanceMapID then return end
		timer = tonumber(timer or 0)
		--We want to permit 0 itself, but block anything negative number or anything between 0 and 3
		if (timer > 0 and timer < 3) or timer < 0 then
			return
		end
		if timer == 0 or DBM:AntiSpam(1, "PT"..sender) then--prevent double pull timer from BW and other mods that are sending D4 and D5 at same time
			if not dummyMod then
				local threshold = DBM.Options.PTCountThreshold2
				threshold = floor(threshold)
				dummyMod = DBM:NewMod("PullTimerCountdownDummy")
				DBM:GetModLocalization("PullTimerCountdownDummy"):SetGeneralLocalization{ name = L.MINIMAP_TOOLTIP_HEADER }
				dummyMod.text = dummyMod:NewAnnounce("%s", 1, "Interface\\Icons\\Ability_Warrior_OffensiveStance")
				dummyMod.geartext = dummyMod:NewSpecialWarning("  %s  ", nil, nil, nil, 3)
				dummyMod.timer = dummyMod:NewTimer(20, "%s", "Interface\\Icons\\Ability_Warrior_OffensiveStance", nil, nil, 0, nil, nil, DBM.Options.DontPlayPTCountdown and 0 or 4, threshold, nil, nil, nil, nil, nil, nil, "pull")
			end
			--Cancel any existing pull timers before creating new ones, we don't want double countdowns or mismatching blizz countdown text (cause you can't call another one if one is in progress)
			if not DBM.Options.DontShowPT2 then--and DBT:GetBar(L.TIMER_PULL)
				dummyMod.timer:Stop()
			end
			local timerTrackerRunning = false
			if not DBM.Options.DontShowPTCountdownText and TT then
				for _, tttimer in pairs(TT.timerList) do
					if not tttimer.isFree then--Timer event running
						if tttimer.type == 3 then--Its a pull timer event, this is one we cancel before starting a new pull timer
							TT:FreeTimerTrackerTimer(tttimer)
						else--Verify that a TimerTracker event NOT started by DBM isn't running, if it is, prevent executing new TimerTracker events below
							timerTrackerRunning = true
						end
					end
				end
			end
			dummyMod.text:Cancel()
			if timer == 0 then return end--"/dbm pull 0" will strictly be used to cancel the pull timer (which is why we let above part of code run but not below)
			DBM:FlashClientIcon()
			if not DBM.Options.DontShowPT2 then
				dummyMod.timer:Start(timer, L.TIMER_PULL)
				sendSync("DBMv4-Pizza", ("%s\t%s\t%s"):format(timer, L.TIMER_PULL, tostring(true))) -- Backwards compatibility so old DBMs can receive pull timers from this DBM
			end
			if not DBM.Options.DontShowPTCountdownText and TT then
				if not timerTrackerRunning then--if a TimerTracker event is running not started by DBM, block creating one of our own (object gets buggy if it has 2+ events running)
					--Start A TimerTracker timer using the new countdown type 3 type (ie what C_PartyInfo.DoCountdown triggers, but without sending it to entire group)
					TT:OnEvent("START_TIMER", 3, timer, timer)
					--Find the timer object DBM just created and hack our own changes into it.
					for _, tttimer in pairs(TT.timerList) do
						if tttimer.type == 3 and not tttimer.isFree then
							--We don't want the PVP bar, we only want timer text
							if timer > 10 then
								--b.startNumbers:Play()
								tttimer.StatusBar:Hide()
							end
							break
						end
					end
				end
			end
			if not DBM.Options.DontShowPTText then
				if target then
					dummyMod.text:Show(L.ANNOUNCE_PULL_TARGET:format(target, timer, sender))
					dummyMod.text:Schedule(timer, L.ANNOUNCE_PULL_NOW_TARGET:format(target))
				else
					dummyMod.text:Show(L.ANNOUNCE_PULL:format(timer, sender))
					dummyMod.text:Schedule(timer, L.ANNOUNCE_PULL_NOW)
				end
			end
			if DBM.Options.EventSoundPullTimer and DBM.Options.EventSoundPullTimer ~= "" and DBM.Options.EventSoundPullTimer ~= "None" then
				DBM:PlaySoundFile(DBM.Options.EventSoundPullTimer, nil, true)
			end
			if DBM.Options.RecordOnlyBosses then
				DBM:StartLogging(timer, checkForActualPull)--Start logging here to catch pre pots.
			end
			if DBM.Options.CheckGear then
				local weapon = GetInventoryItemLink("player", 16)
				local fishingPole = false
				if weapon then
					local _, _, _, _, _, _, type = GetItemInfo(weapon)
					if type and type == L.GEAR_FISHING_POLE then
						fishingPole = true
					end
				end
				if GetNumRaidMembers() > 0 and (not weapon or fishingPole) then
					dummyMod.geartext:Show(L.GEAR_WARNING_WEAPON)
				end
			end
		end
	end

	do
		local dummyMod2 -- dummy mod for the break timer
		function breakTimerStart(self, timer, sender)
			if not dummyMod2 then
				local threshold = DBM.Options.PTCountThreshold2
				threshold = floor(threshold)
				dummyMod2 = DBM:NewMod("BreakTimerCountdownDummy")
				DBM:GetModLocalization("BreakTimerCountdownDummy"):SetGeneralLocalization{ name = L.MINIMAP_TOOLTIP_HEADER }
				dummyMod2.text = dummyMod2:NewAnnounce("%s", 1, "Interface\\Icons\\SPELL_HOLY_BORROWEDTIME")
				--timer, name, icon, optionDefault, optionName, colorType, inlineIcon, keep, countdown, countdownMax, r, g, b, spellId, requiresCombat, waCustomName, customType
				dummyMod2.timer = dummyMod2:NewTimer(20, L.TIMER_BREAK, "Interface\\Icons\\SPELL_HOLY_BORROWEDTIME", nil, nil, 0, nil, nil, DBM.Options.DontPlayPTCountdown and 0 or 1, threshold, nil, nil, nil, nil, nil, nil, "break")
			end
			--Cancel any existing break timers before creating new ones, we don't want double countdowns or mismatching blizz countdown text (cause you can't call another one if one is in progress)
			if not DBM.Options.DontShowPT2 then--and DBT:GetBar(L.TIMER_BREAK)
				dummyMod2.timer:Stop()
			end
			dummyMod2.text:Cancel()
			DBM.Options.RestoreSettingBreakTimer = nil
			if timer == 0 then return end--"/dbm break 0" will strictly be used to cancel the break timer (which is why we let above part of code run but not below)
			self.Options.RestoreSettingBreakTimer = timer.."/"..time()
			if not self.Options.DontShowPT2 then
				dummyMod2.timer:Start(timer)
				sendSync("DBMv4-Pizza", ("%s\t%s\t%s"):format(timer, L.TIMER_BREAK, tostring(true))) -- Backwards compatibility so old DBMs can receive break timers from this DBM
			end
			if not self.Options.DontShowPTText then
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
				dummyMod2.text:Show(L.BREAK_START:format(strFromTime(timer).." ("..hour..":"..minute..")", sender))
				if timer/60 > 10 then dummyMod2.text:Schedule(timer - 10*60, L.BREAK_MIN:format(10)) end
				if timer/60 > 5 then dummyMod2.text:Schedule(timer - 5*60, L.BREAK_MIN:format(5)) end
				if timer/60 > 2 then dummyMod2.text:Schedule(timer - 2*60, L.BREAK_MIN:format(2)) end
				if timer/60 > 1 then dummyMod2.text:Schedule(timer - 1*60, L.BREAK_MIN:format(1)) end
				dummyMod2.text:Schedule(timer, L.ANNOUNCE_BREAK_OVER:format(hour..":"..minute))
			end
			AceTimer:ScheduleTimer(function() self.Options.RestoreSettingBreakTimer = nil end, timer)
		end
	end

	syncHandlers["DBMv4-BT"] = function(sender, timer)
		if DBM.Options.DontShowUserTimers then return end
		timer = tonumber(timer or 0)
		if timer > 3600 then return end
		if (DBM:GetRaidRank(sender) == 0 and IsInGroup()) or select(2, IsInInstance()) == "pvp" then
			return
		end
		if timer == 0 or DBM:AntiSpam(1, "BT"..sender) then
			breakTimerStart(DBM, timer, sender)
		end
	end

	whisperSyncHandlers["DBMv4-BTR3"] = function(sender, timer)
		if DBM.Options.DontShowUserTimers then return end
		timer = tonumber(timer or 0)
		if timer > 3600 then return end
		DBM:Unschedule(DBM.RequestTimers)--IF we got BTR3 sync, then we know immediately RequestTimers was successful, so abort others
		if #inCombat >= 1 then return end
		if DBT:GetBar(L.TIMER_BREAK) then return end--Already recovered. Prevent duplicate recovery
		DBM:Debug("BTR3 calling breakTimerStart from "..sender.." with remaining "..timer, 3)
		breakTimerStart(DBM, timer, sender)
	end

	local function SendVersion(guild)
		if guild then
			local message = ("%s\t%s\t%s"):format(tostring(DBM.Revision), tostring(DBM.ReleaseRevision), DBM.DisplayVersion)
			sendGuildSync("DBMv4-GV", message)
			return
		end
		if DBM.Options.FakeBWVersion and not dbmIsEnabled then
			SendAddonMessage("BWVR3", bwVersionResponseString:format(fakeBWVersion), GetNumRaidMembers() > 0 and "RAID" or "PARTY")
			return
		end
		--(Note, faker isn't to screw with bigwigs nor is theirs to screw with dbm, but rathor raid leaders who don't let people run WTF they want to run)
		local VPVersion
		local VoicePack = DBM.Options.ChosenVoicePack2
		if not voiceSessionDisabled and VoicePack ~= "None" and DBM.VoiceVersions[VoicePack] then
			VPVersion = "/ VP"..VoicePack..": v"..DBM.VoiceVersions[VoicePack]
		end
		if VPVersion then
			sendSync("DBMv4-Ver", ("%s\t%s\t%s\t%s\t%s\t%s"):format(tostring(DBM.Revision), tostring(DBM.ReleaseRevision), DBM.DisplayVersion, GetLocale(), tostring(not DBM.Options.DontSetIcons), VPVersion))
		else
			sendSync("DBMv4-Ver", ("%s\t%s\t%s\t%s\t%s"):format(tostring(DBM.Revision), tostring(DBM.ReleaseRevision), DBM.DisplayVersion, GetLocale(), tostring(not DBM.Options.DontSetIcons)))
		end
	end

	local function HandleVersion(revision, version, displayVersion, sender)
		if version > DBM.Revision then -- Update reminder
			if version > currentFullDate() then return end -- ignore versions higher than current date to prevent abuse
			if #newerVersionPerson < 4 then
				if not checkEntry(newerVersionPerson, sender) then
					newerVersionPerson[#newerVersionPerson + 1] = sender
					DBM:Debug("Newer version detected from "..sender.." : Rev - "..revision..", Ver - "..version..", Rev Diff - "..(revision - DBM.Revision), 3)
				end
				if #newerVersionPerson == 2 and updateNotificationDisplayed < 2 then--Only requires 2 for update notification.
					if DBM.HighestRelease < version then
						DBM.HighestRelease = version--Increase HighestRelease
						DBM.NewerVersion = displayVersion--Apply NewerVersion
						--UGLY hack to get release version number instead of alpha one
						if DBM.NewerVersion:find("alpha") then
							local temp1, _ = string.split(" ", DBM.NewerVersion)--Strip down to just version, no alpha
							if temp1 then
								local temp3, temp4, temp5 = string.split(".", temp1)--Strip version down to 3 numbers
								if temp3 and temp4 and temp5 and tonumber(temp5) then
									temp5 = tonumber(temp5)
									temp5 = temp5 - 1
									temp5 = tostring(temp5)
									DBM.NewerVersion = temp3.."."..temp4.."."..temp5
								end
							end
						end
					end
					--Find min revision.
					updateNotificationDisplayed = 2
					AddMsg(DBM, L.UPDATEREMINDER_HEADER:match("([^\n]*)"))
					AddMsg(DBM, L.UPDATEREMINDER_HEADER:match("\n(.*)"):format(displayVersion, showRealDate(version)))
					showConstantReminder = 1
				elseif #newerVersionPerson >= 3 and updateNotificationDisplayed < 3 then--The following code requires at least THREE people to send that higher revision. That should be more than adaquate
					--Disable if out of date and it's a major patch.
					if not testBuild and dbmToc < wowTOC then
						updateNotificationDisplayed = 3
						DBM:ForceDisableSpam()
						DBM:Disable(true)
						--Disallow out of date to run during beta/ptr what so ever.
					elseif testBuild then
						updateNotificationDisplayed = 3
						DBM:ForceDisableSpam()
						DBM:Disable(true)
					end
				end
			end
		end
	end

	-- is there a good reason that version information is broadcasted and not unicasted?
	syncHandlers["DBMv4-H"] = function()
		DBM:Unschedule(SendVersion)--Throttle so we don't needlessly send tons of comms during initial raid invites
		DBM:Schedule(3, SendVersion)--Send version if 3 seconds have past since last "Hi" sync
	end

	guildSyncHandlers["DBMv4-GH"] = function()
		if DBM.ReleaseRevision >= DBM.HighestRelease then--Do not send version to guild if it's not up to date, since this is only used for update notifcation
			DBM:Unschedule(SendVersion, true)
			--Throttle so we don't needlessly send tons of comms
			--For every 50 players online, DBM has an increasingly lower chance of replying to a version check request. This is because only 3 people actually need to reply
			--50 people or less, 100% chance anyone who saw request will reply
			--100 people on, only 50% chance DBM users replies to request
			--150 people on, only 33% chance a DBM user replies to request
			--1000 people online, only 5% chance a DBM user replies to request
			local totalMembers = GetNumGuildMembers()
			local online = 0
			for i = 1, totalMembers do
				local name, _, _, _, _, _, _, _, connected = GetGuildRosterInfo(i)
				if not name then break end

				if connected then
					online = online + 1
				end
			end
			local chances = (online or 1) / 50
			if chances < 1 then chances = 1 end
			if mrandom(1, chances) == 1 then
				DBM:Schedule(5, SendVersion, true)--Send version if 5 seconds have past since last "Hi" sync
			end
		end
	end

	syncHandlers["DBMv4-BV"] = function(sender, version, hash)--Parsed from bigwigs V7+
		if version and raid[sender] then
			raid[sender].bwversion = version
			raid[sender].bwhash = hash or ""
		end
	end

	syncHandlers["DBMv4-Ver"] = function(sender, revision, version, displayVersion, locale, iconEnabled, VPVersion)
		if revision == "Hi!" then
			DBM:Debug(("DBMv4-Ver Hi! %s %s %s %s"):format(DBM.Revision, DBM.ReleaseRevision, DBM.DisplayVersion, GetLocale()), 3)
			-- Use Retail "H" syncHandler instead
			handleSync(nil, sender, "DBMv4-H")
		else
			DBM:Debug(("DBMv4-Ver received %s %s %s %s from %s"):format(revision, version, displayVersion, locale, sender), 3)
			-- Use Retail "V" syncHandler instead
			handleSync(nil, sender, "DBMv4-V", revision, version, displayVersion, locale, iconEnabled, VPVersion)
		end
	end

	syncHandlers["DBMv4-V"] = function(sender, revision, version, displayVersion, locale, iconEnabled, VPVersion)
		revision, version = tonumber(revision), tonumber(version)
		if revision and version and displayVersion and raid[sender] then
			raid[sender].revision = revision
			raid[sender].version = version
			raid[sender].displayVersion = displayVersion
			raid[sender].VPVersion = VPVersion
			raid[sender].locale = locale
			raid[sender].enabledIcons = iconEnabled or "false"
			DBM:Debug("Received version info from "..sender.." : Rev - "..revision..", Ver - "..version..", Rev Diff - "..(revision - DBM.Revision), 3)
			HandleVersion(revision, version, displayVersion, sender)
		end
		DBM:RAID_ROSTER_UPDATE()
	end

	guildSyncHandlers["DBMv4-GV"] = function(sender, revision, version, displayVersion)
		revision, version = tonumber(revision), tonumber(version)
		if revision and version and displayVersion then
			DBM:Debug("Received G version info from "..sender.." : Rev - "..revision..", Ver - "..version..", Rev Diff - "..(revision - DBM.Revision)..", Display Version "..displayVersion, 3)
			HandleVersion(revision, version, displayVersion, sender)
		end
	end

	-- Workaround for mismatched clients locales: L.TIMER_PULL and L.TIMER_BREAK would be different and therefore would not play sounds since the receiver locale would be different than sender locale.
	local localized_TIMER_PULL = {
		"开怪倒计时",	--CN
		"Pull in",		--DE, EN
		"Iniciando en",	--ES
		"Pull en",		-- ES (old DBM)
		"Pull dans",	--FR
		"풀링",			--KR
		"풀링 중 입니다",--KR (old DBM)
		"Атака",		--RU
		"戰鬥準備"		--TW
	}
	local localized_TIMER_BREAK = {
		"休息时间！",		-- CN
		"Pause!",			-- DE
		"Pause",			-- DE (old DBM)
		"Break time!",		-- EN, FR (old DBM)
		"Break starting now -- you have %s! (Sent by %s)", -- EN (wrong locale, pre 7.09)
		"¡Toca descanso!",	-- ES
		"¡Descanso!",		-- ES (old DBM)
		"Pause !",			-- FR
		"쉬는 시간!",		-- KR
		"Перерыв!",			-- RU
		"休息時間!"			-- TW
	}

	syncHandlers["DBMv4-Pizza"] = function(sender, time, text, new)
		if select(2, IsInInstance()) == "pvp" then return end
		if DBM:GetRaidRank(sender) == 0 then return end
		if sender == UnitName("player") then return end
		time = tonumber(time or 0)
		text = tostring(text)
		if time and text then
			local pullTimer = tContains(localized_TIMER_PULL, tostring(text)) and L.TIMER_PULL or nil -- Fixes localization of pull bar text
			local breakTimer = tContains(localized_TIMER_BREAK, tostring(text)) and L.TIMER_BREAK or nil -- Fixes localization of break bar text
			if pullTimer then
				if new then return end
				handleSync(nil, sender, "DBMv4-PT", time, text)
			elseif breakTimer then
				if new then return end
				handleSync(nil, sender, "DBMv4-BT", time, text)
			else
				DBM:CreatePizzaTimer(time, text, nil, sender)
			end
		end
	end

	-- beware, ugly and missplaced code ahead
	-- todo: move this somewhere else
	do
		local accessList = {}
		local savedSender

		local inspopup = CreateFrame("Frame", "DBMPopupLockout", UIParent)
		inspopup:SetBackdrop({bgFile = "Interface\\DialogFrame\\UI-DialogBox-Background-Dark",
			edgeFile = "Interface\\DialogFrame\\UI-DialogBox-Border",
			tile = true, tileSize = 16, edgeSize = 16,
			insets = {left = 1, right = 1, top = 1, bottom = 1}}
		)
		inspopup:SetSize(500, 120)
		inspopup:SetPoint("TOP", UIParent, "TOP", 0, -200)
		inspopup:SetFrameStrata("DIALOG")

		local inspopuptext = inspopup:CreateFontString()
		inspopuptext:SetFontObject(ChatFontNormal)
		inspopuptext:SetWidth(470)
		inspopuptext:SetWordWrap(true)
		inspopuptext:SetPoint("TOP", inspopup, "TOP", 0, -15)

		local buttonaccept = CreateFrame("Button", nil, inspopup)
		buttonaccept:SetNormalTexture("Interface\\Buttons\\UI-DialogBox-Button-Up")
		buttonaccept:SetPushedTexture("Interface\\Buttons\\UI-DialogBox-Button-Down")
		buttonaccept:SetHighlightTexture("Interface\\Buttons\\UI-DialogBox-Button-Highlight", "ADD")
		buttonaccept:SetSize(128, 35)
		buttonaccept:SetPoint("BOTTOM", inspopup, "BOTTOM", -75, 0)

		local buttonatext = buttonaccept:CreateFontString()
		buttonatext:SetFontObject(ChatFontNormal)
		buttonatext:SetPoint("CENTER", buttonaccept, "CENTER", 0, 5)
		buttonatext:SetText(YES)

		local buttondecline = CreateFrame("Button", nil, inspopup)
		buttondecline:SetNormalTexture("Interface\\Buttons\\UI-DialogBox-Button-Up")
		buttondecline:SetPushedTexture("Interface\\Buttons\\UI-DialogBox-Button-Down")
		buttondecline:SetHighlightTexture("Interface\\Buttons\\UI-DialogBox-Button-Highlight", "ADD")
		buttondecline:SetSize(128, 35)
		buttondecline:SetPoint("BOTTOM", inspopup, "BOTTOM", 75, 0)

		local buttondtext = buttondecline:CreateFontString()
		buttondtext:SetFontObject(ChatFontNormal)
		buttondtext:SetPoint("CENTER", buttondecline, "CENTER", 0, 5)
		buttondtext:SetText(NO)

		inspopup:Hide()

		local function autoDecline(sender, force)
			inspopup:Hide()
			savedSender = nil
			if force then
				SendAddonMessage("DBMv4-II", "denied",  "WHISPER", sender)
			else
				SendAddonMessage("DBMv4-II", "timeout", "WHISPER", sender)
			end
		end

		local function showPopupInstanceIdPermission(sender)
			DBM:Unschedule(autoDecline)
			DBM:Schedule(59, autoDecline, sender)
			inspopup:Hide()
			if savedSender ~= sender then
				if savedSender then
					autoDecline(savedSender, 1) -- Do not allow multiple popups, so auto decline to previous sender.
				end
				savedSender = sender
			end
			inspopuptext:SetText(L.REQ_INSTANCE_ID_PERMISSION:format(sender, sender))
			buttonaccept:SetScript("OnClick", function(f) savedSender = nil DBM:Unschedule(autoDecline) accessList[sender] = true syncHandlers["IR"](sender) f:GetParent():Hide() end)
			buttondecline:SetScript("OnClick", function() autoDecline(sender, 1) end)
			DBM:PlaySound(850)
			inspopup:Show()
		end

		syncHandlers["DBMv4-IR"] = function(sender)
			if DBM:GetRaidRank(sender) == 0 or sender == playerName then
				return
			end
			accessList = accessList or {}
			if not accessList[sender] then
				-- ask for permission
				showPopupInstanceIdPermission(sender)
				return
			end
			-- okay, send data
			local sentData = false
			for i = 1, GetNumSavedInstances() do
				local name, id, _, difficulty, locked, extended, _, isRaid, maxPlayers, textDiff, _, progress = GetSavedInstanceInfo(i)
				if (locked or extended) and isRaid then -- only report locked raid instances
					SendAddonMessage("DBMv4-II", "Data\t" .. name .. "\t" .. id .. "\t" .. difficulty .. "\t" .. maxPlayers .. "\t" .. (progress or 0) .. "\t" .. textDiff, "WHISPER", sender)
					sentData = true
				end
			end
			if not sentData then
				-- send something even if there is nothing to report so the receiver is able to tell you apart from someone who just didn't respond...
				SendAddonMessage("DBMv4-II", "NoData", "WHISPER", sender)
			end
		end

		syncHandlers["DBMv4-IRE"] = function(sender)
			local popup = inspopup:IsShown()
			if popup and savedSender == sender then -- found the popup with the correct data
				savedSender = nil
				DBM:Unschedule(autoDecline)
				inspopup:Hide()
			end
		end

		guildSyncHandlers["DBMv4-GCB"] = function(_, modId, ver, difficulty, name, groupLeader)
			if not DBM.Options.ShowGuildMessages or not difficulty or DBM:GetRaidRank(groupLeader or "") == 2 then return end
			if not ver or ver ~= "4" then return end--Ignore old versions
			if DBM:AntiSpam(10, "GCB") then
				if IsInInstance() then return end--Simple filter, if you are inside an instance, just filter it, if not in instance, good to go.
				difficulty = tonumber(difficulty)
				if not DBM.Options.ShowGuildMessagesPlus then return end
				modId = tonumber(modId)
				local bossName = modId and DBM:GetModLocalization(modId).general.name or name or CL.UNKNOWN
				local difficultyName
				if difficulty == 4 then
					difficultyName = RAID_DIFFICULTY4
				elseif difficulty == 3 then
					difficultyName = RAID_DIFFICULTY3
				elseif difficulty == 2 then
					difficultyName = PLAYER_DIFFICULTY2
				else
					difficultyName = PLAYER_DIFFICULTY1
				end
				DBM:AddMsg(L.GUILD_COMBAT_STARTED:format(difficultyName.."-"..bossName, groupLeader))-- "%s has been engaged by %s's guild group"
			end
		end

		guildSyncHandlers["DBMv4-GCE"] = function(_, modId, ver, wipe, time, difficulty, name, groupLeader, wipeHP)
			if not DBM.Options.ShowGuildMessages or not difficulty or DBM:GetRaidRank(groupLeader or "") == 2 then return end
			if not ver or ver ~="8" then return end--Ignore old versions
			if DBM:AntiSpam(10, "GCE") then
				if IsInInstance() then return end--Simple filter, if you are inside an instance, just filter it, if not in instance, good to go.
				difficulty = tonumber(difficulty)
				if not DBM.Options.ShowGuildMessagesPlus then return end
				modId = tonumber(modId)
				local bossName = modId and DBM:GetModLocalization(modId).general.name or name or CL.UNKNOWN
				local difficultyName
				if difficulty == 4 then
					difficultyName = RAID_DIFFICULTY4
				elseif difficulty == 3 then
					difficultyName = RAID_DIFFICULTY3
				elseif difficulty == 2 then
					difficultyName = PLAYER_DIFFICULTY2
				else
					difficultyName = PLAYER_DIFFICULTY1
				end
				if wipe == "1" then
					DBM:AddMsg(L.GUILD_COMBAT_ENDED_AT:format(groupLeader or CL.UNKNOWN, difficultyName.."-"..bossName, wipeHP, time))--"%s's Guild group has wiped on %s (%s) after %s.
				else
					DBM:AddMsg(L.GUILD_BOSS_DOWN:format(difficultyName.."-"..bossName, groupLeader or CL.UNKNOWN, time))--"%s has been defeated by %s's guild group after %s!"
				end
			end
		end

		local lastRequest = 0
		local numResponses = 0
		local expectedResponses = 0
		local allResponded = false
		local results

		local updateInstanceInfo, showResults

		whisperSyncHandlers["DBMv4-II"] = function(sender, result, name, _, diff, maxPlayers, progress, textDiff) -- sender, result, name, id, diff, maxPlayers, progress, textDiff
			if GetTime() - lastRequest > 62 or not results then
				return
			end
			if not result then
				return
			end
			name = name or CL.UNKNOWN
			diff = tonumber(diff or 0) or 0
			maxPlayers = tonumber(maxPlayers or 0) or 0
			progress = tonumber(progress or 0) or 0
			textDiff = textDiff or ""

			-- count responses
			if not results.responses[sender] then
				results.responses[sender] = result
				numResponses = numResponses + 1
			end

			-- get localized difficulty text
			if textDiff ~= "" then
				results.difftext[diff] = textDiff
			end

			if result == "Data" then
				-- got data in that response and not just a "no" or "i'm away"
				local instanceId = name.." "..maxPlayers.." "..diff -- locale-dependant dungeon ID
				results.data[instanceId] = results.data[instanceId] or {
					ids = {}, -- array of all ids of all raid members
					name = name,
					diff = diff,
					maxPlayers = maxPlayers,
				}

				results.data[instanceId].ids[progress] = results.data[instanceId].ids[progress] or { progress = progress }
				tinsert(results.data[instanceId].ids[progress], sender)
			end

			if numResponses >= expectedResponses then -- unlikely, lol
				DBM:Unschedule(updateInstanceInfo)
				DBM:Unschedule(showResults)
				if not allResponded then --Only display message once in case we get for example 4 syncs the last sender
					DBM:Schedule(0.99, DBM.AddMsg, DBM, L.INSTANCE_INFO_ALL_RESPONSES)
					allResponded = true
				end
				AceTimer:ScheduleTimer(showResults, 1) --Delay results so we allow time for same sender to send more than 1 lockout, otherwise, if we get expectedResponses before all data is sent from 1 user, we clip some of their data.
			end
		end

		function showResults()
			local resultCount = 0
			-- you could catch some localized instances by observing IDs if there are multiple players with the same instance ID but a different name ;) (not that useful if you are trying to get a fresh instance)
			DBM:AddMsg(L.INSTANCE_INFO_RESULTS, false)
			DBM:AddMsg("---", false)
			for _, v in pairs(results.data) do
				resultCount = resultCount + 1
				DBM:AddMsg(L.INSTANCE_INFO_DETAIL_HEADER:format(v.name, (results.difftext[v.diff] or v.diff)), false)
				for id, r in pairs(v.ids) do
					if r.haveid then
						DBM:AddMsg(L.INSTANCE_INFO_DETAIL_INSTANCE:format(id, r.progress, tconcat(r, ", ")), false)
					else
						DBM:AddMsg(L.INSTANCE_INFO_DETAIL_INSTANCE2:format(r.progress, tconcat(r, ", ")), false)
					end
				end
				DBM:AddMsg("---", false)
			end
			if resultCount == 0 then
				DBM:AddMsg(L.INSTANCE_INFO_NOLOCKOUT, false)
			end
			local denied = {}
			local away = {}
			local noResponse = {}
			for i = 1, GetNumRaidMembers() do
				if not UnitIsUnit("raid"..i, "player") then
					tinsert(noResponse, (GetRaidRosterInfo(i)))
				end
			end
			for i, v in pairs(results.responses) do
				if v == "Data" or v == "NoData" then
				elseif v == "timeout" then
					tinsert(away, i)
				else -- could be "clicked" or "override", in both cases we don't get the data because the dialog requesting it was dismissed
					tinsert(denied, i)
				end
				removeEntry(noResponse, i)
			end
			if #denied > 0 then
				DBM:AddMsg(L.INSTANCE_INFO_STATS_DENIED:format(tconcat(denied, ", ")), false)
			end
			if #away > 0 then
				DBM:AddMsg(L.INSTANCE_INFO_STATS_AWAY:format(tconcat(away, ", ")), false)
			end
			if #noResponse > 0 then
				DBM:AddMsg(L.INSTANCE_INFO_STATS_NO_RESPONSE:format(tconcat(noResponse, ", ")), false)
			end
			results = nil
		end

		-- called when the chat link is clicked
		function DBM:ShowRaidIDRequestResults()
			if not results then -- check if we are currently querying raid IDs, results will be nil if we don't
				return
			end
			self:Unschedule(updateInstanceInfo)
			self:Unschedule(showResults)
			showResults() -- sets results to nil after the results are displayed, ending the current id request; future incoming data will be discarded
			sendSync("DBMv4-IRE")
		end

		local function getResponseStats()
			local numResponses = 0
			local sent = 0
			local denied = 0
			local away = 0
			for _, v in pairs(results.responses) do
				numResponses = numResponses + 1
				if v == "Data" or v == "NoData" then
					sent = sent + 1
				elseif v == "timeout" then
					away = away + 1
				else -- could be "clicked" or "override", in both cases we don't get the data because the dialog requesting it was dismissed
					denied = denied + 1
				end
			end
			return numResponses, sent, denied, away
		end

		local function getNumDBMUsers() -- without ourselves
			local r = 0
			for _, v in pairs(raid) do
				if v.revision and v.name ~= playerName and UnitIsConnected(v.id) then
					r = r + 1
				end
			end
			return r
		end

		function updateInstanceInfo(timeRemaining, dontAddShowResultNowButton)
			local numResponses, sent, denied = getResponseStats()
			local dbmUsers = getNumDBMUsers()
			DBM:AddMsg(L.INSTANCE_INFO_STATUS_UPDATE:format(numResponses, dbmUsers, sent, denied, timeRemaining), false)
			if not dontAddShowResultNowButton then
				if dbmUsers - numResponses <= 7 then -- waiting for 7 or less players, show their names and the early result option
					-- copied from above, todo: implement a smarter way of keeping track of stuff like this
					local noResponse = {}
					for i = 1, GetNumRaidMembers() do
						if not UnitIsUnit("raid"..i, "player") and raid[GetRaidRosterInfo(i)] and raid[GetRaidRosterInfo(i)].revision then -- only show players who actually can respond (== DBM users)
							tinsert(noResponse, (GetRaidRosterInfo(i)))
						end
					end
					for i, _ in pairs(results.responses) do
						removeEntry(noResponse, i)
					end

					--[[
					-- this looked like the easiest way (for some reason?) to create the player string when writing this code -.-
					local function dup(...) if select("#", ...) == 0 then return else return ..., ..., dup(select(2, ...)) end end
					DBM:AddMsg(L.INSTANCE_INFO_SHOW_RESULTS:format(("|Hplayer:%s|h[%s]|h| "):rep(#noResponse):format(dup(unpack(noResponse)))), false)
					]]
					-- code that one can actually read
					for i, v in ipairs(noResponse) do
						noResponse[i] = ("|Hplayer:%s|h[%s]|h|"):format(v, v)
					end
					DBM:AddMsg(L.INSTANCE_INFO_SHOW_RESULTS:format(tconcat(noResponse, ", ")), false)
				end
			end
		end

		function DBM:RequestInstanceInfo()
			self:AddMsg(L.INSTANCE_INFO_REQUESTED)
			lastRequest = GetTime()
			allResponded = false
			results = {
				responses = { -- who responded to our request?
				},
				data = { -- the actual data
				},
				difftext = {
				}
			}
			numResponses = 0
			expectedResponses = getNumDBMUsers()
			sendSync("DBMv4-IR")
			self:Unschedule(updateInstanceInfo)
			self:Unschedule(showResults)
			self:Schedule(17, updateInstanceInfo, 45, true)
			self:Schedule(32, updateInstanceInfo, 30)
			self:Schedule(48, updateInstanceInfo, 15)
--			AceTimer:ScheduleTimer(showResults,62)
		end
	end

	guildSyncHandlers["DBMv4-WBE"] = function(sender, modId, realm, health, ver, name)
		if not ver or ver ~="8" then return end--Ignore old versions
		if lastBossEngage[modId..realm] and (GetTime() - lastBossEngage[modId..realm] < 30) then return end--We recently got a sync about this boss on this realm, so do nothing.
		lastBossEngage[modId..realm] = GetTime()
		if realm == playerRealm and DBM.Options.WorldBossAlert and not mod.InCombat then
			modId = tonumber(modId)--If it fails to convert into number, this makes it nil
			local bossName = modId and DBM:GetModLocalization(modId).general.name or name or CL.UNKNOWN
			DBM:AddMsg(L.WORLDBOSS_ENGAGED:format(bossName, floor(health), sender))
		end
	end

	guildSyncHandlers["DBMv4-WBD"] = function(sender, modId, realm, ver, name)
		if not ver or ver ~="8" then return end--Ignore old versions
		if lastBossDefeat[modId..realm] and (GetTime() - lastBossDefeat[modId..realm] < 30) then return end
		lastBossDefeat[modId..realm] = GetTime()
		if realm == playerRealm and DBM.Options.WorldBossAlert and not mod.InCombat then
			modId = tonumber(modId)--If it fails to convert into number, this makes it nil
			local bossName = modId and DBM:GetModLocalization(modId).general.name or name or CL.UNKNOWN
			DBM:AddMsg(L.WORLDBOSS_DEFEATED:format(bossName, sender))
		end
	end

	guildSyncHandlers["DBMv4-WBA"] = function(sender, bossName, faction, spellId, time, ver)
		DBM:Debug("WBA sync recieved")
		if not ver or ver ~= "4" then return end--Ignore old versions
		if lastBossEngage[bossName..faction] and (GetTime() - lastBossEngage[bossName..faction] < 30) then return end--We recently got a sync about this buff on this realm, so do nothing.
		lastBossEngage[bossName..faction] = GetTime()
		if DBM.Options.WorldBuffAlert and #inCombat == 0 then
			DBM:Debug("WBA sync processing")
			local factionText = faction == "Alliance" and FACTION_ALLIANCE or faction == "Horde" and FACTION_HORDE or CL.BOTH
			local buffName, _, buffIcon = DBM:GetSpellInfo(tonumber(spellId) or 0)
			DBM:AddMsg(L.WORLDBUFF_STARTED:format(buffName or CL.UNKNOWN, factionText, sender))
			DBM:PlaySound(DBM.Options.RaidWarningSound, true)
			time = tonumber(time)
			if time then
				DBT:CreateBar(time, buffName or CL.UNKNOWN, buffIcon or "Interface\\Icons\\Spell_Holy_BorrowedTime")
			end
		end
	end

	whisperSyncHandlers["DBMv4-WBE"] = function(sender, modId, realm, health, ver, name)
		if not ver or ver ~= "8" then return end--Ignore old versions
		if lastBossEngage[modId..realm] and (GetTime() - lastBossEngage[modId..realm] < 30) then return end
		lastBossEngage[modId..realm] = GetTime()
		if realm == playerRealm and DBM.Options.WorldBossAlert and (not DBM:IsEncounterInProgress() or #inCombat == 0) then
			local toonName = sender or CL.UNKNOWN
			modId = tonumber(modId)--If it fails to convert into number, this makes it nil
			local bossName = modId and DBM:GetModLocalization(modId).general.name or name or CL.UNKNOWN
			DBM:AddMsg(L.WORLDBOSS_ENGAGED:format(bossName, floor(health), toonName))
		end
	end

	whisperSyncHandlers["DBMv4-WBD"] = function(sender, modId, realm, ver, name)
		if not ver or ver ~="8" then return end--Ignore old versions
		if lastBossDefeat[modId..realm] and (GetTime() - lastBossDefeat[modId..realm] < 30) then return end
		lastBossDefeat[modId..realm] = GetTime()
		if realm == playerRealm and DBM.Options.WorldBossAlert and not mod.InCombat then
			local toonName = sender or CL.UNKNOWN
			modId = tonumber(modId)--If it fails to convert into number, this makes it nil
			local bossName = modId and DBM:GetModLocalization(modId).general.name or name or CL.UNKNOWN
			DBM:AddMsg(L.WORLDBOSS_DEFEATED:format(bossName, toonName))
		end
	end

	whisperSyncHandlers["DBMv4-RequestTimers"] = function(sender)
		if UnitInBattleground("player") then
			DBM:SendPVPTimers(sender)
		else
			DBM:SendTimers(sender)
		end
	end

	whisperSyncHandlers["DBMv4-CombatInfo"] = function(sender, mod, time)
		mod = DBM:GetModByName(mod or "")
		time = tonumber(time or 0)
		if mod and time then
			DBM:ReceiveCombatInfo(sender, mod, time)
		end
	end

	whisperSyncHandlers["DBMv4-TimerInfo"] = function(sender, mod, timeLeft, totalTime, id, paused, ...)
		mod = DBM:GetModByName(mod or "")
		timeLeft = tonumber(timeLeft or 0)
		totalTime = tonumber(totalTime or 0)
		if mod and timeLeft and timeLeft > 0 and totalTime and totalTime > 0 and id then
			DBM:ReceiveTimerInfo(sender, mod, timeLeft, totalTime, id, paused and paused == "1" and true or false, ...)
		end
	end

	whisperSyncHandlers["DBMv4-VarInfo"] = function(sender, mod, name, value)
		mod = DBM:GetModByName(mod or "")
		value = tonumber(value) or value
		if mod and name and value then
			DBM:ReceiveVariableInfo(sender, mod, name, value)
		end
	end

	handleSync = function(channel, sender, prefix, ...)
		if not prefix then
			return
		end
		local handler
		--Whisper syncs sent from non friends are automatically rejected if not from a friend or someone in your group
		if channel == "WHISPER" and sender ~= playerName then -- separate between broadcast and unicast, broadcast must not be sent as unicast or vice-versa
			if (checkForSafeSender(sender, true) or DBM:GetRaidUnitId(sender)) then--Sender passes safety check, or is in group
				handler = whisperSyncHandlers[prefix]
			end
		elseif channel == "GUILD" then
			handler = guildSyncHandlers[prefix]
		else
			handler = syncHandlers[prefix]
		end
		if handler then
			return handler(sender, ...)
		end
	end

	function DBM:CHAT_MSG_ADDON(prefix, msg, channel, sender)
		if strsub(prefix, 1, 5) == DBMPrefix and msg and (channel == "PARTY" or channel == "RAID" or channel == "BATTLEGROUND" or channel == "WHISPER" or channel == "GUILD") then
			handleSync(channel, sender, prefix, strsplit("\t", msg))
		elseif (prefix == "BigWigs" or strsub(prefix, 1, 2) == "BW") and msg and (channel == "PARTY" or channel == "RAID") then
			if prefix == "BigWigs" then--Boss Mod Sync
				for i = 1, #inCombat do
					local mod = inCombat[i]
					if mod and mod.OnBWSync then
						mod:OnBWSync(msg, sender)
					end
				end
				for i = 1, #oocBWComms do
					local mod = oocBWComms[i]
					if mod and mod.OnBWSync then
						mod:OnBWSync(msg, sender)
					end
				end
			else
				local bwPrefix = strsub(prefix, 3, 5)
				if bwPrefix then
					if bwPrefix == "VR3" then
						local verString = msg
						local version = tonumber(verString) or 0
						if version == 0 then return end--Just a query
						handleSync(channel, sender, "DBMv4-BV", version)--Prefix changed, so it's not handled by DBMs "V" handler
						if version > fakeBWVersion then--Newer revision found, upgrade!
							fakeBWVersion = version
						end
					elseif bwPrefix == "VQ3" then--Version request prefix
						self:Unschedule(SendVersion)
						self:Schedule(3, SendVersion)
					end
				end
			end
		elseif prefix == "Transcriptor" and msg then
			for i = 1, #inCombat do
				local mod = inCombat[i]
				if mod and mod.OnTranscriptorSync then
					mod:OnTranscriptorSync(msg, sender)
				end
			end
			local transcriptor = _G["Transcriptor"]
			if msg:find("spell:") and (DBM.Options.DebugLevel > 2 or (transcriptor and transcriptor:IsLogging())) then
				local spellId = string.match(msg, "spell:(%d+)") or CL.UNKNOWN
				local spellName = string.match(msg, "h%[(.-)%]|h") or CL.UNKNOWN
				local message = "RAID_BOSS_WHISPER on "..sender.." with spell of "..spellName.." ("..spellId..")"
				self:Debug(message)
			end
		end
	end
end

----------------------
--  Pull Detection  --
----------------------
do
	local targetList = {}
	local function buildTargetList()
		-- target or groupMemberTarget
		local uId = ((GetNumRaidMembers() == 0) and "party") or "raid"
		for i = 0, mmax(GetNumRaidMembers(), GetNumPartyMembers()) do
			local id = (i == 0 and "target") or uId..i.."target"
			local guid = UnitGUID(id)
			if guid and DBM:IsCreatureGUID(guid) then
				local cId = DBM:GetCIDFromGUID(guid)
				targetList[cId] = id
			end
		end
		-- boss
		for i = 0, 5 do
			local id = "boss" .. i
			local guid = UnitGUID(id)
			if guid and DBM:IsCreatureGUID(guid) then
				local cId = DBM:GetCIDFromGUID(guid)
				targetList[cId] = id
			end
		end
		-- focus (for non IEEU scripts)
		local guid = UnitGUID("focus")
		if guid and DBM:IsCreatureGUID(guid) then
			local cId = DBM:GetCIDFromGUID(guid)
			targetList[cId] = "focus"
		end
	end

	local function clearTargetList()
		twipe(targetList)
	end

	local function scanForCombat(mod, mob, delay, force) -- custom "force" arg for 3.3.5a PLAYER_REGEN_DISABLED
		if not checkEntry(inCombat, mob) then
			buildTargetList()
			if targetList[mob] then
				if mod.noFriendlyEngagement and UnitIsFriend("player", targetList[mob]) then return end
				if (force or delay > 0) and UnitAffectingCombat(targetList[mob]) and not (UnitPlayerOrPetInRaid(targetList[mob]) or UnitPlayerOrPetInParty(targetList[mob])) then
					DBM:StartCombat(mod, delay, "PLAYER_REGEN_DISABLED")
				elseif (delay == 0) and not force then
					DBM:StartCombat(mod, 0, "PLAYER_REGEN_DISABLED_AND_MESSAGE")
				end
			end
			clearTargetList()
		end
	end

	local function checkForPull(mob, combatInfo)
		healthCombatInitialized = false
		--This just can't be avoided, trying to save cpu by using C_TimerAfter broke this
		--This needs the redundancy and ability to pass args.
		scanForCombat(combatInfo.mod, mob, 0, true) -- Since 3.3.5a does not have ENCOUNTER_START, and IEEU is not implemented everywhere, a scan is fired instantly on PLAYER_REGEN_DISABLED, rather than waiting 0.5s. Uses custom arg to use the scanForCombat UnitAffectingCombat checks
		DBM:Schedule(0.5, scanForCombat, combatInfo.mod, mob, 0.5)
		-- DBM:Schedule(1.25, scanForCombat, combatInfo.mod, mob, 1.25)
		DBM:Schedule(2, scanForCombat, combatInfo.mod, mob, 2)
		DBM:Schedule(2.1, function()
			healthCombatInitialized = true
		end)
	end

	-- TODO: fix the duplicate code that was added for quick & dirty support of zone IDs

	-- detects a boss pull based on combat state, this is required for pre-ICC bosses that do not fire INSTANCE_ENCOUNTER_ENGAGE_UNIT events on engage
	function DBM:PLAYER_REGEN_DISABLED()
--		lastCombatStarted = GetTime()
		if not combatInitialized then return end
		local combat = combatInfo[LastInstanceMapID] or combatInfo[LastInstanceZoneName]
		if dbmIsEnabled and combat then
			for _, v in ipairs(combat) do
				if v.type:find("combat") and not v.noRegenDetection and not (#inCombat > 0 and v.noMultiBoss) then
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
		if self.Options.AFKHealthWarning and not DBM:IsEncounterInProgress() and UnitIsAFK("player") and self:AntiSpam(5, "AFK") then--You are afk and losing health, some griever is trying to kill you while you are afk/tabbed out.
			self:FlashClientIcon()
			local voice = DBM.Options.ChosenVoicePack2
			local path = 8585--"Sound\\Creature\\CThun\\CThunYouWillDIe.wav"
			if not voiceSessionDisabled and voice ~= "None" then
				path = "Interface\\AddOns\\DBM-VP"..voice.."\\checkhp.ogg"
			end
			self:PlaySound(path)
			if UnitHealthMax("player") ~= 0 then
				local health = UnitHealth("player") / UnitHealthMax("player") * 100
				self:AddMsg(L.AFK_WARNING:format(health))
			end
		end
	end

	function DBM:PLAYER_REGEN_ENABLED()
		if delayedFunction then--Will throw error if not a function, purposely not doing and type(delayedFunction) == "function" for now to make sure code works though because it always should be function
			delayedFunction()
			delayedFunction = nil
		end
		if watchFrameRestore then
			WatchFrame:Show()
			watchFrameRestore = false
		end
		if self.Options.FixCLEUOnCombatStart then
			self:Schedule(0.5, CombatLogClearEntries)
			self:Debug("Scheduled FixCLEU from PLAYER_REGEN_DISABLED")
		end
	end

	local function isBossEngaged(cId)
		-- note that this is designed to work with any number of bosses, but it might be sufficient to check the first 5 unit ids
		local i = 1
		repeat
			local bossUnitId = "boss"..i
			local bossGUID = not UnitIsDead(bossUnitId) and UnitGUID(bossUnitId) -- check for UnitIsVisible maybe?
			local bossCId = bossGUID and DBM:GetCIDFromGUID(bossGUID)
			if bossCId and (type(cId) == "number" and cId == bossCId or type(cId) == "table" and checkEntry(cId, bossCId)) then
				return true
			end
			i = i + 1
		until not bossGUID
	end

	function DBM:INSTANCE_ENCOUNTER_ENGAGE_UNIT()
		if timerRequestInProgress then return end--do not start ieeu combat if timer request is progressing. (not to break Timer Recovery stuff)
		local combat =  combatInfo[LastInstanceMapID] or combatInfo[LastInstanceZoneName]
		if dbmIsEnabled and combat then
			self:Debug("INSTANCE_ENCOUNTER_ENGAGE_UNIT event fired for zoneId"..LastInstanceMapID, 3)
			for _, v in ipairs(combat) do
				if not v.noIEEUDetection and not (#inCombat > 0 and v.noMultiBoss) then
					if v.type:find("combat") and isBossEngaged(v.multiMobPullDetection or v.mob) then
						self:StartCombat(v.mod, 0, "IEEU")
					end
				end
			end
		end
	end

	local questFrame
	local questTbl = {}
	local function IsQuestFlaggedCompleted(questID)
		-- Load completed quests from the server
		if not questFrame then
			questFrame = CreateFrame("Frame")
			questFrame:RegisterEvent("QUEST_QUERY_COMPLETE")
			questFrame:SetScript("OnEvent", function()
				questTbl = GetQuestsCompleted()
			end)
		end
		QueryQuestsCompleted()

		-- Check if questID is completed from the table
		if tContains(questTbl, questID) then
			return true
		else
			return false
		end
	end

	local function checkExpressionList(exp, str)
		for _, v in ipairs(exp) do
			if str:match(v) then
				return true
			end
		end
		return false
	end

	-- called for all mob chat events
	local function onMonsterMessage(self, type, msg)
		-- pull detection
		local combat = combatInfo[LastInstanceMapID] or combatInfo[LastInstanceZoneName]
		if dbmIsEnabled and combat then
			for _, v in ipairs(combat) do
				if (v.type == type and checkEntry(v.msgs, msg) or v.type == type .. "_regex" and checkExpressionList(v.msgs, msg)) and not (#inCombat > 0 and v.noMultiBoss) then
					self:StartCombat(v.mod, 0, "MONSTER_MESSAGE")
				elseif (v.type == "combat_" .. type .. "find" and tContains(v.msgs, msg) or v.type == "combat_" .. type and checkEntry(v.msgs, msg)) and not (#inCombat > 0 and v.noMultiBoss) then
					if IsInInstance() then--Indoor boss that uses both combat and message for combat, so in other words (such as hodir), don't require "target" of boss for yell like scanForCombat does for World Bosses
						self:StartCombat(v.mod, 0, "MONSTER_MESSAGE")
					else--World Boss
						scanForCombat(v.mod, v.mob, 0)
						if v.mod.readyCheckQuestId and (self.Options.WorldBossNearAlert or v.mod.Options.ReadyCheck) and not IsQuestFlaggedCompleted(v.mod.readyCheckQuestId) and v.mod.readyCheckMaxLevel >= playerLevel then
							self:FlashClientIcon()
							self:PlaySound(8960, true)
						end
					end
				end
			end
		end
		-- kill detection (wipe detection would also be nice to have)
		-- todo: add sync
		for i = #inCombat, 1, -1 do
			local v = inCombat[i]
			if not v.combatInfo then return end
			if v.combatInfo.killType == type and v.combatInfo.killMsgs[msg] then
				self:EndCombat(v, nil, nil, "onMonsterMessage")
			end
		end
	end

	function DBM:IsEncounterInProgress()
		return encounterInProgress
	end

	function DBM:CHAT_MSG_MONSTER_YELL(msg, npc, _, _, target)
		if DBM:IsEncounterInProgress() or (IsInInstance() and InCombatLockdown()) then--Too many 5 mans/old raids don't properly return encounterinprogress
			local targetName = target or "nil"
			self:Debug("CHAT_MSG_MONSTER_YELL from "..npc.." while looking at "..targetName, 2)
		end
		if not IsInInstance() then
			if msg:find(L.WORLD_BUFFS.hordeOny) then
				SendWorldSync(self, "WBA", "Onyxia\tHorde\t22888\t15\t4")
				DBM:Debug("L.WORLD_BUFFS.hordeOny detected")
			elseif msg:find(L.WORLD_BUFFS.allianceOny) then
				SendWorldSync(self, "WBA", "Onyxia\tAlliance\t22888\t15\t4")
				DBM:Debug("L.WORLD_BUFFS.allianceOny detected")
			elseif msg:find(L.WORLD_BUFFS.hordeNef) then
				SendWorldSync(self, "WBA", "Nefarian\tHorde\t22888\t16\t4")
				DBM:Debug("L.WORLD_BUFFS.hordeNef detected")
			elseif msg:find(L.WORLD_BUFFS.allianceNef) then
				SendWorldSync(self, "WBA", "Nefarian\tAlliance\t22888\t16\t4")
				DBM:Debug("L.WORLD_BUFFS.allianceNef detected")
			elseif msg:find(L.WORLD_BUFFS.rendHead) then
				SendWorldSync(self, "WBA", "rendBlackhand\tHorde\t16609\t7\t4")
				DBM:Debug("L.WORLD_BUFFS.rendHead detected")
			elseif msg:find(L.WORLD_BUFFS.zgHeartYojamba) then
				-- zg buff transcripts https://gist.github.com/venuatu/18174f0e98759f83b9834574371b8d20
				-- 28.58, 28.67, 27.77, 29.39, 28.67, 29.03, 28.12, 28.19, 29.61
				SendWorldSync(self, "WBA", "Zandalar\tBoth\t24425\t28\t4")
				DBM:Debug("L.WORLD_BUFFS.zgHeartYojamba detected")
			elseif msg:find(L.WORLD_BUFFS.zgHeartBooty) then
				-- 48.7, 49.76, 50.64, 49.42, 49.8, 50.67, 50.94, 51.06
				SendWorldSync(self, "WBA", "Zandalar\tBoth\t24425\t49\t4")
				DBM:Debug("L.WORLD_BUFFS.zgHeartBooty detected")
			end
		end
		return onMonsterMessage(self, "yell", msg)
	end

	function DBM:CHAT_MSG_MONSTER_EMOTE(msg)
		return onMonsterMessage(self, "emote", msg)
	end

	function DBM:CHAT_MSG_RAID_BOSS_EMOTE(msg, ...)
		onMonsterMessage(self, "emote", msg)
		return self:FilterRaidBossEmote(msg, ...)
	end

	function DBM:CHAT_MSG_RAID_BOSS_WHISPER(msg)
		--Make it easier for devs to detect whispers they are unable to see
		--TINTERFACE\\ICONS\\ability_socererking_arcanewrath.blp:20|t You have been branded by |cFFF00000|Hspell:156238|h[Arcane Wrath]|h|r!"
		if msg and msg ~= "" and IsInGroup() and not _G["BigWigs"] then
			SendAddonMessage("Transcriptor", msg, IsInRaid() and "RAID" or "PARTY")--Send any emote to transcriptor, even if no spellid
		end
	end

	function DBM:CHAT_MSG_MONSTER_SAY(msg)
		if not IsInInstance() then
			if msg:find(L.WORLD_BUFFS.zgHeart) then
				-- 51.01 51.82 51.85 51.53
				SendWorldSync(self, "WBA", "Zandalar\tBoth\t24425\t51\t4")
			end
		end
		return onMonsterMessage(self, "say", msg)
	end
end

---------------------------
--  Kill/Wipe Detection  --
---------------------------

function checkWipe(self, confirm)
	if #inCombat > 0 then
		if not savedDifficulty or not difficultyText or not difficultyIndex then--prevent error if savedDifficulty or difficultyText is nil
			savedDifficulty, difficultyText, difficultyIndex, LastGroupSize = self:GetCurrentInstanceDifficulty()
		end
		-- Apply correction to savedDifficulty for out-of-instance ghost checks
		if encounterDifficulty and encounterDifficulty ~= savedDifficulty then
			savedDifficulty = encounterDifficulty
		end
		--hack for no iEEU information is provided.
		if not bossuIdFound then
			for i = 1, 5 do
				if UnitExists("boss"..i) then
					bossuIdFound = true
					break
				end
			end
		end
		local wipe -- 0: no wipe, 1: normal wipe, 2: wipe by UnitExists check.
		-- DBM:IsEncounterInProgress() wouldn't work here since this WotLK workaround sets the boolean variable on StartCombat and EndCombat, and since checkwipe is one of the triggers for EndCombat, it would never properly wipe.
		-- if DBM:IsEncounterInProgress() then -- Encounter Progress marked, you obviously in combat with boss. So do not Wipe
		--	wipe = 0
		if savedDifficulty == "worldboss" and UnitIsDeadOrGhost("player") then -- On dead or ghost, unit combat status detection would be fail. If you ghost in instance, that means wipe. But in worldboss, ghost means not wipe. So do not wipe.
			wipe = 0
		elseif bossuIdFound and LastInstanceType == "raid" then -- Combat started by IEEU and no boss exist and no EncounterProgress marked, that means wipe
			wipe = 2
			for i = 1, 5 do
				if UnitExists("boss"..i) then
					wipe = 0 -- Boss found. No wipe
					break
				end
			end
		end
		-- Commenting this else check since there is no EncounterProgress info on WotLK, so whenever IEEU fired and there was no boss frames, it was considering a wipe without running the group unit combat detection
--		else -- Unit combat status detection. No combat unit in your party and no EncounterProgress marked, that means wipe
		if wipe ~= 0 then
			wipe = wipe or 1
			local uId = ((GetNumRaidMembers() == 0) and "party") or "raid"
			for i = 0, mmax(GetNumRaidMembers(), GetNumPartyMembers()) do
				local id = (i == 0 and "player") or uId..i
				if UnitAffectingCombat(id) and not UnitIsDeadOrGhost(id) then
					wipe = 0 -- Someone still in combat. No wipe
					break
				end
			end
		end
		if wipe == 0 then
			self:Schedule(3, checkWipe, self)
		elseif confirm then
			for i = #inCombat, 1, -1 do
				local mod = inCombat[i]
				if not mod.noStatistics then
					self:Debug("You wiped. Reason : " .. (wipe == 1 and "No combat unit found in your party." or "No boss found : "..(wipe or "nil")))
				end
				self:EndCombat(mod, true, nil, "checkWipe")
			end
		else
			local maxDelayTime = (savedDifficulty == "worldboss" and 15) or 5 --wait 10s more on worldboss do actual wipe.
			for _, v in ipairs(inCombat) do
				maxDelayTime = v.combatInfo and v.combatInfo.wipeTimer and v.combatInfo.wipeTimer > maxDelayTime and v.combatInfo.wipeTimer or maxDelayTime
			end
			self:Schedule(maxDelayTime, checkWipe, self, true)
		end
	end
end

function DBM:FireCustomEvent(event, ...)
	fireEvent(event, ...)
end

function checkBossHealth(self, onlyHighest)
	if #inCombat > 0 then
		for _, v in ipairs(inCombat) do
			if not v.multiMobPullDetection or v.mainBoss then
				self:GetBossHP(v.mainBoss or v.combatInfo.mob or -1, onlyHighest)
			else
				for _, mob in ipairs(v.multiMobPullDetection) do
					self:GetBossHP(mob, onlyHighest)
				end
			end
		end
		self:Schedule(1, checkBossHealth, self, onlyHighest)
	end
end

function checkCustomBossHealth(self, mod)
	mod:CustomHealthUpdate()
	self:Schedule(1, checkCustomBossHealth, self, mod)
end

function DBM:InGuildParty()
	local guildName = GetGuildInfo("player")
	local numRaid = GetNumPartyMembers()

	if guildName and numRaid > 0 then
		local guldMatch = 0
		for i = 1, numRaid do
			local guild = GetGuildInfo("raid"..i) or ""
			if guild == guildName then
				guldMatch = guldMatch + 1
			end
		end
		if guldMatch >= numRaid * 0.75 then
			return true
		end
	end
end

do
	local tooltipsHidden = false
	--Delayed Guild Combat sync object so we allow time for RL to disable them
	local function delayedGCSync(modId, difficultyIndex, name, thisTime, wipeHP)
		if not dbmIsEnabled then return end
		if not private.statusGuildDisabled and updateNotificationDisplayed == 0 then
			if thisTime then--Wipe event
				if wipeHP then
					sendGuildSync(DBMPrefix.."-GCE", modId.."\t8\t1\t"..thisTime.."\t"..difficultyIndex.."\t"..name.."\t"..lastGroupLeader.."\t"..wipeHP)
				else
					sendGuildSync(DBMPrefix.."-GCE", modId.."\t8\t0\t"..thisTime.."\t"..difficultyIndex.."\t"..name.."\t"..lastGroupLeader)
				end
			else
				sendGuildSync(DBMPrefix.."-GCB", modId.."\t3\t"..difficultyIndex.."\t"..name)
			end
		end
	end

	local statVarTable = {
		--Current
		["event5"] = "normal",
		["event20"] = "lfr25",
		["event40"] = "lfr25",
		["normal5"] = "normal",
		["heroic5"] = "heroic",
		["normal"] = "normal",
		["heroic"] = "heroic",
		["mythic"] = "mythic",
		["worldboss"] = "normal",
		["timewalker"] = "timewalker",
		--Legacy
		["normal10"] = "normal",
		["normal20"] = "normal",
		["normal25"] = "normal25",
		["normal40"] = "normal",
		["heroic10"] = "heroic",
		["heroic25"] = "heroic25",
	}

	function DBM:StartCombat(mod, delay, event, synced, syncedStartHp, syncedEvent)
		cSyncSender = {}
		cSyncReceived = 0
		if not checkEntry(inCombat, mod) then
			if not mod.Options.Enabled then return end
			--HACK: makes sure that we don't detect a false pull if the event fires again when the boss dies...
			if mod.lastKillTime and GetTime() - mod.lastKillTime < 10 then return end
			if not mod.combatInfo then return end
			if mod.combatInfo.noCombatInVehicle and UnitInVehicle("player") then -- HACK
				return
			end
			if self.Options.RecordOnlyBosses then
				self:StartLogging(0)
			end
			savedDifficulty, difficultyText, difficultyIndex, LastGroupSize = self:GetCurrentInstanceDifficulty()
			encounterDifficulty, encounterDifficultyText, encounterDifficultyIndex = savedDifficulty, difficultyText, difficultyIndex
			if event then
				self:Debug("StartCombat called by : "..event.." for mod : "..mod.id.." (revision: "..(mod.revision or 0)..") with difficulty : "..encounterDifficulty..". LastInstanceMapID is "..LastInstanceMapID)
			else
				self:Debug("StartCombat called by individual mod or unknown reason for mod : "..mod.id.." (revision: "..(mod.revision or 0)..") with difficulty : "..encounterDifficulty..". LastInstanceMapID is "..LastInstanceMapID)
				event = ""
			end
			self.currentModId = mod.id
			--check completed. starting combat
			tinsert(inCombat, mod)
			if mod.inCombatOnlyEvents and not mod.inCombatOnlyEventsRegistered then
				mod.inCombatOnlyEventsRegistered = 1
				mod:RegisterEvents(unpack(mod.inCombatOnlyEvents))
			end
			--Fix for "attempt to perform arithmetic on field 'stats' (a nil value)"
			if not mod.stats and not mod.noStatistics then
				self:AddMsg(L.BAD_LOAD)--Warn user that they should reload ui soon as they leave combat to get their mod to load correctly as soon as possible
				mod.ignoreBestkill = true--Force this to true so we don't check any more occurances of "stats"
			elseif event == "TIMER_RECOVERY" then --add a lag time to delay when TIMER_RECOVERY
				delay = delay + select(3, GetNetStats()) / 1000
			else
				mod.ignoreBestkill = false
			end
--			Moving this up, to be logged with the StartCombat debug
--			savedDifficulty, difficultyText, difficultyIndex, LastGroupSize = self:GetCurrentInstanceDifficulty()
--			encounterDifficulty, encounterDifficultyText, encounterDifficultyIndex = savedDifficulty, difficultyText, difficultyIndex
			local name = mod.combatInfo.name
			local modId = mod.id
			mod.inCombat = true
			encounterInProgress = true
			mod.combatInfo.pull = GetTime() - (delay or 0)
			bossuIdFound = event == "IEEU"
			if (self.Options.AlwaysShowHealthFrame or mod.Options.HealthFrame) and mod.Options.Enabled then
				self.BossHealth:Show(mod.localization.general.name)
				if mod.bossHealthInfo then
					for i = 1, #mod.bossHealthInfo, 2 do
						self.BossHealth:AddBoss(mod.bossHealthInfo[i], mod.bossHealthInfo[i + 1])
					end
				else
					self.BossHealth:AddBoss(mod.combatInfo.mob, mod.localization.general.name)
				end
			end
			if mod.minCombatTime then
				self:Schedule(mmax((mod.minCombatTime - delay), 3), checkWipe, self)
			else
				self:Schedule(3, checkWipe, self)
			end
			--get boss hp at pull
			if syncedStartHp and syncedStartHp < 1 then
				syncedStartHp = syncedStartHp * 100
			end
			local startHp = syncedStartHp or mod:GetBossHP(mod.mainBoss or mod.combatInfo.mob or -1) or 100
			--check boss engaged first?
			if (savedDifficulty == "worldboss" and startHp < 98) or (event == "UNIT_HEALTH" and delay > 4) or event == "TIMER_RECOVERY" then--Boss was not full health when engaged, disable combat start timer and kill record
				mod.ignoreBestkill = true
			else--Reset ignoreBestkill after wipe
				mod.ignoreBestkill = false
				--It was a clean pull, so cancel any RequestTimers which might fire after boss was pulled if boss was pulled right after mod load
				--Only want timer recovery on in progress bosses, not clean pulls
				if startHp > 98 and (savedDifficulty == "worldboss" or event == "IEEU") then
					self:Unschedule(self.RequestTimers)
				end
			end
			if self.Options.HideTooltips then
				--Better or cleaner way?
				tooltipsHidden = true
				GameTooltip.Temphide = function() GameTooltip:Hide() end; GameTooltip:SetScript("OnShow", GameTooltip.Temphide)
			end
			if self.Options.DisableSFX and GetCVar("Sound_EnableSFX") == "1" then
				SetCVar("Sound_EnableSFX", 0)
			end
			--boss health info scheduler
			if mod.CustomHealthUpdate then
				self:Schedule(1, checkCustomBossHealth, self, mod)
			else
				self:Schedule(1, checkBossHealth, self, mod.onlyHighest)
			end
			--process global options
			self:HideBlizzardEvents(1)
--			I prefer starting the log at the beginning of the function, to catch the StartCombat debug
--			if self.Options.RecordOnlyBosses then
--				self:StartLogging(0)
--			end
			if self.Options.HideObjectivesFrame and GetNumTrackedAchievements() == 0 then -- doesn't need InCombatLockdown() check since it's not a protected function
				if WatchFrame:IsVisible() then
					WatchFrame:Hide()
					watchFrameRestore = true
				end
			end
			fireEvent("DBM_Pull", mod, delay, synced, startHp)
			self:FlashClientIcon()
			--serperate timer recovery and normal start.
			if event ~= "TIMER_RECOVERY" then
				--add pull count
				if mod.stats and not mod.noStatistics then
					if not mod.stats[statVarTable[savedDifficulty].."Pulls"] then mod.stats[statVarTable[savedDifficulty].."Pulls"] = 0 end
					mod.stats[statVarTable[savedDifficulty].."Pulls"] = mod.stats[statVarTable[savedDifficulty].."Pulls"] + 1
				end
				--show speed timer
				if self.Options.AlwaysShowSpeedKillTimer2 and mod.stats and not mod.ignoreBestkill and not mod.noStatistics then
					local bestTime = mod.stats[statVarTable[savedDifficulty].."BestTime"]
					if bestTime and bestTime > 0 then
						local speedTimer = mod:NewTimer(bestTime, L.SPEED_KILL_TIMER_TEXT, "Interface\\Icons\\SPELL_HOLY_BORROWEDTIME", nil, false)
						speedTimer:Start()
					end
				end
				--update boss left
				if mod.numBoss then
					mod.vb.bossLeft = mod.numBoss
				end
				--elect icon person
				if mod.findFastestComputer and not self.Options.DontSetIcons then
					if self:GetRaidRank() > 0 then
						for i = 1, #mod.findFastestComputer do
							local option = mod.findFastestComputer[i]
							if mod.Options[option] then
								DBM:Debug(("DBMv4-IS sending %s %s %s"):format(UnitGUID("player"), tostring(self.Revision), option), 3)
								sendSync("DBMv4-IS", UnitGUID("player").."\t"..tostring(self.Revision).."\t"..option)
							end
						end
					elseif not IsInGroup() then
						for i = 1, #mod.findFastestComputer do
							local option = mod.findFastestComputer[i]
							if mod.Options[option] then
								private.canSetIcons[option] = true
							end
						end
					end
				end
				--call OnCombatStart
				if mod.OnCombatStart then
					local startEvent = syncedEvent or event
					mod:OnCombatStart(delay or 0, startEvent == "PLAYER_REGEN_DISABLED_AND_MESSAGE" or startEvent == "SPELL_CAST_SUCCESS" or startEvent == "MONSTER_MESSAGE", startEvent == "ENCOUNTER_START")
				end
				--send "C" sync
				event = event or ""
				if not synced then
					sendSync("DBMv4-Pull", (delay or 0).."\t"..modId.."\t"..(mod.revision or 0).."\t"..startHp.."\t"..tostring(self.Revision).."\t"..(mod.hotfixNoticeRev or 0).."\t"..event)
				end
				if UnitIsPartyLeader("player") then
					--Global disables require normal, heroic, mythic raid on retail, or 10 man normal, 25 man normal, 40 man normal, 10 man heroic, or 25 man heroic on classic
					if difficultyIndex == 14 or difficultyIndex == 15 or difficultyIndex == 16 or difficultyIndex == 175 or difficultyIndex == 176 or difficultyIndex == 186 or difficultyIndex == 193 or difficultyIndex == 194 then
						local statusWhisper, guildStatus, raidIcons, chatBubbles = self.Options.DisableStatusWhisper and 1 or 0, self.Options.DisableGuildStatus and 1 or 0, self.Options.DisableRaidIcons and 1 or 0, self.Options.DisableChatBubbles and 1 or 0
						if statusWhisper ~= 0 or guildStatus ~= 0 or raidIcons ~= 0 or chatBubbles ~= 0 then
							sendSync("DBMv4-RLO", "1\t"..statusWhisper.."\t"..guildStatus.."\t"..raidIcons.."\t"..chatBubbles)
						end
					end
				end
				--show bigbrother check
				if self.Options.ShowBigBrotherOnCombatStart and BigBrother and type(BigBrother.ConsumableCheck) == "function" then
					if self.Options.BigBrotherAnnounceToRaid then
						BigBrother:ConsumableCheck("RAID")
					else
						BigBrother:ConsumableCheck("SELF")
					end
				end
				--show engage message
				if self.Options.ShowEngageMessage and not mod.noStatistics then
					if mod.ignoreBestkill and (savedDifficulty == "worldboss") then--Should only be true on in progress field bosses, not in progress raid bosses we did timer recovery on.
						self:AddMsg(L.COMBAT_STARTED_IN_PROGRESS:format(difficultyText..name))
					else
						self:AddMsg(L.COMBAT_STARTED:format(difficultyText..name))
						local check = not private.statusGuildDisabled and self:InGuildParty() and DBM:GetNumGuildPlayersInZone() >= 10
						if check and not self.Options.DisableGuildStatus then--Only send relevant content
							self:Unschedule(delayedGCSync, modId)
							self:Schedule(1.5, delayedGCSync, modId, difficultyIndex, name)
						end
					end
				end
				--stop pull count
				local dummyMod = self:GetModByName("PullTimerCountdownDummy")
				if dummyMod then--stop pull timer
					dummyMod.text:Cancel()
					dummyMod.timer:Stop()
					if not self.Options.DontShowPTCountdownText then
						for _, tttimer in pairs(TT.timerList) do
							if tttimer.type == 3 and not tttimer.isFree then
								TT:FreeTimerTrackerTimer(tttimer)
								break
							end
						end
					end
					DBM:Unschedule(SendChatMessage) -- unschedule chat spam on pull
				end
				-- stop combat start timer and debug if refreshed early
--				if DBM.Options.BadTimerAlert or DBM.Options.DebugMode and DBM.Options.DebugLevel > 1 then
					local bar = DBT:GetBar(L.GENERIC_TIMER_COMBAT)
					if bar then
						if bar.timer > 0 then -- Catch all early refreshes, since pull timers are generally fixed and can be precise
							local remaining = ("%.2f"):format(bar.timer)
							local ttext = bar.id
							if DBM.Options.BadTimerAlert and bar.timer > 1 then--If greater than 1 seconds off, report this out of debug mode to all users
								DBM:AddMsg("Timer "..ttext.." refreshed before expired. Remaining time is : "..remaining..". Please report this bug")
								fireEvent("DBM_Debug", "Timer "..ttext.." refreshed before expired. Remaining time is : "..remaining..". Please report this bug", 2)
							else
								DBM:Debug("Timer "..ttext.." refreshed before expired. Remaining time is : "..remaining, 2)
							end
						end
						DBT:CancelBar(L.GENERIC_TIMER_COMBAT)
					end
--				end
				local bigWigs = _G["BigWigs"]
				if bigWigs and bigWigs.db.profile.raidicon and not self.Options.DontSetIcons and self:GetRaidRank() > 0 then--Both DBM and bigwigs have raid icon marking turned on.
					self:AddMsg(L.BIGWIGS_ICON_CONFLICT)--Warn that one of them should be turned off to prevent conflict (which they turn off is obviously up to raid leaders preference, dbm accepts either or turned off to stop this alert)
				end
				if self.Options.EventSoundEngage2 and self.Options.EventSoundEngage2 ~= "" and self.Options.EventSoundEngage2 ~= "None" then
					self:PlaySoundFile(self.Options.EventSoundEngage2, nil, true)
				end
				if self.Options.EventSoundMusic and self.Options.EventSoundMusic ~= "None" and self.Options.EventSoundMusic ~= "" and not (self.Options.EventMusicMythicFilter and (savedDifficulty == "mythic" or savedDifficulty == "challenge")) and not mod.noStatistics then
					fireEvent("DBM_MusicStart", "BossEncounter")
					if not self.Options.RestoreSettingMusic then
						self.Options.RestoreSettingMusic = tonumber(GetCVar("Sound_EnableMusic")) or 1
						if self.Options.RestoreSettingMusic == 0 then
							SetCVar("Sound_EnableMusic", 1)
						else
							self.Options.RestoreSettingMusic = nil--Don't actually need it
						end
					end
					local path = "MISSING"
					if self.Options.EventSoundMusic == "Random" then
						local usedTable = self.Options.EventSoundMusicCombined and self.Music or self.BattleMusic
						if #usedTable >= 3 then
							local random = random(3, #usedTable)
							path = usedTable[random].value
						end
					else
						path = self.Options.EventSoundMusic
					end
					if path ~= "MISSING" then
						PlayMusic(path)
						self.Options.musicPlaying = true
						self:Debug("Starting combat music with file: "..path)
					end
				end
			else
				self:AddMsg(L.COMBAT_STATE_RECOVERED:format(difficultyText..name, strFromTime(delay)))
				if mod.OnTimerRecovery then
					mod:OnTimerRecovery()
				end
			end
			if savedDifficulty == "worldboss" and mod.WBEsync then
				if lastBossEngage[modId..playerRealm] and (GetTime() - lastBossEngage[modId..playerRealm] < 30) then return end--Someone else synced in last 10 seconds so don't send out another sync to avoid needless sync spam.
				lastBossEngage[modId..playerRealm] = GetTime()--Update last engage time, that way we ignore our own sync
				SendWorldSync(self, "WBE", modId.."\t"..playerRealm.."\t"..startHp.."\t8\t"..name)
			end
			if self.Options.FixCLEUOnCombatStart then
				self:Schedule(0.5, CombatLogClearEntries) -- schedule prevents client crash with DBM:StartCombat function (tested on Leotheras)
				self:Debug("Scheduled FixCLEU from CombatStart")
			end
			-- Debug loaded mod profile and options
			self:Debug("Loaded Mod profile: " .. DBM:CurrentModProfile(), 3)
			for i, v in pairs(mod.Options) do
				self:Debug(("Mod Option %s returns %s"):format(i, tostring(v)), 3)
			end
		end
	end

	function DBM:UNIT_HEALTH(uId)
		local cId = self:GetCIDFromGUID(UnitGUID(uId))
		local health
		if UnitHealthMax(uId) ~= 0 then
			health = UnitHealth(uId) / UnitHealthMax(uId) * 100
		end
		if not health or health < 2 then return end -- no worthy of combat start if health is below 2%
		if dbmIsEnabled and InCombatLockdown() then
			if cId ~= 0 and not bossHealth[cId] and bossIds[cId] and UnitAffectingCombat(uId) and not (UnitPlayerOrPetInRaid(uId) or UnitPlayerOrPetInParty(uId)) and healthCombatInitialized then -- StartCombat by UNIT_HEALTH.
				local combat = combatInfo[LastInstanceMapID] or combatInfo[LastInstanceZoneName]
				if combat then
					for _, v in ipairs(combat) do
						if v.mod.Options.Enabled and not v.mod.disableHealthCombat and v.type:find("combat") and (v.multiMobPullDetection and checkEntry(v.multiMobPullDetection, cId) or v.mob == cId) and not (#inCombat > 0 and v.noMultiBoss) then
							if v.mod.noFriendlyEngagement and UnitIsFriend("player", uId) then return end
							-- No sense in assuming delay based on boss health! Realistically, delay is 0 since it fires as soon as boss drops HP. This ensures a more accurate StartCombat. (Previous logic from retail: Delay set, > 97% = 0.5 (consider as normal pulling), max delay limited to 20s.)
							self:StartCombat(v.mod, 0--[[health > 97 and 0.5 or mmin(GetTime() - lastCombatStarted, 20)]], "UNIT_HEALTH", nil, health)
						end
					end
				end
			end
			if self.Options.AFKHealthWarning and UnitIsUnit(uId, "player") and (health < 85) and not DBM:IsEncounterInProgress() and UnitIsAFK("player") and self:AntiSpam(5, "AFK") then--You are afk and losing health, some griever is trying to kill you while you are afk/tabbed out.
				self:PlaySound(8585)--So fire an alert sound to save yourself from this person's behavior.
				self:AddMsg(L.AFK_WARNING:format(health))
			end
		end
	end

	function DBM:EndCombat(mod, wipe, srmIncluded, event)
		if removeEntry(inCombat, mod) then
			self.currentModId = nil
			if mod.inCombatOnlyEvents and mod.inCombatOnlyEventsRegistered then
				if srmIncluded then-- unregister all events including SPELL_AURA_REMOVED events
					mod:UnregisterInCombatEvents(false, true)
				else-- unregister all events except for SPELL_AURA_REMOVED events (might still be needed to remove icons etc...)
					mod:UnregisterInCombatEvents()
					self:Schedule(2, mod.UnregisterInCombatEvents, mod, true) -- 2 seconds should be enough for all auras to fade
				end
				self:Schedule(3, mod.Stop, mod) -- Remove accident started timers.
				mod.inCombatOnlyEventsRegistered = nil
				if mod.OnCombatEnd then
					self:Schedule(3, mod.OnCombatEnd, mod, wipe, true) -- Remove accidentally shown frames
				end
			end
			if mod.updateInterval then
				mod:UnregisterOnUpdateHandler()
			end
			mod:Stop()
			if event then
				self:Debug("EndCombat called by : "..event.." for mod: " ..mod.id..". LastInstanceMapID is "..LastInstanceMapID)
			end
			if private.enableIcons and not self.Options.DontSetIcons and not self.Options.DontRestoreIcons then
				-- restore saved previous icon
				for uId, icon in pairs(mod.iconRestore) do
					SetRaidTarget(uId, icon)
				end
				twipe(mod.iconRestore)
			end
			mod.inCombat = false
			encounterInProgress = false
			if mod.combatInfo.killMobs then
				for i, _ in pairs(mod.combatInfo.killMobs) do
					mod.combatInfo.killMobs[i] = true
				end
			end
			if not savedDifficulty or not difficultyText or not difficultyIndex then--prevent error if savedDifficulty or difficultyText is nil
				savedDifficulty, difficultyText, difficultyIndex, LastGroupSize = DBM:GetCurrentInstanceDifficulty()
			end
			if encounterDifficulty and encounterDifficultyText and encounterDifficultyIndex and (encounterDifficulty ~= savedDifficulty or encounterDifficultyText ~= difficultyText or encounterDifficultyIndex ~= difficultyIndex) then
				savedDifficulty, difficultyText, difficultyIndex = encounterDifficulty, encounterDifficultyText, encounterDifficultyIndex
			end
			local name = mod.combatInfo.name
			local modId = mod.id
			if wipe and mod.stats and not mod.noStatistics then
				mod.lastWipeTime = GetTime()
				--Fix for "attempt to perform arithmetic on field 'pull' (a nil value)" (which was actually caused by stats being nil, so we never did getTime on pull, fixing one SHOULD fix the other)
				local thisTime = GetTime() - mod.combatInfo.pull
				local hp = mod.highesthealth and mod:GetHighestBossHealth() or mod:GetLowestBossHealth()
				local wipeHP = mod.CustomHealthUpdate and mod:CustomHealthUpdate() or hp and ("%d%%"):format(hp) or CL.UNKNOWN
				if mod.vb.phase then
					wipeHP = wipeHP.." ("..L.SCENARIO_STAGE:format(mod.vb.phase)..")"
				end
				if mod.numBoss and mod.vb.bossLeft and mod.numBoss > 1 then
					local bossesKilled = mod.numBoss - mod.vb.bossLeft
					wipeHP = wipeHP.." ("..BOSSES_KILLED:format(bossesKilled, mod.numBoss)..")"
				end
				local totalPulls = mod.stats[statVarTable[savedDifficulty].."Pulls"]
				local totalKills = mod.stats[statVarTable[savedDifficulty].."Kills"]
				if thisTime < 30 then -- Normally, one attempt will last at least 30 sec.
					totalPulls = totalPulls - 1
					mod.stats[statVarTable[savedDifficulty].."Pulls"] = totalPulls
					if self.Options.ShowDefeatMessage then
						self:AddMsg(L.COMBAT_ENDED_AT:format(difficultyText..name, wipeHP, strFromTime(thisTime)))
						--No reason to GCE it here, so omited on purpose.
						end
				else
					if self.Options.ShowDefeatMessage then
						self:AddMsg(L.COMBAT_ENDED_AT_LONG:format(difficultyText..name, wipeHP, strFromTime(thisTime), totalPulls - totalKills))
						local check = self:InGuildParty() and DBM:GetNumGuildPlayersInZone() >= 10
						if check and not self.Options.DisableGuildStatus then
							self:Unschedule(delayedGCSync, modId)
							self:Schedule(1.5, delayedGCSync, modId, difficultyIndex, name, strFromTime(thisTime), wipeHP)
						end
					end
					if self.Options.EventSoundWipe and self.Options.EventSoundWipe ~= "None" and self.Options.EventSoundWipe ~= "" then
						if self.Options.EventSoundWipe == "Random" then
							local defeatSounds = DBM:GetDefeatSounds()
							if #defeatSounds >= 3 then
								self:PlaySoundFile(defeatSounds[random(3, #defeatSounds)].value)
							end
						else
							self:PlaySoundFile(self.Options.EventSoundWipe, nil, true)
						end
					end
				end
				if showConstantReminder == 2 and IsInGroup() then
					showConstantReminder = 1
					--Show message any time this is a mod that has a newer hotfix revision and it's a wipe
					--These people need to know the wipe could very well be their fault.
					self:AddMsg(L.OUT_OF_DATE_NAG)
				end
				local msg
				for k, _ in pairs(autoRespondSpam) do
					if self.Options.WhisperStats then
						msg = msg or chatPrefixShort..L.WHISPER_COMBAT_END_WIPE_STATS_AT:format(playerName, difficultyText..(name or ""), wipeHP, totalPulls - totalKills)
					else
						msg = msg or chatPrefixShort..L.WHISPER_COMBAT_END_WIPE_AT:format(playerName, difficultyText..(name or ""), wipeHP)
					end
					sendWhisper(k, msg)
				end
				fireEvent("wipe", mod) -- Backwards compatibility
				fireEvent("DBM_Wipe", mod)
			elseif not wipe and mod.stats and not mod.noStatistics then
				mod.lastKillTime = GetTime()
				local thisTime = GetTime() - (mod.combatInfo.pull or 0)
				local lastTime = mod.stats[statVarTable[savedDifficulty].."LastTime"]
				local bestTime = mod.stats[statVarTable[savedDifficulty].."BestTime"]
				if not mod.stats[statVarTable[savedDifficulty].."Kills"] or mod.stats[statVarTable[savedDifficulty].."Kills"] < 0 then mod.stats[statVarTable[savedDifficulty].."Kills"] = 0 end
				--Fix logical error i've seen where for some reason we have more kills then pulls for boss as seen by - stats for wipe messages.
				mod.stats[statVarTable[savedDifficulty].."Kills"] = mod.stats[statVarTable[savedDifficulty].."Kills"] + 1
				if mod.stats[statVarTable[savedDifficulty].."Kills"] > mod.stats[statVarTable[savedDifficulty].."Pulls"] then mod.stats[statVarTable[savedDifficulty].."Kills"] = mod.stats[statVarTable[savedDifficulty].."Pulls"] end
				if not mod.ignoreBestkill and mod.combatInfo.pull then
					mod.stats[statVarTable[savedDifficulty].."LastTime"] = thisTime
					--Just to prevent pre mature end combat calls from broken mods from saving bad time stats.
					if bestTime and bestTime > 0 and bestTime < 1.5 then
						mod.stats[statVarTable[savedDifficulty].."BestTime"] = thisTime
					else
						mod.stats[statVarTable[savedDifficulty].."BestTime"] = mmin(bestTime or mhuge, thisTime)
					end
				end
				local totalKills = mod.stats[statVarTable[savedDifficulty].."Kills"]
				if self.Options.ShowDefeatMessage then
					local msg
					local thisTimeString = thisTime and strFromTime(thisTime)
					if not mod.combatInfo.pull then--was a bad pull so we ignored thisTime, should never happen
						msg = L.BOSS_DOWN:format(difficultyText..name, CL.UNKNOWN)
					elseif mod.ignoreBestkill then--Should never happen in a scenario so no need for scenario check.
						msg = L.BOSS_DOWN_I:format(difficultyText..name, totalKills)
					elseif not lastTime then
						msg = L.BOSS_DOWN:format(difficultyText..name, thisTimeString)
					elseif thisTime < (bestTime or mhuge) then
						msg = L.BOSS_DOWN_NR:format(difficultyText..name, thisTimeString, strFromTime(bestTime), totalKills)
					else
						msg = L.BOSS_DOWN_L:format(difficultyText..name, thisTimeString, strFromTime(lastTime), strFromTime(bestTime), totalKills)
					end
					local check = not private.statusGuildDisabled and self:InGuildParty() and DBM:GetNumGuildPlayersInZone() >= 10
					if thisTimeString and check and not self.Options.DisableGuildStatus and updateNotificationDisplayed == 0 then
						self:Unschedule(delayedGCSync, modId)
						self:Schedule(1.5, delayedGCSync, modId, encounterDifficultyIndex, name, thisTimeString)
					end
					self:Schedule(1, self.AddMsg, self, msg)
				end
				local msg
				for k, _ in pairs(autoRespondSpam) do
					if self.Options.WhisperStats then
						msg = msg or chatPrefixShort..L.WHISPER_COMBAT_END_KILL_STATS:format(playerName, difficultyText..(name or ""), totalKills)
					else
						msg = msg or chatPrefixShort..L.WHISPER_COMBAT_END_KILL:format(playerName, difficultyText..(name or ""))
					end
					sendWhisper(k, msg)
				end
				if self.Options.ReportRecount and self:GetRaidRank() > 0 and Recount then
					Recount:ReportData(25,(GetNumRaidMembers() > 0 and "raid") or "party")
				end
				if self.Options.ReportSkada and self:GetRaidRank() > 0 and Skada and Skada.revisited then
					self:Schedule(1, function() -- delayed by one second to prevent CombatLogClearEntries wow crash
						Skada:Report("RAID", "preset", nil, nil, 25)
					end)
				end
				fireEvent("kill", mod) -- Backwards compatibility
				fireEvent("DBM_Kill", mod)
				if BossBanner then
					local encounterName = mod.localization.general.name or "Unknown"
					BossBanner:OnEvent("BOSS_KILL", modId, encounterName) -- modId is mocked up as encounterID, encounterName is mocked up via mod translation table
				end
				if savedDifficulty == "worldboss" and mod.WBEsync then
					if lastBossDefeat[modId..playerRealm] and (GetTime() - lastBossDefeat[modId..playerRealm] < 30) then return end--Someone else synced in last 10 seconds so don't send out another sync to avoid needless sync spam.
					lastBossDefeat[modId..playerRealm] = GetTime()--Update last defeat time before we send it, so we don't handle our own sync
					SendWorldSync(self, "WBD", modId.."\t"..playerRealm.."\t8\t"..name)
				end
				if self.Options.EventSoundVictory2 and self.Options.EventSoundVictory2 ~= "None" and self.Options.EventSoundVictory2 ~= "" then
					if self.Options.EventSoundVictory2 == "Random" then
						local victorySounds = DBM:GetVictorySounds()
						if #victorySounds >= 3 then
							self:PlaySoundFile(victorySounds[random(3, #victorySounds)].value)
						end
					else
						self:PlaySoundFile(self.Options.EventSoundVictory2, nil, true)
					end
				end
			end
			if mod.OnCombatEnd then mod:OnCombatEnd(wipe) end
			if mod.OnLeavingCombat then delayedFunction = mod.OnLeavingCombat end
			self.BossHealth:Hide()
			if #inCombat == 0 then--prevent error if you pulled multiple boss. (Earth, Wind and Fire)
				private.statusGuildDisabled, private.statusWhisperDisabled, private.raidIconsDisabled, private.chatBubblesDisabled = false, false, false, false
				if self.Options.RecordOnlyBosses then
					self:Schedule(10, self.StopLogging, self)--small delay to catch kill/died combatlog events
				end
				self:HideBlizzardEvents(0)
				self:Unschedule(checkBossHealth)
				self:Unschedule(checkCustomBossHealth)
				self.Arrow:Hide(true)
				-- doesn't need InCombatLockdown() check since it's not a protected function
				if watchFrameRestore then
					WatchFrame:Show()
					watchFrameRestore = false
				end
			if tooltipsHidden then
					--Better or cleaner way?
					tooltipsHidden = false
					GameTooltip:SetScript("OnShow", GameTooltip.Show)
				end
				if self.Options.DisableSFX then
					SetCVar("Sound_EnableSFX", 1)
				end
				--cache table
				twipe(autoRespondSpam)
				twipe(bossHealth)
				twipe(bossHealthuIdCache)
				--sync table
				twipe(private.canSetIcons)
				twipe(iconSetRevision)
				twipe(iconSetPerson)
				bossuIdFound = false
				encounterDifficulty, encounterDifficultyText, encounterDifficultyIndex = nil, nil, nil

				self:CreatePizzaTimer(time, "", nil, nil, nil, true)--Auto Terminate infinite loop timers on combat end
				self:TransitionToDungeonBGM(false, true)
				self:Schedule(22, self.TransitionToDungeonBGM, self)
				--module cleanup
				private:ClearModuleTasks()
			end
		end
	end
end

function DBM:OnMobKill(cId, synced)
	for i = #inCombat, 1, -1 do
		local v = inCombat[i]
		if not v.combatInfo then
			return
		end
		if v.combatInfo.noBossDeathKill then return end
		if v.combatInfo.killMobs and v.combatInfo.killMobs[cId] then
			if not synced then
				sendSync("DBMv4-Kill", cId)
			end
			v.combatInfo.killMobs[cId] = false
			if v.numBoss then
				v.vb.bossLeft = (v.vb.bossLeft or v.numBoss) - 1
				self:Debug("Boss left - "..v.vb.bossLeft.."/"..v.numBoss, 2)
			end
			local allMobsDown = true
			for _, k in pairs(v.combatInfo.killMobs) do
				if k then
					allMobsDown = false
					break
				end
			end
			if allMobsDown then
				self:EndCombat(v, nil, nil, "All Mobs Down")
			end
		elseif cId == v.combatInfo.mob and not v.combatInfo.killMobs and not v.combatInfo.multiMobPullDetection then
			if not synced then
				sendSync("DBMv4-Kill", cId)
			end
			self:EndCombat(v, nil, nil, "Main CID Down")
		end
	end
end

do
	local autoLog = false
	local autoTLog = false

	local function isLogableContent(self)
		--1: Check for any broad global filters like LFG/LFR filter
		--2: Check for what content specifically selected for logging
		--3: Boss Only filter is handled somewhere else (where StartLogging is called)

		if self.Options.DoNotLogLFG and IsPartyLFG() then
			return false
		end

		--First checks are manual index checks versus table because even old content can be scaled up using M+ or TW scaling tech
		--Current player level Mythic+
		if self.Options.LogCurrentMPlus and (difficultyIndex or 0) == 8 then
			return true
		end
		--Timewalking raid
		if self.Options.LogTWRaids and (difficultyIndex == 24 or difficultyIndex == 33) and (instanceDifficultyBylevel[LastInstanceMapID] and instanceDifficultyBylevel[LastInstanceMapID][2] == 3) then
			return true
		end
		--Timewalking Dungeon
		if self.Options.LogTWDungeons and (difficultyIndex == 24 or difficultyIndex == 33) and (instanceDifficultyBylevel[LastInstanceMapID] and instanceDifficultyBylevel[LastInstanceMapID][2] == 2) then
			return true
		end

		--Now we do checks relying on pre coded trivial check table
		--Current level Mythic raid
		if self.Options.LogCurrentMythicRaids and instanceDifficultyBylevel[LastInstanceMapID] and (instanceDifficultyBylevel[LastInstanceMapID][1] >= playerLevel) and (instanceDifficultyBylevel[LastInstanceMapID][2] == 3) and difficultyIndex == 16 then
			return true
		end
		--Current player level non Mythic raid
		if self.Options.LogCurrentRaids and instanceDifficultyBylevel[LastInstanceMapID] and (instanceDifficultyBylevel[LastInstanceMapID][1] >= playerLevel) and (instanceDifficultyBylevel[LastInstanceMapID][2] == 3) and difficultyIndex ~= 16
		or difficultyIndex == 18 -- Custom (Warmane Events)
		then
			return true
		end
		--Trivial raid (ie one below players level)
		if self.Options.LogTrivialRaids and instanceDifficultyBylevel[LastInstanceMapID] and (instanceDifficultyBylevel[LastInstanceMapID][1] < playerLevel) and (instanceDifficultyBylevel[LastInstanceMapID][2] == 3) then
			return true
		end
		--Current level Mythic dungeon
		if self.Options.LogCurrentMythicZero and instanceDifficultyBylevel[LastInstanceMapID] and (instanceDifficultyBylevel[LastInstanceMapID][1] >= playerLevel) and (instanceDifficultyBylevel[LastInstanceMapID][2] == 2) and difficultyIndex == 23 then
			return true
		end
		--Current level Heroic dungeon
		if self.Options.LogCurrentHeroic and instanceDifficultyBylevel[LastInstanceMapID] and (instanceDifficultyBylevel[LastInstanceMapID][1] >= playerLevel) and (instanceDifficultyBylevel[LastInstanceMapID][2] == 2) and (difficultyIndex == 2 or difficultyIndex == 174) then
			return true
		end
		--Current level Normal dungeon
		if self.Options.LogCurrentNormal and instanceDifficultyBylevel[LastInstanceMapID] and (instanceDifficultyBylevel[LastInstanceMapID][1] >= playerLevel) and (instanceDifficultyBylevel[LastInstanceMapID][2] == 2) and (difficultyIndex == 1 or difficultyIndex == 173) then
			return true
		end
		--Trivial dungeon (ie one below players level)
		if self.Options.LogTrivialDungeons and instanceDifficultyBylevel[LastInstanceMapID] and (instanceDifficultyBylevel[LastInstanceMapID][1] < playerLevel) and (instanceDifficultyBylevel[LastInstanceMapID][2] == 2) then
			return true
		end

		return false
	end

	function DBM:StartLogging(timer, checkFunc, force)
		self:Unschedule(DBM.StopLogging)
		if not force and not isLogableContent(self) then return end
		if self.Options.AutologBosses then
			if not LoggingCombat() then
				autoLog = true
				self:AddMsg("|cffffff00"..COMBATLOGENABLED.."|r")
				LoggingCombat(true)
			end
		end
		local transcriptor = _G["Transcriptor"]
		if self.Options.AdvancedAutologBosses and transcriptor then
			if not transcriptor:IsLogging() then
				autoTLog = true
				self:AddMsg("|cffffff00"..L.TRANSCRIPTOR_LOG_START.."|r")
				transcriptor:StartLog(1)
			end
		end
		if checkFunc and (autoLog or autoTLog) then
			self:Unschedule(checkFunc)
			self:Schedule(timer+10, checkFunc)--But if pull was canceled and we don't have a boss engaged within 10 seconds of pull timer ending, abort log
		end
	end

	function DBM:StopLogging()
		if self.Options.AutologBosses and LoggingCombat() and autoLog then
			autoLog = false
			self:AddMsg("|cffffff00"..COMBATLOGDISABLED.."|r")
			LoggingCombat(false)
		end
		local transcriptor = _G["Transcriptor"]
		if self.Options.AdvancedAutologBosses and transcriptor and autoTLog then
			if transcriptor:IsLogging() then
				autoTLog = false
				self:AddMsg("|cffffff00"..L.TRANSCRIPTOR_LOG_END.."|r")
				transcriptor:StopLog(1)
			end
		end
	end

	function DBM:AddSpecialEventToTranscriptorLog(name) -- custom implementation, to further improve Transcriptor timer diffs with scheduled functions from DBM
		local transcriptor = _G["Transcriptor"]
		if not transcriptor then return end

		if transcriptor:IsLogging() then -- checking for running log (might be unnecessary, but doesnt hurt)
			if not transcriptor.InsertSpecialEvent then -- checking for existence of function, to prevent nil from outdated Transcriptor versions
				DBM:AddMsg("Transcriptor addon is outdated. Download the latest version from the following link: https://github.com/Zidras/Transcriptor-WOTLK")
				return
			end
			if name and type(name) == "string" then
				self:Debug("Added Special Event to Transcriptor Log: "..name)
				transcriptor.InsertSpecialEvent(name)
			else
				error("DBM:AddEventToTranscriptorLog(name) must receive a string.")
			end
		end
	end
end

do
	-- From Kader's Compat lib
	local LGTRoleTable = {melee = "DAMAGER", caster = "DAMAGER", healer = "HEALER", tank = "TANK"}
	local roleIconTable = {["DAMAGER"] = CL.DAMAGE_ICON, ["HEALER"] = CL.HEALER_ICON, ["TANK"] = CL.TANK_ICON, ["NONE"] = "|TInterface\\Icons\\INV_Misc_QuestionMark:16:16:0:0:64:64:5:59:5:59|t"}
	local specsTable = {
		["MAGE"] = {62, 63, 64},
		["PRIEST"] = {256, 257, 258},
		["ROGUE"] = {259, 260, 261},
		["WARLOCK"] = {265, 266, 267},
		["WARRIOR"] = {71, 72, 73},
		["PALADIN"] = {65, 66, 70},
		["DEATHKNIGHT"] = {250, 251, 252},
		["DRUID"] = {102, 103, 104, 105},
		["HUNTER"] = {253, 254, 255},
		["SHAMAN"] = {262, 263, 264}
	}

	local function GetSpecialization(isInspect, isPet, specGroup)
		local currentSpecGroup = GetActiveTalentGroup(isInspect, isPet) or (specGroup or 1)
		local points, specname, specid = 0, nil, nil

		for i = 1, MAX_TALENT_TABS do
			local name, _, pointsSpent = GetTalentTabInfo(i, isInspect, isPet, currentSpecGroup)
			if points <= pointsSpent then
				points = pointsSpent
				specname = name
				specid = i
			end
		end
		return specid, specname, points
	end

	local function UnitHasTalent(unit, spell, talentGroup)
		spell = (type(spell) == "number") and GetSpellInfo(spell) or spell
		return LGT:UnitHasTalent(unit, spell, talentGroup)
	end

	local function GetInspectSpecialization(unit, class)
		local spec  -- start with nil

		if UnitExists(unit) then
			class = class or select(2, UnitClass(unit))
			if class and specsTable[class] then
				local talentGroup = LGT:GetActiveTalentGroup(unit)
				local maxPoints, index = 0, 0

				for i = 1, MAX_TALENT_TABS do
					local _, _, pointsSpent = LGT:GetTalentTabInfo(unit, i, talentGroup)
					if pointsSpent ~= nil then
						if maxPoints < pointsSpent then
							maxPoints = pointsSpent
							if class == "DRUID" and i >= 2 then
								if i == 3 then
									index = 4
								elseif i == 2 then
									local points = UnitHasTalent(unit, 57881)
									index = (points and points > 0) and 3 or 2
								end
							else
								index = i
							end
						end
					end
				end
				spec = specsTable[class][index]
			end
		end

		return spec
	end

	local function GetSpecializationRole(unit, class)
		unit = unit or "player" -- always fallback to player

		-- For LFG using "UnitGroupRolesAssigned" is enough.
		local isTank, isHealer, isDamager = UnitGroupRolesAssigned(unit)
		if isTank then
			return "TANK"
		elseif isHealer then
			return "HEALER"
		elseif isDamager then
			return "DAMAGER"
		end

		-- speedup things using classes.
		class = class or select(2, UnitClass(unit))
		if class == "HUNTER" or class == "MAGE" or class == "ROGUE" or class == "WARLOCK" then
			return "DAMAGER"
		end
		return LGTRoleTable[LGT:GetUnitRole(unit)] or "NONE"
	end

	local function GetSpecializationInfo(specIndex, isInspect, isPet, specGroup)
		local name, icon, _, background = GetTalentTabInfo(specIndex, isInspect, isPet, specGroup)
		local id, role
		if isInspect and UnitExists("target") then
			id, role = GetInspectSpecialization("target"), GetSpecializationRole("target")
		else
			id, role = GetInspectSpecialization("player"), GetSpecializationRole("player")
		end
		return id, name, "NaN", icon, background, role
	end

	local function update(_, _, unit)
		local specID, name = GetInspectSpecialization(unit), UnitName(unit)
		-- if raid table doesn't findd the player, force an update
		if not raid[name] then
			DBM:RAID_ROSTER_UPDATE(true)
		end
		-- populate specID
		if raid[name] then
			raid[name].specID = specID
		end
	end
	LGT.RegisterCallback(DBM, "LibGroupTalents_Update", update)

	--In event api fails to pull any data at all, just assign classes to their initial template roles from exiles reach
	local fallbackClassToRole = {
		["MAGE"] = 1449,
		["PALADIN"] = 1451,
		["WARRIOR"] = 1446,
		["DRUID"] = 1447,
		["DEATHKNIGHT"] = 1455,
		["HUNTER"] = 1448,
		["PRIEST"] = 1452,
		["ROGUE"] = 1453,
		["SHAMAN"] = 1444,
		["WARLOCK"] = 1454,
	}

	function DBM:SetCurrentSpecInfo()
		currentSpecGroup = GetSpecialization() or 1
		if GetSpecializationInfo(currentSpecGroup) then
			currentSpecID, currentSpecName = GetSpecializationInfo(currentSpecGroup)--give temp first spec id for non-specialization char. no one should use dbm with no specialization, below level 10, should not need dbm.
			currentSpecID = tonumber(currentSpecID)
		else
			currentSpecID, currentSpecName = fallbackClassToRole[playerClass], playerClass
		end
	end

	function DBM:GetUnitRole(uId, class)
		return GetSpecializationRole(uId, class)
	end

	function DBM:GetUnitRoleIcon(uId, class)
		local role = GetSpecializationRole(uId, class)
		return roleIconTable[role]
	end
end

-- https://wowpedia.fandom.com/wiki/DifficultyID
-- ID	Name				Type		Flavour
-- 1	Normal				party		retail
-- 2	Heroic				party		retail
-- 3	10 Player			raid		retail
-- 4	25 Player			raid		retail
-- 5	10 Player (Heroic)	raid		retail
-- 6	25 Player (Heroic)	raid		retail
-- 9	40 Player			raid
-- 16	Mythic				raid
-- 18	Event				raid		retail (custom)
-- 23	Mythic				party
-- 24	Timewalking			party
-- 33	Timewalking			raid
-- 148	20 Player			raid
-- 173	Normal				party		classic
-- 174	Heroic				party		classic
-- 175	10 Player			raid		classic
-- 176	25 Player			raid		classic
-- 186	40 Player			raid		classic (custom?)
-- 193	10 Player (Heroic)	raid		classic
-- 194	25 Player (Heroic)	raid		classic
function DBM:GetCurrentInstanceDifficulty()
	local instanceName, instanceType, difficulty, difficultyName, maxPlayers, dynamicDifficulty, isDynamicInstance = GetInstanceInfo()
	if instanceType == "none" then
		return difficulty == 1 and "worldboss", L.RAID_INFO_WORLD_BOSS.." - ", 0, maxPlayers
	elseif instanceType == "raid" then
		if isDynamicInstance then -- Dynamic raids (ICC, RS)
			if difficulty == 1 then -- 10 players
				if dynamicDifficulty == 0 then
					return "normal10", difficultyName.." - ", 175, maxPlayers
				elseif dynamicDifficulty == 1 then
					return "heroic10" , difficultyName.." - ", 193, maxPlayers
				else
					return "unknown" , difficultyName.." - ", difficulty, maxPlayers
				end
			elseif difficulty == 2 then -- 25 players
				if dynamicDifficulty == 0 then
					return "normal25", difficultyName.." - ", 176, maxPlayers
				elseif dynamicDifficulty == 1 then
					return "heroic25", difficultyName.." - ", 194, maxPlayers
				else
					return "unknown", difficultyName.." - ", difficulty, maxPlayers
				end
			-- On Warmane, it was confirmed by Midna that difficulty returning only 1 or 2 is their intended behaviour: https://www.warmane.com/bugtracker/report/91065
			-- code below (difficulty 3 and 4 in dynamic instances) prevents GetCurrentInstanceDifficulty() from breaking on servers that correctly assign difficulty 1-4 in dynamic instances.
			elseif difficulty == 3 then -- 10 heroic, dynamic
				return "heroic10", difficultyName.." - ", 193, maxPlayers
			elseif difficulty == 4 then -- 25 heroic, dynamic
				return "heroic25", difficultyName.." - ", 194, maxPlayers
			end
		else -- Non-dynamic raids
			if difficulty == 1 then
				-- check for Timewalking instance (workaround using GetRaidDifficulty since on Warmane all the usual APIs fail and return "normal" difficulty)
				local raidDifficulty = GetRaidDifficulty()
				if raidDifficulty ~= difficulty and (raidDifficulty == 2 or raidDifficulty == 4) then -- extra checks due to lack of tests and no access to a timewalking server
					return "timewalker", difficultyName.." - ", 33, maxPlayers
				else
					if maxPlayers == 40 then
						return "normal40", difficultyName.." - ", 186, maxPlayers
					elseif maxPlayers == 25 then
						return "normal25", difficultyName.." - ", 176, maxPlayers
					elseif maxPlayers == 20 then -- ZG, AQ20
						return "normal20", difficultyName.." - ", 148, maxPlayers
					elseif maxPlayers == 10 then
						return "normal10", difficultyName.." - ", 175, maxPlayers
					elseif maxPlayers == 0 and instanceName == "Azshara Crater" then -- Warmane 2024 Tower Defense, with completely borked API
						return "event25", "Event - ", 18, 25
					elseif maxPlayers then
						DBM:AddMsg("Instance difficulty not registered. Please report this bug! -> ".. maxPlayers)
						return maxPlayers and "normal"..maxPlayers, difficultyName.." - ", difficulty, maxPlayers
					else
						return "unknown", difficultyName.." - ", difficulty, maxPlayers
					end
				end
			elseif difficulty == 2 then
				return "normal25", difficultyName.." - ", 176, maxPlayers
			elseif difficulty == 3 then
				return "heroic10", difficultyName.." - ", 193, maxPlayers
			elseif difficulty == 4 then
				return "heroic25", difficultyName.." - ", 194, maxPlayers
			end
		end
	elseif instanceType == "party" then -- 5 man Dungeons
		if difficulty == 1 then
			return "normal5", difficultyName.." - ", 173, maxPlayers
		elseif difficulty == 2 then
			-- check for Mythic instance (workaround using GetDungeonDifficulty since on Warmane all the usual APIs fail and return "heroic" difficulty)
			local dungeonDifficulty = GetDungeonDifficulty()
			if dungeonDifficulty == 3 then
				return "mythic", difficultyName.." - ", 23, maxPlayers
			else
				return "heroic5", difficultyName.." - ", 174, maxPlayers
			end
		end
	end
end

function DBM:GetCurrentArea()
	return LastInstanceMapID
end

function DBM:GetCurrentAreaName()
	return LastInstanceZoneName
end

function DBM:GetCurrentDifficulty()
	return difficultyIndex
end

function DBM:GetGroupSize()
	return LastGroupSize
end

--Public api for requesting what phase a boss is in, in case they missed the DBM_SetStage callback
--ModId would be journal Id or mod string of mod.
--If not mod is not provided, it'll simply return stage for first boss in combat table if a boss is engaged
function DBM:GetStage(modId)
	if modId then
		local mod = self:GetModByName(modId)
		if mod and mod.inCombat then
			return mod.vb.phase or 0, mod.vb.stageTotality or 0
		end
	else
		if #inCombat > 0 then--At least one boss is engaged
			local mod = inCombat[1]--Get first mod in table
			if mod then
				return mod.vb.phase or 0, mod.vb.stageTotality or 0
			end
		end
	end
end

function DBM:HasMapRestrictions()
	local playerX, playerY = GetPlayerMapPosition("player")
	-- if playerX == 0 or playerY == 0 then -- attempt to fix zone once. Disabled for now to confirm LK 2.5 FPS issues.
	-- 	SetMapToCurrentZone() -- DO NOT RUN THIS FUNCTION IN A LOOP! It's a waste of cpu power and will tank FPS due to radar loop scan.
	-- 	playerX, playerY = GetPlayerMapPosition("player")
	-- end
	local mapName = GetMapInfo()
	local level = GetCurrentMapDungeonLevel()
	local usesTerrainMap = DungeonUsesTerrainMap()
	level = usesTerrainMap and level - 1 or level
	if (playerX == 0 and playerY == 0) or (self.MapSizes[mapName] and not self.MapSizes[mapName][level]) then
		return true
	end
	return false
end

do
	local LSMMediaCacheBuilt, sharedMediaFileCache, validateCache = false, {}, {}

	local function buildLSMFileCache()
		local hashtable = LibStub("LibSharedMedia-3.0", true):HashTable("sound")
		local keytable = {}
		for k in next, hashtable do
			tinsert(keytable, k)
		end
		for i = 1, #keytable do
			sharedMediaFileCache[hashtable[keytable[i]]] = true
		end
		LSMMediaCacheBuilt = true
	end

	function DBM:ValidateSound(path, log, ignoreCustom)
		-- Ignore built-in sounds
		if string.find(path:lower(), "^sound[\\/]+") then -- type(path) == "number" removed since it's not supported in WotLK
			return true
		end
		-- Validate LibSharedMedia
		if not LSMMediaCacheBuilt then
			buildLSMFileCache()
		end
		if not sharedMediaFileCache[path] and not path:find("DBM") then
			if log then
				if ignoreCustom then
					-- This uses debug print because it has potential to cause mid fight spam
					self:Debug("PlaySoundFile failed do to missing media at " .. path .. ". To fix this, re-add missing sound or change setting using this sound to a different sound.")
				else
					AddMsg(self, "PlaySoundFile failed do to missing media at " .. path .. ". To fix this, re-add missing sound or change setting using this sound to a different sound.")
				end
			end
			return false
		end
		-- Validate audio packs
		if not validateCache[path] then
			local splitTable = {}
			for split in string.gmatch(path, "[^\\/]+") do -- Matches \ and / as path delimiters (incl. more than one)
				tinsert(splitTable, split)
			end
			if #splitTable >= 3 and splitTable[3]:lower() == "dbm-customsounds" then
				validateCache[path] = {
					exists = ignoreCustom or false
				}
			elseif #splitTable >= 3 and splitTable[1]:lower() == "interface" and splitTable[2]:lower() == "addons" then -- We're an addon sound
				validateCache[path] = {
					exists = IsAddOnLoaded(splitTable[3]),
					AddOn = splitTable[3]
				}
			else
				validateCache[path] = {
					exists = true
				}
			end
		end
		if validateCache[path] and not validateCache[path].exists then
			if log then
				-- This uses actual user print because these events only occur at start or end of instance or fight.
				AddMsg(self, "PlaySoundFile failed due to missing media at " .. path .. ". To fix this, re-add/enable " .. validateCache[path].AddOn .. " or change setting using this sound to a different sound.")
			end
			return false
		end
		return true
	end

	local function playSoundFile(self, path, _, validate)
		if self.Options.SilentMode or path == "" or path == "None" then
			return
		end
		if validate and not self:ValidateSound(path, true, true) then
			return
		end
		self:Debug("PlaySoundFile playing with media " .. path, 3)
		PlaySoundFile(path)
		fireEvent("DBM_PlaySound", path)
	end
	local ingameSoundPath = {
		[850] = "Sound\\Interface\\uEscapeScreenOpen.wav",
		[856] = "Sound\\Interface\\uChatScrollButton.wav",
		[8585] = "Sound\\Creature\\CThun\\CThunYouWillDIe.wav",
		[8960] = "Sound\\Interface\\levelup2.wav"
	}
	local function playSound(self, path, ignoreSFX)
		if self.Options.SilentMode or path == "" or path == "None" then
			return
		end
		local soundSetting = self.Options.UseSoundChannel
		self:Debug("PlaySound playing with media " .. path, 3)
		if ignoreSFX or soundSetting == "Master" then
			if ingameSoundPath[path] then
				PlaySoundFile(ingameSoundPath[path])
			else
				PlaySound(path)
				if not GetCVarBool("Sound_EnableSFX") then
					self:AddMsg("No sound because SFX is disabled and DBM ingameSoundPath table does not have a sound path for " .. path .. ". Report the path (the numbers) to maintainer on Discord or Github.")
				end
			end
		else
			PlaySound(path) -- Using SFX channel, leave forceNoDuplicates on.
		end
		fireEvent("DBM_PlaySound", path)
	end

	function DBM:PlaySoundFile(path, ignoreSFX, validate)
		playSoundFile(self, path, ignoreSFX, validate)
	end

	function DBM:PlaySound(path, ignoreSFX)
		playSound(self, path, ignoreSFX)
	end
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

function DBM:UnitAura(uId, spellInput, spellInput2, spellInput3, spellInput4)
	if not uId then return end
	for i = 1, 60 do
		local spellName, rank, icon, count, debuffType, duration, expirationTime, unitCaster, isStealable, shouldConsolidate, spellId = UnitAura(uId, i)
		if not spellName then return end
		if spellInput == spellName or spellInput == spellId or spellInput2 == spellName or spellInput2 == spellId or spellInput3 == spellName or spellInput3 == spellId or spellInput4 == spellName or spellInput4 == spellId then
			return spellName, rank, icon, count, debuffType, duration, expirationTime, unitCaster, isStealable, shouldConsolidate, spellId
		end
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

--Handle new spell name requesting with wrapper, to make api changes easier to handle
function DBM:GetSpellInfoNew(spellId)
	local name, rank, icon, _, _, _, castingTime, minRange, maxRange = GetSpellInfo(spellId)
	if not name then--Bad request all together
		DBM:Debug("|cffff0000Invalid call to GetSpellInfo for spellID: |r"..spellId)
		return nil
	else--Good request, return now
		return name, rank, icon, castingTime, minRange, maxRange, spellId
	end
end

function DBM:UnitDebuffNew(uId, spellInput, spellInput2, spellInput3, spellInput4)
	if not uId then return end
	for i = 1, 60 do
		local spellName, _, icon, count, debuffType, duration, expirationTime, unitCaster, isStealable, shouldConsolidate, spellId = UnitDebuff(uId, i)
		if not spellName then return end
		if spellInput == spellName or spellInput == spellId or spellInput2 == spellName or spellInput2 == spellId or spellInput3 == spellName or spellInput3 == spellId or spellInput4 == spellName or spellInput4 == spellId then
			return spellName, icon, count, debuffType, duration, expirationTime, unitCaster, isStealable, shouldConsolidate, spellId
		end
	end
end

function DBM:UnitBuffNew(uId, spellInput, spellInput2, spellInput3, spellInput4)
	if not uId then return end
	for i = 1, 60 do
		local spellName, _, icon, count, debuffType, duration, expirationTime, unitCaster, isStealable, shouldConsolidate, spellId = UnitBuff(uId, i)
		if not spellName then return end
		if spellInput == spellName or spellInput == spellId or spellInput2 == spellName or spellInput2 == spellId or spellInput3 == spellName or spellInput3 == spellId or spellInput4 == spellName or spellInput4 == spellId then
			return spellName, icon, count, debuffType, duration, expirationTime, unitCaster, isStealable, shouldConsolidate, spellId
		end
	end
end

function DBM:UNIT_DIED(args)
	local GUID = args.destGUID
	if self:IsCreatureGUID(GUID) then
		self:OnMobKill(self:GetCIDFromGUID(GUID))
	end
	----GUIDIsPlayer
	if self.Options.AFKHealthWarning and GUID == UnitGUID("player") and not DBM:IsEncounterInProgress() and UnitIsAFK("player") and self:AntiSpam(5, "AFK") then--You are afk and losing health, some griever is trying to kill you while you are afk/tabbed out.
		self:FlashClientIcon()
		self:PlaySound(8585)--So fire an alert sound to save yourself from this person's behavior.
		self:AddMsg(L.AFK_WARNING:format(0))
	end
end
DBM.UNIT_DESTROYED = DBM.UNIT_DIED

----------------------
--  Timer recovery  --
----------------------
do
	local requestedFrom = {}
	local requestTime = 0

	local function sort(v1, v2)
		if v1.revision and not v2.revision then
			return true
		elseif v2.revision and not v1.revision then
			return false
		elseif v1.revision and v2.revision then
			return (tonumber(v1.revision) or 0) > (tonumber(v2.revision) or 0)
		end
	end

	function DBM:RequestTimers(requestNum)
		if not dbmIsEnabled then return end
		local sortMe, clientUsed = {}, {}
		for _, v in pairs(raid) do
			tinsert(sortMe, v)
		end
		tsort(sortMe, sort)
		self:Debug("RequestTimers Running", 2)
		local selectedClient
		local listNum = 0
		for _, v in ipairs(sortMe) do
			-- If selectedClient player's realm is not same with your's, timer recovery by selectedClient not works at all.
			-- SendAddonMessage target channel is "WHISPER" and target player is other realm, no msg sends at all. At same realm, message sending works fine. (Maybe bliz bug or SendAddonMessage function restriction?)
			if v.name ~= playerName and UnitIsConnected(v.id) and UnitIsPlayer(v.id) and (not UnitIsGhost(v.id)) and (GetTime() - (clientUsed[v.name] or 0)) > 10 then
				listNum = listNum + 1
				if listNum == requestNum then
					selectedClient = v
					clientUsed[v.name] = GetTime()
					break
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
		if dbmIsEnabled and requestedFrom[sender] and (GetTime() - requestTime) < 5 and #inCombat == 0 then
			self:StartCombat(mod, time, "TIMER_RECOVERY")
			--Recovery successful, someone sent info, abort other recovery requests
			self:Unschedule(self.RequestTimers)
			twipe(requestedFrom)
		end
	end

	function DBM:ReceiveTimerInfo(sender, mod, timeLeft, totalTime, id, paused, ...)
		DBM:Debug(("Receiving Timer Info: %s %s %s %s from %s"):format(mod.id, timeLeft, totalTime, "123", sender), 3)
		if requestedFrom[sender] and (GetTime() - requestTime) < 5 then
			local lag = paused and 0 or select(3, GetNetStats()) / 1000
			for _, v in ipairs(mod.timers) do
				if v.id == id then
					v:Start(totalTime, ...)
					if paused then
						v.paused = true
					end
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
				if name == "phase" then
					mod:SetStage(value)--Fire stage callback for 3rd party mods when stage is recovered
				end
			end
		end
	end
end

do
	local spamProtection = {}
	function DBM:SendTimers(target)
		if not dbmIsEnabled then return end
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
			--Break timer is up, so send that
			--But only if we are not in combat with a boss
			local breakBar = DBT:GetBar("%s\t"..L.TIMER_BREAK) or DBT:GetBar(L.TIMER_BREAK)
			if breakBar then
				local remaining = breakBar.timer
				self:Debug("Sending Break timer to "..target, 2)
				SendAddonMessage("DBMv4-BTR3", remaining, "WHISPER", target)
				SendAddonMessage("DBMv4-Pizza", ("%s\t%s\t%s"):format(remaining, L.TIMER_BREAK, tostring(true))) -- Backwards compatibility so old DBMs can receive break timers from this DBM
			end
			return
		end
		local mod
		for _, v in ipairs(inCombat) do
			mod = not v.isCustomMod and v
		end
		mod = mod or inCombat[1]
		self:SendCombatInfo(mod, target)
		self:SendVariableInfo(mod, target)
		self:SendTimerInfo(mod, target)
	end
	function DBM:SendPVPTimers(target)
		if not dbmIsEnabled then return end
		self:Debug("SendPVPTimers requested by "..target, 2)
		local spamForTarget = spamProtection[target] or 0
		local time = GetTime()
		-- just try to clean up the table, that should keep the hash table at max. 4 entries or something :)
		for k, v in pairs(spamProtection) do
			if time - v >= 1 then
				spamProtection[k] = nil
			end
		end
		if time - spamForTarget < 1 then -- just to prevent players from flooding this on purpose
			return
		end
		spamProtection[target] = time
		local mod = self:GetModByName("PvPGeneral")
		if mod then
			self:SendTimerInfo(mod, target)
		end
	end
end

function DBM:SendCombatInfo(mod, target)
	if not dbmIsEnabled then return end
	return SendAddonMessage("DBMv4-CombatInfo", ("%s\t%s"):format(mod.id, GetTime() - mod.combatInfo.pull), "WHISPER", target)
end

function DBM:SendTimerInfo(mod, target)
	if not dbmIsEnabled then return end
	for _, v in ipairs(mod.timers) do
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
					self:Debug(("Sending Timer Info: %s %s %s %s to %s"):format(mod.id, timeLeft, totalTime, uId, v.paused and "1" or "0", target), 3)
					SendAddonMessage("DBMv4-TimerInfo", ("%s\t%s\t%s\t%s\t%s"):format(mod.id, timeLeft, totalTime, uId, v.paused and "1" or "0"), "WHISPER", target)
				end
			end
		end
	end
end

function DBM:SendVariableInfo(mod, target)
	if not dbmIsEnabled then return end
	for vname, v in pairs(mod.vb) do
		local v2 = tostring(v)
		if v2 then
			SendAddonMessage("DBMv4-VarInfo", ("%s\t%s\t%s"):format(mod.id, vname, v2), "WHISPER", target)
		end
	end
end

do
	function DBM:PLAYER_ENTERING_WORLD()
		if self.Options.ShowReminders then
			self:Schedule(25, function() if self.Options.SilentMode then self:AddMsg(L.SILENT_REMINDER) end end)
			self:Schedule(30, function() if not self.Options.SettingsMessageShown then self.Options.SettingsMessageShown = true self:AddMsg(L.HOW_TO_USE_MOD) end end)
--			self:Schedule(35, function() if self.Options.NewsMessageShown2 < 2 then self.Options.NewsMessageShown2 = 2 self:AddMsg(L.NEWS_UPDATE) end end)
		end
		--Check if any previous changed cvars were not restored and restore them
		if self.Options.DisableSFX then
			SetCVar("Sound_EnableSFX", 1)
			self:Debug("Restoring Sound_EnableSFX CVAR")
		end
		if #inCombat == 0 then
			DBM:Schedule(0, self.RequestTimers, self, 1)
		end
		self:LFG_UPDATE()
		DBM.BossHealth:Hide()
	end
end

------------------------------------
--  Auto-respond/Status whispers  --
------------------------------------
do
	local function getNumAlivePlayers()
		local alive = 0
		if IsInRaid() then
			for i = 1, GetNumGroupMembers() do
				alive = alive + ((UnitIsDeadOrGhost("raid"..i) and 0) or 1)
			end
		else
			alive = (UnitIsDeadOrGhost("player") and 0) or 1
			for i = 1, GetNumSubgroupMembers() do
				alive = alive + ((UnitIsDeadOrGhost("party"..i) and 0) or 1)
			end
		end
		return alive
	end

	local function getNumRealAlivePlayers()
		local alive = 0
		local playerCurrentZone = GetRealZoneText() or CL.UNKNOWN
		if IsInRaid() then
			for i = 1, GetNumGroupMembers() do
				local _, _, _, _, _, _, zone = GetRaidRosterInfo(i)
				if zone == playerCurrentZone then
					alive = alive + ((UnitIsDeadOrGhost("raid"..i) and 0) or 1)
				end
			end
		else
			alive = (UnitIsDeadOrGhost("player") and 0) or 1
			for i = 1, GetNumSubgroupMembers() do
				if UnitInRange("party"..i) then -- this is VERY conservative to check for same zone. Might remove if too many false negatives
					alive = alive + ((UnitIsDeadOrGhost("party"..i) and 0) or 1)
				end
			end
		end
		return alive
	end
	function DBM:NumRealAlivePlayers()
		return getNumRealAlivePlayers()
	end

	-- sender is a presenceId for real id messages, a character name otherwise
	local function onWhisper(msg, sender) -- msg, sender, isRealIdMessage
		if private.statusWhisperDisabled then return end--RL has disabled status whispers for entire raid.
		if not checkForSafeSender(sender, true, true, true) then return end--Automatically reject all whisper functions from non friends, non guildies, or people in group with us
		if msg == "status" and #inCombat > 0 and DBM.Options.AutoRespond then
			if not difficultyText then -- prevent error when timer recovery function worked and etc (StartCombat not called)
				savedDifficulty, difficultyText, difficultyIndex, LastGroupSize = DBM:GetCurrentInstanceDifficulty()
			end
			local mod
			for _, v in ipairs(inCombat) do
				mod = not v.isCustomMod and v
			end
			mod = mod or inCombat[1]
			if mod.noStatistics then return end
			local hp = mod.highesthealth and mod:GetHighestBossHealth() or mod:GetLowestBossHealth()
			local hpText = mod.CustomHealthUpdate and mod:CustomHealthUpdate() or hp and ("%d%%"):format(hp) or CL.UNKNOWN
			if mod.vb.phase then
				hpText = hpText.." ("..L.SCENARIO_STAGE:format(mod.vb.phase)..")"
			end
			if mod.numBoss and mod.vb.bossLeft and mod.numBoss > 1 then
				local bossesKilled = mod.numBoss - mod.vb.bossLeft
				hpText = hpText.." ("..BOSSES_KILLED:format(bossesKilled, mod.numBoss)..")"
			end
			sendWhisper(sender, chatPrefixShort..L.STATUS_WHISPER:format(difficultyText..(mod.combatInfo.name or ""), hpText, getNumAlivePlayers(), mmax(GetNumRaidMembers(), GetNumPartyMembers() + 1)))
		elseif #inCombat > 0 and DBM.Options.AutoRespond then
			if not difficultyText then -- prevent error when timer recovery function worked and etc (StartCombat not called)
				savedDifficulty, difficultyText, difficultyIndex, LastGroupSize = DBM:GetCurrentInstanceDifficulty()
			end
			local mod
			for _, v in ipairs(inCombat) do
				mod = not v.isCustomMod and v
			end
			mod = mod or inCombat[1]
			if mod.noStatistics then return end
			local hp = mod.highesthealth and mod:GetHighestBossHealth() or mod:GetLowestBossHealth()
			local hpText = mod.CustomHealthUpdate and mod:CustomHealthUpdate() or hp and ("%d%%"):format(hp) or CL.UNKNOWN
			if mod.vb.phase then
				hpText = hpText.." ("..L.SCENARIO_STAGE:format(mod.vb.phase)..")"
			end
			if mod.numBoss and mod.vb.bossLeft and mod.numBoss > 1 then
				local bossesKilled = mod.numBoss - mod.vb.bossLeft
				hpText = hpText.." ("..BOSSES_KILLED:format(bossesKilled, mod.numBoss)..")"
			end
			if not autoRespondSpam[sender] then
				sendWhisper(sender, chatPrefixShort..L.AUTO_RESPOND_WHISPER:format(playerName, difficultyText..(mod.combatInfo.name or ""), hpText, getNumAlivePlayers(), mmax(GetNumRaidMembers(), GetNumPartyMembers() + 1)))
				DBM:AddMsg(L.AUTO_RESPONDED)
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

--This completely unregisteres or registers distruptive events so they don't obstruct combat
--Toggle is for if we are turning off or on.
--Custom is for external mods to call function without duplication and allowing pvp mods custom toggle.
do
	local unregisteredEvents = {}
	local function DisableEvent(frameName, eventName)
		if frameName:IsEventRegistered(eventName) then
			frameName:UnregisterEvent(eventName)
			unregisteredEvents[eventName] = true
		end
	end
	local function EnableEvent(frameName, eventName)
		if unregisteredEvents[eventName] then
			frameName:RegisterEvent(eventName)
			unregisteredEvents[eventName] = nil
		end
	end
	function DBM:HideBlizzardEvents(toggle, custom)
		if toggle == 1 then
			if (self.Options.HideBossEmoteFrame2 or custom) then
				DisableEvent(RaidBossEmoteFrame, "CHAT_MSG_RAID_BOSS_EMOTE")
				DisableEvent(RaidBossEmoteFrame, "CHAT_MSG_RAID_BOSS_WHISPER")
				-- SOUNDKIT.UI_RAID_BOSS_WHISPER_WARNING = 999999 --Commented out and not backported since I don't want to touch blizzard function to edit out the PlaySound("RaidBossEmoteWarning"). Since blizzard can still play the sound via RaidBossEmoteFrame_OnEvent (line 137) via encounter scripts in certain cases despite the frame having no registered events
			end
		elseif toggle == 0 then
			if (self.Options.HideBossEmoteFrame2 or custom) then
				EnableEvent(RaidBossEmoteFrame, "CHAT_MSG_RAID_BOSS_EMOTE")
				EnableEvent(RaidBossEmoteFrame, "CHAT_MSG_RAID_BOSS_WHISPER")
				-- SOUNDKIT.UI_RAID_BOSS_WHISPER_WARNING = 37666 --restore it
			end
		end
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

--------------------------
--  Enable/Disable DBM  --
--------------------------
do
	local forceDisabled = false
	function DBM:Disable(forceDisable)
		DBMScheduler:Unschedule()
		dbmIsEnabled = false
		private.dbmIsEnabled = false
		forceDisabled = forceDisable
	end

	function DBM:Enable()
		if not forceDisabled then
			dbmIsEnabled = true
		end
	end

	function DBM:IsEnabled()
		return dbmIsEnabled
	end

	function DBM:ForceDisableSpam()
		if testBuild then
			DBM:AddMsg(L.UPDATEREMINDER_DISABLETEST)
		elseif dbmToc < wowTOC then
			DBM:AddMsg(L.UPDATEREMINDER_MAJORPATCH)
		else
			DBM:AddMsg(L.UPDATEREMINDER_DISABLE)
		end
	end
end

-----------------------
--  Misc. Functions  --
-----------------------
function DBM:AddMsg(text, prefix)
	local tag = prefix or (self.localization and self.localization.general.name) or L.DBM
	local frame = DBM.Options.ChatFrame and _G[tostring(DBM.Options.ChatFrame)] or DEFAULT_CHAT_FRAME
	if not frame or not frame:IsShown() then
		frame = DEFAULT_CHAT_FRAME
	end
	if prefix ~= false then
		frame:AddMessage(("|cffff7d0a<|r|cffffd200%s|r|cffff7d0a>|r %s"):format(tostring(tag), tostring(text)), 0.41, 0.8, 0.94)
	else
		frame:AddMessage(text, 0.41, 0.8, 0.94)
	end
end
AddMsg = DBM.AddMsg

do
	local testMod
	local testWarning1, testWarning2, testWarning3
	local testTimer1, testTimer2, testTimer3, testTimer4, testTimer5, testTimer6, testTimer7, testTimer8
	local testSpecialWarning1, testSpecialWarning2, testSpecialWarning3
	function DBM:DemoMode()
		if not testMod then
			testMod = self:NewMod("TestMod")
			self:GetModLocalization("TestMod"):SetGeneralLocalization{ name = "Test Mod" }
			testWarning1 = testMod:NewAnnounce("%s", 1, "Interface\\Icons\\Spell_Nature_WispSplode")
			testWarning2 = testMod:NewAnnounce("%s", 2, "Interface\\Icons\\Spell_Shadow_Shadesofdarkness")
			testWarning3 = testMod:NewAnnounce("%s", 3, "Interface\\Icons\\Spell_Fire_SelfDestruct")
			testTimer1 = testMod:NewTimer(20, "%s", "Interface\\Icons\\Spell_Nature_WispSplode", nil, nil)
			testTimer2 = testMod:NewTimer(20, "%s ", "Interface\\Icons\\INV_Misc_Head_Orc_01", nil, nil, 1)
			testTimer3 = testMod:NewTimer(20, "%s  ", "Interface\\Icons\\Spell_Shadow_Shadesofdarkness", nil, nil, 3, CL.MAGIC_ICON, nil, 1, 4)--inlineIcon, keep, countdown, countdownMax
			testTimer4 = testMod:NewTimer(20, "%s   ", "Interface\\Icons\\Spell_Nature_WispSplode", nil, nil, 4, CL.INTERRUPT_ICON)
			testTimer5 = testMod:NewTimer(20, "%s    ", "Interface\\Icons\\Spell_Fire_SelfDestruct", nil, nil, 2, CL.HEALER_ICON, nil, 3, 4)--inlineIcon, keep, countdown, countdownMax
			testTimer6 = testMod:NewTimer(20, "%s     ", "Interface\\Icons\\Spell_Nature_WispSplode", nil, nil, 5, CL.TANK_ICON, nil, 2, 4)--inlineIcon, keep, countdown, countdownMax
			testTimer7 = testMod:NewTimer(20, "%s      ", "Interface\\Icons\\Spell_Nature_WispSplode", nil, nil, 6)
			testTimer8 = testMod:NewTimer(20, "%s       ", "Interface\\Icons\\Spell_Nature_WispSplode", nil, nil, 7)
			testSpecialWarning1 = testMod:NewSpecialWarning("%s", nil, nil, nil, 1, 2)
			testSpecialWarning2 = testMod:NewSpecialWarning(" %s ", nil, nil, nil, 2, 2)
			testSpecialWarning3 = testMod:NewSpecialWarning("  %s  ", nil, nil, nil, 3, 2) -- hack: non auto-generated special warnings need distinct names (we could go ahead and give them proper names with proper localization entries, but this is much easier)
		end
		testTimer1:Stop("Test Bar showing 5s Variance")
		testTimer2:Stop("Adds")
		testTimer3:Stop("Evil Debuff")
		testTimer4:Stop("Important Interrupt")
		testTimer5:Stop("Boom!")
		testTimer6:Stop("Handle your Role")
		testTimer7:Stop("Next Stage")
		testTimer8:Stop("Custom User Bar")
		testTimer1:Start("v5-10", "Test Bar showing 5s Variance")
		testTimer2:Start("v25-30", "Adds")
		testTimer3:Start(43, "Evil Debuff")
		testTimer4:Start(20, "Important Interrupt")
		testTimer5:Start(60, "Boom!")
		testTimer6:Start("v32-35", "Handle your Role")
		testTimer7:Start(50, "Next Stage")
		testTimer8:Start(55, "Custom User Bar")
		testWarning1:Cancel()
		testWarning2:Cancel()
		testWarning3:Cancel()
		testSpecialWarning1:Cancel()
		testSpecialWarning1:CancelVoice()
		testSpecialWarning2:Cancel()
		testSpecialWarning2:CancelVoice()
		testSpecialWarning3:Cancel()
		testSpecialWarning3:CancelVoice()
		testWarning1:Show("Test-mode started...")
		testWarning1:Schedule(62, "Test-mode finished!")
		testWarning3:Schedule(50, "Boom in 10 sec!")
		testWarning3:Schedule(20, "Pew Pew Laser Owl!")
		testWarning2:Schedule(38, "Evil Spell in 5 sec!")
		testWarning2:Schedule(43, "Evil Spell!")
		testWarning1:Schedule(10, "Test Bar expired!")
		testSpecialWarning1:Schedule(20, "Pew Pew Laser Owl")
		testSpecialWarning1:ScheduleVoice(20, "runaway")
		testSpecialWarning2:Schedule(43, "Fear!")
		testSpecialWarning2:ScheduleVoice(43, "fearsoon")
		testSpecialWarning3:Schedule(60, "Boom!")
		testSpecialWarning3:ScheduleVoice(60, "defensive")
	end
end

DBT:SetAnnounceHook(function(bar)
	local prefix
	if bar.color and bar.color.r == 1 and bar.color.g == 0 and bar.color.b == 0 then
		prefix = L.HORDE or FACTION_HORDE
	elseif bar.color and bar.color.r == 0 and bar.color.g == 0 and bar.color.b == 1 then
		prefix = L.ALLIANCE or FACTION_ALLIANCE
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
	end
	return false
end

function DBM:InCombat()
	return #inCombat > 0
end

local FlashWindow = FlashWindow
function DBM:FlashClientIcon(checkAddon)
	if not FlashWindow then return end -- Check for FlashClient exe patch
	-- Check for addon via argument to prevent double API call from both DBM and FlashWindow since it would negate the icon flashing
	if checkAddon and IsAddOnLoaded("FlashWindow") then return end

	if self:AntiSpam(5, "FLASH") then
		FlashWindow()
	end
end

do
	--Search Tags: iconto, toicon, raid icon, diamond, star, triangle
	local iconStrings = {[1] = RAID_TARGET_1, [2] = RAID_TARGET_2, [3] = RAID_TARGET_3, [4] = RAID_TARGET_4, [5] = RAID_TARGET_5, [6] = RAID_TARGET_6, [7] = RAID_TARGET_7, [8] = RAID_TARGET_8,}
	function DBM:IconNumToString(number)
		return iconStrings[number] or number
	end
	function DBM:IconNumToTexture(number)
		return "|TInterface\\TargetingFrame\\UI-RaidTargetingIcon_"..number..".blp:12:12|t" or number
	end
end

do
	local DevTools = private:GetModule("DevTools")
	function DBM:Debug(...)
		return DevTools:Debug(...)
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

function DBM:GetMapSize()
	local mapName = GetMapInfo()
	local level = GetCurrentMapDungeonLevel()
	local usesTerrainMap = DungeonUsesTerrainMap()
	level = usesTerrainMap and level - 1 or level
	local dims = self.MapSizes[mapName] and self.MapSizes[mapName][level]
	return dims[1], dims[2]
end

--------------------
--  Movie Filter  --
--------------------
do
	local neverFilter = {
	}
	function DBM:PLAY_MOVIE(id)
		if id and not neverFilter[id] then
			self:Debug("PLAY_MOVIE fired for ID: "..id, 2)
			local isInstance = IsInInstance()
			if not isInstance or self.Options.MovieFilter2 == "Never" or self.Options.MovieFilter2 == "OnlyFight" and not DBM:IsEncounterInProgress() then return end
			if self.Options.MovieFilter2 == "Block" or (self.Options.MovieFilter2 == "AfterFirst" or self.Options.MovieFilter2 == "OnlyFight") and self.Options.MoviesSeen[id] then
				MovieFrame:Hide()--can only just hide movie frame safely now, which means can't stop audio anymore :\
				GameMovieFinished()
				self:AddMsg(L.MOVIE_SKIPPED)
			else
				self.Options.MoviesSeen[id] = true
			end
		end
		self:TransitionToDungeonBGM(false, true)
	end

	function DBM:CINEMATIC_START()
		self:Debug("CINEMATIC_START fired", 2)
--		self.HudMap:SupressCanvas()
		local isInstance = IsInInstance()
		if not isInstance or self.Options.MovieFilter2 == "Never" or DBM.Options.MovieFilter2 == "OnlyFight" and not DBM:IsEncounterInProgress() then return end
		local currentMapID = GetCurrentMapAreaID()
		local currentSubZone = GetSubZoneText() or ""
		if not currentMapID then return end--Protection from map failures in zones that have no maps yet
		if self.Options.MovieFilter2 == "Block" or (self.Options.MovieFilter2 == "AfterFirst" or self.Options.MovieFilter2 == "OnlyFight") and self.Options.MoviesSeen[currentMapID..currentSubZone] then
			StopCinematic()
			self:AddMsg(L.MOVIE_SKIPPED)
		else
			self.Options.MoviesSeen[currentMapID..currentSubZone] = true
		end
		self:TransitionToDungeonBGM(false, true)
	end
	function DBM:CINEMATIC_STOP()
		self:Debug("CINEMATIC_STOP fired", 2)
--		self.HudMap:UnSupressCanvas()
	end
end

----------------------------
--  Boss Mod Constructor  --
----------------------------
do
	local modsById = setmetatable({}, {__mode = "v"})
	local mt = {__index = bossModPrototype}

	function DBM:NewMod(name, modId, modSubTab, instanceId)
		name = tostring(name) -- the name should never be a number of something as it confuses sync handlers that just receive some string and try to get the mod from it
		if name == "DBM-ProfilesDummy" then return end
		if modsById[name] then error("DBM:NewMod(): Mod names are used as IDs and must therefore be unique.", 2) end
		local obj = setmetatable(
			{
				Options = {
					Enabled = true,
				},
				DefaultOptions = {
					Enabled = true,
				},
				subTab = modSubTab,
				optionCategories = {
				},
				categorySort = {"announce", "announceother", "announcepersonal", "announcerole", "specialannounce", "timer", "sound", "yell", "nameplate", "icon", "misc"},
				id = name,
				announces = {},
				specwarns = {},
				timers = {},
				vb = {},
				iconRestore = {},
				modId = modId,
				instanceId = instanceId,
				revision = 0,
				SyncThreshold = 8,
				localization = self:GetModLocalization(name),
				groupSpells = {},
				groupOptions = OrderedTable(),
			},
			mt
		)
		for _, v in ipairs(self.AddOns) do
			if v.modId == modId then
				obj.addon = v
				break
			end
		end
		obj.localization.general.name = obj.localization.general.name or name
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
bossModPrototype.UnregisterInCombatEvents = DBM.UnregisterInCombatEvents
bossModPrototype.AddMsg = DBM.AddMsg
bossModPrototype.RegisterShortTermEvents = DBM.RegisterShortTermEvents
bossModPrototype.UnregisterShortTermEvents = DBM.UnregisterShortTermEvents

function bossModPrototype:SetZone(...)
	if select("#", ...) == 0 then
		self.zones = {}
		if self.addon then
			if self.addon.mapId then
				for _, v in ipairs(self.addon.mapId) do
					self.zones[v] = true
				end
			end
			if self.addon.zone and #self.addon.zone > 0 then
				for _, v in ipairs(self.addon.zone) do
					self.zones[v] = true
				end
			end
		end
	elseif select(1, ...) ~= DBM_DISABLE_ZONE_DETECTION then
		self.zones = {}
		for i = 1, select("#", ...) do
			self.zones[select(i, ...)] = true
		end
	else -- disable zone detection
		self.zones = nil
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
	for _, v in ipairs(self.timers) do
		v:Stop()
	end
	self:Unschedule()
end

function bossModPrototype:SetUsedIcons(...)
	self.usedIcons = {}
	for i = 1, select("#", ...) do
		self.usedIcons[select(i, ...)] = true
	end
end

function bossModPrototype:RegisterOnUpdateHandler(func, interval)
	if type(func) ~= "function" then return end
	DBM:Debug("Registering RegisterOnUpdateHandler")
	DBMScheduler:StartScheduler()
	self.elapsed = 0
	self.updateInterval = interval or 0
	private.updateFunctions[self] = func
end

function bossModPrototype:UnregisterOnUpdateHandler()
	self.elapsed = nil
	self.updateInterval = nil
	twipe(private.updateFunctions)
end

function bossModPrototype:SetStage(stage)
	if stage == 0 then--Increment request instead of hard value
		if not self.vb.phase then return end--Person DCed mid fight and somehow managed to perfectly time running SetStage with a value of 0 before getting variable recovery
		self.vb.phase = self.vb.phase + 1
	elseif stage == 0.5 then--Half Increment request instead of hard value
		self.vb.phase = self.vb.phase + 0.5
	else
		self.vb.phase = stage
	end
	--Separate variable to use SetStage totality for very niche weak aura practices
	if not self.vb.stageTotality then
		self.vb.stageTotality = 0
	end
	self.vb.stageTotality = self.vb.stageTotality + 1
	if self.inCombat then--Safety, in event mod manages to run any phase change calls out of combat/during a wipe we'll just safely ignore it
		fireEvent("DBM_SetStage", self, self.id, self.vb.phase, self.vb.stageTotality)--Mod, modId, Stage (if available), total number of times SetStage has been called since combat start
		DBM:Debug("DBM_SetStage: " .. self.vb.phase .. "/" .. self.vb.stageTotality)
	end
end

--If args are passed, returns true or false
--If no args given, just returns current stage and stage total
--stage: stage value to checkf or true/false rules
--checkType: 0 or nil for just current stage match, 1 for less than check, 2 for greater than check, 3 not equal check
--useTotal: uses stage total instead of current
function bossModPrototype:GetStage(stage, checkType, useTotal)
	local currentStage, currentTotal = self.vb.phase or 0, self.vb.stageTotality or 0
	if stage then
		checkType = checkType or 0--Optional pass if just an exact match check
		if (checkType == 0) and (useTotal and currentTotal or currentStage) == stage then
			return true
		elseif (checkType == 1) and (useTotal and currentTotal or currentStage) < stage then
			return true
		elseif (checkType == 2) and (useTotal and currentTotal or currentStage) > stage then
			return true
		elseif (checkType == 3) and (useTotal and currentTotal or currentStage) ~= stage then
			return true
		end
		return false
	else
		return currentStage, currentTotal
	end
end

--------------
--  Events  --
--------------
function bossModPrototype:RegisterEventsInCombat(...)
	if self.inCombatOnlyEvents then
		geterrorhandler()("combat events already set")
	end
	self.inCombatOnlyEvents = {...}
	for k, v in pairs(self.inCombatOnlyEvents) do
		if v:sub(0, 5) == "UNIT_" and v:sub(v:len() - 10) ~= "_UNFILTERED" and not v:find(" ") and v ~= "UNIT_DIED" and v ~= "UNIT_DESTROYED" then
			-- legacy event, oh noes
			self.inCombatOnlyEvents[k] = v--[[ .. " boss1 boss2 boss3 boss4 boss5 target focus"]] -- same as ShortTermEvents - don't preassign units if the event does not state them
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

function bossModPrototype:IsLFR()
	local diff = savedDifficulty or DBM:GetCurrentInstanceDifficulty()
	return diff == "lfr" or diff == "lfr25"
end

--Dungeons: normal, heroic. (Raids excluded)
function bossModPrototype:IsEasyDungeon()
	local diff = savedDifficulty or DBM:GetCurrentInstanceDifficulty()
	return diff == "heroic5" or diff == "normal5"
end

--Dungeons: normal, heroic. Raids: LFR, normal
function bossModPrototype:IsEasy()
	local diff = savedDifficulty or DBM:GetCurrentInstanceDifficulty()
	return diff == "normal" or diff == "heroic5" or diff == "normal5"
end

--Dungeons: mythic, mythic+. Raids: heroic, mythic
function bossModPrototype:IsHard()
	local diff = savedDifficulty or DBM:GetCurrentInstanceDifficulty()
	return diff == "mythic" or diff == "heroic"
end

--Pretty much ANYTHING that has a normal mode
function bossModPrototype:IsNormal()
	local diff = savedDifficulty or DBM:GetCurrentInstanceDifficulty()
	return diff == "normal5" or diff == "normal10" or diff == "normal20" or diff == "normal25" or diff == "normal40"
end

--Pretty much ANYTHING that has a heroic mode
function bossModPrototype:IsHeroic()
	local diff = savedDifficulty or DBM:GetCurrentInstanceDifficulty()
	return diff == "heroic5" or diff == "heroic10" or diff == "heroic25"
end

--Pretty much ANYTHING that has mythic mode
function bossModPrototype:IsMythic()
	local diff = savedDifficulty or DBM:GetCurrentInstanceDifficulty()
	return diff == "mythic"
end

-- Timewalking
function bossModPrototype:IsTimewalking()
	local diff = savedDifficulty or DBM:GetCurrentInstanceDifficulty()
	return diff == "timewalker"
end

function bossModPrototype:IsValidWarning(sourceGUID, customunitID, loose, allowFriendly)
	if loose and InCombatLockdown() and GetNumGroupMembers() < 2 then return true end--In a loose check, this basically just checks if we're in combat, important for solo runs of torghast to not gimp mod too much
	if customunitID then
		if UnitExists(customunitID) and UnitGUID(customunitID) == sourceGUID and UnitAffectingCombat(customunitID) and (allowFriendly or not UnitIsFriend("player", customunitID)) then return true end
	else
		local unitId = DBM:GetUnitIdFromGUID(sourceGUID)
		if unitId and UnitExists(unitId) and UnitAffectingCombat(unitId) and (allowFriendly or not UnitIsFriend("player", unitId)) then
			return true
		end
	end
	return false
end

function bossModPrototype:IsEquipmentSetAvailable(setName)
	setName = setName or 'pve'
	local _, index = GetEquipmentSetInfoByName(setName)
	if index then
		DBM:Debug(setName.. " set found.", 2)
		return true
	end
	DBM:Debug(setName.. " set NOT found.", 2)
	return false
end

function bossModPrototype:LatencyCheck(custom)
	return select(3, GetNetStats()) < (custom or DBM.Options.LatencyThreshold)
end

function bossModPrototype:CheckBigWigs(name)
	if raid[name] and raid[name].bwversion then
		return raid[name].bwversion
	else
		return false
	end
end

bossModPrototype.IconNumToString = DBM.IconNumToString
bossModPrototype.IconNumToTexture = DBM.IconNumToTexture
bossModPrototype.AntiSpam = DBM.AntiSpam
bossModPrototype.HasMapRestrictions = DBM.HasMapRestrictions
bossModPrototype.GetUnitCreatureId = DBM.GetUnitCreatureId
bossModPrototype.GetCIDFromGUID = DBM.GetCIDFromGUID
bossModPrototype.IsCreatureGUID = DBM.IsCreatureGUID
bossModPrototype.GetUnitIdFromCID = DBM.GetUnitIdFromCID
bossModPrototype.GetUnitIdFromGUID = DBM.GetUnitIdFromGUID
bossModPrototype.CheckNearby = DBM.CheckNearby
bossModPrototype.IsTrivial = DBM.IsTrivial

do
	local TargetScanning = private:GetModule("TargetScanning")

	function bossModPrototype:GetBossTarget(...)
		return TargetScanning:GetBossTarget(self, ...)
	end

	function bossModPrototype:GetBossUnitByCreatureId(...)
		return TargetScanning:GetBossUnitByCreatureId(self, ...)
	end

	function bossModPrototype:BossTargetScannerAbort(...)
		return TargetScanning:BossTargetScannerAbort(self, ...)
	end

	function bossModPrototype:BossUnitTargetScannerAbort(...)
		return TargetScanning:BossUnitTargetScannerAbort(self, ...)
	end

	function bossModPrototype:BossUnitTargetScanner(...)
		return TargetScanning:BossUnitTargetScanner(self, ...)
	end

	function bossModPrototype:BossTargetScanner(...)
		return TargetScanning:BossTargetScanner(self, ...)
	end

	function bossModPrototype:StartRepeatedScan(...)
		return TargetScanning:StartRepeatedScan(self, ...)
	end

	function bossModPrototype:StopRepeatedScan(...)
		return TargetScanning:StopRepeatedScan(...)--self/bossModPrototype missing not a bug, function doesn't need it
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

	function bossModPrototype:CheckBossDistance(cidOrGuid, onlyBoss, itemId, distance, defaultReturn)
		if not DBM.Options.DontShowFarWarnings then return true end--Global disable.
		cidOrGuid = cidOrGuid or self.creatureId
		local uId
		if type(cidOrGuid) == "number" then--CID passed
			uId = DBM:GetUnitIdFromCID(cidOrGuid, onlyBoss)
		else--GUID
			uId = DBM:GetUnitIdFromGUID(cidOrGuid, onlyBoss)
		end
		if uId then
			itemId = itemId or 32698
			local inRange = IsItemInRange(itemId, uId)
			if inRange then--IsItemInRange was a success
				return inRange
			else--IsItemInRange doesn't work on all bosses/npcs, but tank checks do
				DBM:Debug("CheckBossDistance failed on IsItemInRange for: "..cidOrGuid, 2)
				return self:CheckTankDistance(cidOrGuid, distance, onlyBoss, defaultReturn)--Return tank distance check fallback
			end
		end
		DBM:Debug("CheckBossDistance failed on uId for: "..cidOrGuid, 2)
		return (defaultReturn == nil) or defaultReturn--When we simply can't figure anything out, return true and allow warnings using this filter to fire
	end

	function bossModPrototype:CheckTankDistance(cidOrGuid, distance, onlyBoss, defaultReturn)
		if not DBM.Options.DontShowFarWarnings then return true end--Global disable.
		distance = distance or 43
		if rangeCache[cidOrGuid] and (GetTime() - (rangeUpdated[cidOrGuid] or 0)) < 2 then -- return same range within 2 sec call
			return rangeCache[cidOrGuid] < distance
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
						return inRange2
					else--Its probably a totem or just something we can't assess. Fall back to no filtering
						return true
					end
				end
				local inRange = DBM.RangeCheck:GetDistance("player", uId)--We check how far we are from the tank who has that boss
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

---------------------
--  Class Methods  --
---------------------
do
	--[[function bossModPrototype:GetRoleFlagValue(flag)
		if not flag then return false end
		local flags = {strsplit("|", flag)}
		for i = 1, #flags do
			local flagText = flags[i]
			flagText = flagText:gsub("-", "")
			if not specFlags[flagText] then
				print("bad flag found : "..flagText)
			end
		end
		self:GetRoleFlagValue2(flag)
	end]]

	--to check flag is correct, remove comment block specFlags table and GetRoleFlagValue function, change this to GetRoleFlagValue2
	--disable flag check normally because double flag check comsumes more cpu on mod load.
	function bossModPrototype:GetRoleFlagValue(flag)
		if not flag then return false end
		if not currentSpecID then
			DBM:SetCurrentSpecInfo()
		end
		local flags = {strsplit("|", flag)}
		for i = 1, #flags do
			local flagText = flags[i]
			if flagText:match("^-") then
				flagText = flagText:gsub("-", "")
				if not private.specRoleTable[currentSpecID][flagText] then
					return true
				end
			elseif private.specRoleTable[currentSpecID][flagText] then
				return true
			end
		end
		return false
	end

	function bossModPrototype:IsMeleeDps(uId)
		if uId then--This version includes ONLY melee dps
			local name = GetUnitName(uId, true)
			--First we check if we have acccess to specID (ie remote player is using DBM or Bigwigs)
			if raid[name].specID then--We know their specId
				local specID = raid[name].specID
				return private.specRoleTable[specID]["MeleeDps"]
			else
				--Role checks are second best thing
				local isTank, isHealer = UnitGroupRolesAssigned(uId)
				if (isHealer or isTank) or GetPartyAssignment("MAINTANK", uId, 1) then--Auto filter healer/tank from dps check, can't filter healers in classic
					return false
				end
				--Class checks for things that are a sure thing anyways
				local _, class = UnitClass(uId)
				if class == "WARRIOR" or class == "ROGUE" or class == "DEATHKNIGHT" then
					return true
				end
				--Now we do the ugly checks thanks to Inspect throttle
				if class == "DRUID" or class == "SHAMAN" or class == "PALADIN" then
					local unitMaxPower = UnitPowerMax(uId)
					if unitMaxPower < 7500 then
						return true
					end
				end
			end
			return false
		end
		--Personal check Only
		if not currentSpecID then
			DBM:SetCurrentSpecInfo()
		end
		return private.specRoleTable[currentSpecID]["MeleeDps"]
	end

	function DBM:IsMelee(uId, mechanical)--mechanical arg means the check is asking if boss mechanics consider them melee (even if they aren't, such as holy paladin/mistweaver monks)
		if uId then--This version includes monk healers as melee and tanks as melee
			--Class checks performed first due to mechanical check needing to be broader than a specID check
			local _, class = UnitClass(uId)
			--In mechanical check, ALL paladins are melee so don't need anything fancy, as for rest of classes here, same deal
			if class == "WARRIOR" or class == "ROGUE" or class == "DEATHKNIGHT" or (mechanical and class == "PALADIN") then
				return true
			end
			--Now we check if we have acccess to specID (ie remote player is using DBM or Bigwigs)
			local name = GetUnitName(uId, true)
			if raid[name].specID then--We know their specId
				local specID = raid[name].specID
				return private.specRoleTable[specID]["Melee"]
			else
				--Now we do the ugly checks thanks to Inspect throttle
				if (class == "DRUID" or class == "SHAMAN" or class == "PALADIN") then
					local unitMaxPower = UnitPowerMax(uId)
					if unitMaxPower < 7500 then
						return true
					end
				end
			end
			return false
		end
		--Personal check Only
		if not currentSpecID then
			DBM:SetCurrentSpecInfo()
		end
		return private.specRoleTable[currentSpecID]["Melee"]
	end
	bossModPrototype.IsMelee = DBM.IsMelee

	function DBM:IsRanged(uId)
		if uId then
			local name = GetUnitName(uId, true)
			if raid[name].specID then--We know their specId
				local specID = raid[name].specID
				return private.specRoleTable[specID]["Ranged"]
			else
				print("bossModPrototype:IsRanged should not be called on external units if specID is unavailable, report this message")
			end
		end
		--Personal check Only
		if not currentSpecID then
			DBM:SetCurrentSpecInfo()
		end
		return private.specRoleTable[currentSpecID]["Ranged"]
	end
	bossModPrototype.IsRanged = DBM.IsRanged

	function bossModPrototype:IsSpellCaster(uId)
		if uId then
			local name = GetUnitName(uId, true)
			if raid[name].specID then--We know their specId
				local specID = raid[name].specID
				return private.specRoleTable[specID]["SpellCaster"]
			else
				print("bossModPrototype:IsSpellCaster should not be called on external units if specID is unavailable, report this message")
			end
		end
		--Personal check Only
		if not currentSpecID then
			DBM:SetCurrentSpecInfo()
		end
		return private.specRoleTable[currentSpecID]["SpellCaster"]
	end

	function bossModPrototype:IsMagicDispeller(uId)
		if uId then
			local name = GetUnitName(uId, true)
			if raid[name].specID then--We know their specId
				local specID = raid[name].specID
				return private.specRoleTable[specID]["MagicDispeller"]
			else
				print("bossModPrototype:IsMagicDispeller should not be called on external units if specID is unavailable, report this message")
			end
		end
		--Personal check Only
		if not currentSpecID then
			DBM:SetCurrentSpecInfo()
		end
		return private.specRoleTable[currentSpecID]["MagicDispeller"]
	end

	---------------------
	--  Sort Methods  --
	---------------------
	function DBM.SortByGroup(v1, v2)
		return DBM:GetGroupId(DBM:GetUnitFullName(v1), true) < DBM:GetGroupId(DBM:GetUnitFullName(v2), true)
	end
	function DBM.SortByTankAlpha(v1, v2)
		--Tank > Melee > Ranged prio, and if two of any of types, alphabetical names are preferred
		if DBM:IsTanking(v1) == DBM:IsTanking(v2) then
			return DBM:GetUnitFullName(v1) < DBM:GetUnitFullName(v2)
		--if one is tank and one isn't, they are not equal so it goes to the below elseifs that prio melee
		elseif DBM:IsTanking(v1) and not DBM:IsTanking(v2) then
			return true
		elseif DBM:IsTanking(v2) and not DBM:IsTanking(v1) then
			return false
		elseif DBM:IsMelee(v1) == DBM:IsMelee(v2) then
			return DBM:GetUnitFullName(v1) < DBM:GetUnitFullName(v2)
		--if one is melee and one is ranged, they are not equal so it goes to the below elseifs that prio melee
		elseif DBM:IsMelee(v1) and not DBM:IsMelee(v2) then
			return true
		elseif DBM:IsMelee(v2) and not DBM:IsMelee(v1) then
			return false
		end
	end
	function DBM.SortByTankRoster(v1, v2)
		--Tank > Melee > Ranged prio, and if two of any of types, roster index as secondary
		if DBM:IsTanking(v1) == DBM:IsTanking(v2) then
			return DBM:GetGroupId(DBM:GetUnitFullName(v1), true) < DBM:GetGroupId(DBM:GetUnitFullName(v2), true)
		--if one is melee and one is ranged, they are not equal so it goes to the below elseifs that prio melee
		elseif DBM:IsTanking(v1) and not DBM:IsTanking(v2) then
			return true
		elseif DBM:IsTanking(v2) and not DBM:IsTanking(v1) then
			return false
		elseif DBM:IsMelee(v1) == DBM:IsMelee(v2) then
			return DBM:GetGroupId(DBM:GetUnitFullName(v1), true) < DBM:GetGroupId(DBM:GetUnitFullName(v2), true)
		--if one is melee and one is ranged, they are not equal so it goes to the below elseifs that prio melee
		elseif DBM:IsMelee(v1) and not DBM:IsMelee(v2) then
			return true
		elseif DBM:IsMelee(v2) and not DBM:IsMelee(v1) then
			return false
		end
	end
	function DBM.SortByMeleeAlpha(v1, v2)
		--if both are melee, the return values are equal and we use alpha sort
		--if both are ranged, the return values are equal and we use alpha sort
		if DBM:IsMelee(v1) == DBM:IsMelee(v2) then
			return DBM:GetUnitFullName(v1) < DBM:GetUnitFullName(v2)
		--if one is melee and one is ranged, they are not equal so it goes to the below elseifs that prio melee
		elseif DBM:IsMelee(v1) and not DBM:IsMelee(v2) then
			return true
		elseif DBM:IsMelee(v2) and not DBM:IsMelee(v1) then
			return false
		end
	end
	function DBM.SortByMeleeRoster(v1, v2)
		--if both are melee, the return values are equal and we use raid roster index sort
		--if both are ranged, the return values are equal and we use raid roster index sort
		if DBM:IsMelee(v1) == DBM:IsMelee(v2) then
			return DBM:GetGroupId(DBM:GetUnitFullName(v1), true) < DBM:GetGroupId(DBM:GetUnitFullName(v2), true)
		--if one is melee and one is ranged, they are not equal so it goes to the below elseifs that prio melee
		elseif DBM:IsMelee(v1) and not DBM:IsMelee(v2) then
			return true
		elseif DBM:IsMelee(v2) and not DBM:IsMelee(v1) then
			return false
		end
	end
	function DBM.SortByRangedAlpha(v1, v2)
		--if both are melee, the return values are equal and we use alpha sort
		--if both are ranged, the return values are equal and we use alpha sort
		if DBM:IsRanged(v1) == DBM:IsRanged(v2) then
			return DBM:GetUnitFullName(v1) < DBM:GetUnitFullName(v2)
		--if one is melee and one is ranged, they are not equal so it goes to the below elseifs that prio melee
		elseif DBM:IsRanged(v1) and not DBM:IsRanged(v2) then
			return true
		elseif DBM:IsRanged(v2) and not DBM:IsRanged(v1) then
			return false
		end
	end
	function DBM.SortByRangedRoster(v1, v2)
		--if both are melee, the return values are equal and we use raid roster index sort
		--if both are ranged, the return values are equal and we use raid roster index sort
		if DBM:IsRanged(v1) == DBM:IsRanged(v2) then
			return DBM:GetGroupId(DBM:GetUnitFullName(v1), true) < DBM:GetGroupId(DBM:GetUnitFullName(v2), true)
		--if one is melee and one is ranged, they are not equal so it goes to the below elseifs that prio melee
		elseif DBM:IsRanged(v1) and not DBM:IsRanged(v2) then
			return true
		elseif DBM:IsRanged(v2) and not DBM:IsRanged(v1) then
			return false
		end
	end
end

function bossModPrototype:UnitClass(uId)
	if uId then--Return unit requested
		local _, class = UnitClass(uId)
		return class
	end
	return playerClass--else return "player"
end

function bossModPrototype:IsTank()
	--IsTanking already handles external calls, no need here.
	if not currentSpecID then
		DBM:SetCurrentSpecInfo()
	end
	return private.specRoleTable[currentSpecID]["Tank"]
end

function bossModPrototype:IsDps(uId)
	if uId then--External unit call.
		--no SpecID checks because SpecID is only availalbe with DBM/Bigwigs, but both DBM/Bigwigs auto set DAMAGER/HEALER/TANK roles anyways so it'd be redundant
		if IsPartyLFG() then -- On WotLK, Role API only works on LFG
			local _, _, isDamager = UnitGroupRolesAssigned(uId)
			return isDamager -- or not GetPartyAssignment("MAINTANK", uId, 1) -- Using this GetPartyAssignment API here makes no sense, since it being a non MAINTANK could be a healer...
		else
			return DBM:GetUnitRole(uId) == "DAMAGER"
		end
	end
	if not currentSpecID then
		DBM:SetCurrentSpecInfo()
	end
	return private.specRoleTable[currentSpecID]["Dps"]
end

function DBM:IsHealer(uId)
	if uId then--External unit call.
		--no SpecID checks because SpecID is only availalbe with DBM/Bigwigs, but both DBM/Bigwigs auto set DAMAGER/HEALER/TANK roles anyways so it'd be redundant
		if IsPartyLFG() then -- On WotLK, Role API only works on LFG
			local _, isHealer = UnitGroupRolesAssigned(uId)
			return isHealer
		else
			return DBM:GetUnitRole(uId) == "HEALER"
		end
	end
	if not currentSpecID then
		DBM:SetCurrentSpecInfo()
	end
	return private.specRoleTable[currentSpecID]["Healer"]
end
bossModPrototype.IsHealer = DBM.IsHealer

function DBM:IsTanking(playerUnitID, enemyUnitID, isName, onlyRequested, enemyGUID, includeTarget, onlyS3)
	--Didn't have playerUnitID so combat log name was passed
	if isName then
		playerUnitID = DBM:GetRaidUnitId(playerUnitID)
	end
	if not playerUnitID then
		DBM:Debug("IsTanking passed with invalid unit", 2)
		return false
	end
	--If we don't know enemy unit token, but know it's GUID
	if not enemyUnitID and enemyGUID then
		enemyUnitID = DBM:GetUnitIdFromGUID(enemyGUID)
	end

	DBM:Debug(("IsTanking run with playerUnitID: %s (%s) and enemyUnitID: %s (%s). DBM arguments - onlyRequested: %s ; enemyGUID: %s ; includeTarget: %s ; onlyS3: %s"):format(playerUnitID or "nil", playerUnitID and UnitName(playerUnitID) or "nil", enemyUnitID or "nil", enemyUnitID and UnitName(enemyUnitID) or "nil", tostring(onlyRequested) or "nil", enemyGUID or "nil", tostring(includeTarget) or "nil", tostring(onlyS3) or "nil"), 3)
	--Threat/Tanking Checks
	--We have both units. No need to find unitID
	if enemyUnitID then
		--Check threat first
		local tanking, status, scaledPercent, rawPercent, threatValue = UnitDetailedThreatSituation(playerUnitID, enemyUnitID)
		DBM:Debug(("Threat API arguments - tanking: %s ; status: %s ; scaledPercent: %s ; rawPercent: %s ; threatValue: %s"):format(tostring(tanking) or "nil", tostring(status) or "nil", tostring(scaledPercent) or "nil", tostring(rawPercent) or "nil", tostring(threatValue) or "nil"), 3)
		if (not onlyS3 and tanking) or (status == 3) then
			return true
		end
		--Non threat fallback
		if includeTarget and UnitExists(enemyUnitID.."target") then
			if UnitIsUnit(playerUnitID, enemyUnitID.."target") then
				DBM:Debug("IsTanking found tank, using enemyUnitID target", 3)
				return true
			end
		end
	end
	--if onlyRequested is false/nil, it means we also accept anyone that's a tank role or tanking any boss unit
	if not onlyRequested then
		--Use these as fallback if threat target not found
		if GetPartyAssignment("MAINTANK", playerUnitID, 1) then
			DBM:Debug("IsTanking found MAINTANK, using GetPartyAssignment", 3)
			return true
		end
		--no SpecID checks because SpecID is only availalbe with DBM/Bigwigs, but both DBM/Bigwigs auto set DAMAGER/HEALER/TANK roles anyways so it'd be redundant
		if IsPartyLFG() then -- On WotLK, Role API only works on LFG
			local isTank = UnitGroupRolesAssigned(playerUnitID)
			if isTank then
				DBM:Debug("IsTanking found TANK role, using UnitGroupRolesAssigned", 3)
				return true
			end
		else
			if DBM:GetUnitRole(playerUnitID) == "TANK" then
				DBM:Debug("IsTanking found TANK role, using DBM:GetUnitRole", 3)
				return true
			end
		end
		for i = 1, 5 do
			local unitID = "boss"..i
			local guid = UnitGUID(unitID)
			--No GUID, any unit having threat returns true, GUID, only specific unit matching guid
			if not enemyGUID or (guid and guid == enemyGUID) then
				--Check threat first
				local tanking, status = UnitDetailedThreatSituation(playerUnitID, unitID)
				if (not onlyS3 and tanking) or (status == 3) then
					DBM:Debug("IsTanking found TANK, using Threat API on boss units", 3)
					return true
				end
				--Non threat fallback
				if includeTarget and UnitExists(unitID.."target") then
					if UnitIsUnit(playerUnitID, unitID.."target") then
						DBM:Debug("IsTanking found TANK, using bosstarget fallback", 3)
						return true
					end
				end
			end
		end
	end
	DBM:Debug("IsTanking return false", 3)
	return false
end
bossModPrototype.IsTanking = DBM.IsTanking

function bossModPrototype:GetNumAliveTanks()
	if not IsInGroup() then return 1 end--Solo raid, you're the "tank"
	local count = 0
	local uId = (IsInRaid() and "raid") or "party"
	for i = 1, DBM:GetNumRealGroupMembers() do
		local isTank = UnitGroupRolesAssigned(uId..i)
		if (isTank or GetPartyAssignment("MAINTANK", uId..i, 1)) and not UnitIsDeadOrGhost(uId..i) then
			count = count + 1
		end
	end
	return count
end

-----------------------
--  Filter Methods  --
-----------------------

do
	local interruptSpells = {
		[1766] = true,--Rogue Kick
		[2139] = true,--Mage Counterspell
		[6552] = true,--Warrior Pummel
		[15487] = true,--Priest Silence
		[19647] = true,--Warlock pet Spell Lock
		[47528] = true,--Death Knight Mind Freeze
		[49377] = true,--Druid Feral Charge
		[57994] = true,--Shaman Wind Shear
	}
	--onlyTandF param is used when CheckInterruptFilter is actually being used for a simple target/focus check and nothing more.
	--checkCooldown should always be passed true except for special rotations like count warnings when you should be alerted it's your turn even if you dropped ball and put it on CD at wrong time
	--ignoreTandF is passed usually when interrupt is on a main boss or event that is global to entire raid and should always be alerted regardless of targetting.
	function bossModPrototype:CheckInterruptFilter(sourceGUID, checkOnlyTandF, checkCooldown, ignoreTandF)
		--Check healer spec filter
		if self:IsHealer() and (self.isTrashMod and DBM.Options.FilterTInterruptHealer or not self.isTrashMod and DBM.Options.FilterBInterruptHealer) then
			return false
		end

		--Check if cooldown check is required
		if checkCooldown and (self.isTrashMod and DBM.Options.FilterTInterruptCooldown or not self.isTrashMod and DBM.Options.FilterBInterruptCooldown) then
			for spellID, _ in pairs(interruptSpells) do
				--For an inverse check, don't need to check if it's known, if it's on cooldown it's known
				--This is possible since no class has 2 interrupt spells (well, actual interrupt spells)
				if (GetSpellCooldown(spellID)) ~= 0 then--Spell is on cooldown
					return false
				end
			end
		end

		local unitID = (UnitGUID("target") == sourceGUID) and "target" or (UnitGUID("focus") == sourceGUID) and "focus"
		--Check if target/focus is required (or if onlyTandF is used, meaning this isn't actually an interrupt API check)
		if checkOnlyTandF or (self.isTrashMod and DBM.Options.FilterTTargetFocus or not self.isTrashMod and DBM.Options.FilterBTargetFocus) then
			--Just return false if source isn't our target or focus, no need to do further checks
			if not ignoreTandF and not unitID then
				return false
			end
		end

		--Check if it's casting something that's not interruptable at the moment
		--needed for torghast since many mobs can have interrupt immunity with same spellIds as other mobs that can be interrupted
		if unitID then
			if UnitCastingInfo(unitID) then
				local _, _, _, _, _, _, _, _, notInterruptible = UnitCastingInfo(unitID)
				if notInterruptible then return false end
			elseif UnitChannelInfo(unitID) then
				local _, _, _, _, _, _, _, notInterruptible = UnitChannelInfo(unitID)
				if notInterruptible then return false end
			end
		end
		return true
	end
end

do
	--lazyCheck mostly for migration, doesn't distinguish dispel types
	local lazyCheck = {
		[2782] = true,--Druid: Remove Curse (Curse and Poison)
		[2893] = true,--Druid: Abolish Poison (Poison)
		[8946] = true,--Druid: Cure Poison (Poison)
		[527] = true,--Priest: Dispel Magic (Magic and Disease)
		[528] = true,--Priest: Cure Disease (Disease)
		[552] = true,--Priest: Abolish Disease (Disease)
		[32375] = true,--Priest: Mass Dispel (Magic and Disease)
		[1022] = true,--Paladin: Hand of Protection (Bleed)
		[1152] = true,--Paladin: Purify (Poison and Disease)
		[4987] = true,--Paladin: Cleanse (Magic, Poison and Disease)
		[526] = true,--Shaman: Cure Toxins (Poison and Disease)
		[51886] = true,--Shaman: Cleanse Spirit (Curse, Poison and Disease)
		[475] = true,--Mage: Remove Curse (Curse)
	}
	--Obviously only checks spells relevant for the dispel type
	local typeCheck = {
		["magic"] = {
			[527] = true,--Priest: Dispel Magic (Magic and Disease)
			[32375] = true,--Priest: Mass Dispel (Magic and Disease)
			[4987] = true,--Paladin: Cleanse (Magic, Poison and Disease)
			[77130] = true,--Shaman: Purify Spirit (Magic and Curse)
		},
		["curse"] = {
			[2782] = true,--Druid: Remove Curse (Curse and Poison)
			[51886] = DBM:IsHealer() and true,--Shaman: Cleanse Spirit (Curse, Poison and Disease)
			[475] = true,--Mage: Remove Curse (Curse)
		},
		["poison"] = {
			[2782] = true,--Druid: Remove Corruption (Curse and Poison)
			[2893] = true,--Druid: Abolish Poison (Poison)
			[8946] = true,--Druid: Cure Poison (Poison)
			[1152] = true,--Paladin: Purify (Poison and Disease)
			[4987] = true,--Paladin: Cleanse (Magic, Poison and Disease)
			[526] = true,--Shaman: Cure Toxins (Poison and Disease)
			[51886] = DBM:IsHealer() and true,--Shaman: Cleanse Spirit (Curse, Poison and Disease)
		},
		["disease"] = {
			[527] = true,--Priest: Dispel Magic (Magic and Disease)
			[528] = true,--Priest: Cure Disease (Disease)
			[552] = true,--Priest: Abolish Disease (Disease)
			[32375] = true,--Priest: Mass Dispel (Magic and Disease)
			[1152] = true,--Paladin: Purify (Poison and Disease)
			[4987] = true,--Paladin: Cleanse (Magic, Poison and Disease)
			[526] = true,--Shaman: Cure Toxins (Poison and Disease)
			[51886] = DBM:IsHealer() and true,--Shaman: Cleanse Spirit (Curse, Poison and Disease)
		},
		["bleed"] = {
			[1022] = true,--Paladin: Hand of Protection (Bleed)
		},
	}
	local lastCheck, lastReturn = 0, true
	function bossModPrototype:CheckDispelFilter(dispelType)
		if not DBM.Options.FilterDispel then return true end
		-- WotLK: Druid: Abolish Poison (2893), Cure Poison (8946), Remove Curse (2782); Priest: Dispel Magic (527), Abolish Disease (552), Cure Disease (528), Mass Dispel (32375); Paladin: Cleanse (4987), Purify (1152); Shaman: Cleanse Spirit (51886), Cure Toxins (526); Mage: Remove Curse (475), Warlock (pet Felhunter): Devour Magic (48011)
		--start, duration, enable = GetSpellCooldown
		--start & duration == 0 if spell not on cd
		if UnitIsDeadOrGhost("player") then return false end--if dead, can't dispel
		if GetTime() - lastCheck < 0.1 then--Recently returned status, return same status to save cpu from aggressive api checks caused by CheckDispelFilter running on multiple raid members getting debuffed at once
			return lastReturn
		end
		if dispelType then
			--Devour Magic requires checking if Felhunter pet is out (Warlock only)
			--Only checking 48011 (rank 7) for convenience, since API returns 0 for every other rank below it (possibly an unwanted behaviour with API and pet)
			if dispelType == "magic" and (GetSpellCooldown(48011)) == 0 and (UnitExists("pet") and self:GetCIDFromGUID(UnitGUID("pet")) == 6) then
				lastCheck = GetTime()
				lastReturn = true
				return true
			end
			--We cannot do inverse check here because some classes actually have two dispels for same type (such as evoker)
			--Therefor, we can't go false if only one of them are on cooldown. We have to go true of any of them aren't on CD instead
			--As such, we have to check if a spell is known in addition to it not being on cooldown
			for spellID, _ in pairs(typeCheck[dispelType]) do
				if typeCheck[dispelType][spellID] and IsSpellKnown(spellID) and (GetSpellCooldown(spellID)) == 0 then--Spell is known and not on cooldown
					lastCheck = GetTime()
					lastReturn = true
					return true
				end
			end
		else--use lazy check until all mods are migrated to define type
			for spellID, _ in pairs(lazyCheck) do
				if IsSpellKnown(spellID) and (GetSpellCooldown(spellID)) == 0 then--Spell is known and not on cooldown
					lastCheck = GetTime()
					lastReturn = true
					return true
				end
			end
		end
		lastCheck = GetTime()
		lastReturn = false
		return false
	end
end

-------------------------
--  Boss Health Frame  --
-------------------------
function bossModPrototype:SetBossHealthInfo(...)
	self.bossHealthInfo = {...}
end

----------------------------
--  Boss Health Function  --
----------------------------
--This accepts both CID and GUID
function DBM:GetBossHP(cIdOrGUID, onlyHighest)
	local uId = bossHealthuIdCache[cIdOrGUID] or "target"
	local guid = UnitGUID(uId)
	--Target or Cached (if already called with this cid or GUID before)
	if (self:GetCIDFromGUID(guid) == cIdOrGUID or guid == cIdOrGUID) and UnitHealthMax(uId) ~= 0 then
		if bossHealth[cIdOrGUID] and (UnitHealth(uId) == 0 and not UnitIsDead(uId)) then return bossHealth[cIdOrGUID], uId, UnitName(uId) end--Return last non 0 value if value is 0, since it's last valid value we had.
		local hp = UnitHealth(uId) / UnitHealthMax(uId) * 100
		if not onlyHighest or onlyHighest and hp > (bossHealth[cIdOrGUID] or 0) then
			bossHealth[cIdOrGUID] = hp
		end
		return hp, uId, UnitName(uId)
	--Focus
	elseif (self:GetCIDFromGUID(UnitGUID("focus")) == cIdOrGUID or UnitGUID("focus") == cIdOrGUID) and UnitHealthMax("focus") ~= 0 then
		if bossHealth[cIdOrGUID] and (UnitHealth("focus") == 0 and not UnitIsDead("focus")) then return bossHealth[cIdOrGUID], "focus", UnitName("focus") end--Return last non 0 value if value is 0, since it's last valid value we had.
		local hp = UnitHealth("focus") / UnitHealthMax("focus") * 100
		if not onlyHighest or onlyHighest and hp > (bossHealth[cIdOrGUID] or 0) then
			bossHealth[cIdOrGUID] = hp
		end
		return hp, "focus", UnitName("focus")
	else
		--Boss UnitIds
		for i = 1, 5 do
			local unitID = "boss"..i
			local bossguid = UnitGUID(unitID)
			if (self:GetCIDFromGUID(bossguid) == cIdOrGUID or bossguid == cIdOrGUID) and UnitHealthMax(unitID) ~= 0 then
				if bossHealth[cIdOrGUID] and (UnitHealth(unitID) == 0 and not UnitIsDead(unitID)) then return bossHealth[cIdOrGUID], unitID, UnitName(unitID) end--Return last non 0 value if value is 0, since it's last valid value we had.
				local hp = UnitHealth(unitID) / UnitHealthMax(unitID) * 100
				if not onlyHighest or onlyHighest and hp > (bossHealth[cIdOrGUID] or 0) then
					bossHealth[cIdOrGUID] = hp
				end
				bossHealthuIdCache[cIdOrGUID] = unitID
				return hp, unitID, UnitName(unitID)
			end
		end
		--Scan raid/party target frames
		local idType = (IsInRaid() and "raid") or "party"
		for i = 0, GetNumGroupMembers() do
			local unitId = ((i == 0) and "target") or idType..i.."target"
			local bossguid = UnitGUID(unitId)
			if (self:GetCIDFromGUID(bossguid) == cIdOrGUID or bossguid == cIdOrGUID) and UnitHealthMax(unitId) ~= 0 then
				if bossHealth[cIdOrGUID] and (UnitHealth(unitId) == 0 and not UnitIsDead(unitId)) then return bossHealth[cIdOrGUID], unitId, UnitName(unitId) end--Return last non 0 value if value is 0, since it's last valid value we had.
				local hp = UnitHealth(unitId) / UnitHealthMax(unitId) * 100
				if not onlyHighest or onlyHighest and hp > (bossHealth[cIdOrGUID] or 0) then
					bossHealth[cIdOrGUID] = hp
				end
				bossHealthuIdCache[cIdOrGUID] = unitId
				return hp, unitId, UnitName(unitId)
			end
		end
	end
end

function DBM:GetBossHPByGUID(guid)
	local uId = bossHealthuIdCache[guid] or "target"
	if UnitGUID(uId) == guid and UnitHealthMax(uId) ~= 0 then
		if bossHealth[guid] and (UnitHealth(uId) == 0 and not UnitIsDead(uId)) then return bossHealth[guid], uId, UnitName(uId) end--Return last non 0 value if value is 0, since it's last valid value we had.
		local hp = UnitHealth(uId) / UnitHealthMax(uId) * 100
		bossHealth[guid] = hp
		return hp, uId, UnitName(uId)
	elseif UnitGUID("focus") == guid and UnitHealthMax("focus") ~= 0 then
		if bossHealth[guid] and (UnitHealth("focus") == 0  and not UnitIsDead("focus")) then return bossHealth[guid], "focus", UnitName("focus") end--Return last non 0 value if value is 0, since it's last valid value we had.
		local hp = UnitHealth("focus") / UnitHealthMax("focus") * 100
		bossHealth[guid] = hp
		return hp, "focus", UnitName("focus")
	else
		for i = 1, 5 do
			local guid2 = UnitGUID("boss"..i)
			if guid == guid2 and UnitHealthMax("boss"..i) ~= 0 then
				if bossHealth[guid] and (UnitHealth("boss"..i) == 0 and not UnitIsDead("boss"..i)) then return bossHealth[guid], "boss"..i, UnitName("boss"..i) end--Return last non 0 value if value is 0, since it's last valid value we had.
				local hp = UnitHealth("boss"..i) / UnitHealthMax("boss"..i) * 100
				bossHealth[guid] = hp
				bossHealthuIdCache[guid] = "boss"..i
				return hp, "boss"..i, UnitName("boss"..i)
			end
		end
		local idType = (GetNumRaidMembers() > 0 and "raid") or "party"
		for i = 0, GetNumGroupMembers() do
			local unitId = ((i == 0) and "target") or idType..i.."target"
			local guid2 = UnitGUID(unitId)
			if guid == guid2 and UnitHealthMax(unitId) ~= 0 then
				if bossHealth[guid] and (UnitHealth(unitId) == 0 and not UnitIsDead(unitId)) then return bossHealth[guid], unitId, UnitName(unitId) end--Return last non 0 value if value is 0, since it's last valid value we had.
				local hp = UnitHealth(unitId) / UnitHealthMax(unitId) * 100
				bossHealth[guid] = hp
				bossHealthuIdCache[guid] = unitId
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
bossModPrototype.GetBossHPByGUID = DBM.GetBossHPByGUID
bossModPrototype.GetBossHPByUnitID = DBM.GetBossHPByUnitID


-------------------------
--  Timers Table Util  --
-------------------------
function bossModPrototype:GetFromTimersTable(table, difficultyName, phase, spellId, count)
	local prev = table

	if difficultyName ~= false then
		if not difficultyName or not prev[difficultyName] then
			DBM:Debug("difficultyName is missing from table")
			return
		end
		prev = prev[difficultyName]
	end

	if phase ~= false then
		if not phase or not prev[phase] then
			DBM:Debug("phase is missing from table")
			return
		end
		prev = prev[phase]
	end

	if not prev[spellId] then
		DBM:Debug("spellId is missing from table")
		return
	end
	prev = prev[spellId]

	if count then
		prev = prev[count]
	end

	return prev
end

-----------------------
--  Announce Object  --
-----------------------
do
	local frame = CreateFrame("Frame", "DBMWarning", UIParent)
	local font1u = CreateFrame("Frame", "DBMWarning1Updater", UIParent)
	local font2u = CreateFrame("Frame", "DBMWarning2Updater", UIParent)
	local font3u = CreateFrame("Frame", "DBMWarning3Updater", UIParent)
	local font1 = frame:CreateFontString("DBMWarning1", "OVERLAY", "GameFontNormal")
	font1:SetWidth(0) -- Don't hardcode, it WILL cause client crashes if a string with icons and certain fonts reach a certain FontHeight on the OnUpdate grow
	font1:SetHeight(0)
	font1:SetPoint("TOP", 0, 0)
	local font2 = frame:CreateFontString("DBMWarning2", "OVERLAY", "GameFontNormal")
	font2:SetWidth(0) -- Don't hardcode, it WILL cause client crashes if a string with icons and certain fonts reach a certain FontHeight on the OnUpdate grow
	font2:SetHeight(0)
	font2:SetPoint("TOP", font1, "BOTTOM", 0, 0)
	local font3 = frame:CreateFontString("DBMWarning3", "OVERLAY", "GameFontNormal")
	font3:SetWidth(0) -- Don't hardcode, it WILL cause client crashes if a string with icons and certain fonts reach a certain FontHeight on the OnUpdate grow
	font3:SetHeight(0)
	font3:SetPoint("TOP", font2, "BOTTOM", 0, 0)
	frame:SetMovable(1)
	frame:SetWidth(1)
	frame:SetHeight(1)
	frame:SetFrameStrata("HIGH")
	frame:SetClampedToScreen()
	frame:SetPoint("CENTER", UIParent, "CENTER", 0, 300)
	font1u:Hide()
	font2u:Hide()
	font3u:Hide()

	local font1elapsed, font2elapsed, font3elapsed

	local function fontHide1()
		local duration = DBM.Options.WarningDuration2
		if font1elapsed > duration * 1.3 then
			font1u:Hide()
			font1:Hide()
			if frame.font1ticker then
				AceTimer:CancelTimer(frame.font1ticker)
				frame.font1ticker = nil
			end
		elseif font1elapsed > duration then
			font1elapsed = font1elapsed + 0.05
			local alpha = 1 - (font1elapsed - duration) / (duration * 0.3)
			font1:SetAlpha(alpha > 0 and alpha or 0)
		else
			font1elapsed = font1elapsed + 0.05
			font1:SetAlpha(1)
		end
	end

	local function fontHide2()
		local duration = DBM.Options.WarningDuration2
		if font2elapsed > duration * 1.3 then
			font2u:Hide()
			font2:Hide()
			if frame.font2ticker then
				AceTimer:CancelTimer(frame.font2ticker)
				frame.font2ticker = nil
			end
		elseif font2elapsed > duration then
			font2elapsed = font2elapsed + 0.05
			local alpha = 1 - (font2elapsed - duration) / (duration * 0.3)
			font2:SetAlpha(alpha > 0 and alpha or 0)
		else
			font2elapsed = font2elapsed + 0.05
			font2:SetAlpha(1)
		end
	end

	local function fontHide3()
		local duration = DBM.Options.WarningDuration2
		if font3elapsed > duration * 1.3 then
			font3u:Hide()
			font3:Hide()
			if frame.font3ticker then
				AceTimer:CancelTimer(frame.font3ticker)
				frame.font3ticker = nil
			end
		elseif font3elapsed > duration then
			font3elapsed = font3elapsed + 0.05
			local alpha = 1 - (font3elapsed - duration) / (duration * 0.3)
			font3:SetAlpha(alpha > 0 and alpha or 0)
		else
			font3elapsed = font3elapsed + 0.05
			font3:SetAlpha(1)
		end
	end

	font1u:SetScript("OnUpdate", function(self)
		local diff = GetTime() - font1.lastUpdate
		local origSize = DBM.Options.WarningFontSize
		if diff > 0.4 then
			font1:SetTextHeight(origSize)
			self:Hide()
		elseif diff > 0.2 then
			font1:SetTextHeight(origSize * (1.5 - (diff-0.2) * 2.5))
		else
			font1:SetTextHeight(origSize * (1 + diff * 2.5))
		end
	end)

	font2u:SetScript("OnUpdate", function(self)
		local diff = GetTime() - font2.lastUpdate
		local origSize = DBM.Options.WarningFontSize
		if diff > 0.4 then
			font2:SetTextHeight(origSize)
			self:Hide()
		elseif diff > 0.2 then
			font2:SetTextHeight(origSize * (1.5 - (diff-0.2) * 2.5))
		else
			font2:SetTextHeight(origSize * (1 + diff * 2.5))
		end
	end)

	font3u:SetScript("OnUpdate", function(self)
		local diff = GetTime() - font3.lastUpdate
		local origSize = DBM.Options.WarningFontSize
		if diff > 0.4 then
			font3:SetTextHeight(origSize)
			self:Hide()
		elseif diff > 0.2 then
			font3:SetTextHeight(origSize * (1.5 - (diff-0.2) * 2.5))
		else
			font3:SetTextHeight(origSize * (1 + diff * 2.5))
		end
	end)

	function DBM:UpdateWarningOptions()
		frame:ClearAllPoints()
		frame:SetPoint(self.Options.WarningPoint, UIParent, self.Options.WarningPoint, self.Options.WarningX, self.Options.WarningY)
		local font = self.Options.WarningFont == "standardFont" and standardFont or self.Options.WarningFont
		font1:SetFont(font, self.Options.WarningFontSize, self.Options.WarningFontStyle == "None" and nil or self.Options.WarningFontStyle)
		font2:SetFont(font, self.Options.WarningFontSize, self.Options.WarningFontStyle == "None" and nil or self.Options.WarningFontStyle)
		font3:SetFont(font, self.Options.WarningFontSize, self.Options.WarningFontStyle == "None" and nil or self.Options.WarningFontStyle)
		if self.Options.WarningFontShadow then
			font1:SetShadowOffset(1, -1)
			font2:SetShadowOffset(1, -1)
			font3:SetShadowOffset(1, -1)
		else
			font1:SetShadowOffset(0, 0)
			font2:SetShadowOffset(0, 0)
			font3:SetShadowOffset(0, 0)
		end
	end

	function DBM:AddWarning(text, force)
		local added = false
		if not frame.font1ticker then
			font1elapsed = 0
			font1.lastUpdate = GetTime()
			font1:SetText(text)
			font1:Show()
			font1u:Show()
			added = true
			frame.font1ticker = frame.font1ticker or AceTimer:ScheduleRepeatingTimer(fontHide1, 0.05)
		elseif not frame.font2ticker then
			font2elapsed = 0
			font2.lastUpdate = GetTime()
			font2:SetText(text)
			font2:Show()
			font2u:Show()
			added = true
			frame.font2ticker = frame.font2ticker or AceTimer:ScheduleRepeatingTimer(fontHide2, 0.05)
		elseif not frame.font3ticker or force then
			font3elapsed = 0
			font3.lastUpdate = GetTime()
			font3:SetText(text)
			font3:Show()
			font3u:Show()
			fontHide3()
			added = true
			frame.font3ticker = frame.font3ticker or AceTimer:ScheduleRepeatingTimer(fontHide3, 0.05)
		end
		if not added then
			local prevText1 = font2:GetText()
			local prevText2 = font3:GetText()
			font1:SetText(prevText1)
			font1elapsed = font2elapsed
			font2:SetText(prevText2)
			font2elapsed = font3elapsed
			self:AddWarning(text, true)
		end
	end

	do
		local anchorFrame
		local function moveEnd(self)
			anchorFrame:Hide()
			if anchorFrame.ticker then
				AceTimer:CancelTimer(anchorFrame.ticker)
				anchorFrame.ticker = nil
			end
			font1elapsed = self.Options.WarningDuration2
			font2elapsed = self.Options.WarningDuration2
			font3elapsed = self.Options.WarningDuration2
			frame:SetFrameStrata("HIGH")
			self:Unschedule(moveEnd)
			DBT:CancelBar(L.MOVE_WARNING_BAR)
		end

		function DBM:MoveWarning()
			if not anchorFrame then
				anchorFrame = CreateFrame("Frame", nil, frame)
				anchorFrame:SetWidth(32)
				anchorFrame:SetHeight(32)
				anchorFrame:EnableMouse(true)
				anchorFrame:SetPoint("TOP", frame, "TOP", 0, 32)
				anchorFrame:RegisterForDrag("LeftButton")
				anchorFrame:SetClampedToScreen()
				anchorFrame:Hide()
				local texture = anchorFrame:CreateTexture()
				texture:SetTexture("Interface\\Addons\\DBM-Core\\textures\\dot.blp")
				texture:SetPoint("CENTER", anchorFrame, "CENTER", 0, 0)
				texture:SetWidth(32)
				texture:SetHeight(32)
				anchorFrame:SetScript("OnDragStart", function()
					frame:StartMoving()
					self:Unschedule(moveEnd)
					DBT:CancelBar(L.MOVE_WARNING_BAR)
				end)
				anchorFrame:SetScript("OnDragStop", function()
					frame:StopMovingOrSizing()
					local point, _, _, xOfs, yOfs = frame:GetPoint(1)
					self.Options.WarningPoint = point
					self.Options.WarningX = xOfs
					self.Options.WarningY = yOfs
					self:Schedule(15, moveEnd, self)
					DBT:CreateBar(15, L.MOVE_WARNING_BAR, "Interface\\Icons\\Spell_Holy_BorrowedTime")
				end)
			end
			if anchorFrame:IsShown() then
				moveEnd(self)
			else
				anchorFrame:Show()
				anchorFrame.ticker = anchorFrame.ticker or AceTimer:ScheduleRepeatingTimer(function() self:AddWarning(L.MOVE_WARNING_MESSAGE) end, 5)
				self:AddWarning(L.MOVE_WARNING_MESSAGE)
				self:Schedule(15, moveEnd, self)
				DBT:CreateBar(15, L.MOVE_WARNING_BAR, "Interface\\Icons\\Spell_Holy_BorrowedTime")
				frame:Show()
				frame:SetFrameStrata("TOOLTIP")
				frame:SetAlpha(1)
			end
		end
	end

	local textureCode = " |T%s:12:12|t "
	local textureExp = " |T(%S+......%S+):12:12|t "--Fix texture file including blank not strips(example: Interface\\Icons\\Spell_Frost_Ring of Frost). But this have limitations. Since I'm poor at regular expressions, this is not good fix. Do you have another good regular expression, tandanu?
	local announcePrototype = {}
	local mt = {__index = announcePrototype}

	-- TODO: is there a good reason that this is a weak table?
	local cachedColorFunctions = setmetatable({}, {__mode = "kv"})

	local function setText(announceType, spellId, castTime, preWarnTime, customName, originalSpellID)
		local spellName
		if customName then
			spellName = customName
		else
			spellName = (spellId or 0) >= 6 and DBM:GetSpellInfo(spellId) or CL.UNKNOWN
		end
		local text
		if announceType == "cast" then
			local spellHaste = select(7, DBM:GetSpellInfo(53142)) / 10000 -- 53142 = Dalaran Portal, should have 10000 ms cast time
			local timer = (select(7, DBM:GetSpellInfo(originalSpellID or spellId)) or 1000) / spellHaste
			text = L.AUTO_ANNOUNCE_TEXTS[announceType]:format(spellName, castTime or (timer / 1000))
		elseif announceType == "prewarn" then
			if type(preWarnTime) == "string" then
				text = L.AUTO_ANNOUNCE_TEXTS[announceType]:format(spellName, preWarnTime)
			else
				text = L.AUTO_ANNOUNCE_TEXTS[announceType]:format(spellName, L.SEC_FMT:format(tostring(preWarnTime or 5)))
			end
		elseif announceType == "stage" or announceType == "prestage" then
			text = L.AUTO_ANNOUNCE_TEXTS[announceType]:format(tostring(spellId))
		elseif announceType == "stagechange" then
			text = L.AUTO_ANNOUNCE_TEXTS.spell
		else
			text = L.AUTO_ANNOUNCE_TEXTS[announceType]:format(spellName)
		end
		return text, spellName
	end

	function announcePrototype:SetText(customName)
		local text, spellName = setText(self.announceType, self.spellId, self.castTime, self.preWarnTime, customName)
		self.text = text
		self.spellName = spellName
	end

	-- TODO: this function is an abomination, it needs to be rewritten. Also: check if these work-arounds are still necessary
	function announcePrototype:Show(...) -- todo: reduce amount of unneeded strings
		if not self.option or self.mod.Options[self.option] then
			if DBM.Options.DontShowBossAnnounces then return end	-- don't show the announces if the spam filter option is set
			if DBM.Options.DontShowTargetAnnouncements and (self.announceType == "target" or self.announceType == "targetdistance" or self.announceType == "targetcount" or self.announceType == "targetcountdistance") and not self.noFilter then return end--don't show announces that are generic target announces
			local argTable = {...}
			local colorCode = ("|cff%.2x%.2x%.2x"):format(self.color.r * 255, self.color.g * 255, self.color.b * 255)
			if #self.combinedtext > 0 then
				--Throttle spam.
				if DBM.Options.WarningAlphabetical then
					tsort(self.combinedtext)
				end
				local combinedText = tconcat(self.combinedtext, "<, >")
				if self.combinedcount == 1 then
					combinedText = combinedText.." "..L.GENERIC_WARNING_OTHERS
				elseif self.combinedcount > 1 then
					combinedText = combinedText.." "..L.GENERIC_WARNING_OTHERS2:format(self.combinedcount)
				end
				--Process
				for i = 1, #argTable do
					if type(argTable[i]) == "string" then
						argTable[i] = combinedText
					end
				end
			end
			local message = pformat(self.text, unpack(argTable))
			local text = ("%s%s%s|r%s"):format(
				(DBM.Options.WarningIconLeft and self.icon and textureCode:format(self.icon)) or "",
				colorCode,
				message,
				(DBM.Options.WarningIconRight and self.icon and textureCode:format(self.icon)) or ""
			)
			self.combinedcount = 0
			self.combinedtext = {}
			if not cachedColorFunctions[self.color] then
				local color = self.color -- upvalue for the function to colorize names, accessing self in the colorize closure is not safe as the color of the announce object might change (it would also prevent the announce from being garbage-collected but announce objects are never destroyed)
				cachedColorFunctions[color] = function(cap)
					cap = cap:sub(2, -2)
					local noStrip = cap:match("noStrip ")
					if not noStrip then
						local name = cap
						local playerClass, playerIcon = DBM:GetRaidClass(name)
						if playerClass ~= "UNKNOWN" then
							cap = DBM:GetShortServerName(cap)--Only run realm strip function if class color was valid (IE it's an actual playername)
						end
						local playerColor = RAID_CLASS_COLORS[playerClass] or color
						if playerColor then
							if playerIcon > 0 and playerIcon <= 8 then
								cap = ("|TInterface\\TargetingFrame\\UI-RaidTargetingIcon_%d:0|t"):format(playerIcon) .. ("|r|cff%.2x%.2x%.2x%s|r|cff%.2x%.2x%.2x"):format(playerColor.r * 255, playerColor.g * 255, playerColor.b * 255, cap, color.r * 255, color.g * 255, color.b * 255)
							else
								cap = ("|r|cff%.2x%.2x%.2x%s|r|cff%.2x%.2x%.2x"):format(playerColor.r * 255, playerColor.g * 255, playerColor.b * 255, cap, color.r * 255, color.g * 255, color.b * 255)
							end
						end
					else
						cap = cap:sub(9)
					end
					return cap
				end
			end
			text = text:gsub(">.-<", cachedColorFunctions[self.color])
			DBM:AddWarning(text)
			if DBM.Options.ShowWarningsInChat then
				if not DBM.Options.WarningIconChat then
					text = text:gsub(textureExp, "") -- textures @ chat frame can (and will) distort the font if using certain combinations of UI scale, resolution and font size TODO: is this still true as of cataclysm?
				end
				if DBM.Options.ShowFakedRaidWarnings then
					for i = 1, select("#", GetFramesRegisteredForEvent("CHAT_MSG_RAID_WARNING")) do
						local frame = select(i, GetFramesRegisteredForEvent("CHAT_MSG_RAID_WARNING"))
						if frame ~= RaidWarningFrame and frame:GetScript("OnEvent") then
							frame:GetScript("OnEvent")(frame, "CHAT_MSG_RAID_WARNING", text, playerName, GetDefaultLanguage("player"), "", playerName, "", 0, 0, "", 0, 99, "")
						end
					end
				else
					self.mod:AddMsg(text, nil)
				end
			end
			--Message: Full message text
			--Icon: Texture path/id for icon
			--Type: Announce type
			----Types: you, target, targetsource, spell, ends, endtarget, fades, adds, count, stack, cast, soon, sooncount, prewarn, bait, stage, stagechange, prestage, moveto
			------Personal/Role (Applies to you, or your job): you, stack, bait, moveto, fades
			------General Target Messages (informative, doesn't usually apply to you): target, targetsource
			------Fight Changes (Stages, adds, boss buff/debuff, etc): stage, stagechange, prestage, adds, ends, endtarget
			------General (can really apply to anything): spell, count, soon, sooncount, prewarn
			--SpellId: Raw spell or encounter journal Id if available.
			--Mod ID: Encounter ID as string, or a generic string for mods that don't have encounter ID (such as trash, dummy/test mods)
			--boolean: Whether or not this warning is a special warning (higher priority).
			fireEvent("DBM_Announce", message, self.icon, self.type, self.spellId, self.mod.id, false)
			if self.sound > 0 then--0 means muted, 1 means no voice pack support, 2 means voice pack version/support
				if self.sound > 1 and DBM.Options.ChosenVoicePack2 ~= "None" and DBM.Options.VPReplacesAnnounce and not voiceSessionDisabled and not DBM.Options.VPDontMuteSounds and self.sound <= SWFilterDisabled then return end
				if not self.option or self.mod.Options[self.option.."SWSound"] ~= "None" then
					DBM:PlaySoundFile(DBM.Options.RaidWarningSound, nil, true)--Validate true
				end
			end
		else
			self.combinedcount = 0
			self.combinedtext = {}
		end
	end

	function announcePrototype:CombinedShow(delay, ...)
		if self.option and not self.mod.Options[self.option] then return end
		if DBM.Options.DontShowBossAnnounces then return end	-- don't show the announces if the spam filter option is set
		if DBM.Options.DontShowTargetAnnouncements and (self.announceType == "target" or self.announceType == "targetdistance" or self.announceType == "targetcount" or self.announceType == "targetcountdistance") and not self.noFilter then return end--don't show announces that are generic target announces
		local argTable = {...}
		for i = 1, #argTable do
			if type(argTable[i]) == "string" then
				if #self.combinedtext < 8 then--Throttle spam. We may not need more than 9 targets..
					if not checkEntry(self.combinedtext, argTable[i]) then
						self.combinedtext[#self.combinedtext + 1] = argTable[i]
					end
				else
					self.combinedcount = self.combinedcount + 1
				end
			end
		end
		DBMScheduler:Unschedule(self.Show, self.mod, self)
		DBMScheduler:Schedule(delay or 0.5, self.Show, self.mod, self, ...)
	end

	function announcePrototype:Schedule(t, ...)
		return DBMScheduler:Schedule(t, self.Show, self.mod, self, ...)
	end

	function announcePrototype:Countdown(time, numAnnounces, ...)
		DBMScheduler:ScheduleCountdown(time, numAnnounces, self.Show, self.mod, self, ...)
	end

	function announcePrototype:Cancel(...)
		return DBMScheduler:Unschedule(self.Show, self.mod, self, ...)
	end

	function announcePrototype:Play(name, customPath)
		local voice = DBM.Options.ChosenVoicePack2
		if voiceSessionDisabled or voice == "None" or not DBM.Options.VPReplacesAnnounce then return end
		local always = DBM.Options.AlwaysPlayVoice
		if DBM.Options.DontShowTargetAnnouncements and (self.announceType == "target" or self.announceType == "targetdistance" or self.announceType == "targetcount" or self.announceType == "targetcountdistance") and not self.noFilter and not always then return end--don't show announces that are generic target announces
		if (not DBM.Options.DontShowBossAnnounces and (not self.option or self.mod.Options[self.option]) or always) and self.sound <= SWFilterDisabled then
			--Filter tank specific voice alerts for non tanks if tank filter enabled
			--But still allow AlwaysPlayVoice to play as well.
			if (name == "changemt" or name == "tauntboss") and DBM.Options.FilterTankSpec and not self.mod:IsTank() and not always then return end
			local path = customPath or "Interface\\AddOns\\DBM-VP"..voice.."\\"..name..".ogg"
			DBM:PlaySoundFile(path)
		end
	end

	function announcePrototype:ScheduleVoice(t, ...)
		if voiceSessionDisabled or DBM.Options.ChosenVoicePack2 == "None" or not DBM.Options.VPReplacesAnnounce then return end
		DBMScheduler:Unschedule(self.Play, self.mod, self)--Allow ScheduleVoice to be used in same way as CombinedShow
		return DBMScheduler:Schedule(t, self.Play, self.mod, self, ...)
	end

	--Object Permits scheduling voice multiple times for same object
	function announcePrototype:ScheduleVoiceOverLap(t, ...)
		if voiceSessionDisabled or DBM.Options.ChosenVoicePack2 == "None" or not DBM.Options.VPReplacesAnnounce then return end
		return DBMScheduler:Schedule(t, self.Play, self.mod, self, ...)
	end

	function announcePrototype:CancelVoice(...)
		if voiceSessionDisabled or DBM.Options.ChosenVoicePack2 == "None" or not DBM.Options.VPReplacesAnnounce then return end
		return DBMScheduler:Unschedule(self.Play, self.mod, self, ...)
	end

	-- old constructor (no auto-localize)
	function bossModPrototype:NewAnnounce(text, color, icon, optionDefault, optionName, soundOption, spellID)
		if not text then
			error("NewAnnounce: you must provide announce text", 2)
			return
		end
		if type(text) == "number" then
			DBM:Debug("|cffff0000NewAnnounce: Non auto localized text cannot be numbers, fix this for |r"..text)
		end
		if type(optionName) == "number" then
			DBM:Debug("|cffff0000NewAnnounce: Non auto localized optionNames cannot be numbers, fix this for |r"..text)
			optionName = nil
		end
		if soundOption and type(soundOption) == "boolean" then
			soundOption = 0--No Sound
		end
		local obj = setmetatable(
			{
				text = self.localization.warnings[text],
				combinedtext = {},
				combinedcount = 0,
				color = DBM.Options.WarningColors[color or 1] or DBM.Options.WarningColors[1],
				sound = soundOption or 1,
				mod = self,
				icon = (type(icon) == "number" and ( icon <=8 and (iconFolder .. icon) or select(3, GetSpellInfo(icon)))) or icon or "Interface\\Icons\\Spell_Nature_WispSplode",
			},
			mt
		)
		if optionName then
			obj.option = optionName
			self:AddBoolOption(obj.option, optionDefault, "announce", nil, nil, nil, spellID)
		elseif optionName ~= false then
			obj.option = text
			self:AddBoolOption(obj.option, optionDefault, "announce", nil, nil, nil, spellID)
		end
		tinsert(self.announces, obj)
		return obj
	end

	-- new constructor (partially auto-localized warnings and options, yay!)
	local function newAnnounce(self, announceType, spellId, color, icon, optionDefault, optionName, castTime, preWarnTime, soundOption, noFilter)
		if not spellId then
			error("newAnnounce: you must provide spellId", 2)
			return
		end
		local optionVersion, alternateSpellId
		if type(optionName) == "number" then
			if optionName > 10 then--Being used as spell name shortening
				if DBM.Options.WarningShortText then
					alternateSpellId = optionName
				end
			else--Being used as option version
				optionVersion = optionName
			end
			optionName = nil
		end
		if soundOption and type(soundOption) == "boolean" then
			soundOption = 0--No Sound
		end
		local text, spellName = setText(announceType, alternateSpellId or spellId, castTime, preWarnTime, nil, spellId)
		icon = icon or spellId
		local obj = setmetatable( -- todo: fix duplicate code
			{
				text = text,
				combinedtext = {},
				combinedcount = 0,
				announceType = announceType,
				color = DBM.Options.WarningColors[color or 1] or DBM.Options.WarningColors[1],
				mod = self,
				icon = (type(icon) == "number" and (icon <=8 and (iconFolder .. icon) or select(3, GetSpellInfo(icon)))) or icon or "Interface\\Icons\\Spell_Nature_WispSplode",
				sound = soundOption or 1,
				type = announceType,
				spellId = spellId,
				spellName = spellName,
				noFilter = noFilter,
				castTime = castTime,
				preWarnTime = preWarnTime,
			},
			mt
		)
		local catType = "announce"--Default to General announce
		if not self.NoSortAnnounce then--ALL announce objects will be assigned "announce", usually for mods that sort by phase instead
			--Change if Personal or Other
			if announceType == "target" or self.announceType == "targetdistance" or announceType == "targetcount" or self.announceType == "targetcountdistance" or announceType == "stack" then
				catType = "announceother"
			end
		end
		if optionName then
			obj.option = optionName
			self:AddBoolOption(obj.option, optionDefault, catType, nil, nil, nil, spellId, announceType)
		elseif optionName ~= false then
			obj.option = catType..spellId..announceType..(optionVersion or "")
			self:AddBoolOption(obj.option, optionDefault, catType, nil, nil, nil, spellId, announceType)
			if noFilter and announceType == "target" then
				self.localization.options[obj.option] = L.AUTO_ANNOUNCE_OPTIONS["targetNF"]:format(spellId)
			else
				self.localization.options[obj.option] = L.AUTO_ANNOUNCE_OPTIONS[announceType]:format(spellId)
			end
		end
		tinsert(self.announces, obj)
		return obj
	end

	function bossModPrototype:NewYouAnnounce(spellId, color, ...)
		return newAnnounce(self, "you", spellId, color or 1, ...)
	end

	function bossModPrototype:NewTargetNoFilterAnnounce(spellId, color, icon, optionDefault, optionName, castTime, preWarnTime, soundOption) -- spellId, color, icon, optionDefault, optionName, castTime, preWarnTime, soundOption, noFilter
		return newAnnounce(self, "target", spellId, color or 3, icon, optionDefault, optionName, castTime, preWarnTime, soundOption, true)
	end

	function bossModPrototype:NewTargetAnnounce(spellId, color, ...)
		return newAnnounce(self, "target", spellId, color or 3, ...)
	end

	function bossModPrototype:NewTargetDistanceAnnounce(spellId, color, ...)
		return newAnnounce(self, "targetdistance", spellId, color or 3, ...)
	end

	function bossModPrototype:NewTargetSourceAnnounce(spellId, color, ...)
		return newAnnounce(self, "targetsource", spellId, color or 3, ...)
	end

	function bossModPrototype:NewTargetCountAnnounce(spellId, color, ...)
		return newAnnounce(self, "targetcount", spellId, color or 3, ...)
	end

	function bossModPrototype:NewTargetCountDistanceAnnounce(spellId, color, ...)
		return newAnnounce(self, "targetcountdistance", spellId, color or 3, ...)
	end

	function bossModPrototype:NewSpellAnnounce(spellId, color, ...)
		return newAnnounce(self, "spell", spellId, color or 2, ...)
	end

	function bossModPrototype:NewIncomingAnnounce(spellId, color, ...)
		return newAnnounce(self, "incoming", spellId, color or 2, ...)
	end

	function bossModPrototype:NewIncomingCountAnnounce(spellId, color, ...)
		return newAnnounce(self, "incomingcount", spellId, color or 2, ...)
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
		return newAnnounce(self, "addsleft", spellId, color or 3, ...)
	end

	function bossModPrototype:NewCountAnnounce(spellId, color, ...)
		return newAnnounce(self, "count", spellId, color or 2, ...)
	end

	function bossModPrototype:NewStackAnnounce(spellId, color, ...)
		return newAnnounce(self, "stack", spellId, color or 2, ...)
	end

	function bossModPrototype:NewCastAnnounce(spellId, color, castTime, icon, optionDefault, optionName, _, soundOption) -- spellId, color, castTime, icon, optionDefault, optionName, noArg, soundOption
		return newAnnounce(self, "cast", spellId, color or 3, icon, optionDefault, optionName, castTime, nil, soundOption)
	end

	function bossModPrototype:NewSoonAnnounce(spellId, color, ...)
		return newAnnounce(self, "soon", spellId, color or 2, ...)
	end

	function bossModPrototype:NewSoonCountAnnounce(spellId, color, ...)
		return newAnnounce(self, "sooncount", spellId, color or 2, ...)
	end

	--This object disables sounds, it's almost always used in combation with a countdown timer. Even if not a countdown, its a text only spam not a sound spam
	function bossModPrototype:NewCountdownAnnounce(spellId, color, icon, optionDefault, optionName, castTime, preWarnTime, _, noFilter) -- spellId, color, icon, optionDefault, optionName, castTime, preWarnTime, soundOption, noFilter
		return newAnnounce(self, "countdown", spellId, color or 4, icon, optionDefault, optionName, castTime, preWarnTime, 0, noFilter)
	end

	function bossModPrototype:NewPreWarnAnnounce(spellId, time, color, icon, optionDefault, optionName, _, soundOption) -- spellId, time, color, icon, optionDefault, optionName, noArg, soundOption
		return newAnnounce(self, "prewarn", spellId, color or 2, icon, optionDefault, optionName, nil, time, soundOption)
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
				mod = self,
			},
			mt
		)
		if optionName then
			obj.option = optionName
			self:AddBoolOption(obj.option, optionDefault, "sound", nil, nil, nil, spellId)
		elseif optionName ~= false then
			obj.option = "Sound"..spellId
			self:AddBoolOption(obj.option, optionDefault, "sound", nil, nil, nil, spellId)
			self.localization.options[obj.option] = L.AUTO_SOUND_OPTION_TEXT:format(spellId)
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
		return DBMScheduler:Schedule(t, self.Play, self.mod, self, ...)
	end

	function soundPrototype:Cancel(...)
		return DBMScheduler:Unschedule(self.Play, self.mod, self, ...)
	end
end

do
	local soundPrototype5 = {}
	local mt = { __index = soundPrototype5 }
	function bossModPrototype:NewSound5(spellId, optionName, optionDefault)
		self.numSounds = self.numSounds and self.numSounds + 1 or 1
		local obj = setmetatable(
			{
				mod = self,
			},
			mt
		)
		if optionName then
			obj.option = optionName
			self:AddBoolOption(obj.option, optionDefault, "sound", nil, nil, nil, spellId)
		elseif optionName ~= false then
			obj.option = "Sound"..spellId.."in5"
			self:AddBoolOption(obj.option, optionDefault, "sound", nil, nil, nil, spellId)
			self.localization.options[obj.option] = L.AUTO_SOUND_OPTION_TEXT5:format(spellId)
		end
		return obj
	end

	function soundPrototype5:Play(file)
		if not self.option or self.mod.Options[self.option] then
			PlaySoundFile(file or "Interface\\AddOns\\DBM-Core\\sounds\\5to1.mp3", "Master")
		end
	end

	function soundPrototype5:Schedule(t, ...)
		return DBMScheduler:Schedule(t, self.Play, self.mod, self, ...)
	end

	function soundPrototype5:Cancel(...)
		return DBMScheduler:Unschedule(self.Play, self.mod, self, ...)
	end
end

do
	local soundPrototype3 = {}
	local mt = { __index = soundPrototype3 }
	function bossModPrototype:NewSound3(spellId, optionName, optionDefault)
		self.numSounds = self.numSounds and self.numSounds + 1 or 1
		local obj = setmetatable(
			{
				mod = self,
			},
			mt
		)
		if optionName then
			obj.option = optionName
			self:AddBoolOption(obj.option, optionDefault, "sound", nil, nil, nil, spellId)
		elseif optionName ~= false then
			obj.option = "Sound"..spellId.."in3"
			self:AddBoolOption(obj.option, optionDefault, "sound", nil, nil, nil, spellId)
			self.localization.options[obj.option] = L.AUTO_SOUND_OPTION_TEXT3:format(spellId)
		end
		return obj
	end

	function soundPrototype3:Play(file)
		if not self.option or self.mod.Options[self.option] then
			PlaySoundFile(file or "Interface\\AddOns\\DBM-Core\\sounds\\3to1.mp3", "Master")
		end
	end

	function soundPrototype3:Schedule(t, ...)
		return DBMScheduler:Schedule(t, self.Play, self.mod, self, ...)
	end

	function soundPrototype3:Cancel(...)
		return DBMScheduler:Unschedule(self.Play, self.mod, self, ...)
	end
end

do
	local soundPrototypeYou = {}
	local mt = { __index = soundPrototypeYou }
	function bossModPrototype:NewSoundYou(spellId, optionName, optionDefault)
		self.numSounds = self.numSounds and self.numSounds + 1 or 1
		local obj = setmetatable(
			{
				mod = self,
			},
			mt
		)
		if optionName then
			obj.option = optionName
			self:AddBoolOption(obj.option, optionDefault, "sound", nil, nil, nil, spellId)
		elseif optionName ~= false then
			obj.option = "Sound"..spellId.."you"
			self:AddBoolOption(obj.option, optionDefault, "sound", nil, nil, nil, spellId)
			self.localization.options[obj.option] = L.AUTO_SOUND_OPTION_TEXT_YOU:format(spellId)
		end
		return obj
	end

	function soundPrototypeYou:Play(file)
		if not self.option or self.mod.Options[self.option] then
			PlaySoundFile(file or "Sound\\Creature\\HoodWolf\\HoodWolfTransformPlayer01.wav", "Master")
		end
	end

	function soundPrototypeYou:Schedule(t, ...)
		return DBMScheduler:Schedule(t, self.Play, self.mod, self, ...)
	end

	function soundPrototypeYou:Cancel(...)
		return DBMScheduler:Unschedule(self.Play, self.mod, self, ...)
	end
end

do
	local soundPrototypeSoon = {}
	local mt = { __index = soundPrototypeSoon }
	function bossModPrototype:NewSoundSoon(spellId, optionName, optionDefault)
		self.numSounds = self.numSounds and self.numSounds + 1 or 1
		local obj = setmetatable(
			{
				mod = self,
			},
			mt
		)
		if optionName then
			obj.option = optionName
			self:AddBoolOption(obj.option, optionDefault, "sound", nil, nil, nil, spellId)
		elseif optionName ~= false then
			obj.option = "Sound"..spellId.."soon"
			self:AddBoolOption(obj.option, optionDefault, "sound", nil, nil, nil, spellId)
			self.localization.options[obj.option] = L.AUTO_SOUND_OPTION_TEXT_SOON:format(spellId)
		end		return obj
	end

	function soundPrototypeSoon:Play(file)
		if not self.option or self.mod.Options[self.option] then
			PlaySoundFile(file or "Sound\\Creature\\HoodWolf\\HoodWolfTransformPlayer01.wav", "Master")
		end
	end

	function soundPrototypeSoon:Schedule(t, ...)
		return DBMScheduler:Schedule(t, self.Play, self.mod, self, ...)
	end

	function soundPrototypeSoon:Cancel(...)
		return DBMScheduler:Unschedule(self.Play, self.mod, self, ...)
	end
end

do
	local soundPrototypeClose = {}
	local mt = { __index = soundPrototypeClose }
	function bossModPrototype:NewSoundClose(spellId, optionName, optionDefault)
		self.numSounds = self.numSounds and self.numSounds + 1 or 1
		local obj = setmetatable(
			{
				mod = self,
			},
			mt
		)
		if optionName then
			obj.option = optionName
			self:AddBoolOption(obj.option, optionDefault, "sound", nil, nil, nil, spellId)
		elseif optionName ~= false then
			obj.option = "Sound"..spellId.."close"
			self:AddBoolOption(obj.option, optionDefault, "sound", nil, nil, nil, spellId)
			self.localization.options[obj.option] = L.AUTO_SOUND_OPTION_TEXT_CLOSE:format(spellId)
		end
		return obj
	end

	function soundPrototypeClose:Play(file)
		if not self.option or self.mod.Options[self.option] then
			PlaySoundFile(file or "Sound\\Creature\\HoodWolf\\HoodWolfTransformPlayer01.wav", "Master")
		end
	end

	function soundPrototypeClose:Schedule(t, ...)
		return DBMScheduler:Schedule(t, self.Play, self.mod, self, ...)
	end

	function soundPrototypeClose:Cancel(...)
		return DBMScheduler:Unschedule(self.Play, self.mod, self, ...)
	end
end

--------------------
--  Yell Object  --
--------------------
do
	local demonForm = GetSpellInfo(47241)
	local yellPrototype = {}
	local mt = { __index = yellPrototype }
	local function newYell(self, yellType, spellId, yellText, optionDefault, optionName, chatType)
		if not spellId and not yellText then
			error("NewYell: you must provide either spellId or yellText", 2)
			return
		end
		local optionVersion
		if type(optionName) == "number" then
			optionVersion = optionName
			optionName = nil
		end
		local displayText
		if not yellText then
			displayText = L.AUTO_YELL_ANNOUNCE_TEXT[yellType]:format(DBM:GetSpellInfo(spellId) or CL.UNKNOWN)
		end
		--Passed spellid as yellText.
		--Auto localize spelltext using yellText instead
		if yellText and type(yellText) == "number" then
			displayText = L.AUTO_YELL_ANNOUNCE_TEXT[yellType]:format(DBM:GetSpellInfo(yellText) or CL.UNKNOWN)
		end
		local obj = setmetatable(
			{
				spellId = spellId,
				text = displayText or yellText,
				mod = self,
				chatType = chatType,
				yellType = yellType
			},
			mt
		)
		if optionName then
			obj.option = optionName
			self:AddBoolOption(obj.option, optionDefault, "yell", nil, nil, nil, spellId, yellType)
		elseif optionName ~= false then
			obj.option = "Yell"..(spellId or yellText)..(yellType ~= "yell" and yellType or "")..(optionVersion or "")
			self:AddBoolOption(obj.option, optionDefault, "yell", nil, nil, nil, spellId, yellType)
			self.localization.options[obj.option] = L.AUTO_YELL_OPTION_TEXT[yellType]:format(spellId)
		end
		return obj
	end

	--Standard "Yell" object that will use SAY/YELL based on what's defined in the object (Defaulting to SAY if nil)
	--I realize object being :Yell is counter intuitive to default being "SAY" but for many years the default was YELL and it's too many years of mods to change now
	function yellPrototype:Yell(...)
		if DBM.Options.DontSendYells or private.chatBubblesDisabled or self.yellType and self.yellType == "position" and DBM:UnitBuff("player", demonForm) and DBM.Options.FilterVoidFormSay then return end
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
		if DBM.Options.DontSendYells or private.chatBubblesDisabled or self.yellType and self.yellType == "position" and DBM:UnitBuff("player", demonForm) and DBM.Options.FilterVoidFormSay then return end
		if not self.option or self.mod.Options[self.option] then
			SendChatMessage(pformat(self.text, ...), "SAY")
		end
	end

	function yellPrototype:Schedule(t, ...)
		return DBMScheduler:Schedule(t, self.Yell, self.mod, self, ...)
	end

	--Standard schedule object to schedule a say/yell based on what's defined in object
	function yellPrototype:Countdown(time, numAnnounces, ...)
		if time > 60 then--It's a spellID not a time
			local _, _, _, _, _, _, expireTime = DBM:UnitDebuff("player", time)
			if expireTime then
				local remaining = expireTime-GetTime()
				DBMScheduler:ScheduleCountdown(remaining, numAnnounces, self.Yell, self.mod, self, ...)
			end
		else
			DBMScheduler:ScheduleCountdown(time, numAnnounces, self.Yell, self.mod, self, ...)
		end
	end

	--Scheduled Force override to use SAY message, even when object defines "YELL"
	function yellPrototype:CountdownSay(time, numAnnounces, ...)
		if time > 60 then--It's a spellID not a time
			local _, _, _, _, _, _, expireTime = DBM:UnitDebuff("player", time)
			if expireTime then
				local remaining = expireTime-GetTime()
				DBMScheduler:ScheduleCountdown(remaining, numAnnounces, self.Say, self.mod, self, ...)
			end
		else
			DBMScheduler:ScheduleCountdown(time, numAnnounces, self.Say, self.mod, self, ...)
		end
	end

	function yellPrototype:Cancel(...)
		return DBMScheduler:Unschedule(self.Yell, self.mod, self, ...)
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

	function bossModPrototype:NewShortPosYell(...)
		return newYell(self, "shortposition", ...)
	end

	function bossModPrototype:NewComboYell(...)
		return newYell(self, "combo", ...)
	end

	function bossModPrototype:NewPlayerRepeatYell(...)
		return newYell(self, "repeatplayer", ...)
	end

	function bossModPrototype:NewIconRepeatYell(...)
		return newYell(self, "repeaticon", ...)
	end
end

------------------------------
--  Special Warning Object  --
------------------------------
do
	local frame = CreateFrame("Frame", "DBMSpecialWarning", UIParent)
	local font1 = frame:CreateFontString("DBMSpecialWarning1", "OVERLAY", "ZoneTextFont")
	font1:SetWidth(1024)
	font1:SetHeight(0)
	font1:SetPoint("TOP", 0, 0)
	local font2 = frame:CreateFontString("DBMSpecialWarning2", "OVERLAY", "ZoneTextFont")
	font2:SetWidth(1024)
	font2:SetHeight(0)
	font2:SetPoint("TOP", font1, "BOTTOM", 0, 0)
	frame:SetMovable(1)
	frame:SetWidth(1)
	frame:SetHeight(1)
	frame:SetFrameStrata("HIGH")
	frame:SetClampedToScreen()
	frame:SetPoint("CENTER", UIParent, "CENTER", 0, 0)

	local font1elapsed, font2elapsed, moving

	local function fontHide1()
		local duration = DBM.Options.SpecialWarningDuration2
		if font1elapsed > duration * 1.3 then
			font1:Hide()
			if frame.font1ticker then
				AceTimer:CancelTimer(frame.font1ticker)
				frame.font1ticker = nil
			end
		elseif font1elapsed > duration then
			font1elapsed = font1elapsed + 0.05
			local alpha = 1 - (font1elapsed - duration) / (duration * 0.3)
			font1:SetAlpha(alpha > 0 and alpha or 0)
		else
			font1elapsed = font1elapsed + 0.05
			font1:SetAlpha(1)
		end
	end

	local function fontHide2()
		local duration = DBM.Options.SpecialWarningDuration2
		if font2elapsed > duration * 1.3 then
			font2:Hide()
			if frame.font2ticker then
				AceTimer:CancelTimer(frame.font2ticker)
				frame.font2ticker = nil
			end
		elseif font2elapsed > duration then
			font2elapsed = font2elapsed + 0.05
			local alpha = 1 - (font2elapsed - duration) / (duration * 0.3)
			font2:SetAlpha(alpha > 0 and alpha or 0)
		else
			font2elapsed = font2elapsed + 0.05
			font2:SetAlpha(1)
		end
	end

	function DBM:UpdateSpecialWarningOptions()
		frame:ClearAllPoints()
		local font = self.Options.SpecialWarningFont == "standardFont" and standardFont or self.Options.SpecialWarningFont
		frame:SetPoint(self.Options.SpecialWarningPoint, UIParent, self.Options.SpecialWarningPoint, self.Options.SpecialWarningX, self.Options.SpecialWarningY)
		font1:SetFont(font, self.Options.SpecialWarningFontSize2, self.Options.SpecialWarningFontStyle == "None" and nil or self.Options.SpecialWarningFontStyle)
		font2:SetFont(font, self.Options.SpecialWarningFontSize2, self.Options.SpecialWarningFontStyle == "None" and nil or self.Options.SpecialWarningFontStyle)
		font1:SetTextColor(unpack(self.Options.SpecialWarningFontCol))
		font2:SetTextColor(unpack(self.Options.SpecialWarningFontCol))
		if self.Options.SpecialWarningFontShadow then
			font1:SetShadowOffset(1, -1)
			font2:SetShadowOffset(1, -1)
		else
			font1:SetShadowOffset(0, 0)
			font2:SetShadowOffset(0, 0)
		end
	end

	function DBM:AddSpecialWarning(text, force)
		local added = false
		if not frame.font1ticker then
			font1elapsed = 0
			font1.lastUpdate = GetTime()
			font1:SetText(text)
			font1:Show()
			added = true
			frame.font1ticker = frame.font1ticker or AceTimer:ScheduleRepeatingTimer(fontHide1, 0.05)
		elseif not frame.font2ticker or force then
			font2elapsed = 0
			font2.lastUpdate = GetTime()
			font2:SetText(text)
			font2:Show()
			added = true
			frame.font2ticker = frame.font2ticker or AceTimer:ScheduleRepeatingTimer(fontHide2, 0.05)
		end
		if not added then
			local prevText1 = font2:GetText()
			font1:SetText(prevText1)
			font1elapsed = font2elapsed
			self:AddSpecialWarning(text, true)
		end
	end

	do
		local anchorFrame
		local function moveEnd(self)
			moving = false
			anchorFrame:Hide()
			font1elapsed = self.Options.SpecialWarningDuration2
			font2elapsed = self.Options.SpecialWarningDuration2
			frame:SetFrameStrata("HIGH")
			self:Unschedule(moveEnd)
			DBT:CancelBar(L.MOVE_SPECIAL_WARNING_BAR)
		end

		function DBM:MoveSpecialWarning()
			if not anchorFrame then
				anchorFrame = CreateFrame("Frame", nil, frame)
				anchorFrame:SetWidth(32)
				anchorFrame:SetHeight(32)
				anchorFrame:EnableMouse(true)
				anchorFrame:SetPoint("TOP", frame, "TOP", 0, 32)
				anchorFrame:RegisterForDrag("LeftButton")
				anchorFrame:SetClampedToScreen()
				anchorFrame:Hide()
				local texture = anchorFrame:CreateTexture()
				texture:SetTexture("Interface\\Addons\\DBM-Core\\textures\\dot.blp")
				texture:SetPoint("CENTER", anchorFrame, "CENTER", 0, 0)
				texture:SetWidth(32)
				texture:SetHeight(32)
				anchorFrame:SetScript("OnDragStart", function()
					frame:StartMoving()
					self:Unschedule(moveEnd)
					DBT:CancelBar(L.MOVE_SPECIAL_WARNING_BAR)
				end)
				anchorFrame:SetScript("OnDragStop", function()
					frame:StopMovingOrSizing()
					local point, _, _, xOfs, yOfs = frame:GetPoint(1)
					self.Options.SpecialWarningPoint = point
					self.Options.SpecialWarningX = xOfs
					self.Options.SpecialWarningY = yOfs
					self:Schedule(15, moveEnd, self)
					DBT:CreateBar(15, L.MOVE_SPECIAL_WARNING_BAR, "Interface\\Icons\\Spell_Holy_BorrowedTime")
				end)
			end
			if anchorFrame:IsShown() then
				moveEnd(self)
			else
				moving = true
				anchorFrame:Show()
				self:AddSpecialWarning(L.MOVE_SPECIAL_WARNING_TEXT)
				self:AddSpecialWarning(L.MOVE_SPECIAL_WARNING_TEXT)
				self:Schedule(15, moveEnd, self)
				DBT:CreateBar(15, L.MOVE_SPECIAL_WARNING_BAR, "Interface\\Icons\\Spell_Holy_BorrowedTime")
				frame:Show()
				frame:SetFrameStrata("TOOLTIP")
				frame:SetAlpha(1)
			end
		end
	end

	local specialWarningPrototype = {}
	local mt = {__index = specialWarningPrototype}

	local function classColoringFunction(cap)
		cap = cap:sub(2, -2)
		local noStrip = cap:match("noStrip ")
		if not noStrip then
			local name = cap
			local playerClass, playerIcon = DBM:GetRaidClass(name)
			if playerClass ~= "UNKNOWN" then
				cap = DBM:GetShortServerName(cap)--Only run strip code on valid player classes
				if DBM.Options.SWarnClassColor then
					local playerColor = RAID_CLASS_COLORS[playerClass]
					if playerColor then
						if playerIcon > 0 and playerIcon <= 8 then
							cap = ("|TInterface\\TargetingFrame\\UI-RaidTargetingIcon_%d:0|t"):format(playerIcon) .. ("|r|cff%.2x%.2x%.2x%s|r|cff%.2x%.2x%.2x"):format(playerColor.r * 255, playerColor.g * 255, playerColor.b * 255, cap, DBM.Options.SpecialWarningFontCol[1] * 255, DBM.Options.SpecialWarningFontCol[2] * 255, DBM.Options.SpecialWarningFontCol[3] * 255)
						else
							cap = ("|r|cff%.2x%.2x%.2x%s|r|cff%.2x%.2x%.2x"):format(playerColor.r * 255, playerColor.g * 255, playerColor.b * 255, cap, DBM.Options.SpecialWarningFontCol[1] * 255, DBM.Options.SpecialWarningFontCol[2] * 255, DBM.Options.SpecialWarningFontCol[3] * 255)
						end
					end
				end
			end
		else
			cap = cap:sub(9)
		end
		return cap
	end

	local textureCode = " |T%s:12:12|t "

	local specInstructionalRemapTable = {
		["dispel"] = "target",
		["interrupt"] = "spell",
		["interruptcount"] = "count",
		["defensive"] = "spell",
		["taunt"] = "target",
		["soak"] = "spell",
		["soakcount"] = "count",
		["soakpos"] = "spell",
		["switch"] = "spell",
		["switchcount"] = "count",
--		["adds"] = "spell",
--		["addscount"] = "spell",
--		["addscustom"] = "spell",
		["targetchange"] = "target",
		["gtfo"] = "spell",
		["bait"] = "soon",
		["youpos"] = "you",
		["youposcount"] = "youcount",
		["move"] = "spell",
		["keepmove"] = "spell",
		["stopmove"] = "spell",
		["dodge"] = "spell",
		["dodgecount"] = "count",
		["dodgeloc"] = "spell",
		["moveaway"] = "spell",
		["moveawaycount"] = "count",
		["moveto"] = "spell",
		["jump"] = "spell",
		["run"] = "spell",
		["runcount"] = "spell",
		["cast"] = "spell",
		["lookaway"] = "spell",
		["reflect"] = "target",
	}

	local function setText(announceType, spellId, stacks, customName)
		local text, spellName
		if customName then
			spellName = customName
		else
			spellName = (spellId or 0) >= 6 and DBM:GetSpellInfo(spellId) or CL.UNKNOWN
		end
		if announceType == "prewarn" then
			if type(stacks) == "string" then
				text = L.AUTO_SPEC_WARN_TEXTS[announceType]:format(spellName, stacks)
			else
				text = L.AUTO_SPEC_WARN_TEXTS[announceType]:format(spellName, L.SEC_FMT:format(tostring(stacks or 5)))
			end
		else
			if DBM.Options.SpamSpecInformationalOnly and specInstructionalRemapTable[announceType] then
				local newType = specInstructionalRemapTable[announceType]
				text = L.AUTO_SPEC_WARN_TEXTS[newType]:format(spellName)
			else
				text = L.AUTO_SPEC_WARN_TEXTS[announceType]:format(spellName)
			end
		end
		return text, spellName
	end

	function specialWarningPrototype:SetText(customName)
		local text, spellName = setText(self.announceType, self.spellId, self.stacks, customName)
		self.text = text
		self.spellName = spellName
	end

	local function canVoiceReplace(self, soundId)
		soundId = soundId or self.option and self.mod.Options[self.option .. "SWSound"] or self.flash
		local isVoicePackUsed
		if self.announceType == "gtfo" then
			isVoicePackUsed = DBM.Options.VPReplacesGTFO
		elseif type(soundId) == "number" then
			isVoicePackUsed = DBM.Options["VPReplacesSA"..soundId]
		else
			isVoicePackUsed = DBM.Options.VPReplacesCustom
		end
		return isVoicePackUsed
	end

	local specTypeFilterTable = {
		["dispel"] = "dispel",
		["interrupt"] = "interrupt",
		["interruptcount"] = "interrupt",
		["defensive"] = "defensive",
		["taunt"] = "taunt",
		["soak"] = "soak",
		["soakcount"] = "soak",
		["soakpos"] = "soak",
		["stack"] = "stack",
		["switch"] = "switch",
		["switchcount"] = "switch",
		["adds"] = "switch",
		["addscount"] = "switch",
		["addscustom"] = "switch",
		["targetchange"] = "switch",
		["gtfo"] = "gtfo",
	}

	function specialWarningPrototype:Show(...)
		--Check if option for this warning is even enabled
		if (not self.option or self.mod.Options[self.option]) and not moving and frame then
			--Now, check if all special warning filters are enabled to save cpu and abort immediately if true.
			if DBM.Options.DontPlaySpecialWarningSound and DBM.Options.DontShowSpecialWarningFlash and DBM.Options.DontShowSpecialWarningText then return end
			--Next, we check if trash mod warning and if so check the filter trash warning filter for trivial difficulties
			if self.mod.isTrashMod and DBM.Options.FilterTrashWarnings2 and (self.mod:IsEasyDungeon() or DBM:IsTrivial()) then return end
			--We also check if person has the role filter turned on (typical for highest end raiders who don't want as much handholding from DBM)
			if specTypeFilterTable[self.announceType] then
				if DBM.Options["SpamSpecRole"..specTypeFilterTable[self.announceType]] then return end
			end
			--Lastly, we check if it's a tank warning and filter if not in tank spec. This is done because tank warnings on by default and handled fluidly by spec, not option setting
			if self.announceType == "taunt" and DBM.Options.FilterTankSpec and not self.mod:IsTank() then return end--Don't tell non tanks to taunt, ever.
			local argTable = {...}
			-- add a default parameter for move away warnings
			if self.announceType == "gtfo" then
				if DBM:UnitBuff("player", 27827) then return end--Don't tell a priest in spirit of redemption form to GTFO, they can't, and they don't take damage from it anyhow
				if #argTable == 0 then
					argTable[1] = L.BAD
				end
			end
			if #self.combinedtext > 0 then
				--Throttle spam.
				if DBM.Options.SWarningAlphabetical then
					tsort(self.combinedtext)
				end
				local combinedText = tconcat(self.combinedtext, "<, >")
				if self.combinedcount == 1 then
					combinedText = combinedText.." "..L.GENERIC_WARNING_OTHERS
				elseif self.combinedcount > 1 then
					combinedText = combinedText.." "..L.GENERIC_WARNING_OTHERS2:format(self.combinedcount)
				end
				--Process
				for i = 1, #argTable do
					if type(argTable[i]) == "string" then
						argTable[i] = combinedText
					end
				end
			end
			local message = pformat(self.text, unpack(argTable))
			local text = ("%s%s%s"):format(
				(DBM.Options.SpecialWarningIcon and self.icon and textureCode:format(self.icon)) or "",
				message,
				(DBM.Options.SpecialWarningIcon and self.icon and textureCode:format(self.icon)) or ""
			)
			local noteHasName = false
			if self.option then
				local noteText = self.mod.Options[self.option .. "SWNote"]
				if noteText and type(noteText) == "string" and noteText ~= "" then--Filter false bool and empty strings
					local count1 = self.announceType == "count" or self.announceType == "switchcount" or self.announceType == "targetcount"
					local count2 = self.announceType == "interruptcount"
					if count1 or count2 then--Counts support different note for EACH count
						local noteCount
						local notesTable = {string.split("/", noteText)}
						if count1 then
							noteCount = argTable[1]--Count should be first arg in table
						elseif count2 then
							noteCount = argTable[2]--Count should be second arg in table
						end
						if type(noteCount) == "string" then
							--Probably a hypehnated double count like inferno slice or marked for death
							local mainCount = string.split("-", noteCount)
							noteCount = tonumber(mainCount)
						end
						noteText = notesTable[noteCount]
						if noteText and type(noteText) == "string" and noteText ~= "" then--Refilter after string split to make sure a note for this count exists
							local hasPlayerName = noteText:find(playerName)
							if DBM.Options.SWarnNameInNote and hasPlayerName then
								noteHasName = 5
							end
							--Terminate special warning, it's an interrupt count warning without player name and filter enabled
							if count2 and DBM.Options.FilterInterruptNoteName and not hasPlayerName then return end
							noteText = " ("..noteText..")"
							text = text..noteText
						end
					else--Non count warnings will have one note, period
						if DBM.Options.SWarnNameInNote and noteText:find(playerName) then
							noteHasName = 5
						end
						if self.announceType and not self.announceType:find("switch") then
							noteText = noteText:gsub(">.-<", classColoringFunction)--Class color note text before combining with warning text.
						end
						noteText = " ("..noteText..")"
						text = text..noteText
					end
				end
			end
			--Text is disabled, suresss text from screen and chat frame
			if not DBM.Options.DontShowSpecialWarningText then
				--No stripping on switch warnings, ever. They will NEVER have player name, but often have adds with "-" in name
				if self.announceType and not self.announceType:find("switch") then
					text = text:gsub(">.-<", classColoringFunction)
				end
				DBM:AddSpecialWarning(text)
				if DBM.Options.ShowSWarningsInChat then
					local colorCode = ("|cff%.2x%.2x%.2x"):format(DBM.Options.SpecialWarningFontCol[1] * 255, DBM.Options.SpecialWarningFontCol[2] * 255, DBM.Options.SpecialWarningFontCol[3] * 255)
					self.mod:AddMsg(colorCode.."["..L.MOVE_SPECIAL_WARNING_TEXT.."] "..text.."|r", nil)
				end
			end
			self.combinedcount = 0
			self.combinedtext = {}
			if not UnitIsDeadOrGhost("player") then
				if noteHasName then
					if not DBM.Options.DontShowSpecialWarningFlash and DBM.Options.SpecialWarningFlash5 then--Not included in above if statement on purpose. we don't want to trigger else rule if noteHasName is true but SpecialWarningFlash5 is false
						local repeatCount = DBM.Options.SpecialWarningFlashCount5 or 1
						DBM.Flash:Show(DBM.Options.SpecialWarningFlashCol5[1],DBM.Options.SpecialWarningFlashCol5[2], DBM.Options.SpecialWarningFlashCol5[3], DBM.Options.SpecialWarningFlashDura5, DBM.Options.SpecialWarningFlashAlph5, repeatCount-1)
					end
				else
					local number = self.flash
					if not DBM.Options.DontShowSpecialWarningFlash and DBM.Options["SpecialWarningFlash"..number] then
						local repeatCount = DBM.Options["SpecialWarningFlashCount"..number] or 1
						local flashcolor = DBM.Options["SpecialWarningFlashCol"..number]
						DBM.Flash:Show(flashcolor[1], flashcolor[2], flashcolor[3], DBM.Options["SpecialWarningFlashDura"..number], DBM.Options["SpecialWarningFlashAlph"..number], repeatCount-1)
					end
				end
			end
			--Text: Full message text
			--Icon: Texture path/id for icon
			--Type: Announce type
			----Types: spell, ends, fades, soon, bait, dispel, interrupt, interruptcount, you, youcount, youpos, soakpos, target, targetcount, defensive, taunt, close, move, keepmove, stopmove,
			----gtfo, dodge, dodgecount, dodgeloc, moveaway, moveawaycount, moveto, soak, jump, run, cast, lookaway, reflect, count, sooncount, stack, switch, switchcount, adds, addscount, addscustom, targetchange, prewarn
			------General Target Messages (but since it's a special warning, it applies to you in some way): target, targetcount
			------Fight Changes (Stages, adds, boss buff/debuff, etc): adds, addscount, addscustom, targetchange, switch, switchcount, ends
			------General (can really apply to anything): spell, count, soon, sooncount, prewarn
			------Personal/Role (Applies to you, or your job): Everything Else
			--SpellId: Raw spell or encounter journal Id if available.
			--Mod ID: Encounter ID as string, or a generic string for mods that don't have encounter ID (such as trash, dummy/test mods)
			--boolean: Whether or not this warning is a special warning (higher priority).
			fireEvent("DBM_Announce", text, self.icon, self.type, self.spellId, self.mod.id, true)
			if self.sound and not DBM.Options.DontPlaySpecialWarningSound and (not self.option or self.mod.Options[self.option.."SWSound"] ~= "None") then
				local soundId = self.option and self.mod.Options[self.option .. "SWSound"] or self.flash
				if noteHasName and type(soundId) == "number" then soundId = noteHasName end--Change number to 5 if it's not a custom sound, else, do nothing with it
				if self.hasVoice and DBM.Options.ChosenVoicePack2 ~= "None" and not voiceSessionDisabled and not DBM.Options.VPDontMuteSounds and canVoiceReplace(self, soundId) and self.hasVoice <= SWFilterDisabled then return end
				DBM:PlaySpecialWarningSound(soundId or 1)
			end
		else
			self.combinedcount = 0
			self.combinedtext = {}
		end
	end

	function specialWarningPrototype:CombinedShow(delay, ...)
		--Check if option for this warning is even enabled
		if self.option and not self.mod.Options[self.option] then return end
		--Now, check if all special warning filters are enabled to save cpu and abort immediately if true.
		if DBM.Options.DontPlaySpecialWarningSound and DBM.Options.DontShowSpecialWarningFlash and DBM.Options.DontShowSpecialWarningText then return end
		--Next, we check if trash mod warning and if so check the filter trash warning filter for trivial difficulties
		if self.mod:IsEasyDungeon() and self.mod.isTrashMod and DBM.Options.FilterTrashWarnings2 then return end
		local argTable = {...}
		for i = 1, #argTable do
			if type(argTable[i]) == "string" then
				if #self.combinedtext < 8 then--Throttle spam. We may not need more than 9 targets..
					if not checkEntry(self.combinedtext, argTable[i]) then
						self.combinedtext[#self.combinedtext + 1] = argTable[i]
					end
				else
					self.combinedcount = self.combinedcount + 1
				end
			end
		end
		DBMScheduler:Unschedule(self.Show, self.mod, self)
		DBMScheduler:Schedule(delay or 0.5, self.Show, self.mod, self, ...)
	end

	function specialWarningPrototype:DelayedShow(delay, ...)
		DBMScheduler:Unschedule(self.Show, self.mod, self, ...)
		DBMScheduler:Schedule(delay or 0.5, self.Show, self.mod, self, ...)
	end

	function specialWarningPrototype:Schedule(t, ...)
		return DBMScheduler:Schedule(t, self.Show, self.mod, self, ...)
	end

	function specialWarningPrototype:Countdown(time, numAnnounces, ...)
		DBMScheduler:ScheduleCountdown(time, numAnnounces, self.Show, self.mod, self, ...)
	end

	function specialWarningPrototype:Cancel(_, ...) -- t, ...
		return DBMScheduler:Unschedule(self.Show, self.mod, self, ...)
	end

	--Several voice lines still need generic alternatives that don't feel "instructional"
	local specInstructionalRemapVoiceTable = {
--		["dispel"] = "target",
--		["interrupt"] = "spell",
--		["interruptcount"] = "count",
--		["defensive"] = "spell",
		["taunt"] = "changemt",--Remaps sound to say a swap is happening, rather than telling you to taunt boss
--		["soak"] = "spell",
--		["soakcount"] = "count",
--		["soakpos"] = "spell",
--		["switch"] = "spell",
--		["switchcount"] = "count",
		["adds"] = "mobsoon",--Remaps sound to say mobs incoming only, not to kill them or cc them or anything else.
		["addscount"] = "mobsoon",
		["addscustom"] = "mobsoon",--Remaps sound to say mobs incoming only, not to kill them or cc them or anything else.
--		["targetchange"] = "target",
--		["gtfo"] = "spell",
--		["bait"] = "soon",
		["you"] = "targetyou",--Remaps personal alert to just say "target you", without instruction
		["youpos"] = "targetyou",--Remaps personal alert to just say "target you", without instruction
		["youposcount"] = "targetyou",--Remaps personal alert to just say "target you", without instruction
--		["move"] = "spell",
--		["keepmove"] = "spell",
--		["stopmove"] = "spell",
--		["dodge"] = "spell",
--		["dodgecount"] = "count",
--		["dodgeloc"] = "spell",
		["moveaway"] = "targetyou",--Remaps personal alert to just say "target you", without instruction
		["moveawaycount"] = "targetyou",--Remaps personal alert to just say "target you", without instruction
--		["moveto"] = "spell",
--		["jump"] = "spell",
--		["run"] = "spell",
--		["runcount"] = "spell",
--		["cast"] = "spell",
--		["lookaway"] = "spell",
--		["reflect"] = "target",
	}

	function specialWarningPrototype:Play(name, customPath)
		local always = DBM.Options.AlwaysPlayVoice
		local voice = DBM.Options.ChosenVoicePack2
		local soundId = self.option and self.mod.Options[self.option .. "SWSound"] or self.flash
		if voiceSessionDisabled or voice == "None" or not canVoiceReplace(self, soundId) then return end
		if self.mod:IsEasyDungeon() and self.mod.isTrashMod and DBM.Options.FilterTrashWarnings2 then return end
		if specTypeFilterTable[self.announceType] then
			--Filtered warning, filtered voice
			if DBM.Options["SpamSpecRole"..specTypeFilterTable[self.announceType]] then return end
		elseif DBM.Options.SpamSpecInformationalOnly and specInstructionalRemapVoiceTable[self.announceType] then
			--Instructional disabled, remap to a less instructional voice line
			name = specInstructionalRemapVoiceTable[self.announceType]
		end
		if ((not self.option or self.mod.Options[self.option]) or always) and self.hasVoice <= SWFilterDisabled then
			--Filter tank specific voice alerts for non tanks if tank filter enabled
			--But still allow AlwaysPlayVoice to play as well.
			if (name == "changemt" or name == "tauntboss") and DBM.Options.FilterTankSpec and not self.mod:IsTank() and not always then return end
			--Mute VP if SW sound is set to None in the boss mod.
			if soundId == "None" then return end
			local path = customPath or "Interface\\AddOns\\DBM-VP"..voice.."\\"..name..".ogg"
			DBM:PlaySoundFile(path)
		end
	end

	function specialWarningPrototype:ScheduleVoice(t, ...)
		if voiceSessionDisabled or DBM.Options.ChosenVoicePack2 == "None" or not canVoiceReplace(self) then return end
		DBMScheduler:Unschedule(self.Play, self.mod, self)--Allow ScheduleVoice to be used in same way as CombinedShow
		return DBMScheduler:Schedule(t, self.Play, self.mod, self, ...)
	end

	--Object Permits scheduling voice multiple times for same object
	function specialWarningPrototype:ScheduleVoiceOverLap(t, ...)
		if voiceSessionDisabled or DBM.Options.ChosenVoicePack2 == "None" or not canVoiceReplace(self) then return end
		return DBMScheduler:Schedule(t, self.Play, self.mod, self, ...)
	end

	function specialWarningPrototype:CancelVoice(...)
		if voiceSessionDisabled or DBM.Options.ChosenVoicePack2 == "None" or not canVoiceReplace(self) then return end
		return DBMScheduler:Unschedule(self.Play, self.mod, self, ...)
	end

	function bossModPrototype:NewSpecialWarning(text, optionDefault, optionName, optionVersion, runSound, hasVoice, difficulty, texture, spellID)
		if not text then
			error("NewSpecialWarning: you must provide special warning text", 2)
			return
		end
		if type(text) == "string" and text:match("OptionVersion") then
			error("NewSpecialWarning: you must provide remove optionversion hack for "..optionDefault)
			return
		end
		if runSound == true then
			runSound = 2
		elseif not runSound then
			runSound = 1
		end
		if hasVoice == true then--if not a number, set it to 2, old mods that don't use new numbered system
			hasVoice = 2
		end
		local seticon
		if texture then
			if type(texture) == "string" and texture:match("ej%d+") then
				self:AddMsg("|cffff0000Invalid call to EJ_GetSectionInfo for texture: |r"..texture..". Please report this bug")
			end
			seticon = type(texture) == "number" and GetSpellTexture(texture) or texture
		end
		local obj = setmetatable(
			{
				text = self.localization.warnings[text],
				combinedtext = {},
				combinedcount = 0,
				mod = self,
				sound = runSound>0,
				flash = runSound,--Set flash color to hard coded runsound (even if user sets custom sounds)
				hasVoice = hasVoice,
				difficulty = difficulty,
				icon = seticon,
			},
			mt
		)
		local optionId = optionName or optionName ~= false and text
		if optionId then
			obj.voiceOptionId = hasVoice and "Voice"..optionId or nil
			obj.option = optionId..(optionVersion or "")
			self:AddSpecialWarningOption(obj.option, optionDefault, runSound, self.NoSortAnnounce and "specialannounce" or "announce", spellID)
		end
		tinsert(self.specwarns, obj)
		return obj
	end

	local function newSpecialWarning(self, announceType, spellId, stacks, optionDefault, optionName, optionVersion, runSound, hasVoice, difficulty)
		if not spellId then
			error("newSpecialWarning: you must provide spellId", 2)
			return
		end
		if runSound == true then
			runSound = 2
		elseif not runSound then
			runSound = 1
		end
		if hasVoice == true then--if not a number, set it to 2, old mods that don't use new numbered system
			hasVoice = 2
		end
		local alternateSpellId
		if type(optionName) == "number" then
			if DBM.Options.SpecialWarningShortText then
				alternateSpellId = optionName
			end
			optionName = nil
		end
		local text, spellName = setText(announceType, alternateSpellId or spellId, stacks)
		local obj = setmetatable( -- todo: fix duplicate code
			{
				text = text,
				combinedtext = {},
				combinedcount = 0,
				announceType = announceType,
				mod = self,
				sound = runSound>0,
				flash = runSound,--Set flash color to hard coded runsound (even if user sets custom sounds)
				hasVoice = hasVoice,
				difficulty = difficulty,
				type = announceType,
				spellId = spellId,
				spellName = spellName,
				stacks = stacks,
				icon = select(3, GetSpellInfo(spellId))
			},
			mt
		)
		if optionName then
			obj.option = optionName
		elseif optionName ~= false then
			local difficultyIcon = ""
			if difficulty then
				--1 LFR, 2 Normal, 3 Heroic, 4 Mythic
				--Likely 1 and 2 will never be used, but being prototyped just in case
				local path = "AddOns\\DBM-Core\\textures"
				if difficulty == 3 then
					difficultyIcon = "|TInterface\\" .. path .. "\\UI-EJ-Icons.blp:18:18:0:0:255:66:102:118:7:27|t"
				elseif difficulty == 4 then
					difficultyIcon = "|TInterface\\" .. path .. "\\UI-EJ-Icons.blp:18:18:0:0:255:66:133:153:40:58|t"
				end
			end
			obj.option = "SpecWarn"..spellId..announceType..(optionVersion or "")
			if announceType == "stack" then
				self.localization.options[obj.option] = difficultyIcon..L.AUTO_SPEC_WARN_OPTIONS[announceType]:format(stacks or 3, spellId)
			elseif announceType == "prewarn" then
				self.localization.options[obj.option] = difficultyIcon..L.AUTO_SPEC_WARN_OPTIONS[announceType]:format(tostring(stacks or 5), spellId)
			else
				self.localization.options[obj.option] = difficultyIcon..L.AUTO_SPEC_WARN_OPTIONS[announceType]:format(spellId)
			end
		end
		if obj.option then
			local catType = "announce"--Default to General announce
			if self.NoSortAnnounce then--ALL special announce objects will be assigned "specialannounce", usually for mods that sort by phase instead
				catType = "specialannounce"
			else
				--Directly affects another target (boss or player) that you need to know about
				if announceType == "target" or announceType == "targetcount" or announceType == "close" or announceType == "reflect" then
					catType = "announceother"
				--Directly affects you
				elseif announceType == "you" or announceType == "youcount" or announceType == "youpos" or announceType == "move" or announceType == "dodge" or announceType == "dodgecount" or announceType == "moveaway" or announceType == "moveawaycount" or announceType == "keepmove" or announceType == "stopmove" or announceType == "run" or announceType == "runcount" or announceType == "stack" or announceType == "moveto" or announceType == "soak" or announceType == "soakcount" or announceType == "soakpos" then
					catType = "announcepersonal"
				--Things you have to do to fulfil your role
				elseif announceType == "taunt" or announceType == "dispel" or announceType == "interrupt" or announceType == "interruptcount" or announceType == "switch" or announceType == "switchcount" then
					catType = "announcerole"
				end
			end
			self:AddSpecialWarningOption(obj.option, optionDefault, runSound, catType, spellId, announceType)
		end
		obj.voiceOptionId = hasVoice and "Voice"..spellId or nil
		tinsert(self.specwarns, obj)
		return obj
	end

	function bossModPrototype:NewSpecialWarningSpell(spellId, optionDefault, ...)
		return newSpecialWarning(self, "spell", spellId, nil, optionDefault, ...)
	end

	function bossModPrototype:NewSpecialWarningEnd(spellId, optionDefault, ...)
		return newSpecialWarning(self, "ends", spellId, nil, optionDefault, ...)
	end

	function bossModPrototype:NewSpecialWarningFades(spellId, optionDefault, ...)
		return newSpecialWarning(self, "fades", spellId, nil, optionDefault, ...)
	end

	function bossModPrototype:NewSpecialWarningSoon(spellId, optionDefault, ...)
		return newSpecialWarning(self, "soon", spellId, nil, optionDefault, ...)
	end

	function bossModPrototype:NewSpecialWarningBait(spellId, optionDefault, ...)
		return newSpecialWarning(self, "bait", spellId, nil, optionDefault, ...)
	end

	function bossModPrototype:NewSpecialWarningDispel(spellId, optionDefault, ...)
		return newSpecialWarning(self, "dispel", spellId, nil, optionDefault, ...)
	end

	function bossModPrototype:NewSpecialWarningInterrupt(spellId, optionDefault, ...)
		return newSpecialWarning(self, "interrupt", spellId, nil, optionDefault, ...)
	end

	function bossModPrototype:NewSpecialWarningInterruptCount(spellId, optionDefault, ...)
		return newSpecialWarning(self, "interruptcount", spellId, nil, optionDefault, ...)
	end

	function bossModPrototype:NewSpecialWarningYou(spellId, optionDefault, ...)
		return newSpecialWarning(self, "you", spellId, nil, optionDefault, ...)
	end

	function bossModPrototype:NewSpecialWarningYouCount(spellId, optionDefault, ...)
		return newSpecialWarning(self, "youcount", spellId, nil, optionDefault, ...)
	end

	function bossModPrototype:NewSpecialWarningYouPos(spellId, optionDefault, ...)
		return newSpecialWarning(self, "youpos", spellId, nil, optionDefault, ...)
	end

	function bossModPrototype:NewSpecialWarningYouPosCount(spellId, optionDefault, ...)
		return newSpecialWarning(self, "youposcount", spellId, nil, optionDefault, ...)
	end

	function bossModPrototype:NewSpecialWarningSoakPos(spellId, optionDefault, ...)
		return newSpecialWarning(self, "soakpos", spellId, nil, optionDefault, ...)
	end

	function bossModPrototype:NewSpecialWarningTarget(spellId, optionDefault, ...)
		return newSpecialWarning(self, "target", spellId, nil, optionDefault, ...)
	end

	function bossModPrototype:NewSpecialWarningTargetCount(spellId, optionDefault, ...)
		return newSpecialWarning(self, "targetcount", spellId, nil, optionDefault, ...)
	end

	function bossModPrototype:NewSpecialWarningDefensive(spellId, optionDefault, ...)
		return newSpecialWarning(self, "defensive", spellId, nil, optionDefault, ...)
	end

	function bossModPrototype:NewSpecialWarningTaunt(spellId, optionDefault, ...)
		return newSpecialWarning(self, "taunt", spellId, nil, optionDefault, ...)
	end

	function bossModPrototype:NewSpecialWarningClose(spellId, optionDefault, ...)
		return newSpecialWarning(self, "close", spellId, nil, optionDefault, ...)
	end

	function bossModPrototype:NewSpecialWarningMove(spellId, optionDefault, ...)
		return newSpecialWarning(self, "move", spellId, nil, optionDefault, ...)
	end

	function bossModPrototype:NewSpecialWarningKeepMove(spellId, optionDefault, ...)
		return newSpecialWarning(self, "keepmove", spellId, nil, optionDefault, ...)
	end

	function bossModPrototype:NewSpecialWarningStopMove(spellId, optionDefault, ...)
		return newSpecialWarning(self, "stopmove", spellId, nil, optionDefault, ...)
	end

	function bossModPrototype:NewSpecialWarningGTFO(spellId, optionDefault, ...)
		return newSpecialWarning(self, "gtfo", spellId, nil, optionDefault, ...)
	end

	function bossModPrototype:NewSpecialWarningDodge(spellId, optionDefault, ...)
		return newSpecialWarning(self, "dodge", spellId, nil, optionDefault, ...)
	end

	function bossModPrototype:NewSpecialWarningDodgeCount(spellId, optionDefault, ...)
		return newSpecialWarning(self, "dodgecount", spellId, nil, optionDefault, ...)
	end

	function bossModPrototype:NewSpecialWarningDodgeLoc(spellId, optionDefault, ...)
		return newSpecialWarning(self, "dodgeloc", spellId, nil, optionDefault, ...)
	end

	function bossModPrototype:NewSpecialWarningMoveAway(spellId, optionDefault, ...)
		return newSpecialWarning(self, "moveaway", spellId, nil, optionDefault, ...)
	end

	function bossModPrototype:NewSpecialWarningMoveAwayCount(spellId, optionDefault, ...)
		return newSpecialWarning(self, "moveawaycount", spellId, nil, optionDefault, ...)
	end

	function bossModPrototype:NewSpecialWarningMoveTo(spellId, optionDefault, ...)
		return newSpecialWarning(self, "moveto", spellId, nil, optionDefault, ...)
	end

	function bossModPrototype:NewSpecialWarningSoak(spellId, optionDefault, ...)
		return newSpecialWarning(self, "soak", spellId, nil, optionDefault, ...)
	end

	function bossModPrototype:NewSpecialWarningSoakCount(spellId, optionDefault, ...)
		return newSpecialWarning(self, "soakcount", spellId, nil, optionDefault, ...)
	end

	function bossModPrototype:NewSpecialWarningJump(spellId, optionDefault, ...)
		return newSpecialWarning(self, "jump", spellId, nil, optionDefault, ...)
	end

	function bossModPrototype:NewSpecialWarningRun(spellId, optionDefault, optionName, optionVersion, runSound, ...)
		return newSpecialWarning(self, "run", spellId, nil, optionDefault, optionName, optionVersion, runSound or 4, ...)
	end

	function bossModPrototype:NewSpecialWarningRunCount(spellId, optionDefault, optionName, optionVersion, runSound, ...)
		return newSpecialWarning(self, "runcount", spellId, nil, optionDefault, optionName, optionVersion, runSound or 4, ...)
	end

	function bossModPrototype:NewSpecialWarningCast(spellId, optionDefault, ...)
		return newSpecialWarning(self, "cast", spellId, nil, optionDefault, ...)
	end

	function bossModPrototype:NewSpecialWarningLookAway(spellId, optionDefault, ...)
		return newSpecialWarning(self, "lookaway", spellId, nil, optionDefault, ...)
	end

	function bossModPrototype:NewSpecialWarningReflect(spellId, optionDefault, ...)
		return newSpecialWarning(self, "reflect", spellId, nil, optionDefault, ...)
	end

	function bossModPrototype:NewSpecialWarningCount(spellId, optionDefault, ...)
		return newSpecialWarning(self, "count", spellId, nil, optionDefault, ...)
	end

	function bossModPrototype:NewSpecialWarningSoonCount(spellId, optionDefault, ...)
		return newSpecialWarning(self, "sooncount", spellId, nil, optionDefault, ...)
	end

	function bossModPrototype:NewSpecialWarningStack(spellId, optionDefault, stacks, ...)
		return newSpecialWarning(self, "stack", spellId, stacks, optionDefault, ...)
	end

	function bossModPrototype:NewSpecialWarningSwitch(spellId, optionDefault, ...)
		return newSpecialWarning(self, "switch", spellId, nil, optionDefault, ...)
	end

	function bossModPrototype:NewSpecialWarningSwitchCount(spellId, optionDefault, ...)
		return newSpecialWarning(self, "switchcount", spellId, nil, optionDefault, ...)
	end

	function bossModPrototype:NewSpecialWarningAdds(spellId, optionDefault, ...)
		return newSpecialWarning(self, "adds", spellId, nil, optionDefault, ...)
	end

	function bossModPrototype:NewSpecialWarningAddsCount(spellId, optionDefault, ...)
		return newSpecialWarning(self, "addscount", spellId, nil, optionDefault, ...)
	end

	function bossModPrototype:NewSpecialWarningAddsCustom(spellId, optionDefault, ...)
		return newSpecialWarning(self, "addscustom", spellId, nil, optionDefault, ...)
	end

	function bossModPrototype:NewSpecialWarningTargetChange(spellId, optionDefault, ...)
		return newSpecialWarning(self, "targetchange", spellId, nil, optionDefault, ...)
	end

	function bossModPrototype:NewSpecialWarningPreWarn(spellId, optionDefault, time, ...)
		return newSpecialWarning(self, "prewarn", spellId, time, optionDefault, ...)
	end

	function DBM:PlayCountSound(number, forceVoice, forcePath)
		if number > 10 then return end
		local voice
		if forceVoice then--For options example
			voice = forceVoice
		else
			voice = self.Options.CountdownVoice
		end
		local path
		local maxCount = 5
		if forcePath then
			path = forcePath
		else
			for _, count in pairs(DBM:GetCountSounds()) do
				if count.value == voice then
					path = count.path
					maxCount = count.max
					break
				end
			end
		end
		if not path or (number > maxCount) then return end
		self:PlaySoundFile(path..number..".ogg")
	end

	do
		local minVoicePackVersion = 14

		function DBM:CheckVoicePackVersion(value)
			local activeVP = self.Options.ChosenVoicePack2
			--Check if voice pack out of date
			if activeVP ~= "None" and activeVP == value then
				-- User might reselect "missing" entry shown in GUI if previously selected voice pack is uninstalled or disabled
				if self.VoiceVersions[value] then
					voiceSessionDisabled = false
					if self.VoiceVersions[value] < minVoicePackVersion then--Version will be bumped when new voice packs released that contain new voices.
						if self.Options.ShowReminders then
							self:AddMsg(L.VOICE_PACK_OUTDATED)
						end
						SWFilterDisabled = self.VoiceVersions[value]--Set disable to version on current voice pack
					else
						SWFilterDisabled = minVoicePackVersion
					end
				else
					voiceSessionDisabled = true
				end
			end
		end
	end

	function DBM:PlaySpecialWarningSound(soundId, force)
		local sound
		if not force and self:IsTrivial() and self.Options.DontPlayTrivialSpecialWarningSound then
			sound = self.Options.RaidWarningSound
		else
			sound = type(soundId) == "number" and self.Options["SpecialWarningSound" .. (soundId == 1 and "" or soundId)] or soundId or self.Options.SpecialWarningSound
		end
		self:PlaySoundFile(sound, nil, true)
	end

	local function testWarningEnd()
		frame:SetFrameStrata("HIGH")
	end

	function DBM:ShowTestSpecialWarning(_, number, noSound, force) -- text, number, noSound, force
		if moving then
			return
		end
		self:AddSpecialWarning(L.MOVE_SPECIAL_WARNING_TEXT)
		frame:SetFrameStrata("TOOLTIP")
		self:Unschedule(testWarningEnd)
		self:Schedule(self.Options.SpecialWarningDuration2 * 1.3, testWarningEnd)
		if number and not noSound then
			self:PlaySpecialWarningSound(number, force)
		end
		if number then
			if self.Options["SpecialWarningFlash"..number] then
				if not force and self:IsTrivial() and self.Options.DontPlayTrivialSpecialWarningSound then return end--No flash if trivial
				local flashColor = self.Options["SpecialWarningFlashCol"..number]
				local repeatCount = self.Options["SpecialWarningFlashCount"..number] or 1
				self.Flash:Show(flashColor[1], flashColor[2], flashColor[3], self.Options["SpecialWarningFlashDura"..number], self.Options["SpecialWarningFlashAlph"..number], repeatCount-1)
			end
		end
	end
end

--------------------
--  Timer Object  --
--------------------
do
	local timerPrototype = {}
	local mt = {__index = timerPrototype}
	local countvoice1, countvoice2, countvoice3, countvoice4
	local countvoice1max, countvoice2max, countvoice3max, countvoice4max = 5, 5, 5, 5
	local countpath1, countpath2, countpath3, countpath4

	--Merged countdown object for timers with build-in countdown
	function DBM:BuildVoiceCountdownCache()
		countvoice1 = self.Options.CountdownVoice
		countvoice2 = self.Options.CountdownVoice2
		countvoice3 = self.Options.CountdownVoice3
		countvoice4 = self.Options.PullVoice
		for _, count in pairs(DBM:GetCountSounds()) do
			if count.value == countvoice1 then
				countpath1 = count.path
				countvoice1max = count.max
			end
			if count.value == countvoice2 then
				countpath2 = count.path
				countvoice2max = count.max
			end
			if count.value == countvoice3 then
				countpath3 = count.path
				countvoice3max = count.max
			end
			if count.value == countvoice4 then
				countpath4 = count.path
				countvoice4max = count.max
			end
		end
	end

	local function playCountSound(timerId, path, requiresCombat)
		DBM:Debug("playCountSound originated from timer: "..(timerId or "nil").." with path: "..(path or "nil"), 3) -- doubling this here to confirm sound provenance on debug logs
		if requiresCombat and not (InCombatLockdown() or UnitAffectingCombat("player")) then return end
		DBM:PlaySoundFile(path)
	end

	local function playCountdown(timerId, timer, voice, count, requiresCombat)
		if DBM.Options.DontPlayCountdowns then return end
		timer = timer or 10
		count = count or 4
		voice = voice or 1
		if timer <= count then count = floor(timer) end
		if not countpath1 or not countpath2 or not countpath3 then
			DBM:Debug("Voice cache not built at time of playCountdown. On fly caching.", 3)
			DBM:BuildVoiceCountdownCache()
		end
		local maxCount, path
		if type(voice) == "string" then
			maxCount = 5--Safe to assume if it's not one of the built ins, it's likely heroes/OW, which has a max of 5
			path = voice
		elseif voice == 2 then
			maxCount = countvoice2max or 10
			path = countpath2 or "Interface\\AddOns\\DBM-Core\\Sounds\\Kolt\\"
		elseif voice == 3 then
			maxCount = countvoice3max or 5
			path = countpath3 or "Interface\\AddOns\\DBM-Core\\Sounds\\Smooth\\"
		elseif voice == 4 then
			maxCount = countvoice4max or 10
			path = countpath4 or "Interface\\AddOns\\DBM-Core\\Sounds\\Corsica\\"
		else
			maxCount = countvoice1max or 10
			path = countpath1 or "Interface\\AddOns\\DBM-Core\\Sounds\\Corsica\\"
		end
		if not path then--Should not happen but apparently it does somehow
			DBM:Debug("Voice path failed in countdownProtoType:Start.")
			return
		end
		if count == 0 then--If a count of 0 is passed,then it's a "Countout" timer, not "Countdown"
			for i = 1, timer do
				if i < maxCount then
					DBM:Schedule(i, playCountSound, timerId, path..i..".ogg", requiresCombat)
				end
			end
		else
			for i = count, 1, -1 do
				if i <= maxCount then
					DBM:Schedule(timer-i, playCountSound, timerId, path..i..".ogg", requiresCombat)
				end
			end
		end
	end

	--"break" and "pull" timers have custom classifications that are straight forward and not in this table
	local timerTypeSimplification = {
		--All cooldown times, be they approx cd or next exact, or even AI timers, map to "CD"
		["cdcount"] = "cd",
		["cdsource"] = "cd",
		["cdspecial"] = "cd",
		["nextcount"] = "cd",
		["nextsource"] = "cd",
		["nextspecial"] = "cd",
		["var"] = "cd",
		["varcount"] = "cd",
		["varsource"] = "cd",
		["varspecial"] = "cd",
		["ai"] = "cd",
		["adds"] = "cd",
		["addscustom"] = "cd",

		--All nameplate only timers, be they approx or exact or ai cooldowns, or nameplate only cast timers
		--CDs all map to cdnp but cast maps to castnp
		["cdnp"] = "cdnp",
		["cdpnp"] = "cdnp",
		["nextnp"] = "cdnp",
		["nextpnp"] = "cdnp",
		["castpnp"] = "castnp",

		--RPs all map to "warmup"
		["roleplay"] = "warmup",
		["combat"] = "warmup",

		--all stage types will map to "stage"
		["achievement"] = "stage",
		["stagecount"] = "stage",
		["stagecountcycle"] = "stage",
		["stagecontext"] = "stage",
		["stagecontextcount"] = "stage",
		["intermission"] = "stage",
		["intermissioncount"] = "stage",

		--Target Bars such as buff/debuff on another player, on self, or on the boss, RPs all map to "target"
		["targetcount"] = "target",
		["fades"] = "target",--Fades is usually used as a personal target timer. So like debuff on other player is "debuff (targetname)" but on self it's just "debuff fades"

		--All cast bar types map to "cast"
		["active"] = "cast",--Active bars are usually things like Whirlwind is active on the boss, or a channeled cast is being done. so effectively it's for channeled casts, as upposed to regular casts
		["castsource"] = "cast",
		["castcount"] = "cast",
	}

	--Very similar to above but more specific to key replacement and not type replacement, to match BW behavior for unification of WAs
	local waKeyOverrides = {
		["combat"] = "warmup",
		["roleplay"] = "warmup",
		["achievement"] = "stages",
		["stagecount"] = "stages",
		["stagecountcycle"] = "stages",
		["stagecontext"] = "stages",
		["stagecontextcount"] = "stages",
		["intermission"] = "stages",
		["intermissioncount"] = "stages",
	}

	local function isNegativeZero(x)
		return x == 0 and 1/x < 0  -- Only true for -0
	end

	-- Parse variance from timer string (v30.5-40" or "dv30.5-40"), into minimum and maximum timer, and calculated variance duration
	---@param timer string
	---@return number maxTimer, number minTimer, number varianceDuration
	local function parseVarianceFromTimer(timer)
		-- ^(d?v) matches starting character d (optional) or v
		-- (%d+%.?%d*) matches any number of digits with optional decimal
		-- %- matches literal character "-"
		-- (%d+%.?%d*)$ matches any number of digits with optional decimal, at the end of the string
		local minTimer, maxTimer = timer:match("v(%d+%.?%d*)%-(%d+%.?%d*)")
		minTimer, maxTimer = tonumber(minTimer), tonumber(maxTimer)
		if type(minTimer) ~= "number" or type(maxTimer) ~= "number" then
			DBM:Debug("|cffff0000No timers found in the string passed to parseVarianceFromTimer function: "..timer..". Returning zero.|r")
			return 0, 0, 0
			end
		local varianceDuration = maxTimer - minTimer

		return maxTimer, minTimer, varianceDuration  -- maximum possible timer from the variance window, minimum..., variance duration
	end

	local function correctWithVarianceDuration(numberToCorrect, timerBar)
		if not numberToCorrect then
			DBM:Debug("|cffff0000No number passed to correctWithVarianceDuration function.|r")
			return
		end

		if not timerBar then
			DBM:Debug("|cffff0000No timerBar passed to correctWithVarianceDuration function.|r")
			return numberToCorrect
		end

		return timerBar.hasVariance and (numberToCorrect + timerBar.varianceDuration) or numberToCorrect
	end

	function timerPrototype:Start(timer, ...)
		if not self.mod.isDummyMod then--Don't apply following rulesets to pull timers and such
			if DBM.Options.DontShowBossTimers and not self.mod.isTrashMod then return end
			if DBM.Options.DontShowTrashTimers and self.mod.isTrashMod then return end
		end
		local isDelayed = type(timer) == "number" and (isNegativeZero(timer) or timer < 0)
		local hasVariance = type(timer) == "number" and timer > 0 and false or not timer and self.hasVariance -- account for metavariant timers that were fired with a fixed timer start, like timer:Start(10). Does not account for timer:Start(-delay), which is parsed below after variance started timers
		local timerStringWithVariance, maxTimer, minTimer
		if type(timer) == "string" and timer:match("^v%d+%.?%d*-%d+%.?%d*$") then -- catch "timer variance" pattern, expressed like v10.5-20.5
			hasVariance = true
			timerStringWithVariance = timer -- cache timer string
			maxTimer, minTimer = parseVarianceFromTimer(timer) -- use highest possible value as the actual End timer
			timer = DBT.Options.VarianceEnabled and maxTimer or minTimer
			end
		if isDelayed then -- catch metavariant timers with delay, expressed like timer:Start(-delay)
			if self.hasVariance then
				hasVariance = self.hasVariance
				maxTimer, minTimer = parseVarianceFromTimer(self.timerStringWithVariance) -- use highest possible value as the actual End timer
				timerStringWithVariance = ("v%s-%s"):format(minTimer + timer, maxTimer + timer) -- rebuild timer string with delay applied
				timer = (DBT.Options.VarianceEnabled and maxTimer or minTimer) + timer
			end
		end
--		if DBM.Options.DebugMode and self.mod.id ~= "TestMod" then
--			self.keep = hasVariance -- keep variance timers for debug purposes
--		end
		if timer and type(timer) ~= "number" then
			return self:Start(nil, timer, ...) -- first argument is optional!
		end
		local isBarEnabled = not self.option or self.mod.Options[self.option]
		--this segment needs to run regardless of enabled to collect info for callback
		local isCountTimer = false
		if self.type and (self.type == "cdcount" or self.type == "nextcount" or self.type == "stagecount" or self.type == "stagecontextcount" or self.type == "stagecountcycle" or self.type == "intermissioncount" or self.type == "varcount") then
			isCountTimer = true
		end
		local guid, timerCount
		if select("#", ...) > 0 then--If timer has args
			for i = 1, select("#", ...) do
				local v = select(i, ...)
				if DBM:IsNonPlayableGUID(v) then--Then scan them for a mob guid
					guid = v--If found, guid will be passed in DBM_TimerStart callback
				end
				--Not most efficient way to do it, but since it's already being done for guid, it's best not to repeat the work
				if isCountTimer and type(v) == "number" then
					timerCount = v
				end
			end
		end
		timer = timer and ((timer > 0 and timer) or self.timer + timer) or self.timer
		if isCountTimer and not self.allowdouble then--remove previous timer.
			for i = #self.startedTimers, 1, -1 do
--					if DBM.Options.BadTimerAlert or DBM.Options.DebugMode and DBM.Options.DebugLevel > 1 then
					local bar = DBT:GetBar(self.startedTimers[i])
					if bar then
						if mabs(bar.timer) > 0.1 then -- Positive and Negative ("keep") timers. Also shortened time window
							local remaining = ("%.2f"):format(bar.timer)
							local ttext = _G[bar.frame:GetName() .. "BarName"]:GetText() or ""
							ttext = ttext .. "(" .. self.id .. "-" .. (timer or 0) .. ")"
							local deltaFromVarianceMinTimer = ("%.2f"):format(bar.hasVariance and bar.timer - bar.varianceDuration or bar.timer)
							local phaseText = self.mod.vb.phase and " (" .. L.SCENARIO_STAGE:format(self.mod.vb.phase) .. ")" or ""
							if bar.hasVariance then
								if DBM.Options.BadTimerAlert and bar.timer > correctWithVarianceDuration(1, bar) then--If greater than 1 seconds off, report this out of debug mode to all users
									DBM:AddMsg("Timer "..ttext..phaseText.. " refreshed before expired, outside known variance window. Remaining time is : "..remaining.." (until variance minimum timer: "..deltaFromVarianceMinTimer.."). Please report this bug")
									fireEvent("DBM_Debug", "Timer "..ttext..phaseText.. " refreshed before expired, outside known variance window. Remaining time is : "..remaining.." (until variance minimum timer: "..deltaFromVarianceMinTimer.."). Please report this bug", 2)
								elseif bar.timer < -0.1 then -- Would be useful to implement a variance detector, and report outside the known variance, however this would need to happen on a timer after it was refreshed. For the moment, only "keep" arg can achieve this.
									DBM:Debug("Timer "..ttext..phaseText.. " refreshed after zero, outside known variance window. Remaining time is : "..remaining, 2)
								elseif bar.timer > correctWithVarianceDuration(0.1, bar) then
									DBM:Debug("Timer "..ttext..phaseText.. " refreshed before expired. Remaining time is : "..remaining.." (until variance minimum timer: "..deltaFromVarianceMinTimer..")", 2)
								end
							else -- duplicated code, should be refactored
								if DBM.Options.BadTimerAlert and bar.timer > 1 then--If greater than 1 seconds off, report this out of debug mode to all users
									DBM:AddMsg("Timer "..ttext..phaseText.. " refreshed before expired. Remaining time is : "..remaining..". Please report this bug")
									fireEvent("DBM_Debug", "Timer "..ttext..phaseText.. " refreshed before expired. Remaining time is : "..remaining..". Please report this bug", 2)
								elseif bar.timer < -5 then -- arbitrary threshold
									DBM:Debug("Timer "..ttext..phaseText.. " refreshed after zero. Remaining time is : "..remaining, 2)
								elseif bar.timer > 0.1 then
									DBM:Debug("Timer "..ttext..phaseText.. " refreshed before expired. Remaining time is : "..remaining, 2)
								end
							end
						end
					end
--					end
				DBT:CancelBar(self.startedTimers[i])
				fireEvent("DBM_TimerStop", self.startedTimers[i])
				tremove(self.startedTimers, i)
			end
		end
		local id = self.id .. pformat((("\t%s"):rep(select("#", ...))), ...)
		--AI timer api:
		--Starting ai timer with (1) indicates it's a first timer after pull
		--Starting timer with (2) or (3) indicates it's a stage 2 or stage 3 first timer
		--Starting AI timer with anything above 3 indicarets it's a regular timer and to use shortest time in between two regular casts
		if self.type == "ai" then--A learning timer
			if not DBM.Options.AITimer then return end
			if timer > 5 then--Normal behavior.
				local newPhase = false
				for i = 1, 5 do
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
					if timeLastCast > 5 then--Prevent infinite loop cpu hang. Plus anything shorter than 5 seconds doesn't need a timer
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
				if self["phase" .. timer .. "CastTimer"] and type(self["phase" .. timer .. "CastTimer"]) == "number" then
					--Check if timer is shorter than previous learned first timer by scanning remaining time on existing bar
					local bar = DBT:GetBar(id)
					if bar then
						local remaining = ("%.1f"):format(bar.timer)
						if bar.timer > 0.1 then -- Shortened time window
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
		--This should only run if bar is actually enabled, else we don't have a previous bar to compare it to anyways
		if isBarEnabled --[[and DBM.Options.BadTimerAlert or DBM.Options.DebugMode and DBM.Options.DebugLevel > 1]] then
			if not self.type or (self.type ~= "target" and self.type ~= "active" and self.type ~= "fades" and self.type ~= "ai") and not self.allowdouble then
				local bar = DBT:GetBar(id)
				if bar then
					if mabs(bar.timer) > 0.1 then -- Positive and Negative ("keep") timers. Also shortened time window
						local remaining = ("%.2f"):format(bar.timer)
						local deltaFromVarianceMinTimer = ("%.2f"):format(bar.hasVariance and bar.timer - bar.varianceDuration or bar.timer)
						local ttext = _G[bar.frame:GetName() .. "BarName"]:GetText() or ""
						ttext = ttext .. "(" .. self.id .. "-" .. (timer or 0) .. ")"
						local phaseText = self.mod.vb.phase and " (" .. L.SCENARIO_STAGE:format(self.mod.vb.phase) .. ")" or ""
						if bar.hasVariance then
							if DBM.Options.BadTimerAlert and bar.timer > correctWithVarianceDuration(1, bar) then--If greater than 1 seconds off, report this out of debug mode to all users
								DBM:AddMsg("Timer "..ttext..phaseText.. " refreshed before expired, outside known variance window. Remaining time is : "..remaining.." (until variance minimum timer: "..deltaFromVarianceMinTimer.."). Please report this bug")
								fireEvent("DBM_Debug", "Timer "..ttext..phaseText.. " refreshed before expired, outside known variance window. Remaining time is : "..remaining.." (until variance minimum timer: "..deltaFromVarianceMinTimer.."). Please report this bug", 2)
							elseif bar.timer < -0.1 then -- Would be useful to implement a variance detector, and report outside the known variance, however this would need to happen on a timer after it was refreshed. For the moment, only "keep" arg can achieve this.
								DBM:Debug("Timer "..ttext..phaseText.. " refreshed after zero, outside known variance window. Remaining time is : "..remaining, 2)
							elseif bar.timer > correctWithVarianceDuration(0.1, bar) then
								DBM:Debug("Timer "..ttext..phaseText.. " refreshed before expired. Remaining time is : "..remaining.." (until variance minimum timer: "..deltaFromVarianceMinTimer..")", 2)
							end
						else -- duplicated code, should be refactored
							if DBM.Options.BadTimerAlert and bar.timer > 1 then--If greater than 1 seconds off, report this out of debug mode to all users
								DBM:AddMsg("Timer "..ttext..phaseText.. " refreshed before expired. Remaining time is : "..remaining..". Please report this bug")
								fireEvent("DBM_Debug", "Timer "..ttext..phaseText.. " refreshed before expired. Remaining time is : "..remaining..". Please report this bug", 2)
							elseif bar.timer < -5 then -- arbitrary threshold
								DBM:Debug("Timer "..ttext..phaseText.. " refreshed after zero. Remaining time is : "..remaining, 2)
							elseif bar.timer > 0.1 then
								DBM:Debug("Timer "..ttext..phaseText.. " refreshed before expired. Remaining time is : "..remaining, 2)
							end
						end
					end
				end
			end
		end
		local colorId
		if self.option then
			colorId = self.mod.Options[self.option .. "TColor"]
		elseif self.colorType and type(self.colorType) == "string" then--No option for specific timer, but another bool option given that tells us where to look for TColor (for mods such as trio boss for valentines day in events mods)
			colorId = self.mod.Options[self.colorType .. "TColor"]
		else--No option, or secondary option, set colorId to hardcoded color type
			colorId = self.colorType or 0
		end
		local bar
		--Bar and countdown construction should only actually occur if enabled
		if isBarEnabled then
			local countVoice, countVoiceMax = 0, self.countdownMax or 4
			if self.option then
				countVoice = self.mod.Options[self.option .. "CVoice"]
				if not self.fade and (type(countVoice) == "string" or countVoice > 0) then--Started without faded and has count voice assigned
					DBM:Unschedule(playCountSound, id) -- Prevents count sound if timer is started again before timer expires
					-- minTimer checks for the minimum possible timer in the variance timer string sent from Start method, self.minTimer is from newTimer constructor. Else, use timer value
					playCountdown(id, minTimer or (hasVariance and self.minTimer) or timer, countVoice, countVoiceMax, self.requiresCombat)--timerId, timer, voice, count
				end
			end
			-- timerStringWithVariance checks for timer string sent from Start method, self.timerStringWithVariance is from newTimer constructor. Else, use timer value
			bar = DBT:CreateBar(timerStringWithVariance or (hasVariance and self.timerStringWithVariance) or timer, id, self.icon, nil, nil, nil, nil, colorId, nil, self.keep, self.fade, countVoice, countVoiceMax, self.simpType == "cd" or self.simpType == "cdnp")
			if not bar then
				return false, "error" -- creating the timer failed somehow, maybe hit the hard-coded timer limit of 15
			end
		end
		local msg
		if self.type and not self.text then
			msg = pformat(self.mod:GetLocalizedTimerText(self.type, self.spellId, self.name), ...)
		else
			if type(self.text) == "number" then--spellId passed in timer text, it's a timer with short text
				msg = pformat(self.mod:GetLocalizedTimerText(self.type, self.text, self.name), ...)
			else
				msg = pformat(self.text, ...)
			end
		end
		msg = msg:gsub(">.-<", stripServerName)
		if bar then
			bar:SetText(msg, self.inlineIcon)
		end
		--ID (string) Internal DBM timer ID
		--msg (string) Timer Text (Do not use msg has an event trigger, it varies language to language or based on user timer options. Use this to DISPLAY only (such as timer replacement UI). use spellId field 99% of time
		--timer (number) Raw timer value. Will return lowest number in variance timers (like DBM has always done, earliest an ability comes off CD is expected behavior for weak auras)
		--Icon (string or number): Texture Path for Icon
		--simpleType (string): Timer type, which is one of only 7 possible types: "cd" for coolodwns, "target" for target bars such as debuff on a player, "stage" for any kind of stage timer (stage ends, next stage, or even just a warmup timer like "fight begins"), and then "cast" timer which is used for both a regular cast and a channeled cast (ie boss is casting frostbolt, or boss is channeling whirlwind). Lastly, break, pull, and berserk timers are "breaK", "pull", and "berserk" respectively
		--spellId (string or number): Raw spellid if available (most timers will have spellId or EJ ID unless it's a specific timer not tied to ability such as pull or combat start or rez timers. EJ id will be in format ej%d
		--colorID (number): Type classification (1-Add, 2-Aoe, 3-targeted ability, 4-Interrupt, 5-Role, 6-Stage, 7-User(custom))
		--Mod ID (string or number): Encounter ID as string, or a generic string for mods that don't have encounter ID (such as trash, dummy/test mods)
		--Keep (true or nil), whether or not to keep bar on screen when it expires (if true, timer should be retained until an actual TimerStop occurs or a new TimerStart with same barId happens (in which case you replace bar with new one)
		--fade (true or nil), whether or not to fade a bar (set alpha to usersetting/2)
		--spellName (string) Sent so users can use a spell name instead of spellId, if they choose. Mostly to be more classic wow friendly, spellID is still preferred method (even for classic)
		--MobGUID (string) if it could be parsed out of args
		--timerCount (number) if current timer is a count timer. Returns number (count value) needed to have weak auras that trigger off a specific timer count without using localized message text
		--isPriority: If true, this ability has been flagged as extra important. Can be used for weak auras or nameplate addons to add extra emphasis onto specific timer like a glow
		--fullType (the true type of timer, for those who really want to filter timers by DBM classifications such as "adds" or "interrupt")
		--hasVariance (true or nil) if timer has variance.
		--variancePeaktimer (number) if timer has variance, this is the peak timer in the variance window, otherwise nil
		--isEnabled (true or nil) if timer is enabled

		--Mods that have specifically flagged that it's safe to assume all timers from that boss mod belong to boss1
		--This check is performed secondary to args scan so that no adds guids are overwritten
		--NOTE: Begin fires regardless of enabled status, and includes additional enabled flag. Start only fires if option is enabled (old behavior)
		if not guid and self.mod.sendMainBossGUID and not DBM.Options.DontSendBossGUIDs and (self.type == "cd" or self.type == "next" or self.type == "cdcount" or self.type == "nextcount" or self.type == "cdspecial" or self.type == "ai") then--Variance excluded for now while NP timers don't support yet
			guid = UnitGUID("boss1")
		end
		if self.simpType and (self.simpType == "cdnp" or self.simpType == "castnp") then--Only send nampelate callback
			fireEvent("DBM_NameplateBegin", id, msg, minTimer or (hasVariance and self.minTimer) or timer, self.icon, self.simpType, self.waSpecialKey or self.spellId, colorId, self.mod.id, (self.simpType == "cdnp" and DBM.Options.AlwaysKeepNPs) and true or self.keep, self.fade, self.name, guid, timerCount, self.isPriority, self.type, hasVariance, hasVariance and timer, isBarEnabled)
			if isBarEnabled then
				fireEvent("DBM_NameplateStart", id, msg, minTimer or (hasVariance and self.minTimer) or timer, self.icon, self.simpType, self.waSpecialKey or self.spellId, colorId, self.mod.id, (self.simpType == "cdnp" and DBM.Options.AlwaysKeepNPs) and true or self.keep, self.fade, self.name, guid, timerCount, self.isPriority, self.type, hasVariance, hasVariance and timer)
			end
		else--Send both callbacks
			fireEvent("DBM_TimerBegin", id, msg, minTimer or (hasVariance and self.minTimer) or timer, self.icon, self.simpType, self.waSpecialKey or self.spellId, colorId, self.mod.id, self.keep, self.fade, self.name, guid, timerCount, self.isPriority, self.type, hasVariance, hasVariance and timer, isBarEnabled)
			if isBarEnabled then
				fireEvent("DBM_TimerStart", id, msg, minTimer or (hasVariance and self.minTimer) or timer, self.icon, self.simpType, self.waSpecialKey or self.spellId, colorId, self.mod.id, self.keep, self.fade, self.name, guid, timerCount, self.isPriority, self.type, hasVariance, hasVariance and timer, isBarEnabled)
			end
			if guid then--But nameplate is only sent if actual GUID
				fireEvent("DBM_NameplateBegin", id, msg, minTimer or (hasVariance and self.minTimer) or timer, self.icon, self.simpType, self.waSpecialKey or self.spellId, colorId, self.mod.id, self.keep, self.fade, self.name, guid, timerCount, self.isPriority, self.type, hasVariance, hasVariance and timer, isBarEnabled)
				if isBarEnabled then
					fireEvent("DBM_NameplateStart", id, msg, minTimer or (hasVariance and self.minTimer) or timer, self.icon, self.simpType, self.waSpecialKey or self.spellId, colorId, self.mod.id, self.keep, self.fade, self.name, guid, timerCount, self.isPriority, self.type, hasVariance, hasVariance and timer)
				end
			end
		end
		local nameplateAborted
		if isBarEnabled then
			--Basically tops bar from starting if it's being put on a plater nameplate, to give plater users option to have nameplate CDs without actually using the bars
			--This filter will only apply to trash mods though, boss timers will always be shown due to need to have them exist for Pause, Resume, Update, and GetTime/GetRemaining methods
			if guid and DBM.Options.DontShowTimersWithNameplates and Plater and Plater.db.profile.bossmod_support_bars_enabled and self.mod.isTrashMod then
				DBT:CancelBar(id)--Cancel bar without stop callback
				nameplateAborted = true
			end
		end
		--We still want to store timer references in started timers even if we didn't actually start them, so they can be tracked and stoped accordingly
		if not tContains(self.startedTimers, id) then--Make sure timer doesn't exist already before adding it
			tinsert(self.startedTimers, id)
		end
		self.mod:Unschedule(removeEntry, self.startedTimers, id)
		if not self.keep then--Don't ever remove startedTimers on a schedule, if it's a keep timer
			self.mod:Schedule(timer, removeEntry, self.startedTimers, id)
		end
		if bar and not nameplateAborted then
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
			local bar = DBT:GetBar(id)
			if bar and not bar.fade then
				fireEvent("DBM_TimerFadeUpdate", id, self.spellId, self.mod.id, true, self.name)--Timer ID, spellId, modId, true/nil, spellName (new callback only needed if we update an existing timers fade, self.fade is passed in timer start object for new timers)
				bar.fade = true--Set bar object metatable, which is copied from timer metatable at bar start only
				bar:ApplyStyle()
				DBM:Unschedule(playCountSound, id)--Don't even need to check option, it's faster cpu wise to just unschedule countdown either way
			end
		elseif not fadeOn and self.fade then
			self.fade = nil--set timer object metatable, which will make sure next bar started does NOT use fade
			--Find and Update an existing bar that's already started
			local id = self.id..pformat((("\t%s"):rep(select("#", ...))), ...)
			local bar = DBT:GetBar(id)
			if bar and bar.fade then
				fireEvent("DBM_TimerFadeUpdate", id, self.spellId, self.mod.id, nil, self.name)--Timer ID, spellId, modId, true/nil, spellName (new callback only needed if we update an existing timers fade, self.fade is passed in timer start object for new timers)
				bar.fade = nil--Set bar object metatable, which is copied from timer metatable at bar start only
				bar:ApplyStyle()
				if self.option then
					local countVoice = self.mod.Options[self.option .. "CVoice"] or 0
					if (type(countVoice) == "string" or countVoice > 0) then--Unfading bar, start countdown
						DBM:Unschedule(playCountSound, id)
						playCountdown(id, bar.timer, countVoice, bar.countdownMax, bar.requiresCombat)--timerId, timer, voice, count
						DBM:Debug("Re-enabling a countdown on bar ID: "..id.." after a SetFade disable call")
					end
				end
			end
		end
	end

	--This version does NOT set timer object meta, only started bar meta
	--Use this if you only want to alter an already STARTED temporarily
	--As such it also only needs fadeOn. fadeoff isn't needed since this temp alter never affects newly started bars
	function timerPrototype:SetSTFade(fadeOn, ...)
		local id = self.id..pformat((("\t%s"):rep(select("#", ...))), ...)
		local bar = DBT:GetBar(id)
		if bar then
			if fadeOn and not bar.fade then
				fireEvent("DBM_TimerFadeUpdate", id, self.spellId, self.mod.id, true, self.name)--Timer ID, spellId, modId, true/nil, spellName (new callback only needed if we update an existing timers fade, self.fade is passed in timer start object for new timers)
				bar.fade = true--Set bar object metatable, which is copied from timer metatable at bar start only
				bar:ApplyStyle()
				DBM:Unschedule(playCountSound, id)
			elseif not fadeOn and bar.fade then
				fireEvent("DBM_TimerFadeUpdate", id, self.spellId, self.mod.id, nil, self.name)
				bar.fade = false
				bar:ApplyStyle()
				if self.option then
					local countVoice = self.mod.Options[self.option .. "CVoice"] or 0
					if (type(countVoice) == "string" or countVoice > 0) then--Unfading bar, start countdown
						DBM:Unschedule(playCountSound, id)
						playCountdown(id, bar.timer, countVoice, bar.countdownMax)--timerId, timer, voice, count
						DBM:Debug("Re-enabling a countdown on bar ID: "..id.." after a SetSTFade disable call")
					end
				end
			end
		end
	end

	function timerPrototype:SetSTKeep(keepOn, ...)
		local id = self.id..pformat((("\t%s"):rep(select("#", ...))), ...)
		local bar = DBT:GetBar(id)
		if bar then
			if keepOn and not bar.keep then
				bar.keep = true--Set bar object metatable, which is copied from timer metatable at bar start only
				bar:ApplyStyle()
			elseif not keepOn and bar.keep then
				fireEvent("DBM_TimerFadeUpdate", id, self.spellId, self.mod.id, nil)
				bar.keep = false
				bar:ApplyStyle()
			end
		end
	end

	function timerPrototype:DelayedStart(delay, ...)
		DBMScheduler:Unschedule(self.Start, self.mod, self, ...)
		DBMScheduler:Schedule(delay or 0.5, self.Start, self.mod, self, ...)
	end
	timerPrototype.DelayedShow = timerPrototype.DelayedStart

	function timerPrototype:Schedule(t, ...)
		return DBMScheduler:Schedule(t, self.Start, self.mod, self, ...)
	end

	function timerPrototype:Unschedule(...)
		return DBMScheduler:Unschedule(self.Start, self.mod, self, ...)
	end

	--TODO, figure out why this function doesn't properly stop count timers when calling stop without count on count timers
	function timerPrototype:Stop(...)
		if select("#", ...) == 0 then
			for i = #self.startedTimers, 1, -1 do
				fireEvent("DBM_TimerStop", self.startedTimers[i])
				DBT:CancelBar(self.startedTimers[i])
				DBM:Unschedule(playCountSound, self.startedTimers[i])--Unschedule countdown by timerId
				DBM:Unschedule(removeEntry, self.startedTimers, self.startedTimers[i])
				tremove(self.startedTimers, i)
			end
		else
			local id = self.id..pformat((("\t%s"):rep(select("#", ...))), ...)
			for i = #self.startedTimers, 1, -1 do
				if self.startedTimers[i] == id then
					local guid
					for j = 1, select("#", ...) do
						local v = select(j, ...)
						if DBM:IsNonPlayableGUID(v) then--Then scan them for a mob guid
							guid = v--If found, guid will be passed in DBM_TimerStart callback
						end
					end
					fireEvent("DBM_TimerStop", id, guid)
					DBT:CancelBar(id)
					DBM:Unschedule(playCountSound, id)--Unschedule countdown by timerId
					DBM:Unschedule(removeEntry, self.startedTimers, self.startedTimers[i])
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

	--In past boss mods have always had to manually call Stop just to restart a timer, to avoid triggering false debug messages
	--This function should simplify boss mod creation by allowing you to "Restart" a timer with one call in mod instead of 2
	function timerPrototype:Restart(timer, ...)
		if self.type and (self.type == "cdcount" or self.type == "nextcount") and not self.allowdouble then
			self:Stop()--Cleanup any count timers left over on a restart
		else
			self:Stop(...)
		end
		self:Unschedule(...)--Also unschedules not yet started timers that used timer:Schedule()
		self:Start(timer, ...)
	end
	timerPrototype.Reboot = timerPrototype.Restart

	function timerPrototype:Cancel(...)
		self:Stop(...)
		self:Unschedule(...)--Also unschedules not yet started timers that used timer:Schedule()
	end

	function timerPrototype:GetTime(...)
		local id = self.id..pformat((("\t%s"):rep(select("#", ...))), ...)
		local bar = DBT:GetBar(id)
		return bar and (bar.totalTime - bar.timer) or 0, (bar and bar.totalTime) or 0
	end

	function timerPrototype:GetRemaining(...)
		local id = self.id..pformat((("\t%s"):rep(select("#", ...))), ...)
		local bar = DBT:GetBar(id)
		return bar and bar.timer or 0
	end

	function timerPrototype:Time(...)
		local id = self.id..pformat((("\t%s"):rep(select("#", ...))), ...)
		local bar = DBT:GetBar(id)
		return bar.totalTime or 0
	end

	function timerPrototype:IsStarted(...)
		local id = self.id..pformat((("\t%s"):rep(select("#", ...))), ...)
		local bar = DBT:GetBar(id)
		return bar and true
	end

	function timerPrototype:SetTimer(timer)
		self.timer = timer
	end

	function timerPrototype:Update(elapsed, totalTime, ...)
		if DBM.Options.DontShowBossTimers and not self.mod.isTrashMod then return end
		if DBM.Options.DontShowTrashTimers and self.mod.isTrashMod then return end
		if self:GetTime(...) == 0 then
			self:Start(totalTime, ...)
		end
		local id = self.id..pformat((("\t%s"):rep(select("#", ...))), ...)
		local bar = DBT:GetBar(id)
		fireEvent("DBM_TimerUpdate", id, elapsed, totalTime)
		if bar then
			local newRemaining = totalTime-elapsed
			self.mod:Unschedule(removeEntry, self.startedTimers, id)
			if not bar.keep and newRemaining > 0 then
				--Correct table for tracked timer objects for adjusted time, or else timers may get stuck if stop is called on them
				self.mod:Schedule(newRemaining, removeEntry, self.startedTimers, id)
			end
			if self.option then
				local countVoice = self.mod.Options[self.option .. "CVoice"] or 0
				if (type(countVoice) == "string" or countVoice > 0) then
					DBM:Unschedule(playCountSound, id)
					if not bar.fade then--Don't start countdown voice if it's faded bar
						if newRemaining > 2 then
							playCountdown(id, newRemaining, countVoice, bar.countdownMax, bar.requiresCombat)--timerId, timer, voice, count
							DBM:Debug("Updating a countdown after a timer Update call for timer ID:"..id)
						end
					end
				end
			end
		end
		return DBT:UpdateBar(id, elapsed, totalTime)
	end

	function timerPrototype:AddTime(extendAmount, ...)
		if DBM.Options.DontShowBossTimers and not self.mod.isTrashMod then return end
		if DBM.Options.DontShowTrashTimers and self.mod.isTrashMod then return end
		if self:GetTime(...) == 0 then
			return self:Start(extendAmount, ...)
		else
			local id = self.id..pformat((("\t%s"):rep(select("#", ...))), ...)
			local bar = DBT:GetBar(id)
			if bar then
				local elapsed, total = (bar.totalTime - bar.timer), bar.totalTime
				if elapsed and total then
					local newRemaining = (total + extendAmount) - elapsed
					self.mod:Unschedule(removeEntry, self.startedTimers, id)
					if not bar.keep then
					--Correct table for tracked timer objects for adjusted time, or else timers may get stuck if stop is called on them
						self.mod:Schedule(newRemaining, removeEntry, self.startedTimers, id)
					end
					if self.option then
						local countVoice = self.mod.Options[self.option .. "CVoice"] or 0
						if (type(countVoice) == "string" or countVoice > 0) then
							DBM:Unschedule(playCountSound, id)
							if not bar.fade then--Don't start countdown voice if it's faded bar
								playCountdown(id, newRemaining, countVoice, bar.countdownMax, bar.requiresCombat)--timerId, timer, voice, count
								DBM:Debug("Updating a countdown after a timer AddTime call for timer ID:"..id)
							end
						end
					end
					fireEvent("DBM_TimerUpdate", id, elapsed, total+extendAmount)
					return DBT:UpdateBar(id, elapsed, total+extendAmount)
				end
			end
		end
	end

	function timerPrototype:RemoveTime(reduceAmount, ...)
		if DBM.Options.DontShowBossTimers and not self.mod.isTrashMod then return end
		if DBM.Options.DontShowTrashTimers and self.mod.isTrashMod then return end
		if self:GetTime(...) == 0 then
			return--Do nothing
		else
			local id = self.id..pformat((("\t%s"):rep(select("#", ...))), ...)
			local bar = DBT:GetBar(id)
			if bar then
				self.mod:Unschedule(removeEntry, self.startedTimers, id)--Needs to be unscheduled here, or the entry might just get left in table until original expire time, if new expire time is less than 0
				DBM:Unschedule(playCountSound, id)--Needs to be unscheduled here,or countdown might not be canceled if removing time made it cease to have a > 0 value
				local elapsed, total = (bar.totalTime - bar.timer), bar.totalTime
				if elapsed and total then
					local newRemaining = (total-reduceAmount) - elapsed
					if newRemaining > 0 then
						--Correct table for tracked timer objects for adjusted time, or else timers may get stuck if stop is called on them
						if not bar.keep then
							self.mod:Schedule(newRemaining, removeEntry, self.startedTimers, id)
						end
						if self.option and newRemaining > 2 then
							local countVoice = self.mod.Options[self.option .. "CVoice"] or 0
							if (type(countVoice) == "string" or countVoice > 0) then
								if not bar.fade then--Don't start countdown voice if it's faded bar
									if newRemaining > 2 then
										playCountdown(id, newRemaining, countVoice, bar.countdownMax, bar.requiresCombat)--timerId, timer, voice, count
										DBM:Debug("Updating a countdown after a timer RemoveTime call for timer ID:"..id)
									end
								end
							end
						end
						fireEvent("DBM_TimerUpdate", id, elapsed, total-reduceAmount)
						return DBT:UpdateBar(id, elapsed, total-reduceAmount)
					else--New remaining less than 0
						fireEvent("DBM_TimerStop", id)
						return DBT:CancelBar(id)
					end
				end
			end
		end
	end

	function timerPrototype:Pause(...)
		local id = self.id..pformat((("\t%s"):rep(select("#", ...))), ...)
		local bar = DBT:GetBar(id)
		if bar then
			DBM:Unschedule(playCountSound, id)--Kill countdown on pause
			self.mod:Unschedule(removeEntry, self.startedTimers, id)--Prevent removal from startedTimers table while bar is paused
			fireEvent("DBM_TimerPause", id)
			return bar:Pause()
		end
	end

	function timerPrototype:Resume(...)
		local id = self.id .. pformat((("\t%s"):rep(select("#", ...))), ...)
		local bar = DBT:GetBar(id)
		if bar then
			local elapsed, total = (bar.totalTime - bar.timer), bar.totalTime
			if elapsed and total then
				local remaining = total - elapsed
				if not bar.keep then
					self.mod:Schedule(remaining, removeEntry, self.startedTimers, id)--Re-schedule the auto remove entry stuff
				end
				--Have to check if paused bar had a countdown on resume so we can restore it
				if self.option and not bar.fade then
					local countVoice = self.mod.Options[self.option .. "CVoice"] or 0
					if (type(countVoice) == "string" or countVoice > 0) then
						playCountdown(id, remaining, countVoice, bar.countdownMax, bar.requiresCombat)--timerId, timer, voice, count
						DBM:Debug("Updating a countdown after a timer Resume call for timer ID:"..id)
					end
				end
			end
			fireEvent("DBM_TimerResume", id)
			return bar:Resume()
		end
	end

	function timerPrototype:UpdateIcon(icon, ...)
		local id = self.id..pformat((("\t%s"):rep(select("#", ...))), ...)
		local bar = DBT:GetBar(id)
		if bar then
			return bar:SetIcon((type(icon) == "number" and ( icon <=8 and (iconFolder .. icon) or select(3, GetSpellInfo(icon)))) or icon or "Interface\\Icons\\Spell_Nature_WispSplode")
		end
	end

	function timerPrototype:UpdateInline(newInline, ...)
		local id = self.id..pformat((("\t%s"):rep(select("#", ...))), ...)
		local bar = DBT:GetBar(id)
		if bar then
			local ttext = _G[bar.frame:GetName().."BarName"]:GetText() or ""
			return bar:SetText(ttext, newInline or self.inlineIcon)
		end
	end

	function timerPrototype:UpdateName(name, ...)
		local id = self.id..pformat((("\t%s"):rep(select("#", ...))), ...)
		local bar = DBT:GetBar(id)
		if bar then
			return bar:SetText(name, self.inlineIcon)
		end
	end

	function timerPrototype:SetColor(c, ...)
		local id = self.id..pformat((("\t%s"):rep(select("#", ...))), ...)
		local bar = DBT:GetBar(id)
		if bar then
			return bar:SetColor(c)
		end
	end

	function timerPrototype:DisableEnlarge(...)
		local id = self.id..pformat((("\t%s"):rep(select("#", ...))), ...)
		local bar = DBT:GetBar(id)
		if bar then
			bar.small = true
		end
	end

	function timerPrototype:AddOption(optionDefault, optionName, colorType, countdown, spellId, optionType)
		if optionName ~= false then
			self.option = optionName or self.id
			self.mod:AddBoolOption(self.option, optionDefault, "timer", nil, colorType, countdown, spellId, optionType)
		end
	end

	--If a new countdown default is added to a NewTimer object, change optionName of timer to reset a new default
	function bossModPrototype:NewTimer(timer, name, texture, optionDefault, optionName, colorType, inlineIcon, keep, countdown, countdownMax, r, g, b, spellId, requiresCombat, waCustomName, customType, isPriority)
		if r and type(r) == "string" then
			DBM:Debug("|cffff0000r probably has inline icon in it and needs to be fixed for |r" .. name .. r)
			r = nil--Fix it for users
		end
		if inlineIcon and type(inlineIcon) == "number" then
			DBM:Debug("|cffff0000spellID texture path or colorType is in inlineIcon field and needs to be fixed for |r" .. name .. inlineIcon)
			inlineIcon = nil--Fix it for users
		end
		local hasVariance, timerStringWithVariance, minTimer, varianceDuration
		if type(timer) == "string" then
			if timer:match("^v%d+%.?%d*%-%d+%.?%d*$") then -- parse variance, e.g. "v20.5-25.5"
				hasVariance = true
				timerStringWithVariance = timer
				timer, minTimer, varianceDuration = parseVarianceFromTimer(timer)
			end
		end
		local icon = type(texture) == "number" and ( texture <=8 and (iconFolder .. texture) or select(3, GetSpellInfo(texture))) or texture or "Interface\\Icons\\Spell_Nature_WispSplode"
		local waSpecialKey, simpType
		if customType then
			simpType = timerTypeSimplification[customType] or customType
			waSpecialKey = waKeyOverrides[customType]
		end
		local obj = setmetatable(
			{
				objClass = "Timer",
				text = self.localization.timers[name],
				type = customType or "cd",--Auto assign
				simpType = simpType or "cd",
				waSpecialKey = waSpecialKey,
				spellId = spellId,--Allows Localized timer text to still have a spellId arg weak auras can latch onto
				timer = timer,
				id = name,
				icon = icon,
				colorType = colorType or 0,
				inlineIcon = inlineIcon,
				keep = keep,
				countdown = countdown,
				countdownMax = countdownMax,
				r = r,
				g = g,
				b = b,
				requiresCombat = requiresCombat,
				hasVariance = hasVariance,
				minTimer = minTimer,
				timerStringWithVariance = timerStringWithVariance,
				varianceDuration = varianceDuration,
				startedTimers = {},
				mod = self,
				startLarge = nil,
				isPriority = isPriority,
			},
			mt
		)
		obj:AddOption(optionDefault, optionName, colorType, countdown, spellId, nil, waCustomName)
		tinsert(self.timers, obj)
		return obj
	end

	-- new constructor for the new auto-localized timer types
	-- note that the function might look unclear because it needs to handle different timer types, especially achievement timers need special treatment
	-- If a new countdown is added to an existing timer that didn't have one before, use optionName (number) to force timer to reset defaults by assigning it a new variable
	local function newTimer(self, timerType, timer, spellId, timerText, optionDefault, optionName, colorType, texture, inlineIcon, keep, countdown, countdownMax, r, g, b, requiresCombat, isPriority)
		if type(timer) == "string" and timer:match("OptionVersion") then
			DBM:Debug("|cffff0000OptionVersion hack depricated, remove it from: |r"..spellId)
			return
		end
		if type(colorType) == "number" and colorType > 7 then
			DBM:Debug("|cffff0000texture is in the colorType arg for: |r"..spellId)
		end
		--Use option optionName for optionVersion as well, no reason to split.
		--This ensures that remaining arg positions match for auto generated and regular NewTimer
		local optionVersion
		if type(optionName) == "number" then
			optionVersion = optionName
			optionName = nil
		end
		local allowdouble, hasVariance, timerStringWithVariance, minTimer, varianceDuration, timerStringVarianceGUI
		if type(timer) == "string" then
			if timer:match("d%d+") then -- parse doubling timers, e.g. "d20"
				allowdouble = true
				timer = tonumber(string.sub(timer, 2))
			elseif timer:match("^v%d+%.?%d*%-%d+%.?%d*$") then -- parse variance, e.g. "v20.5-25.5"
				hasVariance = true
				timerStringWithVariance = timer
				timer, minTimer, varianceDuration = parseVarianceFromTimer(timer)
				timerStringVarianceGUI = ("%s-%s"):format(minTimer, timer)
			elseif timer:match("dv%d+%.?%d*%-%d+%.?%d*$") then -- parse doubling and variance, e.g. "dv20.5-25.5"
				allowdouble = true
				hasVariance = true
				timerStringWithVariance = timer
				timer, minTimer, varianceDuration = parseVarianceFromTimer(timer)
				timerStringVarianceGUI = ("%s-%s"):format(minTimer, timer)
			else
				error("bad string timer, expected number or string starting with d, v, or dv", 2)
			end
		end
		local spellName, icon
		local unparsedId = spellId
		if timerType == "achievement" then
			spellName = select(2, GetAchievementInfo(spellId))
			icon = type(texture) == "number" and select(10, GetAchievementInfo(texture)) or texture or spellId and select(10, GetAchievementInfo(spellId))
		elseif timerType == "cdspecial" or timerType == "nextspecial" or timerType == "stage" or timerType == "stagecount" or timerType == "stagecountcycle" or timerType == "stagecontext" or timerType == "stagecontextcount" or timerType == "intermission" or timerType == "intermissioncount" then
			icon = type(texture) == "number" and select(3, GetSpellInfo(texture)) or texture or (type(spellId) == "number" and select(3, GetSpellInfo(spellId))) or "Interface\\Icons\\Spell_Nature_WispSplode"
			if timerType == "stage" or timerType == "stagecount" or timerType == "stagecountcycle" or timerType == "stagecontext" or timerType == "stagecontextcount" or timerType == "intermission" or timerType == "intermissioncount" then
				colorType = 6
			end
		elseif timerType == "roleplay" then
			icon = type(texture) == "number" and select(3, GetSpellInfo(texture)) or texture or (type(spellId) == "number" and select(3, GetSpellInfo(spellId))) or "Interface\\Icons\\SPELL_HOLY_BORROWEDTIME"
			colorType = 6
		elseif timerType == "adds" or timerType == "addscustom" then
			icon = type(texture) == "number" and select(3, GetSpellInfo(texture)) or texture or (type(spellId) == "number" and select(3, GetSpellInfo(spellId))) or "Interface\\Icons\\Spell_Nature_WispSplode"
			colorType = 1
		else
			spellName = DBM:GetSpellInfo(spellId or 0)
			if spellName then
				icon = type(texture) == "number" and ( texture <=8 and (iconFolder .. texture) or select(3, GetSpellInfo(texture))) or texture or spellId and select(3, GetSpellInfo(spellId))
			else
				icon = nil
			end
		end
		spellName = spellName or tostring(spellId)
		local timerTextValue
		if timerText then
			--If timertext is a number, accept it as a secondary auto translate spellid
			if DBM.Options.ShortTimerText and type(timerText) == "number" then
				timerTextValue = timerText
				spellName = DBM:GetSpellInfo(timerText or 0)--Override Cached spell Name
			else
				timerTextValue = self.localization.timers[timerText] or timerText--Check timers table first, otherwise accept it as literal timer text
			end
		end
		local id = "Timer" .. (spellId or 0) .. timerType .. (optionVersion or "")
		local simpType = timerTypeSimplification[timerType] or timerType
		local waSpecialKey = waKeyOverrides[timerType]
		local obj = setmetatable(
			{
				objClass = "Timer",
				text = timerTextValue,
				type = timerType,
				simpType = simpType,
				waSpecialKey = waSpecialKey,--Not same as simpType, this overrides option key
				spellId = spellId,
				name = spellName,--If name gets stored as nil, it'll be corrected later in Timer start, if spell name returns in a later attempt
				timer = timer,
				id = id,
				icon = icon,
				colorType = colorType,
				inlineIcon = inlineIcon,
				keep = keep,
				countdown = countdown,
				countdownMax = countdownMax,
				r = r,
				g = g,
				b = b,
				requiresCombat = requiresCombat,
				isPriority = isPriority or false,
				allowdouble = allowdouble,
				hasVariance = hasVariance,
				minTimer = minTimer,
				timerStringWithVariance = timerStringWithVariance,
				varianceDuration = varianceDuration,
				startedTimers = {},
				mod = self,
			},
			mt
		)
		obj:AddOption(optionDefault, optionName, colorType, countdown, spellId, timerType)
		tinsert(self.timers, obj)
		-- todo: move the string creation to the GUI with SetFormattedString...
		if timerType == "achievement" then
			self.localization.options[id] = L.AUTO_TIMER_OPTIONS[timerType]:format(GetAchievementLink(spellId):gsub("%[(.+)%]", "%1"), timer)
		elseif timerType == "cdspecial" or timerType == "cdcombo" or timerType == "nextspecial" or timerType == "nextcombo" or timerType == "stage" or timerType == "stagecount" or timerType == "stagecountcycle" or timerType == "intermission" or timerType == "intermissioncount" or timerType == "adds" or timerType == "addscustom" or timerType == "roleplay" or timerType == "combat" then--Timers without spellid, generic (do not add stagecontext here, it has spellname parsing)
			self.localization.options[id] = L.AUTO_TIMER_OPTIONS[timerType]:format(timerStringVarianceGUI or timer)--Using more than 1 stage timer or more than 1 special timer will break this, fortunately you should NEVER use more than 1 of either in a mod
		else
			self.localization.options[id] = L.AUTO_TIMER_OPTIONS[timerType]:format(unparsedId, timerStringVarianceGUI or timer)
		end
		return obj
	end

	---@overload fun(self: DBMMod, timer: number|string, spellId: number|string?, timerText: number|string?, optionDefault: SpecFlags|boolean?, optionName: string|number|boolean?, colorType: number?, texture: number|string?, inlineIcon: string?, keep: boolean?, countdown: number?, countdownMax: number?, r: number?, g: number?, b: number?, requiresCombat: boolean?, isPriority: boolean?): Timer
	function bossModPrototype:NewTargetTimer(...)
		return newTimer(self, "target", ...)
	end

	---@overload fun(self: DBMMod, timer: number|string, spellId: number|string?, timerText: number|string?, optionDefault: SpecFlags|boolean?, optionName: string|number|boolean?, colorType: number?, texture: number|string?, inlineIcon: string?, keep: boolean?, countdown: number?, countdownMax: number?, r: number?, g: number?, b: number?, requiresCombat: boolean?, isPriority: boolean?): Timer
	function bossModPrototype:NewTargetCountTimer(...)
		return newTimer(self, "targetcount", ...)
	end

	--Buff/Debuff/event on boss
	function bossModPrototype:NewBuffActiveTimer(...)
		return newTimer(self, "active", ...)
	end

	----Buff/Debuff on players
	---@overload fun(self: DBMMod, timer: number|string, spellId: number|string?, timerText: number|string?, optionDefault: SpecFlags|boolean?, optionName: string|number|boolean?, colorType: number?, texture: number|string?, inlineIcon: string?, keep: boolean?, countdown: number?, countdownMax: number?, r: number?, g: number?, b: number?, requiresCombat: boolean?, isPriority: boolean?): Timer
	function bossModPrototype:NewBuffFadesTimer(...)
		return newTimer(self, "fades", ...)
	end

	---@overload fun(self: DBMMod, timer: number|string, spellId: number|string?, timerText: number|string?, optionDefault: SpecFlags|boolean?, optionName: string|number|boolean?, colorType: number?, texture: number|string?, inlineIcon: string?, keep: boolean?, countdown: number?, countdownMax: number?, r: number?, g: number?, b: number?, requiresCombat: boolean?, isPriority: boolean?): Timer
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

	---@overload fun(self: DBMMod, timer: number|string, spellId: number|string?, timerText: number|string?, optionDefault: SpecFlags|boolean?, optionName: string|number|boolean?, colorType: number?, texture: number|string?, inlineIcon: string?, keep: boolean?, countdown: number?, countdownMax: number?, r: number?, g: number?, b: number?, requiresCombat: boolean?, isPriority: boolean?): Timer
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

	---@overload fun(self: DBMMod, timer: number|string, spellId: number|string?, timerText: number|string?, optionDefault: SpecFlags|boolean?, optionName: string|number|boolean?, colorType: number?, texture: number|string?, inlineIcon: string?, keep: boolean?, countdown: number?, countdownMax: number?, r: number?, g: number?, b: number?, requiresCombat: boolean?, isPriority: boolean?): Timer
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

	---@overload fun(self: DBMMod, timer: number|string, spellId: number|string?, timerText: number|string?, optionDefault: SpecFlags|boolean?, optionName: string|number|boolean?, colorType: number?, texture: number|string?, inlineIcon: string?, keep: boolean?, countdown: number?, countdownMax: number?, r: number?, g: number?, b: number?, requiresCombat: boolean?, isPriority: boolean?): Timer
	function bossModPrototype:NewCDTimer(...)
		return newTimer(self, "cd", ...)
	end

	---@overload fun(self: DBMMod, timer: number|string, spellId: number|string?, timerText: number|string?, optionDefault: SpecFlags|boolean?, optionName: string|number|boolean?, colorType: number?, texture: number|string?, inlineIcon: string?, keep: boolean?, countdown: number?, countdownMax: number?, r: number?, g: number?, b: number?, requiresCombat: boolean?, isPriority: boolean?): Timer
	function bossModPrototype:NewCDCountTimer(...)
		return newTimer(self, "cdcount", ...)
	end

	---@overload fun(self: DBMMod, timer: number|string, spellId: number|string?, timerText: number|string?, optionDefault: SpecFlags|boolean?, optionName: string|number|boolean?, colorType: number?, texture: number|string?, inlineIcon: string?, keep: boolean?, countdown: number?, countdownMax: number?, r: number?, g: number?, b: number?, requiresCombat: boolean?, isPriority: boolean?): Timer
	function bossModPrototype:NewCDSourceTimer(...)
		return newTimer(self, "cdsource", ...)
	end

	---@overload fun(self: DBMMod, timer: number|string, spellId: number|string?, timerText: number|string?, optionDefault: SpecFlags|boolean?, optionName: string|number|boolean?, colorType: number?, texture: number|string?, inlineIcon: string?, keep: boolean?, countdown: number?, countdownMax: number?, r: number?, g: number?, b: number?, requiresCombat: boolean?, isPriority: boolean?): Timer
	function bossModPrototype:NewCDSpecialTimer(...)
		return newTimer(self, "cdspecial", ...)
	end

	---@overload fun(self: DBMMod, timer: number|string, spellId: number|string?, timerText: number|string?, optionDefault: SpecFlags|boolean?, optionName: string|number|boolean?, colorType: number?, texture: number|string?, inlineIcon: string?, keep: boolean?, countdown: number?, countdownMax: number?, r: number?, g: number?, b: number?, requiresCombat: boolean?, isPriority: boolean?): Timer
	function bossModPrototype:NewNextTimer(...)
		return newTimer(self, "next", ...)
	end

	---@overload fun(self: DBMMod, timer: number|string, spellId: number|string?, timerText: number|string?, optionDefault: SpecFlags|boolean?, optionName: string|number|boolean?, colorType: number?, texture: number|string?, inlineIcon: string?, keep: boolean?, countdown: number?, countdownMax: number?, r: number?, g: number?, b: number?, requiresCombat: boolean?, isPriority: boolean?): Timer
	function bossModPrototype:NewNextCountTimer(...)
		return newTimer(self, "nextcount", ...)
	end

	---@overload fun(self: DBMMod, timer: number|string, spellId: number|string?, timerText: number|string?, optionDefault: SpecFlags|boolean?, optionName: string|number|boolean?, colorType: number?, texture: number|string?, inlineIcon: string?, keep: boolean?, countdown: number?, countdownMax: number?, r: number?, g: number?, b: number?, requiresCombat: boolean?, isPriority: boolean?): Timer
	function bossModPrototype:NewNextSourceTimer(...)
		return newTimer(self, "nextsource", ...)
	end

	---@overload fun(self: DBMMod, timer: number|string, spellId: number|string?, timerText: number|string?, optionDefault: SpecFlags|boolean?, optionName: string|number|boolean?, colorType: number?, texture: number|string?, inlineIcon: string?, keep: boolean?, countdown: number?, countdownMax: number?, r: number?, g: number?, b: number?, requiresCombat: boolean?, isPriority: boolean?): Timer
	function bossModPrototype:NewNextSpecialTimer(...)
		return newTimer(self, "nextspecial", ...)
	end

	---@overload fun(self: DBMMod, timer: number|string, spellId: number|string?, timerText: number|string?, optionDefault: SpecFlags|boolean?, optionName: string|number|boolean?, colorType: number?, texture: number|string?, inlineIcon: string?, keep: boolean?, countdown: number?, countdownMax: number?, r: number?, g: number?, b: number?, requiresCombat: boolean?, isPriority: boolean?): Timer
	function bossModPrototype:NewVarTimer(...)
		return newTimer(self, "var", ...)
	end

	---@overload fun(self: DBMMod, timer: number|string, spellId: number|string?, timerText: number|string?, optionDefault: SpecFlags|boolean?, optionName: string|number|boolean?, colorType: number?, texture: number|string?, inlineIcon: string?, keep: boolean?, countdown: number?, countdownMax: number?, r: number?, g: number?, b: number?, requiresCombat: boolean?, isPriority: boolean?): Timer
	function bossModPrototype:NewVarCountTimer(...)
		return newTimer(self, "varcount", ...)
	end

	---@overload fun(self: DBMMod, timer: number|string, spellId: number|string?, timerText: number|string?, optionDefault: SpecFlags|boolean?, optionName: string|number|boolean?, colorType: number?, texture: number|string?, inlineIcon: string?, keep: boolean?, countdown: number?, countdownMax: number?, r: number?, g: number?, b: number?, requiresCombat: boolean?, isPriority: boolean?): Timer
	function bossModPrototype:NewVarSourceTimer(...)
		return newTimer(self, "varsource", ...)
	end

	---@overload fun(self: DBMMod, timer: number|string, spellId: number|string?, timerText: number|string?, optionDefault: SpecFlags|boolean?, optionName: string|number|boolean?, colorType: number?, texture: number|string?, inlineIcon: string?, keep: boolean?, countdown: number?, countdownMax: number?, r: number?, g: number?, b: number?, requiresCombat: boolean?, isPriority: boolean?): Timer
	function bossModPrototype:NewVarSpecialTimer(...)
		return newTimer(self, "varspecial", ...)
	end

	---@overload fun(self: DBMMod, timer: number|string, spellId: number|string?, timerText: number|string?, optionDefault: SpecFlags|boolean?, optionName: string|number|boolean?, colorType: number?, texture: number|string?, inlineIcon: string?, keep: boolean?, countdown: number?, countdownMax: number?, r: number?, g: number?, b: number?, requiresCombat: boolean?, isPriority: boolean?): Timer
	function bossModPrototype:NewVarComboTimer(...)
		return newTimer(self, "varcombo", ...)
	end

	---@overload fun(self: DBMMod, timer: number|string, spellId: number|string?, timerText: number|string?, optionDefault: SpecFlags|boolean?, optionName: string|number|boolean?, colorType: number?, texture: number|string?, inlineIcon: string?, keep: boolean?, countdown: number?, countdownMax: number?, r: number?, g: number?, b: number?, requiresCombat: boolean?, isPriority: boolean?): Timer
	function bossModPrototype:NewAchievementTimer(...)
		return newTimer(self, "achievement", ...)
	end

	---@overload fun(self: DBMMod, timer: number|string, spellId: number|string?, timerText: number|string?, optionDefault: SpecFlags|boolean?, optionName: string|number|boolean?, colorType: number?, texture: number|string?, inlineIcon: string?, keep: boolean?, countdown: number?, countdownMax: number?, r: number?, g: number?, b: number?, requiresCombat: boolean?, isPriority: boolean?): Timer
	function bossModPrototype:NewPhaseTimer(...)
		return newTimer(self, "stage", ...)
	end

	---@overload fun(self: DBMMod, timer: number|string, spellId: number|string?, timerText: number|string?, optionDefault: SpecFlags|boolean?, optionName: string|number|boolean?, colorType: number?, texture: number|string?, inlineIcon: string?, keep: boolean?, countdown: number?, countdownMax: number?, r: number?, g: number?, b: number?, requiresCombat: boolean?, isPriority: boolean?): Timer
	function bossModPrototype:NewRPTimer(...)
		return newTimer(self, "roleplay", ...)
	end

	---@overload fun(self: DBMMod, timer: number|string, spellId: number|string?, timerText: number|string?, optionDefault: SpecFlags|boolean?, optionName: string|number|boolean?, colorType: number?, texture: number|string?, inlineIcon: string?, keep: boolean?, countdown: number?, countdownMax: number?, r: number?, g: number?, b: number?, requiresCombat: boolean?, isPriority: boolean?): Timer
	function bossModPrototype:NewAddsTimer(...)
		return newTimer(self, "adds", ...)
	end

	---@overload fun(self: DBMMod, timer: number|string, spellId: number|string?, timerText: number|string?, optionDefault: SpecFlags|boolean?, optionName: string|number|boolean?, colorType: number?, texture: number|string?, inlineIcon: string?, keep: boolean?, countdown: number?, countdownMax: number?, r: number?, g: number?, b: number?, requiresCombat: boolean?, isPriority: boolean?): Timer
	function bossModPrototype:NewAddsCustomTimer(...)
		return newTimer(self, "addscustom", ...)
	end

	function bossModPrototype:NewNextNPTimer(...)
		return newTimer(self, "nextnp", ...)
	end

	---@overload fun(self: DBMMod, timer: number|string, spellId: number|string?, timerText: number|string?, optionDefault: SpecFlags|boolean?, optionName: string|number|boolean?, colorType: number?, texture: number|string?, inlineIcon: string?, keep: boolean?, countdown: number?, countdownMax: number?, r: number?, g: number?, b: number?, requiresCombat: boolean?, isPriority: boolean?): Timer
	function bossModPrototype:NewCDNPTimer(...)
		return newTimer(self, "cdnp", ...)
	end

	function bossModPrototype:NewCDCountNPTimer(...)
		return newTimer(self, "cdcountnp", ...)
	end

	---@overload fun(self: DBMMod, timer: number|string, spellId: number|string?, timerText: number|string?, optionDefault: SpecFlags|boolean?, optionName: string|number|boolean?, colorType: number?, texture: number|string?, inlineIcon: string?, keep: boolean?, countdown: number?, countdownMax: number?, r: number?, g: number?, b: number?, requiresCombat: boolean?, isPriority: boolean?): Timer
	function bossModPrototype:NewNextCountNPTimer(...)
		return newTimer(self, "nextcountnp", ...)
	end

	---@overload fun(self: DBMMod, timer: number|string, spellId: number|string?, timerText: number|string?, optionDefault: SpecFlags|boolean?, optionName: string|number|boolean?, colorType: number?, texture: number|string?, inlineIcon: string?, keep: boolean?, countdown: number?, countdownMax: number?, r: number?, g: number?, b: number?, requiresCombat: boolean?, isPriority: boolean?): Timer
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
			--Name wasn't provided, but we succeeded in getting a name, generate one into object now for caching purposes
			--This would really only happen if GetSpellInfo failed to return spell name on first attempt (which now happens in 9.0)
			if spellName then
				self.name = spellName
			end
		end
		if L.AUTO_TIMER_TEXTS[timerType.."short"] and DBT.Options.StripCDText then
			return pformat(L.AUTO_TIMER_TEXTS[timerType.."short"], spellName)
		else
			return pformat(L.AUTO_TIMER_TEXTS[timerType], spellName)
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
		timer = timer <= 0 and self.timer - mabs(timer) or timer
		self.bar:SetTimer(timer)
		self.bar:Start()
		if self.warning1 then
			if timer > 660 then self.warning1:Schedule(timer - 600, 10, L.MIN) end
			if timer > 300 then self.warning1:Schedule(timer - 300, 5, L.MIN) end
			if timer > 180 then self.warning2:Schedule(timer - 180, 3, L.MIN) end
		end
		if self.warning2 then
			if timer > 60 then self.warning2:Schedule(timer - 60, 1, L.MIN) end
			if timer > 30 then self.warning2:Schedule(timer - 30, 30, L.SEC) end
			if timer > 10 then self.warning2:Schedule(timer - 10, 10, L.SEC) end
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
		local warning1 = self:NewAnnounce(text or L.GENERIC_WARNING_BERSERK, 1, nil, "warning_berserk", false)
		local warning2 = self:NewAnnounce(text or L.GENERIC_WARNING_BERSERK, 4, nil, "warning_berserk", false)
		--timer, name, icon, optionDefault, optionName, colorType, inlineIcon, keep, countdown, countdownMax, r, g, b, spellId, requiresCombat, waCustomName, customType
		local bar = self:NewTimer(timer, barText or L.GENERIC_TIMER_BERSERK, barIcon or 28131, nil, "timer_berserk", nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, "berserk")
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

	function bossModPrototype:NewCombatTimer(timer, _, barText, barIcon) -- timer, text, barText, barIcon
		timer = timer or 10
		--NewTimer(timer, name, texture, optionDefault, optionName, colorType, inlineIcon, keep, countdown, countdownMax, r, g, b)
		local bar = self:NewTimer(timer, barText or L.GENERIC_TIMER_COMBAT, barIcon or "Interface\\Icons\\Ability_Warrior_OffensiveStance", nil, "timer_combat", nil, nil, nil, 1, 5, nil, nil, nil, nil, nil, nil, "combat")
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
function bossModPrototype:AddBoolOption(name, default, cat, func, extraOption, extraOptionTwo, spellId, optionType)
	if checkDuplicateObjects[name] and name ~= "timer_berserk" and name ~= "HealthFrame" then
		DBM:Debug("|cffff0000Option already exists for: |r"..name)
	else
		checkDuplicateObjects[name] = true
	end
	cat = cat or "misc"
	self.DefaultOptions[name] = (default == nil) or default
	if cat == "timer" then
		self.DefaultOptions[name.."TColor"] = extraOption or 0
		self.DefaultOptions[name.."CVoice"] = extraOptionTwo or 0
	end
	if default and type(default) == "string" then
		default = self:GetRoleFlagValue(default)
	end
	self.Options[name] = (default == nil) or default
	if cat == "timer" then
		self.Options[name.."TColor"] = extraOption or 0
		self.Options[name.."CVoice"] = extraOptionTwo or 0
	end
	if spellId then
		if optionType and optionType == "achievement" then
			spellId = "at"..spellId--"at" for achievement timer
		end
		self:GroupSpells(spellId, name)
	end
	self:SetOptionCategory(name, cat, optionType)
	if func then
		self.optionFuncs = self.optionFuncs or {}
		self.optionFuncs[name] = func
	end
end

function bossModPrototype:AddSpecialWarningOption(name, default, defaultSound, cat, spellId, optionType)
	if checkDuplicateObjects[name] then
		DBM:Debug("|cffff0000Option already exists for: |r"..name)
	else
		checkDuplicateObjects[name] = true
	end
	cat = cat or "misc"
	self.DefaultOptions[name] = (default == nil) or default
	self.DefaultOptions[name.."SWSound"] = defaultSound or 1
	self.DefaultOptions[name.."SWNote"] = true
	if default and type(default) == "string" then
		default = self:GetRoleFlagValue(default)
	end
	self.Options[name] = (default == nil) or default
	self.Options[name.."SWSound"] = defaultSound or 1
	self.Options[name.."SWNote"] = true
	if spellId then
		self:GroupSpells(spellId, name)
	end
	self:SetOptionCategory(name, cat, optionType)
end

--[[
--auraspellId must match debuff ID so EnablePrivateAuraSound function can call right option key and right debuff ID
--groupSpellId is used if a diff option key is used in all other options with spell (will be quite common)
function bossModPrototype:AddPrivateAuraSoundOption(auraspellId, default, groupSpellId)
	self.DefaultOptions["PrivateAuraSound"..auraspellId] = (default == nil) or default
	if default and type(default) == "string" then
		default = self:GetRoleFlagValue(default)
	end
	self.Options["PrivateAuraSound"..auraspellId] = (default == nil) or default
	self.localization.options["PrivateAuraSound"..auraspellId] = L.AUTO_PRIVATEAURA_OPTION_TEXT:format(auraspellId)
	self:GroupSpells(groupSpellId or auraspellId, "PrivateAuraSound"..auraspellId)
	self:SetOptionCategory("PrivateAuraSound"..auraspellId, "misc")
end

--Function to actually register specific media to specific auras
--auraspellId: Private aura spellId
--voice: voice pack media path
--voiceVersion: Required voice pack verion (if not met, falls back to airhorn
function bossModPrototype:EnablePrivateAuraSound(auraspellId, voice, voiceVersion)
	if self.Options["PrivateAuraSound"..auraspellId] then
		if not self.paSounds then self.paSounds = {} end
		local mediaPath
		--Check valid voice pack sound
		local chosenVoice = DBM.Options.ChosenVoicePack2
		if chosenVoice ~= "None" and not voiceSessionDisabled and voiceVersion <= SWFilterDisabled then
			mediaPath = "Interface\\AddOns\\DBM-VP"..chosenVoice.."\\"..voice..".ogg"
		else
			mediaPath = "Interface\\AddOns\\DBM-Core\\sounds\\AirHorn.ogg"
		end
		self.paSounds[#self.paSounds + 1] = C_UnitAuras.AddPrivateAuraAppliedSound({
			spellID = auraspellId,
			unitToken = "player",
			soundFileName = mediaPath,
			outputChannel = "master",
		})
	end
end

function bossModPrototype:DisablePrivateAuraSounds()
	for _, id in next, self.paSounds do
		C_UnitAuras.RemovePrivateAuraAppliedSound(id)
	end
	self.paSounds = nil
end
--]]

--Extended Icon Usage Notes
--Any time extended icons is used, option must be OFF by default
--Option must be hidden from GUI if extended icoins not enabled
--If extended icons are disabled, then on mod load, users option is reset to default (off) to prevent their mod from still executing SetIcon functions (this is because even if it's hidden from GUI, if option was created and enabled, it'd still run)
function bossModPrototype:AddSetIconOption(name, spellId, default, iconType, iconsUsed, conflictWarning)
	self.DefaultOptions[name] = (default == nil) or default
	if default and type(default) == "string" then
		default = self:GetRoleFlagValue(default)
	end
	self.Options[name] = (default == nil) or default
	if spellId and not DBM.Options.GroupOptionsExcludeIcon then
		self:GroupSpells(spellId, name)
	end
	self:SetOptionCategory(name, "icon")
	--Legacy bool and nil support
	if type(iconType) ~= "number" then
		if iconType then--true
			iconType = 5
		else --false/nil
			iconType = 0
		end
	end
	if iconType == 1 then
		self.localization.options[name] = spellId and L.AUTO_ICONS_OPTION_TARGETS_MELEE_A:format(spellId) or self.localization.options[name]
	elseif iconType == 2 then
		self.localization.options[name] = spellId and L.AUTO_ICONS_OPTION_TARGETS_MELEE_R:format(spellId) or self.localization.options[name]
	elseif iconType == 3 then
		self.localization.options[name] = spellId and L.AUTO_ICONS_OPTION_TARGETS_RANGED_A:format(spellId) or self.localization.options[name]
	elseif iconType == 4 then
		self.localization.options[name] = spellId and L.AUTO_ICONS_OPTION_TARGETS_RANGED_R:format(spellId) or self.localization.options[name]
	elseif iconType == 5 then
		--NPC/Mob setting uses icon elect feature and needs to establish latency check table
		if not self.findFastestComputer then
			self.findFastestComputer = {}
		end
		self.findFastestComputer[#self.findFastestComputer + 1] = name
		self.localization.options[name] = spellId and L.AUTO_ICONS_OPTION_NPCS:format(spellId) or self.localization.options[name]
	elseif iconType == 6 then
		self.localization.options[name] = spellId and L.AUTO_ICONS_OPTION_TARGETS_ALPHA:format(spellId) or self.localization.options[name]
	elseif iconType == 7 then
		self.localization.options[name] = spellId and L.AUTO_ICONS_OPTION_TARGETS_ROSTER:format(spellId) or self.localization.options[name]
	elseif iconType == 8 then
		self.localization.options[name] = spellId and L.AUTO_ICONS_OPTION_TARGETS_TANK_A:format(spellId) or self.localization.options[name]
	elseif iconType == 9 then
		self.localization.options[name] = spellId and L.AUTO_ICONS_OPTION_TARGETS_TANK_R:format(spellId) or self.localization.options[name]
	else--Type 0 (Generic for targets)
		self.localization.options[name] = spellId and L.AUTO_ICONS_OPTION_TARGETS:format(spellId) or self.localization.options[name]
	end
	--A table defining used icons by number, insert icon textures to end of option
	if iconsUsed then
		self.localization.options[name] = self.localization.options[name].." ("
		for i=1, #iconsUsed do
			--Texture ID 137009 if direct calling RaidTargetingIcons stops working one day
			if		iconsUsed[i] == 1 then		self.localization.options[name] = self.localization.options[name].."|TInterface\\TargetingFrame\\UI-RaidTargetingIcons.blp:13:13:0:0:64:64:0:16:0:16|t"
			elseif	iconsUsed[i] == 2 then		self.localization.options[name] = self.localization.options[name].."|TInterface\\TargetingFrame\\UI-RaidTargetingIcons.blp:13:13:0:0:64:64:16:32:0:16|t"
			elseif	iconsUsed[i] == 3 then		self.localization.options[name] = self.localization.options[name].."|TInterface\\TargetingFrame\\UI-RaidTargetingIcons.blp:13:13:0:0:64:64:32:48:0:16|t"
			elseif	iconsUsed[i] == 4 then		self.localization.options[name] = self.localization.options[name].."|TInterface\\TargetingFrame\\UI-RaidTargetingIcons.blp:13:13:0:0:64:64:48:64:0:16|t"
			elseif	iconsUsed[i] == 5 then		self.localization.options[name] = self.localization.options[name].."|TInterface\\TargetingFrame\\UI-RaidTargetingIcons.blp:13:13:0:0:64:64:0:16:16:32|t"
			elseif	iconsUsed[i] == 6 then		self.localization.options[name] = self.localization.options[name].."|TInterface\\TargetingFrame\\UI-RaidTargetingIcons.blp:13:13:0:0:64:64:16:32:16:32|t"
			elseif	iconsUsed[i] == 7 then		self.localization.options[name] = self.localization.options[name].."|TInterface\\TargetingFrame\\UI-RaidTargetingIcons.blp:13:13:0:0:64:64:32:48:16:32|t"
			elseif	iconsUsed[i] == 8 then		self.localization.options[name] = self.localization.options[name].."|TInterface\\TargetingFrame\\UI-RaidTargetingIcons.blp:13:13:0:0:64:64:48:64:16:32|t"
			end
		end
		self.localization.options[name] = self.localization.options[name]..")"
		if conflictWarning then
			self.localization.options[name] = self.localization.options[name] .. L.AUTO_ICONS_OPTION_CONFLICT
		end
	end
end

function bossModPrototype:AddArrowOption(name, spellId, default, isRunTo)
	if isRunTo == true then isRunTo = 2 end--Support legacy
	self.DefaultOptions[name] = (default == nil) or default
	if default and type(default) == "string" then
		default = self:GetRoleFlagValue(default)
	end
	self.Options[name] = (default == nil) or default
	self:GroupSpells(spellId, name)
	self:SetOptionCategory(name, "misc")
	if isRunTo == 2 then
		self.localization.options[name] = L.AUTO_ARROW_OPTION_TEXT:format(spellId)
	elseif isRunTo == 3 then
		self.localization.options[name] = L.AUTO_ARROW_OPTION_TEXT3:format(spellId)
	else
		self.localization.options[name] = L.AUTO_ARROW_OPTION_TEXT2:format(spellId)
	end
end

function bossModPrototype:AddRangeFrameOption(range, spellId, default)
	self.DefaultOptions["RangeFrame"] = (default == nil) or default
	if default and type(default) == "string" then
		default = self:GetRoleFlagValue(default)
	end
	self.Options["RangeFrame"] = (default == nil) or default
	if spellId then
		self:GroupSpells(spellId, "RangeFrame")
		self.localization.options["RangeFrame"] = L.AUTO_RANGE_OPTION_TEXT:format(range, spellId)
	else
		self.localization.options["RangeFrame"] = L.AUTO_RANGE_OPTION_TEXT_SHORT:format(range)
	end
	self:SetOptionCategory("RangeFrame", "misc")
end

function bossModPrototype:AddHudMapOption(name, spellId, default)
	self.DefaultOptions[name] = (default == nil) or default
	if default and type(default) == "string" then
		default = self:GetRoleFlagValue(default)
	end
	self.Options[name] = (default == nil) or default
	if spellId then
		self:GroupSpells(spellId, name)
		self.localization.options[name] = L.AUTO_HUD_OPTION_TEXT:format(spellId)
	else
		self.localization.options[name] = L.AUTO_HUD_OPTION_TEXT_MULTI
	end
	self:SetOptionCategory(name, "misc")
end

function bossModPrototype:AddNamePlateOption(name, spellId, default, forceDBM)
	if not spellId then
		error("AddNamePlateOption must provide valid spellId", 2)
	end
	self.DefaultOptions[name] = (default == nil) or default
	if default and type(default) == "string" then
		default = self:GetRoleFlagValue(default)
	end
	self.Options[name] = (default == nil) or default
	self:GroupSpells(spellId, name)
	self:SetOptionCategory(name, "nameplate")
	self.localization.options[name] = forceDBM and L.AUTO_NAMEPLATE_OPTION_TEXT_FORCED:format(spellId) or L.AUTO_NAMEPLATE_OPTION_TEXT:format(spellId)
end

function bossModPrototype:AddInfoFrameOption(spellId, default, optionVersion, optionalThreshold)
	local oVersion = ""
	if optionVersion then
		oVersion = tostring(optionVersion)
	end
	self.DefaultOptions["InfoFrame"..oVersion] = (default == nil) or default
	if default and type(default) == "string" then
		default = self:GetRoleFlagValue(default)
	end
	self.Options["InfoFrame"..oVersion] = (default == nil) or default
	if spellId then
		self:GroupSpells(spellId, "InfoFrame" .. oVersion)
		if optionalThreshold then
			self.localization.options["InfoFrame"..oVersion] = L.AUTO_INFO_FRAME_OPTION_TEXT3:format(spellId, optionalThreshold)
		else
			self.localization.options["InfoFrame"..oVersion] = L.AUTO_INFO_FRAME_OPTION_TEXT:format(spellId)
		end
	else
		self.localization.options["InfoFrame"..oVersion] = L.AUTO_INFO_FRAME_OPTION_TEXT2
	end
	self:SetOptionCategory("InfoFrame"..oVersion, "misc")
end

function bossModPrototype:AddReadyCheckOption(questId, default, maxLevel)
	self.readyCheckQuestId = questId
	self.readyCheckMaxLevel = maxLevel or 999
	self.DefaultOptions["ReadyCheck"] = (default == nil) or default
	if default and type(default) == "string" then
		default = self:GetRoleFlagValue(default)
	end
	self.Options["ReadyCheck"] = (default == nil) or default
	self.localization.options["ReadyCheck"] = L.AUTO_READY_CHECK_OPTION_TEXT
	self:SetOptionCategory("ReadyCheck", "misc")
end

function bossModPrototype:AddSpeedClearOption(name, default)
	self.DefaultOptions["SpeedClearTimer"] = (default == nil) or default
	if default and type(default) == "string" then
		default = self:GetRoleFlagValue(default)
	end
	self.Options["SpeedClearTimer"] = (default == nil) or default
	self:SetOptionCategory("SpeedClearTimer", "timer")
	self.localization.options["SpeedClearTimer"] = L.AUTO_SPEEDCLEAR_OPTION_TEXT:format(name)
end

function bossModPrototype:AddSliderOption(name, minValue, maxValue, valueStep, default, cat, func)
	cat = cat or "misc"
	self.DefaultOptions[name] = {type = "slider", value = default or 0}
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

function bossModPrototype:AddEditboxOption(name, default, cat, width, height, func)
	cat = cat or "misc"
	self.DefaultOptions[name] = {type = "editbox", value = default or ""}
	self.Options[name] = default or ""
	self:SetOptionCategory(name, cat)
	self.editboxes = self.editboxes or {}
	self.editboxes[name] = {
		width = width,
		height = height
	}
	if func then
		self.optionFuncs = self.optionFuncs or {}
		self.optionFuncs[name] = func
	end
end

function bossModPrototype:AddButton(name, onClick, cat, width, height, fontObject)
	cat = cat or "misc"
	self:SetOptionCategory(name, cat)
	self.buttons = self.buttons or {}
	self.buttons[name] = {
		onClick = onClick,
		width = width,
		height = height,
		fontObject = fontObject
	}
end

-- this function does not reset any settings to default if you remove an option in a later revision and a user has selected this option in an earlier revision were it still was available
-- this will be fixed as soon as it is necessary due to removed options ;-)
function bossModPrototype:AddDropdownOption(name, options, default, cat, func, spellId)
	cat = cat or "misc"
	self.DefaultOptions[name] = {type = "dropdown", value = default}
	self.Options[name] = default
	if spellId then
		self:GroupSpells(spellId, name)
	end
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

do
	local lineCount = 1

	function bossModPrototype:AddOptionLine(text, cat, forceIgnore)
		if self.addon and not self.addon.oldOptions and DBM.Options.GroupOptionsBySpell and not forceIgnore then
			self.groupOptions["line" .. lineCount] = text
			lineCount = lineCount + 1
		else
			cat = cat or "misc"
			if not self.optionCategories[cat] then
				self.optionCategories[cat] = {}
			end
			if self.optionCategories[cat] then
				tinsert(self.optionCategories[cat], {line = true, text = text})
			end
		end
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

function bossModPrototype:AddNamePlateLine(text)
	return self:AddOptionLine(text, "nameplate")
end

function bossModPrototype:AddIconLine(text)
	return self:AddOptionLine(text, "icon")
end

function bossModPrototype:AddMiscLine(text)
	return self:AddOptionLine(text, "misc", true)
end

function bossModPrototype:RemoveOption(name)
	self.Options[name] = nil
	for k, options in pairs(self.optionCategories) do
		removeEntry(options, name)
		if #options == 0 then
			self.optionCategories[k] = nil
		end
	end
	if self.optionFuncs then
		self.optionFuncs[name] = nil
	end
end

function bossModPrototype:GroupSpells(...)
	local spells = {...}
	local catSpell = tostring(tremove(spells, 1))
	if not self.groupSpells[catSpell] then
		self.groupSpells[catSpell] = {}
	end
	for _, spell in ipairs(spells) do
		local sSpell = tostring(spell)
		self.groupSpells[sSpell] = catSpell
		if sSpell ~= catSpell and self.groupOptions[sSpell] then
			if not self.groupOptions[catSpell] then
				self.groupOptions[catSpell] = {}
			end
			for _, spell2 in ipairs(self.groupOptions[sSpell]) do
				tinsert(self.groupOptions[catSpell], spell2)
			end
			self.groupOptions[sSpell] = nil
		end
	end
end

function bossModPrototype:SetOptionCategory(name, cat, optionType)
	optionType = optionType or ""
	for _, options in pairs(self.optionCategories) do
		removeEntry(options, name)
	end
	if self.addon and not self.addon.oldOptions and DBM.Options.GroupOptionsBySpell and self.groupSpells[name] and not (optionType == "gtfo" or optionType == "adds" or optionType == "addscount" or optionType == "addscustom" or optionType:find("stage") or cat == "icon" and DBM.Options.GroupOptionsExcludeIcon) then
		local sSpell = self.groupSpells[name]
		if not self.groupOptions[sSpell] then
			self.groupOptions[sSpell] = {}
		end
		tinsert(self.groupOptions[sSpell], name)
	else
		if not self.optionCategories[cat] then
			self.optionCategories[cat] = {}
		end
		tinsert(self.optionCategories[cat], name)
		tinsert(self.categorySort, cat)
	end
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
	if self.noIEEUDetection then
		info.noIEEUDetection = self.noIEEUDetection
	end
	if self.noFriendlyEngagement then
		info.noFriendlyEngagement = self.noFriendlyEngagement
	end
	if self.noRegenDetection then
		info.noRegenDetection = self.noRegenDetection
	end
	if self.noMultiBoss then
		info.noMultiBoss = self.noMultiBoss
	end
	if self.WBEsync then
		info.WBEsync = self.WBEsync
	end
	if self.noBossDeathKill then
		info.noBossDeathKill = self.noBossDeathKill
	end
	-- use pull-mobs as kill mobs by default, can be overriden by RegisterKill
	if self.multiMobPullDetection then
		for _, v in ipairs(self.multiMobPullDetection) do
			info.killMobs = info.killMobs or {}
			info.killMobs[v] = true
		end
	end
	self.combatInfo = info
	if not self.zones then return end
	for v in pairs(self.zones) do
		combatInfo[v] = combatInfo[v] or {}
		tinsert(combatInfo[v], info)
	end
end

-- needs to be called _AFTER_ RegisterCombat
function bossModPrototype:RegisterKill(msgType, ...)
	if not self.combatInfo then
		error("mod.combatInfo not yet initialized, use mod:RegisterCombat before using this method", 2)
	end
	if msgType == "kill" then
		if select("#", ...) > 0 then -- calling this method with 0 IDs means "use the values from SetCreatureID", this is already done by RegisterCombat as calling RegisterKill should be optional --> mod:RegisterKill("kill") with no IDs is never necessary
			self.combatInfo.killMobs = {}
			for i = 1, select("#", ...) do
				local v = select(i, ...)
				if type(v) == "number" then
					self.combatInfo.killMobs[v] = true
				end
			end
		end
	else
		self.combatInfo.killType = msgType
		self.combatInfo.killMsgs = {}
		for i = 1, select("#", ...) do
			local v = select(i, ...)
			self.combatInfo.killMsgs[v] = true
		end
	end
end

function bossModPrototype:SetDetectCombatInVehicle(flag)
	if not self.combatInfo then
		error("mod.combatInfo not yet initialized, use mod:RegisterCombat before using this method", 2)
	end
	self.combatInfo.noCombatInVehicle = not flag
end

function bossModPrototype:SetCreatureID(...)
	self.creatureId = ...
	if select("#", ...) > 1 then
		self.multiMobPullDetection = {...}
		if self.combatInfo then
			self.combatInfo.multiMobPullDetection = self.multiMobPullDetection
			self.numBoss = #self.multiMobPullDetection
			if self.inCombat then
				--Called mid combat, fix some variables
				self.vb.bossLeft = self.numBoss
			end
		end
		for i = 1, select("#", ...) do
			local cId = select(i, ...)
			bossIds[cId] = true
		end
	else
		local cId = ...
		bossIds[cId] = true
		self.numBoss = 1
		if self.combatInfo then
			--Called mid combat, update combatinfo mob for boss health and win detection
			self.combatInfo.mob = self.creatureId
		end
	end
end

function bossModPrototype:DisableIEEUCombatDetection()
	self.noIEEUDetection = true
	if self.combatInfo then
		self.combatInfo.noIEEUDetection = true
	end
end

function bossModPrototype:DisableFriendlyDetection()
	self.noFriendlyEngagement = true
	if self.combatInfo then
		self.combatInfo.noFriendlyEngagement = true
	end
end

function bossModPrototype:DisableRegenDetection()
	self.noRegenDetection = true
	if self.combatInfo then
		self.combatInfo.noRegenDetection = true
	end
end

function bossModPrototype:DisableMultiBossPulls()
	self.noMultiBoss = true
	if self.combatInfo then
		self.combatInfo.noMultiBoss = true
	end
end

function bossModPrototype:EnableWBEngageSync()
	self.WBEsync = true
	if self.combatInfo then
		self.combatInfo.WBEsync = true
	end
end

---Used when a bosses death condition should be ignored (maybe they die repeatedly for example)
function bossModPrototype:DisableBossDeathKill()
	self.noBossDeathKill = true
	if self.combatInfo then
		self.combatInfo.noBossDeathKill = true
	end
end

---Used when a boss is scripted in a hacky way that their creature Id changes mid fight, and we want to treat multiple IDs as a single boss
function bossModPrototype:SetMultiIDSingleBoss()
	self.multiIDSingleBoss = true
end

--used for knowing if a specific mod is engaged
function bossModPrototype:IsInCombat()
	return self.inCombat
end

--Used for knowing if any person is in any kind of combat period
function bossModPrototype:GroupInCombat()
	local combatFound = false
	--Any Boss engaged
	if DBM:IsEncounterInProgress() then
		combatFound = true
	end
	--Self in Combat
	if InCombatLockdown() or UnitAffectingCombat("player") then
		combatFound = true
	end
	--Any Other group member in combat
	if not combatFound then
		for uId in DBM:GetGroupMembers() do
			if UnitAffectingCombat(uId) and not UnitIsDeadOrGhost(uId) then
				combatFound = true
				break
			end
		end
	end
	return combatFound
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
		error("mod.combatInfo not yet initialized, use mod:RegisterCombat before using this method", 2)
	end
	self.combatInfo.wipeTimer = t
end

-- fix for LFR ToES Tsulong combat detection bug after killed.
function bossModPrototype:SetReCombatTime(t, t2)--T1, after kill. T2 after wipe
	self.reCombatTime = t
	self.reCombatTime2 = t2
end

function bossModPrototype:SetOOCBWComms()
	tinsert(oocBWComms, self)
end

function bossModPrototype:GetBossHPString(cId)
	local idType = (GetNumRaidMembers() == 0 and "party") or "raid"
	for i = 0, mmax(GetNumRaidMembers(), GetNumPartyMembers()) do
		local unitId = ((i == 0) and "target") or idType..i.."target"
		local guid = UnitGUID(unitId)
		if guid and tonumber(guid:sub(8, 12), 16) == cId then
			return floor(UnitHealth(unitId)/UnitHealthMax(unitId) * 100).."%"
		end
	end
	return CL.UNKNOWN
end

function bossModPrototype:GetHP()
	return self:GetBossHPString((self.combatInfo and self.combatInfo.mob) or self.creatureId)
end

-----------------------
--  Synchronization  --
-----------------------
function bossModPrototype:SendSync(event, ...)
	event = event or ""
	local arg = select("#", ...) > 0 and strjoin("\t", tostringall(...)) or ""
	local str = ("%s\t%s\t%s\t%s"):format(self.id, self.revision or 0, event, arg)
	local spamId = self.id .. event .. arg -- *not* the same as the sync string, as it doesn't use the revision information
	local time = GetTime()
	--Mod syncs are more strict and enforce latency threshold always.
	--Do not put latency check in main sendSync local function (line 313) though as we still want to get version information, etc from these users.
	if not private.modSyncSpam[spamId] or (time - private.modSyncSpam[spamId]) > 8 then
		self:ReceiveSync(event, playerName, self.revision or 0, tostringall(...))
		sendSync("DBMv4-Mod", str)
	end
end

function bossModPrototype:SendBigWigsSync(msg, extra)
	if not dbmIsEnabled then return end
	msg = "B^".. msg
	if extra then
		msg = msg .."^".. extra
	end
	if IsInGroup() then
		SendAddonMessage("BigWigs", msg, IsInRaid() and "RAID" or "PARTY")
	end
end

function bossModPrototype:ReceiveSync(event, sender, revision, ...)
	local spamId = self.id .. event .. strjoin("\t", ...)
	local time = GetTime()
	if (not private.modSyncSpam[spamId] or (time - private.modSyncSpam[spamId]) > self.SyncThreshold) and self.OnSync and (not self.minSyncRevision or revision >= self.minSyncRevision) then
		private.modSyncSpam[spamId] = time
		-- we have to use the sender as last argument for compatibility reasons (stupid old API...)
		-- avoid table allocations for frequently used number of arguments
		if select("#", ...) <= 1 then
			-- syncs with no arguments have an empty argument (also for compatibility reasons)
			self:OnSync(event, ... or "", sender)
		elseif select("#", ...) == 2 then
			self:OnSync(event, ..., select(2, ...), sender)
		else
			local tmp = { ... }
			tmp[#tmp + 1] = sender
			self:OnSync(event, unpack(tmp))
		end
	end
end

function bossModPrototype:SetRevision(revision)
	revision = parseCurseDate(revision or "")
	if not revision or type(revision) == "string" then
		-- bad revision: either forgot the svn keyword or using github
		revision = DBM.Revision
	end
	self.revision = revision
end

--Either treat it as a valid number, or a curse string that needs to be made into a valid number
function bossModPrototype:SetMinSyncRevision(revision)
	self.minSyncRevision = (type(revision or "") == "number") and revision or parseCurseDate(revision)
end

function bossModPrototype:SetHotfixNoticeRev(revision)
	self.hotfixNoticeRev = (type(revision or "") == "number") and revision or parseCurseDate(revision)
end

-----------------
--  Scheduler  --
-----------------
function bossModPrototype:Schedule(t, f, ...)
	return DBMScheduler:Schedule(t, f, self, ...)
end

function bossModPrototype:Unschedule(f, ...)
	return DBMScheduler:Unschedule(f, self, ...)
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
do
	local iconsModule = private:GetModule("Icons")

	function bossModPrototype:SetIcon(...)
		return iconsModule:SetIcon(self, ...)
	end

	function bossModPrototype:SetIconByTable(...)
		return iconsModule:SetIconByTable(self, ...)
	end

	function bossModPrototype:SetUnsortedIcon(...)
		return iconsModule:SetUnsortedIcon(self, ...)
	end

	--Backwards compat for old mods using this method, which is now merged into SetSortedIcon
	function bossModPrototype:SetAlphaIcon(delay, target, maxIcon, returnFunc, scanId, ...)
		return iconsModule:SetSortedIcon(self, "alpha", delay, target, 1, maxIcon, false, returnFunc, scanId, ...)
	end

	function bossModPrototype:SetIconBySortedTable(...)
		return iconsModule:SetIconBySortedTable(self, ...)
	end

	function bossModPrototype:SetSortedIcon(...)
		return iconsModule:SetSortedIcon(self, ...)
	end

	function bossModPrototype:ScanForMobs(...)
		return iconsModule:ScanForMobs(self, ...)
	end

	function bossModPrototype:RemoveIcon(...)
		return iconsModule:RemoveIcon(self, ...)
	end

	bossModPrototype.GetIcon = iconsModule.GetIcon
	bossModPrototype.ClearIcons = iconsModule.ClearIcons
	bossModPrototype.CanSetIcon = iconsModule.CanSetIcon
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
	self.localization.miscStrings.name = self.localization.general.name
	return self.localization.miscStrings
end
