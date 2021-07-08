-- ***************************************************
-- **             DBM Range Check Frame             **
-- **         http://www.deadlybossmods.com         **
-- ***************************************************
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
--    * zhTW: Azael/kc10577				paul.poon.kw@gmail.com
--    * koKR: BlueNyx/nBlueWiz			bluenyx@gmail.com / everfinale@gmail.com
--    * esES: Snamor/1nn7erpLaY      	romanscat@hotmail.com
--
-- Special thanks to:
--    * Arta
--    * Omegal @ US-Whisperwind (continuing mod support for 3.2+)
--    * Tennberg (a lot of fixes in the enGB/enUS localization)
--
--
-- The code of this addon is licensed under a Creative Commons Attribution-Noncommercial-Share Alike 3.0 License. (see license.txt)
-- All included textures and sounds are copyrighted by their respective owners.
--
--
--  You are free:
--    * to Share ?to copy, distribute, display, and perform the work
--    * to Remix ?to make derivative works
--  Under the following conditions:
--    * Attribution. You must attribute the work in the manner specified by the author or licensor (but not in any way that suggests that they endorse you or your use of the work).
--    * Noncommercial. You may not use this work for commercial purposes.
--    * Share Alike. If you alter, transform, or build upon this work, you may distribute the resulting work only under the same or similar license to this one.
--
--
-- This file makes use of the following free (Creative Commons Sampling Plus 1.0) sounds:
--    * alarmclockbeeps.ogg by tedthetrumpet (http://www.freesound.org/usersViewSingle.php?id=177)
--    * blip_8.ogg by Corsica_S (http://www.freesound.org/usersViewSingle.php?id=7037)
--  The full of text of the license can be found in the file "Sounds\Creative Commons Sampling Plus 1.0.txt".

DBM:RegisterMapSize("Durotar",				0, 5287.5, 3525)
DBM:RegisterMapSize("Mulgore",				0, 5137.5, 3425.0003)
DBM:RegisterMapSize("Barrens",				0, 10133.334, 6756.25)
DBM:RegisterMapSize("Kalimdor",				0, 36799.81, 24533.2)
DBM:RegisterMapSize("Azeroth",				0, 40741.18, 27149.68)
DBM:RegisterMapSize("Alterac",				0, 2800.0003, 1866.6667)
DBM:RegisterMapSize("Arathi",				0, 3600.0004, 2399.9997)
DBM:RegisterMapSize("Badlands",				0, 2487.5, 1658.334)
DBM:RegisterMapSize("BlastedLands",			0, 3350, 2233.33)
DBM:RegisterMapSize("Tirisfal",				0, 4518.75, 3012.5001)
DBM:RegisterMapSize("Silverpine",			0, 4200, 2800)
DBM:RegisterMapSize("WesternPlaguelands",	0, 4299.9997, 2866.667)
DBM:RegisterMapSize("EasternPlaguelands",	0, 4031.25, 2687.5)
DBM:RegisterMapSize("Hilsbrad",				0, 3200, 2133.333)
DBM:RegisterMapSize("Hinterlands",			0, 3850, 2566.667)
DBM:RegisterMapSize("DunMorogh",			0, 4925, 3283.334)
DBM:RegisterMapSize("SearingGorge",			0, 2231.2503, 1487.5)
DBM:RegisterMapSize("BurningSteppes",		0, 2929.1663, 1952.083)
DBM:RegisterMapSize("Elwynn",				0, 3470.834, 2314.587)
DBM:RegisterMapSize("DeadwindPass",			0, 2499.9997, 1666.664)
DBM:RegisterMapSize("Duskwood",				0, 2700.0003, 1800.004)
DBM:RegisterMapSize("LochModan",			0, 2758.333, 1839.583)
DBM:RegisterMapSize("Redridge",				0, 2170.834, 1447.92)
DBM:RegisterMapSize("Stranglethorn",		0, 6381.25, 4254.17)
DBM:RegisterMapSize("SwampOfSorrows",		0, 2293.75, 1529.167)
DBM:RegisterMapSize("Westfall",				0, 3500.0003, 2333.33)
DBM:RegisterMapSize("Wetlands",				0, 4135.4167, 2756.25)
DBM:RegisterMapSize("Teldrassil",			0, 5091.666, 3393.75)
DBM:RegisterMapSize("Darkshore",			0, 6550, 4366.666)
DBM:RegisterMapSize("Ashenvale",			0, 5766.667, 3843.7504)
DBM:RegisterMapSize("ThousandNeedles",		0, 4399.9997, 2933.333)
DBM:RegisterMapSize("StonetalonMountains",	0, 4883.333, 3256.2503)
DBM:RegisterMapSize("Desolace",				0, 4495.833, 2997.9163)
DBM:RegisterMapSize("Feralas",				0, 6950, 4633.333)
DBM:RegisterMapSize("Dustwallow",			0, 5250.0001, 3500)
DBM:RegisterMapSize("Tanaris",				0, 6900, 4600)
DBM:RegisterMapSize("Aszhara",				0, 5070.833, 3381.25)
DBM:RegisterMapSize("Felwood",				0, 5750, 3833.333)
DBM:RegisterMapSize("UngoroCrater",			0, 3700.0003, 2466.666)
DBM:RegisterMapSize("Moonglade",			0, 2308.333, 1539.583)
DBM:RegisterMapSize("Silithus",				0, 3483.334, 2322.916)
DBM:RegisterMapSize("Winterspring",			0, 7100.0003, 4733.333)
DBM:RegisterMapSize("Stormwind",			0, 1737.50033, 1158.333)
DBM:RegisterMapSize("Ogrimmar",				0, 1402.605, 935.416)
DBM:RegisterMapSize("Ironforge",			0, 790.6246, 527.605)
DBM:RegisterMapSize("ThunderBluff",			0, 1043.7499, 695.8331)
DBM:RegisterMapSize("Darnassis",			0, 1058.333, 705.733)
DBM:RegisterMapSize("Undercity",			0, 959.375, 640.104)
DBM:RegisterMapSize("AlteracValley",		0, 4237.5, 2825)
DBM:RegisterMapSize("WarsongGulch",			0, 1145.8337, 764.5831)
DBM:RegisterMapSize("ArathiBasin",			0, 1756.2497, 1170.833)
DBM:RegisterMapSize("EversongWoods" ,		0, 4925, 3283.337)
DBM:RegisterMapSize("Ghostlands",			0, 3300, 2199.999)
DBM:RegisterMapSize("AzuremystIsle",		0, 4070.83, 2714.583)
DBM:RegisterMapSize("Hellfire",				0, 5164.583, 3443.75)
DBM:RegisterMapSize("Expansion01",			0, 17464.079, 11642.718) --?
DBM:RegisterMapSize("Zangarmarsh",			0, 5027.083, 3352.084)
DBM:RegisterMapSize("TheExodar",			0, 1056.77, 704.688)
DBM:RegisterMapSize("ShadowmoonValley",		0, 5500, 3666.666)
DBM:RegisterMapSize("BladesEdgeMountains",	0, 5425, 3616.6664)
DBM:RegisterMapSize("BloodmystIsle",		0, 3262.5, 2174.9997)
DBM:RegisterMapSize("Nagrand",				0, 5524.997, 3683.33366)
DBM:RegisterMapSize("TerokkarForest",		0, 5400, 3600.0001)
DBM:RegisterMapSize("Netherstorm",			0, 5574.99966, 3716.667)
DBM:RegisterMapSize("SilvermoonCity",		0, 1211.458, 806.772)
DBM:RegisterMapSize("ShattrathCity",		0, 1306.25, 870.834)
DBM:RegisterMapSize("NetherstormArena",		0, 2270.8337, 1514.583)
DBM:RegisterMapSize("Northrend",			0, 17751.398, 11834.27)
DBM:RegisterMapSize("BoreanTundra",			0, 5764.583, 3843.75)
DBM:RegisterMapSize("Dragonblight",			0, 5608.333, 3739.583)
DBM:RegisterMapSize("GrizzlyHills",			0, 5250, 3500)
DBM:RegisterMapSize("HowlingFjord",			0, 6045.833, 4031.2503)
DBM:RegisterMapSize("IcecrownGlacier",		0, 6270.8333, 4181.25)
DBM:RegisterMapSize("SholazarBasin",		0, 4356.25, 2904.167)
DBM:RegisterMapSize("TheStormPeaks",		0, 7112.5, 4741.67)
DBM:RegisterMapSize("ZulDrak",				0, 4993.75, 3329.167)
DBM:RegisterMapSize("Sunwell",				0, 3327.083, 2218.75)
DBM:RegisterMapSize("LakeWintergrasp",		0, 2975, 1983.334)
DBM:RegisterMapSize("ScarletEnclave",		0, 3162.5, 2108.3334)
DBM:RegisterMapSize("Dalaran",				1, 830.015, 553.34,		2, 563.224, 375.49)
DBM:RegisterMapSize("CrystalsongForest",	0, 2722.917, 1814.583)
DBM:RegisterMapSize("StrandoftheAncients",	0, 1743.7499, 1162.4997)
--"TheNexus" = {{1101.281, 734.1875}} -- Exists on Party-WotLK
--"CoTStratholme" = {{1125.3, 750.2}} -- This looks wrong. Exists on Party-WotLK
--"Ahnkahet" = {{972.418, 648.279}} -- Exists on Party-WotLK
--"UtgardeKeep" = {{734.581, 489.7215}, {481.081, 320.7203}, {736.581, 491.0545}} -- Exists on Party-WotLK
--"UtgardePinnacle" = {{548.936, 365.957}, {756.17996, 504.119}} -- Exists on Party-WotLK
--"HallsofLightning" = {{566.235, 377.49}, {708.237, 472.16}} -- Exists on Party-WotLK
--"Ulduar77" = {{920.196, 613.466}} -- Halls of Stone. Exists on Party-WotLK
--"TheEyeofEternity" = {{430.07, 286.713}} -- Exists on EyeOfEternity
--"Nexus80" = {{514.707, 343.139}, {664.707, 443.139}, {514.707, 343.139}, {294.701, 196.464}} -- Oculus. Exists on Party-WotLK
--"Ulduar" = {{669.451, 446.3}, {1328.461, 885.64}, {910.5, 607}, {1569.46, 1046.3}, {619.469, 412.98}} -- Exists on Ulduar
--"Gundrak" = {{905.033, 603.35}} -- Exists on Party-WotLK
--"TheObsidianSanctum" = {{1162.49967, 775}} -- Exists on Obsidian
--"VaultofArchavon" = {{1398.255, 932.17}} -- Exists on VoA
--"AzjolNerub" = {{752.974, 501.983}, {292.974, 195.316}, {367.5, 245}} -- Exists on Party-WotLK
--"DrakTharonKeep" = {{619.941, 413.294}, {619.941, 413.294}} -- Exists on Party-WotLK
--"Naxxramas" = {{1093.83, 729.22}, {1093.83, 729.22}, {1200, 800}, {1200.33, 800.22}, {2069.81, 1379.88}, {655.94, 437.29}} -- Exists on Naxx
--"VioletHold" = {{256.229, 170.82}} -- Exists on Party-WotLK
DBM:RegisterMapSize("IsleofConquest",		0, 2650, 1766.66633)
DBM:RegisterMapSize("HrothgarsLanding",		0, 3677.0836, 2452.084)
--"TheArgentColiseum" = {{369.9862, 246.658}, {369.9862, 246.658}, {739.996, 493.33}} -- 3 levels? Exists on Coliseum
--"TheForgeofSouls" = {{1448.1, 965.4}} -- Exists on Party-WotLK
--"PitofSaron" = {{1533.3333, 1022.9167}} -- Exists on Party-WotLK
--"HallsofReflection" = {{879.02, 586.02}} -- Exists on Party-WotLK
--"TheRubySanctum" = {{752.0833, 502.084}} -- Exists on Ruby

---------------
--  Globals  --
---------------
DBM.RangeCheck = {}


--------------
--  Locals  --
--------------
local rangeCheck = DBM.RangeCheck
local checkFuncs = {}
local frame
local createFrame
local radarFrame
local createRadarFrame
local onUpdate
local onUpdateRadar
local dropdownFrame
local initializeDropdown
local initRangeCheck -- initializes the range check for a specific range (if necessary), returns false if the initialization failed (because of a map range check in an unknown zone)
local dots = {}
local charms = {}

-- for Phanx' Class Colors
local RAID_CLASS_COLORS = CUSTOM_CLASS_COLORS or RAID_CLASS_COLORS

local CHARM_TEX_COORDS = {
	[1] = 	{ 0,	0.25, 0,    0.25 },
	[2] = 	{ 0.25, 0.5,  0,    0.25 },
	[3] = 	{ 0.5, 	0.75, 0,    0.25 },
	[4] = 	{ 0.75, 1,    0,    0.25 },
	[5] = 	{ 0, 	0.25, 0.25, 0.5  },
	[6] = 	{ 0.25, 0.5,  0.25, 0.5  },
	[7] = 	{ 0.5, 	0.75, 0.25, 0.5  },
	[8] = 	{ 0.75, 1,    0.25, 0.5  }
}

--local hexColors = {}
local vertexColors = {}
for k, v in pairs(RAID_CLASS_COLORS) do
	--hexColors[k] = ("|cff%02x%02x%02x"):format(v.r * 255, v.g * 255, v.b * 255)
	vertexColors[k] = { v.r, v.g, v.b }
end
---------------------
--  Dropdown Menu  --
---------------------

-- todo: this dropdown menu is somewhat ugly and unflexible....
	local function setFrames(self, option)
		DBM.Options.RangeFrameFrames = option
		radarFrame:Hide()
		frame:Hide()
		rangeCheck:Show(frame.range, frame.filter)
	end

do
	local function setRange(self, range)
		rangeCheck:Show(range)
	end

	local sound0 = "none"
	local sound1 = "Interface\\AddOns\\DBM-Core\\Sounds\\blip_8.ogg"
	local sound2 = "Interface\\AddOns\\DBM-Core\\Sounds\\alarmclockbeeps.ogg"
	local function setSound(self, option, sound)
		DBM.Options[option] = sound
		if sound ~= "none" then
			PlaySoundFile(sound)
		end
	end

	local function setSpeed(self, option)
		DBM.Options.RangeFrameUpdates = option
	end

	local function toggleLocked()
		DBM.Options.RangeFrameLocked = not DBM.Options.RangeFrameLocked
	end

	local function toggleRadar()
		DBM.Options.RangeFrameRadar = not DBM.Options.RangeFrameRadar
		if DBM.Options.RangeFrameRadar then
			radarFrame = radarFrame or createRadarFrame()
			radarFrame:Show()
		else
			radarFrame:Hide()
		end
	end

	function initializeDropdown(dropdownFrame, level, menu)
		local info
		if level == 1 then
			info = UIDropDownMenu_CreateInfo()
			info.text = DBM_CORE_RANGECHECK_SETRANGE
			info.notCheckable = true
			info.hasArrow = true
			info.menuList = "range"
			UIDropDownMenu_AddButton(info, 1)

			info = UIDropDownMenu_CreateInfo()
			info.text = DBM_CORE_RANGECHECK_SOUNDS
			info.notCheckable = true
			info.hasArrow = true
			info.menuList = "sounds"
			UIDropDownMenu_AddButton(info, 1)

			info = UIDropDownMenu_CreateInfo()
			info.text = DBM_CORE_RANGECHECK_OPTION_FRAMES
			info.notCheckable = true
			info.hasArrow = true
			info.menuList = "frames"
			UIDropDownMenu_AddButton(info, 1)

			info = UIDropDownMenu_CreateInfo()
			info.text = DBM_CORE_RANGECHECK_OPTION_SPEED
			info.notCheckable = true
			info.hasArrow = true
			info.menuList = "speed"
			UIDropDownMenu_AddButton(info, 1)

			info = UIDropDownMenu_CreateInfo()
			info.text = DBM_CORE_RANGECHECK_LOCK
			if DBM.Options.RangeFrameLocked then
				info.checked = true
			end
			info.func = toggleLocked
			UIDropDownMenu_AddButton(info, 1)

			info = UIDropDownMenu_CreateInfo()
			info.text = DBM_CORE_RANGECHECK_HIDE
			info.notCheckable = true
			info.func = rangeCheck.Hide
			info.arg1 = rangeCheck
			UIDropDownMenu_AddButton(info, 1)

		elseif level == 2 then
			if menu == "range" then

				if initRangeCheck() then
					info = UIDropDownMenu_CreateInfo()
					info.text = DBM_CORE_RANGECHECK_SETRANGE_TO:format(5)
					info.func = setRange
					info.arg1 = 5
					info.checked = (frame.range == 5)
					UIDropDownMenu_AddButton(info, 2)
				end

				if initRangeCheck() then
					info = UIDropDownMenu_CreateInfo()
					info.text = DBM_CORE_RANGECHECK_SETRANGE_TO:format(6)
					info.func = setRange
					info.arg1 = 6
					info.checked = (frame.range == 6)
					UIDropDownMenu_AddButton(info, 2)
				end

				if initRangeCheck() then
					info = UIDropDownMenu_CreateInfo()
					info.text = DBM_CORE_RANGECHECK_SETRANGE_TO:format(7)
					info.func = setRange
					info.arg1 = 7
					info.checked = (frame.range == 7)
					UIDropDownMenu_AddButton(info, 2)
				end

				if initRangeCheck() then
					info = UIDropDownMenu_CreateInfo()
					info.text = DBM_CORE_RANGECHECK_SETRANGE_TO:format(8)
					info.func = setRange
					info.arg1 = 8
					info.checked = (frame.range == 8)
					UIDropDownMenu_AddButton(info, 2)
				end

				if initRangeCheck() then
					info = UIDropDownMenu_CreateInfo()
					info.text = DBM_CORE_RANGECHECK_SETRANGE_TO:format(9)
					info.func = setRange
					info.arg1 = 9
					info.checked = (frame.range == 9)
					UIDropDownMenu_AddButton(info, 2)
				end

				if initRangeCheck() then
					info = UIDropDownMenu_CreateInfo()
					info.text = DBM_CORE_RANGECHECK_SETRANGE_TO:format(10)
					info.func = setRange
					info.arg1 = 10
					info.checked = (frame.range == 10)
					UIDropDownMenu_AddButton(info, 2)
				end

				if initRangeCheck() then
					info = UIDropDownMenu_CreateInfo()
					info.text = DBM_CORE_RANGECHECK_SETRANGE_TO:format(11)
					info.func = setRange
					info.arg1 = 11
					info.checked = (frame.range == 11)
					UIDropDownMenu_AddButton(info, 2)
				end

				if initRangeCheck() then
					info = UIDropDownMenu_CreateInfo()
					info.text = DBM_CORE_RANGECHECK_SETRANGE_TO:format(12)
					info.func = setRange
					info.arg1 = 12
					info.checked = (frame.range == 12)
					UIDropDownMenu_AddButton(info, 2)
				end

				if initRangeCheck() then
					info = UIDropDownMenu_CreateInfo()
					info.text = DBM_CORE_RANGECHECK_SETRANGE_TO:format(13)
					info.func = setRange
					info.arg1 = 13
					info.checked = (frame.range == 13)
					UIDropDownMenu_AddButton(info, 2)
				end

				if initRangeCheck() then
					info = UIDropDownMenu_CreateInfo()
					info.text = DBM_CORE_RANGECHECK_SETRANGE_TO:format(14)
					info.func = setRange
					info.arg1 = 14
					info.checked = (frame.range == 14)
					UIDropDownMenu_AddButton(info, 2)
				end

				if initRangeCheck() then
					info = UIDropDownMenu_CreateInfo()
					info.text = DBM_CORE_RANGECHECK_SETRANGE_TO:format(15)
					info.func = setRange
					info.arg1 = 15
					info.checked = (frame.range == 15)
					UIDropDownMenu_AddButton(info, 2)
				end

				if initRangeCheck() then
					info = UIDropDownMenu_CreateInfo()
					info.text = DBM_CORE_RANGECHECK_SETRANGE_TO:format(20)
					info.func = setRange
					info.arg1 = 20
					info.checked = (frame.range == 20)
					UIDropDownMenu_AddButton(info, 2)
				end

				if initRangeCheck() then
					info = UIDropDownMenu_CreateInfo()
					info.text = DBM_CORE_RANGECHECK_SETRANGE_TO:format(28)
					info.func = setRange
					info.arg1 = 28
					info.checked = (frame.range == 28)
					UIDropDownMenu_AddButton(info, 2)
				end


			elseif menu == "sounds" then
				info = UIDropDownMenu_CreateInfo()
				info.text = DBM_CORE_RANGECHECK_SOUND_OPTION_1
				info.notCheckable = true
				info.hasArrow = true
				info.menuList = "RangeFrameSound1"
				UIDropDownMenu_AddButton(info, 2)

				info = UIDropDownMenu_CreateInfo()
				info.text = DBM_CORE_RANGECHECK_SOUND_OPTION_2
				info.notCheckable = true
				info.hasArrow = true
				info.menuList = "RangeFrameSound2"
				UIDropDownMenu_AddButton(info, 2)
			elseif menu == "frames" then
				info = UIDropDownMenu_CreateInfo()
				info.text = DBM_CORE_RANGECHECK_OPTION_TEXT
				info.func = setFrames
				info.arg1 = "text"
				info.checked = (DBM.Options.RangeFrameFrames == "text")
				UIDropDownMenu_AddButton(info, 2)

				info = UIDropDownMenu_CreateInfo()
				info.text = DBM_CORE_RANGECHECK_OPTION_RADAR
				info.func = setFrames
				info.arg1 = "radar"
				info.checked = (DBM.Options.RangeFrameFrames == "radar")
				UIDropDownMenu_AddButton(info, 2)

				info = UIDropDownMenu_CreateInfo()
				info.text = DBM_CORE_RANGECHECK_OPTION_BOTH
				info.func = setFrames
				info.arg1 = "both"
				info.checked = (DBM.Options.RangeFrameFrames == "both")
				UIDropDownMenu_AddButton(info, 2)
			elseif menu == "speed" then
				info = UIDropDownMenu_CreateInfo()
				info.text = DBM_CORE_RANGECHECK_OPTION_SLOW
				info.func = setSpeed
				info.arg1 = "Slow"
				info.checked = (DBM.Options.RangeFrameUpdates == "Slow")
				UIDropDownMenu_AddButton(info, 2)

				info = UIDropDownMenu_CreateInfo()
				info.text = DBM_CORE_RANGECHECK_OPTION_AVERAGE
				info.func = setSpeed
				info.arg1 = "Average"
				info.checked = (DBM.Options.RangeFrameUpdates == "Average")
				UIDropDownMenu_AddButton(info, 2)

				info = UIDropDownMenu_CreateInfo()
				info.text = DBM_CORE_RANGECHECK_OPTION_FAST
				info.func = setSpeed
				info.arg1 = "Fast"
				info.checked = (DBM.Options.RangeFrameUpdates == "Fast")
				UIDropDownMenu_AddButton(info, 2)
			end
		elseif level == 3 then
			local option = menu
			info = UIDropDownMenu_CreateInfo()
			info.text = DBM_CORE_RANGECHECK_SOUND_0
			info.func = setSound
			info.arg1 = option
			info.arg2 = sound0
			info.checked = (DBM.Options[option] == sound0)
			UIDropDownMenu_AddButton(info, 3)

			info = UIDropDownMenu_CreateInfo()
			info.text = DBM_CORE_RANGECHECK_SOUND_1
			info.func = setSound
			info.arg1 = option
			info.arg2 = sound1
			info.checked = (DBM.Options[option] == sound1)
			UIDropDownMenu_AddButton(info, 3)

			info = UIDropDownMenu_CreateInfo()
			info.text = DBM_CORE_RANGECHECK_SOUND_2
			info.func = setSound
			info.arg1 = option
			info.arg2 = sound2
			info.checked = (DBM.Options[option] == sound2)
			UIDropDownMenu_AddButton(info, 3)
		end
	end
end

-----------------
-- Play Sounds --
-----------------
local function updateSound(numPlayers) -- called every 5 seconds
	if not UnitAffectingCombat("player") then
		return
	end
	if numPlayers == 1 then
		if DBM.Options.RangeFrameSound1 ~= "none" then
			PlaySoundFile(DBM.Options.RangeFrameSound1)
		end
	elseif numPlayers > 1 then
		if DBM.Options.RangeFrameSound2 ~= "none" then
			PlaySoundFile(DBM.Options.RangeFrameSound2)
		end
	end
end

------------------------
--  Create the frame  --
------------------------
function createFrame()
	local elapsed = 0
	local updateRate
	if DBM.Options.RangeFrameUpdates == "Slow" then
		updateRate = 0.5
	elseif DBM.Options.RangeFrameUpdates == "Average" then
		updateRate = 0.25
	elseif DBM.Options.RangeFrameUpdates == "Fast" then
		updateRate = 0.05
	else
		updateRate = 0.05
	end
	local frame = CreateFrame("GameTooltip", "DBMRangeCheck", UIParent, "GameTooltipTemplate")
	dropdownFrame = CreateFrame("Frame", "DBMRangeCheckDropdown", frame, "UIDropDownMenuTemplate")
	frame:SetFrameStrata("DIALOG")
	frame:SetPoint(DBM.Options.RangeFramePoint, UIParent, DBM.Options.RangeFramePoint, DBM.Options.RangeFrameX, DBM.Options.RangeFrameY)
	frame:SetHeight(64)
	frame:SetWidth(64)
	frame:EnableMouse(true)
	frame:SetToplevel(true)
	frame:SetMovable()
	GameTooltip_OnLoad(frame)
	frame:SetPadding(16)
	frame:RegisterForDrag("LeftButton")
	frame:SetScript("OnDragStart", function(self)
		if not DBM.Options.RangeFrameLocked then
			self:StartMoving()
		end
	end)
	frame:SetScript("OnDragStop", function(self)
		self:StopMovingOrSizing()
		ValidateFramePosition(self)
		local point, _, _, x, y = self:GetPoint(1)
		DBM.Options.RangeFrameX = x
		DBM.Options.RangeFrameY = y
		DBM.Options.RangeFramePoint = point
	end)
	frame:SetScript("OnUpdate", function(self, e)
		elapsed = elapsed + e
		if elapsed >= updateRate and self.checkFunc then
			onUpdate(self, elapsed)
			elapsed = 0
		end
	end)
	frame:SetScript("OnMouseDown", function(self, button)
		if button == "RightButton" then
			UIDropDownMenu_Initialize(dropdownFrame, initializeDropdown, "MENU")
			ToggleDropDownMenu(1, nil, dropdownFrame, "cursor", 5, -10)
		end
	end)
	return frame
end

function createRadarFrame()
	local elapsed = 0
	local updateRate
	if DBM.Options.RangeFrameUpdates == "Slow" then
		updateRate = 0.5
	elseif DBM.Options.RangeFrameUpdates == "Average" then
		updateRate = 0.25
	elseif DBM.Options.RangeFrameUpdates == "Fast" then
		updateRate = 0.05
	else
		updateRate = 0.05
	end
	local radarFrame = CreateFrame("Frame", "DBMRangeCheckRadar", UIParent)
	radarFrame:SetFrameStrata("DIALOG")


	if (not DBM.Options.RangeFrameRadarPoint) then
		DBM:Debug("radar probably upgrading from an older version",3)
		DBM.Options.RangeFrameRadarPoint = DBM.DefaultOptions.RangeFrameRadarPoint
		DBM.Options.RangeFrameRadarX = DBM.DefaultOptions.RangeFrameRadarX
		DBM.Options.RangeFrameRadarY = DBM.DefaultOptions.RangeFrameRadarY
		DBM.Options.RangeFrameFrames = DBM.DefaultOptions.RangeFrameFrames
	end
	radarFrame:SetPoint(DBM.Options.RangeFrameRadarPoint, UIParent, DBM.Options.RangeFrameRadarPoint, DBM.Options.RangeFrameRadarX, DBM.Options.RangeFrameRadarY)
	radarFrame:SetHeight(128)
	radarFrame:SetWidth(128)
	radarFrame:EnableMouse(true)
	radarFrame:SetToplevel(true)
	radarFrame:SetMovable()
	radarFrame:RegisterForDrag("LeftButton")
	radarFrame:SetScript("OnDragStart", function(self)
		if not DBM.Options.RangeFrameLocked then
			self:StartMoving()
		end
	end)
	radarFrame:SetScript("OnDragStop", function(self)
		self:StopMovingOrSizing()
		ValidateFramePosition(self)
		local point, _, _, x, y = self:GetPoint(1)
		DBM.Options.RangeFrameRadarX = x
		DBM.Options.RangeFrameRadarY = y
		DBM.Options.RangeFrameRadarPoint = point
	end)
	radarFrame:SetScript("OnUpdate", function(self, e)
		elapsed = elapsed + e
		if elapsed >= updateRate then
			onUpdateRadar(self, elapsed)
			elapsed = 0
		end
	end)
	radarFrame:SetScript("OnMouseDown", function(self, button)
		if button == "RightButton" then
			UIDropDownMenu_Initialize(dropdownFrame, initializeDropdown, "MENU")
			ToggleDropDownMenu(1, nil, dropdownFrame, "cursor", 5, -10)
		end
	end)

	local bg = radarFrame:CreateTexture(nil, "BACKGROUND")
	bg:SetAllPoints(radarFrame)
	bg:SetBlendMode("BLEND")
	bg:SetTexture(0, 0, 0, 0.3)
	radarFrame.background = bg

	local circle = radarFrame:CreateTexture(nil, "ARTWORK")
	circle:SetPoint("CENTER")
	circle:SetTexture("Interface\\AddOns\\DBM-Core\\textures\\radar_circle.blp")
	circle:SetBlendMode("ADD")
	radarFrame.circle = circle

	local player = radarFrame:CreateTexture(nil, "OVERLAY")
	player:SetSize(32, 32)
	player:SetTexture("Interface\\Minimap\\MinimapArrow.blp")
	player:SetBlendMode("ADD")
	player:SetPoint("CENTER")

	local text = radarFrame:CreateFontString(nil, "OVERLAY","GameTooltipText")
	text:SetWidth(128)
	text:SetHeight(15)
	text:SetPoint("BOTTOMLEFT", radarFrame, "TOPLEFT", 0,0)
--	text:SetFont("Fonts\\FRIZQT__.TTF", 11)
	text:SetTextColor(1, 1, 1, 1)
	text:Show()
	radarFrame.text = text

--	for i=1, 40 do
--		local dot = CreateFrame("Frame", "DBMRangeCheckRadarDot"..i, radarFrame, "WorldMapPartyUnitTemplate")
--		dot:SetWidth(24)
--		dot:SetHeight(24)
--		dot:SetFrameStrata("TOOLTIP")
--		dot:Hide()
--		dots[i] = {dot = dot}
--	end
	for i=1, 8 do
		local charm = radarFrame:CreateTexture("DBMRangeCheckRadarCharm"..i, "OVERLAY")
		charm:SetTexture("interface\\targetingframe\\UI-RaidTargetingIcons.blp")
		charm:SetWidth(16)
		charm:SetHeight(16)
		charm:SetTexCoord(
			CHARM_TEX_COORDS[i][1],
			CHARM_TEX_COORDS[i][2],
			CHARM_TEX_COORDS[i][3],
			CHARM_TEX_COORDS[i][4]
		)
		charm:Hide()
		charms[i] = charm
	end

	radarFrame:Hide()
	return radarFrame
end

----------------
--  OnUpdate  --
----------------

local soundUpdate = 0
function onUpdate(self, elapsed)
	local color
	local j = 0
	self:ClearLines()
	self:SetText(DBM_CORE_RANGECHECK_HEADER:format(self.range), 1, 1, 1)
	if initRangeCheck(self.range) then
		if GetNumRaidMembers() > 0 then
			for i = 1, GetNumRaidMembers() do
				local uId = "raid"..i
				if not UnitIsUnit(uId, "player") and not UnitIsDeadOrGhost(uId) and self.checkFunc(uId, self.range) and (not self.filter or self.filter(uId)) then
					j = j + 1
					color = RAID_CLASS_COLORS[select(2, UnitClass(uId))] or NORMAL_FONT_COLOR
					local icon = GetRaidTargetIndex(uId)
					local text = icon and ("|TInterface\\TargetingFrame\\UI-RaidTargetingIcon_%d:0|t %s"):format(icon, UnitName(uId)) or UnitName(uId)
					self:AddLine(text, color.r, color.g, color.b)
					if j >= 5 then
						break
					end
				end
			end
		elseif GetNumPartyMembers() > 0 then
			for i = 1, GetNumPartyMembers() do
				local uId = "party"..i
				if not UnitIsUnit(uId, "player") and not UnitIsDeadOrGhost(uId) and self.checkFunc(uId, self.range) and (not self.filter or self.filter(uId)) then
					j = j + 1
					color = RAID_CLASS_COLORS[select(2, UnitClass(uId))] or NORMAL_FONT_COLOR
					local icon = GetRaidTargetIndex(uId)
					local text = icon and ("|TInterface\\TargetingFrame\\UI-RaidTargetingIcon_%d:0|t %s"):format(icon, UnitName(uId)) or UnitName(uId)
					self:AddLine(text, color.r, color.g, color.b)
					if j >= 5 then
						break
					end
				end
			end
		end
	else
		self:AddLine(DBM_CORE_RANGE_CHECK_ZONE_UNSUPPORTED:format(self.range))
	end
	soundUpdate = soundUpdate + elapsed
	if soundUpdate >= 5 and j > 0 then
		updateSound(j)
		soundUpdate = 0
	end
	self:Show()
end

do
	local rotation, pixelsperyard, prevNumPlayers, range, isInSupportedArea
	local function createDot(id)
		local dot = radarFrame:CreateTexture("DBMRangeCheckRadarDot"..id, "OVERLAY")
		dot:SetTexture([[Interface\AddOns\DBM-Core\textures\blip]])
		dot:SetWidth(16)
		dot:SetHeight(16)
		dot:Hide()

		dots[id].dot = dot	-- store the dot so we can use it later again
		return dot
	end

	local function setDotColor(id, class)
		if not class then -- set to white color, dont set .class so we can try again later when class returns properly i guess?
			dots[id].dot:SetVertexColor(unpack(vertexColors["PRIEST"]))
			return
		end
		if class and class == dots[id].class then return end

		dots[id].dot:SetVertexColor(unpack(vertexColors[class]))
		dots[id].class = class
	end

	local function setDot(id, icon, filtered)
		local dot = dots[id].dot or createDot(id)		-- load the dot, or create a new one if none exists yet (creating new probably never happens as the dots are created when the frame is created)
		local x = dots[id].x
		local y = dots[id].y
		local range = (x*x + y*y) ^ 0.5
		if range < (1.5 * frame.range) then							-- if person is closer than 1.5 * range, show the dot. Else hide it
			local dx = ((x * math.cos(rotation)) - (-y * math.sin(rotation))) * pixelsperyard		-- Rotate the X,Y based on player facing
			local dy = ((x * math.sin(rotation)) + (-y * math.cos(rotation))) * pixelsperyard

			if icon and type(icon) == "number" and icon >= 1 and icon <= 8 then -- GetRaidTargetIndex seems to return strange values sometimes; see http://www.deadlybossmods.com/phpbb3/viewtopic.php?f=2&t=3213&p=30889#p30889
				if dots[id].icon and dots[id].icon ~= icon then
					charms[dots[id].icon]:Hide()
				end
				if not filtered then
					charms[icon]:ClearAllPoints()
					charms[icon]:SetPoint("CENTER", radarFrame, "CENTER", dx, dy)
					charms[icon]:Show()
				else
					charms[icon]:Hide()
				end
				dot:Hide()
				dots[id].icon = icon
			elseif not filtered then
				dot:ClearAllPoints()
				dot:SetPoint("CENTER", radarFrame, "CENTER", dx, dy)
				dot:Show()
				if dots[id].icon then
					charms[dots[id].icon]:Hide()
					dots[id].icon = nil
				end
			else
				if dots[id].icon and dots[id].icon ~= icon then
					charms[dots[id].icon]:Hide()
					dots[id].icon = nil
				end
				dot:Hide()
			end
		else
			dot:Hide()
			if dots[id].icon then
				charms[dots[id].icon]:Hide()
				dots[id].icon = nil
			end
		end
		if range < 1.10 * frame.range and not filtered then		-- add an  extra 10% in case of inaccuracy
			dots[id].tooClose = true
		else
			dots[id].tooClose = false
		end
	end

	function onUpdateRadar(self, elapsed)
		if initRangeCheck(frame.range) then--This is basically fixing a bug with map not being on right dungeon level half the time.
			pixelsperyard = min(radarFrame:GetWidth(), radarFrame:GetHeight()) / (frame.range * 3)
			radarFrame.circle:SetSize(frame.range * pixelsperyard * 2, frame.range * pixelsperyard * 2)

			if frame.range ~= (range or 0) then
				range = frame.range
				radarFrame.text:SetText(DBM_CORE_RANGERADAR_HEADER:format(range))
			end

			local mapName = GetMapInfo()
			local level = GetCurrentMapDungeonLevel()
			local dims  = DBM.MapSizes[mapName] and DBM.MapSizes[mapName][level]
			if not dims then -- This ALWAYS happens when leaving a zone that has a map and moving into one that does not.
				if select(3, radarFrame.circle:GetVertexColor()) < 0.5 then
					radarFrame.circle:SetVertexColor(1,1,1)
				end
				for i, v in pairs(dots) do
					v.dot:Hide()
				end
				for i = 1, 8 do
					charms[i]:Hide()
				end
			else
				isInSupportedArea = true
				rotation = (2 * math.pi) - GetPlayerFacing()
				local numPlayers = 0
				local unitID = "raid%d"
				if GetNumRaidMembers() > 0 then
					unitID = "raid%d"
					numPlayers = GetNumRaidMembers()
				elseif GetNumPartyMembers() > 0 then
					unitID = "party%d"
					numPlayers = GetNumPartyMembers()
				end
				if numPlayers < (prevNumPlayers or 0) then
					for i=numPlayers, prevNumPlayers do
						if dots[i] then
							if dots[i].dot then
								dots[i].dot:Hide()		-- Hide dots when people leave the group
							end
							dots[i].tooClose = false
							dots[i].icon = nil
						end
					end
					for i=1, 8 do
						charms[i]:Hide()
					end
				end
				prevNumPlayers = numPlayers

				local playerX, playerY = GetPlayerMapPosition("player")
				if playerX == 0 and playerY == 0 then
					setFrames(self, "text")
					DBM:AddMsg("Radar is unavailable in this location: GetPlayerMapPosition(\"player\") = 0, 0")
				return end		-- Somehow we can't get the correct position?

				for i=1, numPlayers do
					local uId = unitID:format(i)
					if not UnitIsUnit(uId, "player") then
						local x,y = GetPlayerMapPosition(uId)
						if UnitIsDeadOrGhost(uId) then x = 100 end	-- hack to make sure dead people aren't shown
						if not dots[i] then
							dots[i] = {
								icon = nil,
								class = "none",
								x = (x - playerX) * dims[1],
								y = (y - playerY) * dims[2]
							}
						else
							dots[i].x = (x - playerX) * dims[1]
							dots[i].y = (y - playerY) * dims[2]
						end
						setDot(i, GetRaidTargetIndex(uId), (frame.filter and not frame.filter(uId)))
						setDotColor(i, (select(2, UnitClass(uId))))
					else
						if dots[i] and dots[i].dot then
							dots[i].dot:Hide()
						end
					end
				end

				local playerTooClose = false
				for i,v in pairs(dots) do
					if v.tooClose then
						playerTooClose = true
						break;
					end
				end
				if UnitIsDeadOrGhost("player") then
					radarFrame.circle:SetVertexColor(1,1,1)
				elseif playerTooClose then
					radarFrame.circle:SetVertexColor(1,0,0)
				else
					radarFrame.circle:SetVertexColor(0,1,0)
				end
				self:Show()
			end
		else
			if isInSupportedArea then
				-- we were in an area with known map dimensions during the last update but looks like we left it
				isInSupportedArea = false
				-- white frame
				radarFrame.circle:SetVertexColor(1,1,1)
				-- hide everything
				for i, v in pairs(dots) do
					v.dot:Hide()
				end
				for i = 1, 8 do
					charms[i]:Hide()
				end
			end
		end
	end
end


-----------------------
--  Check functions  --
-----------------------
checkFuncs[11] = function(uId)
	return CheckInteractDistance(uId, 2)
end


checkFuncs[10] = function(uId)
	return CheckInteractDistance(uId, 3)
end

checkFuncs[28] = function(uId)
	return CheckInteractDistance(uId, 4)
end


local getDistanceBetween
do
	local mapSizes = DBM.MapSizes

	function getDistanceBetween(uId, x, y)
		local startX, startY = GetPlayerMapPosition(uId)
		local mapName = GetMapInfo()
		local level = GetCurrentMapDungeonLevel()
		local dims = mapSizes[mapName] and mapSizes[mapName][level]
		if not dims then
			return
		end
		local dX = (startX - x) * dims[1]
		local dY = (startY - y) * dims[2]
		return math.sqrt(dX * dX + dY * dY)
	end

	local function mapRangeCheck(uId, range)
		return getDistanceBetween(uId, GetPlayerMapPosition("player")) < range
	end

	function initRangeCheck(range)
		if checkFuncs[range] ~= mapRangeCheck then
			return true
		end
		local pX, pY = GetPlayerMapPosition("player")
		if pX == 0 and pY == 0 then
			SetMapToCurrentZone()
			pX, pY = GetPlayerMapPosition("player")
		end
		local levels = mapSizes[GetMapInfo()]
		if not levels then
			return false
		end
		local level = GetCurrentMapDungeonLevel()
		local dims = levels[level]
		if not dims and levels and GetCurrentMapDungeonLevel() == 0 then -- we are in a known zone but the dungeon level seems to be wrong
			SetMapToCurrentZone() -- fixes the dungeon level
			dims = levels[GetCurrentMapDungeonLevel()] -- try again
			if not dims then -- there is actually a level 0 in this zone but we don't know about it...too bad :(
				return false
			end
		elseif not dims then
			return false
		end
		return true -- everything ok!
	end

	setmetatable(checkFuncs, {
		__index = function(t, k)
			return mapRangeCheck
		end
	})
end

do
	local bandages = {21991, 34721, 34722, 53049, 53050, 53051}  -- you should have one of these bandages in your cache

	checkFuncs[15] = function(uId)
		for i, v in ipairs(bandages) do
			if IsItemInRange(v, uId) == 1 then
				return true
			elseif IsItemInRange(v, uId) == 0 then
				return false
			end
		end
	end
end

---------------
--  Methods  --
---------------
function rangeCheck:Show(range, filter)
	SetMapToCurrentZone()--Set map to current zone before checking other stuff, work around annoying bug i hope?
	if type(range) == "function" then -- the first argument is optional
		return self:Show(nil, range)
	end
	local mapName = GetMapInfo()
	range = range or 10
	frame = frame or createFrame()
	radarFrame = radarFrame or createRadarFrame()
	frame.checkFunc = checkFuncs[range] or error(("Range \"%d yd\" is not supported."):format(range), 2)
	frame.range = range
	frame.filter = filter
	local level = GetCurrentMapDungeonLevel()
	if DBM.Options.RangeFrameFrames == "text" or DBM.Options.RangeFrameFrames == "both" or not DBM.MapSizes[mapName] or (DBM.MapSizes[mapName] and not DBM.MapSizes[mapName][level]) then
		frame:Show()
		frame:SetOwner(UIParent, "ANCHOR_PRESERVE")
		onUpdate(frame, 0)
	end
	if (DBM.Options.RangeFrameFrames == "radar" or DBM.Options.RangeFrameFrames == "both") and (DBM.MapSizes[mapName] and DBM.MapSizes[mapName][level]) then
		onUpdateRadar(radarFrame, 1)
	end
end

function rangeCheck:Hide()
	if frame then frame:Hide() end
	if radarFrame then radarFrame:Hide() end
end

function rangeCheck:IsShown()
	return frame and frame:IsShown() or radarFrame and radarFrame:IsShown()
end

function rangeCheck:GetDistance(...)
	if initRangeCheck() then
		return getDistanceBetween(...)
	end
end
