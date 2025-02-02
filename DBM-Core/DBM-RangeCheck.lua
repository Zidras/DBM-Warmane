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
--    * esES: Snamor/1nn7erpLaY     	romanscat@hotmail.com
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

----------------
--  MapSizes  --
----------------
-- Based on the [MPQ Patch] Classic/BC Dungeon Maps for WotLK, by Trimitor
DBM:RegisterMapSize("AhnQiraj",				-- Ahn'Qiraj 40 (Raid-Classic)
	1, 2777.544113162, 1851.6962890599989,
	2, 977.55993651999984, 651.70654296999965,
	3, 577.5600585899997, 385.04003906999969
)
DBM:RegisterMapSize("Ahnkahet",				1, 972.417968747, 648.27902221699992) -- Ahn'Kahet (Party-WotLK)
DBM:RegisterMapSize("Alterac",				0, 2799.9999389679997, 1866.666656494)
DBM:RegisterMapSize("AlteracValley",		0, 4237.49987793, 2824.99987793)
DBM:RegisterMapSize("Arathi",				0, 3599.999877933, 2399.999923703)
DBM:RegisterMapSize("ArathiBasin",			0, 1756.249923703, 1170.83325195)
DBM:RegisterMapSize("Ashenvale",			0, 5766.6663818399993, 3843.749877933)
DBM:RegisterMapSize("Aszhara",				0, 5070.83276368, 3381.24987793)
DBM:RegisterMapSize("AuchenaiCrypts",		-- Auchenai Crypts (Party-BC)
	1, 742.54043579099994, 495.026992798,
	2, 817.540466309, 545.026992798
)
DBM:RegisterMapSize("Azeroth",				0, 40741.1816406, 27149.6875)
DBM:RegisterMapSize("AzjolNerub",				-- Azjol-Nerub (Party-WotLK)
	1, 752.973999023, 501.983001709,			-- The Brood Pit
	2, 292.97399902300003, 195.31597900399998,	-- Hadronox's Lair
	3, 367.5, 245								-- The Gilded Gate
)
DBM:RegisterMapSize("AzuremystIsle",		0, 4070.8330078, 2714.58300781)
DBM:RegisterMapSize("Badlands",				0, 2487.5, 1658.3334961)
DBM:RegisterMapSize("Barrens",				0, 10133.33300782, 6756.24987793)
DBM:RegisterMapSize("BlackTemple",			-- Black Temple (Raid-BC). Has DungeonUsesTerrainMap()
	0, 783.333343506, 522.916625977,
	1, 1252.2495784784999, 834.833007813,
	2, 975, 650,
	3, 1005, 670,
	4, 440.000976562, 293.333984375,
	5, 670, 446.66668701599986,
	6, 705, 470,
	7, 355, 236.66662597599998
)
DBM:RegisterMapSize("BlackfathomDeeps",		-- Blackfathom Deeps (Party-Classic)
	1, 884.22000122000009, 589.4799728391,
	2, 884.220031738, 589.480010986,
	3, 284.22400426826, 189.48266601600005
)
DBM:RegisterMapSize("BlackrockDepths",		-- Blackrock Depths (Party-Classic)
	1, 1407.060974121, 938.040756224,
	2, 1507.060974121, 1004.7074279820001
)
DBM:RegisterMapSize("BlackrockSpire",		-- Blackrock Spire (Party-Classic)
	1, 886.8390140532, 591.22601318400007,
	2, 886.8390140532, 591.22601318400007,
	3, 886.8390140532, 591.22601318400007,
	4, 886.8390140532, 591.22601318400007,
	5, 886.8390140532, 591.22601318400007,
	6, 886.8390140532, 591.22601318400007,
	7, 886.8390140532, 591.22601318400007
)
DBM:RegisterMapSize("BlackwingLair",		-- Blackwing Lair (Raid-Classic)
	1, 499.42803955299996, 332.94970702999944,
	2, 649.42706299, 432.94970702999944,
	3, 649.42706299, 432.94970702999944,
	4, 649.42706299, 432.94970702999944
)
DBM:RegisterMapSize("BladesEdgeMountains",	0, 5424.9997558600007, 3616.666381833)
DBM:RegisterMapSize("BlastedLands",			0, 3349.99987793, 2233.3339844)
DBM:RegisterMapSize("BloodmystIsle",		0, 3262.4990233999997, 2174.9999389619998)
DBM:RegisterMapSize("BoreanTundra",			0, 5764.5830078100007, 3843.74987793)
DBM:RegisterMapSize("BurningSteppes",		0, 2929.166595456, 1952.0834960900011)
DBM:RegisterMapSize("CoTHillsbradFoothills", -- Caverns of Time: Old Hillsbrad Foothils (Party-BC)
	0, 2331.2499389679997, 1554.16662597
)
DBM:RegisterMapSize("CoTMountHyjal",		0, 2499.99975586, 1666.6665039)
DBM:RegisterMapSize("CoTStratholme",		-- The Culling of Stratholme (Party-WotLK) ; API returns levels 1 and 2 - this is corrected with DungeonUsesTerrainMap()
	0, 1824.999938962, 1216.6665039099998,	-- DUNGEON_FLOOR_COTSTRATHOLME0 = "The Road to Stratholme"
	1, 1125.2999877910001, 750.1999511700003-- DUNGEON_FLOOR_COTSTRATHOLME1 = "Stratholme City"
)
DBM:RegisterMapSize("CoTTheBlackMorass",	-- Caverns of Time: The Black Morass (Party-BC)
	0, 1087.5, 725
)
DBM:RegisterMapSize("CoilfangReservoir",	-- Coilfang: Serpentshrine Cavern (Raid-BC)
	1, 1575.002975463, 1050.00201416
)
DBM:RegisterMapSize("CrystalsongForest",	0, 2722.91662598, 1814.5830078099998)
DBM:RegisterMapSize("Dalaran",
	1, 830.01501465299987, 553.33984375,
	2, 563.223999023, 375.48974609000015
)
DBM:RegisterMapSize("Darkshore",			0, 6549.99975586, 4366.6665039000009)
DBM:RegisterMapSize("Darnassis",			0, 1058.3332519500002, 705.72949223999967)
DBM:RegisterMapSize("DeadwindPass",			0, 2499.9999389619998, 1666.6669921699995)
DBM:RegisterMapSize("DeeprunTram",
	1, 312, 208,
	2, 309, 208
)
DBM:RegisterMapSize("Desolace",				0, 4495.83300781, 2997.916564938)
DBM:RegisterMapSize("DireMaul",				-- Dire Maul (Party-Classic)
	1, 1275, 850,
	2, 525, 350,
	3, 487.5, 325,
	4, 750, 500,
	5, 800.0008010864, 533.33399963400007,
	6, 975, 650
)
DBM:RegisterMapSize("Dragonblight",			0, 5608.33312988, 3739.58337402)
DBM:RegisterMapSize("DrakTharonKeep",		-- Drak'Tharon Keep (Party-WotLK)
	1, 619.94100952200006, 413.293991089,	-- The Vestibules of Drak'Tharon
	2, 619.941009526, 413.293991089			-- Drak'Tharon Overlook
)
DBM:RegisterMapSize("DunMorogh",			0, 4924.99975586, 3283.33325196)
DBM:RegisterMapSize("Durotar",				0, 5287.4996337899993, 3524.99987793)
DBM:RegisterMapSize("Duskwood",				0, 2699.9999389679997, 1799.9999999699994)
DBM:RegisterMapSize("Dustwallow",			0, 5250.000061035, 3499.99975586)
DBM:RegisterMapSize("EasternPlaguelands",	0, 4031.25, 2687.49987793)
DBM:RegisterMapSize("Elwynn",				0, 3470.83325196, 2314.58300779)
DBM:RegisterMapSize("EversongWoods" ,		0, 4925, 3283.33300779)
DBM:RegisterMapSize("Expansion01",			0, 17464.078125, 11642.71875) -- Old client Zangarmarsh BC dungeons. [MPQ Patch] "Classic/BC Dungeon Maps for WotLK" fixes mapInfo
DBM:RegisterMapSize("Felwood",				0, 5749.9996337899993, 3833.33325195)
DBM:RegisterMapSize("Feralas",				0, 6949.99975586, 4633.33300781)
DBM:RegisterMapSize("Ghostlands",			0, 3300.0000000000009, 2199.9995117200006)
DBM:RegisterMapSize("Gnomeregan",			-- Gnomeregan (Party-Classic)
	1, 769.667999268, 513.111999512,
	2, 769.6679992678, 513.111999512,
	3, 869.667999268, 579.778015137,
	4, 869.6697082523001, 579.77999877899992
)
DBM:RegisterMapSize("GrizzlyHills",			0, 5249.99987793, 3499.99987793)
DBM:RegisterMapSize("GruulsLair",			-- Gruul's Lair (Raid-BC)
	1, 525, 350
)
DBM:RegisterMapSize("Gundrak",				-- Gundrak (Party-WotLK)
	1, 905.033050542, 603.3500976600003
)
DBM:RegisterMapSize("HallsofLightning",			-- Halls of Lightning (Party-WotLK)
	1, 566.235015869, 377.4899902300001,		-- Unyielding Garrison
	2, 708.23701477000009, 472.16003417699994	-- Walk of the Makers
)
DBM:RegisterMapSize("HallsofReflection",	-- Halls of Reflection (Party-WotLK)
	1, 879.02001954, 586.0195312399992
)
DBM:RegisterMapSize("Hellfire",				0, 5164.58300781, 3443.74987793)
DBM:RegisterMapSize("HellfireRamparts",		-- Hellfire Citadel: Ramparts (Party-BC)
	1, 694.5600586, 463.04003906
)
DBM:RegisterMapSize("Hilsbrad",				0, 3199.99987793, 2133.33325195)
DBM:RegisterMapSize("Hinterlands",			0, 3850, 2566.66662598)
DBM:RegisterMapSize("HowlingFjord",			0, 6045.8328857399993, 4031.249816898)
DBM:RegisterMapSize("HrothgarsLanding",		0, 3677.083129887, 2452.0839843699996)
DBM:RegisterMapSize("IcecrownCitadel",			-- Icecrown Citadel (Raid-WotLK)
	1, 1355.47009278, 903.647033691,			-- The Lower Citadel
	2, 1067, 711.3336906438,					-- The Rampart of Skulls
	3, 195.46997069999998, 130.315002441,		-- Deathbringer's Rise
	4, 773.71008301000006, 515.81030273000033,	-- The Frost Queen's Lair
	5, 1148.7399902399998, 765.82006835999982,	-- The Upper Reaches
	6, 373.7099609400002, 249.1298828099998,	-- Royal Quarters
	7, 293.2600097699999, 195.50701904200002,	-- The Frozen Throne
	8, 247.92993164000018, 165.287994385		-- Frostmourne
)
DBM:RegisterMapSize("IcecrownGlacier",		0, 6270.833312988, 4181.2500000000009)
DBM:RegisterMapSize("Ironforge",			0, 790.625061031, 527.6044921900002)
DBM:RegisterMapSize("IsleofConquest",		0, 2650, 1766.6665840118)
DBM:RegisterMapSize("Kalimdor",				0, 36799.8105469, 24533.2001953)
DBM:RegisterMapSize("Karazhan",				-- Karazhan (Raid-BC)
	1, 550.04882811999983, 366.69921880000038,
	2, 257.85986329, 171.90625,
	3, 345.1494140599998, 230.09960940000019,
	4, 520.04882811999983, 346.69921880000038,
	5, 234.14990233999993, 156.09960940000019,
	6, 581.54882811999983, 387.69921880000038,
	7, 191.54882811999983, 127.69921880000038,
	8, 139.35058593999997, 92.90039059999981,
	9, 760.04882811999983, 506.69921880000038,
	10, 450.25, 300.16601559999981,
	11, 271.05004882999992, 180.69921880000038,
	12, 595.04882811999983, 396.69921880000038,
	13, 529.04882812, 352.69921880000038,
	14, 245.25, 163.5,
	15, 211.14990233999993, 140.765625,
	16, 101.25, 67.5,
	17, 341.24999999999977, 227.5
)
DBM:RegisterMapSize("LakeWintergrasp",		0, 2974.99987793, 1983.3332519599999)
DBM:RegisterMapSize("LochModan",			0, 2758.33312988, 1839.5830078099998)
DBM:RegisterMapSize("MagistersTerrace",	-- Magister's Terrace (Party-BC)
	1, 530.334014893, 353.5559692383,
	2, 530.334014893, 353.5559921261
)
DBM:RegisterMapSize("MagtheridonsLair",	-- Magtheridon's Lair (Raid-BC)
	1, 556, 370.666694641
)
DBM:RegisterMapSize("ManaTombs",		-- Mana-Tombs (Party-BC)
	1, 823.28515625, 548.85681152329994
)
DBM:RegisterMapSize("Maraudon",			-- Maraudon (Party-Classic)
	1, 975, 650,
	2, 1637.5, 1091.666000367
)
DBM:RegisterMapSize("MoltenCore",		-- Molten Core (Raid-Classic)
	1, 1264.800064083, 843.19906615799994
)
DBM:RegisterMapSize("Moonglade",			0, 2308.33325195, 1539.5830078200006)
DBM:RegisterMapSize("Mulgore",				0, 5137.49987793, 3424.9998474159997)
DBM:RegisterMapSize("Nagrand",				0, 5524.99999999, 3683.3331680335)
DBM:RegisterMapSize("Naxxramas",			-- Naxxramas (Raid-WotLK)
	1, 1093.83007813, 729.21997070999987,	-- The Construct Quarter
	2, 1093.83007813, 729.21997070999987,	-- The Arachnid Quarter
	3, 1200, 800,							-- The Military Quarter
	4, 1200.33007813, 800.21997070999987,	-- The Plague Quarter
	5, 2069.80981445, 1379.8798828099998,	-- The Lower Necropolis
	6, 655.9399414, 437.2900390599998		-- The Upper Necropolis
)
DBM:RegisterMapSize("Netherstorm",			0, 5574.9996719334995, 3716.66674805)
DBM:RegisterMapSize("NetherstormArena",		0, 2270.8331909219996, 1514.58337402)
DBM:RegisterMapSize("Nexus80",					-- The Oculus (Party-WotLK)
	1, 514.70697021699993, 343.13897705299996,	-- Band of Variance
	2, 664.70697021699993, 443.13897705299996,	-- Band of Acceleration
	3, 514.70697021699993, 343.13897705299996,	-- Band of Transmutation
	4, 294.70098877199996, 196.46398926100017	-- Band of Alignment
)
DBM:RegisterMapSize("Northrend",			0, 17751.3984375, 11834.26501465)
DBM:RegisterMapSize("Ogrimmar",				0, 1402.6044921899997, 935.41662598000016)
DBM:RegisterMapSize("OnyxiasLair",			-- Onyxia's Lair (Raid-WotLK)
	1, 483.117988587, 322.07878875759997
)
DBM:RegisterMapSize("PitofSaron",			0, 1533.333312988, 1022.916671753) -- Pit of Saron (Party-WotLK)
DBM:RegisterMapSize("Ragefire",				-- Ragefire Chasm (Party-Classic)
	1, 738.864013672, 492.57620239290003
)
DBM:RegisterMapSize("RazorfenDowns",		-- Razorfen Downs (Party-Classic)
	1, 709.048950199, 472.69995117000008
)
DBM:RegisterMapSize("RazorfenKraul",		-- Razorfen Kraul (Party-Classic)
	1, 736.44995118, 490.95983886999988
)
DBM:RegisterMapSize("Redridge",				0, 2170.83325196, 1447.9160155999998)
DBM:RegisterMapSize("RuinsofAhnQiraj",		0, 2512.499877933, 1675) -- Ahn'Qiraj 20 (Raid-Classic)

DBM:RegisterMapSize("ScarletEnclave",		0, 3162.5, 2108.333374023)
DBM:RegisterMapSize("ScarletMonastery",		-- Scarlet Monastery (Party-Classic)
	1, 619.983947751, 413.32275390000018,
	2, 320.190994263, 213.4604949947,
	3, 612.6966094966, 408.45996094,
	4, 703.30004882, 468.86669921500004
)
DBM:RegisterMapSize("Scholomance",			-- Scholomance (Party-Classic)
	1, 320.0489044188, 213.364997864,
	2, 440.04901123, 293.3664054871,
	3, 410.0779953, 273.3857994075,
	4, 531.04200744700006, 354.0281982418
)
DBM:RegisterMapSize("SearingGorge",			0, 2231.2498474159997, 1487.4995117199996)
DBM:RegisterMapSize("SethekkHalls",			-- Auchindoun: Sethekk Halls (Party-BC)
	1, 703.495483399, 468.996994019,
	2, 703.495483399, 468.996994019
)
DBM:RegisterMapSize("ShadowLabyrinth",		-- Shadow Labyrinth (Party-BC)
	1, 841.522354126, 561.0148887639
)
DBM:RegisterMapSize("ShadowfangKeep",		-- Shadowfang Keep (Party-Classic)
	1, 352.43005371000004, 234.95339202830002,
	2, 212.42675781000025, 141.617996216,
	3, 152.42993164000018, 101.6199646001,
	4, 152.42993164000018, 101.6246948243,
	5, 152.42993164000018, 101.6246948243,
	6, 198.42993164000018, 132.2866287233,
	7, 272.42993164000018, 181.6199646001
)
DBM:RegisterMapSize("ShadowmoonValley",		0, 5500, 3666.66638183)
DBM:RegisterMapSize("ShattrathCity",		0, 1306.25, 870.83337403)
DBM:RegisterMapSize("SholazarBasin",		0, 4356.25, 2904.16650391)
DBM:RegisterMapSize("Silithus",				0, 3483.333984375, 2322.9160156199996)
DBM:RegisterMapSize("SilvermoonCity",		0, 1211.4584960900002, 806.77050783999948)
DBM:RegisterMapSize("Silverpine",			0, 4199.99975586, 2799.99987793)
DBM:RegisterMapSize("StonetalonMountains",	0, 4883.33312988, 3256.249816898)
DBM:RegisterMapSize("Stormwind",			0, 1737.4999589954, 1158.3330078200006)
DBM:RegisterMapSize("StrandoftheAncients",	0, 1743.749938965, 1162.499938962)
DBM:RegisterMapSize("Stranglethorn",		0, 6381.24975586, 4254.1660156)
DBM:RegisterMapSize("Stratholme",			-- Stratholme (Party-Classic)
	1, 705.7199707, 470.4799804700001,
	2, 1005.7204589799999, 670.48022460999982
)
DBM:RegisterMapSize("Sunwell",				0, 3327.0830078200006, 2218.7490233999997)
DBM:RegisterMapSize("SunwellPlateau",		-- The Sunwell (Raid-BC)
	0, 906.25, 604.16662597999994,
	1, 465, 310
)
DBM:RegisterMapSize("SwampOfSorrows",		0, 2293.75, 1529.1669921899993)
DBM:RegisterMapSize("Tanaris",				0, 6899.999526979, 4600)
DBM:RegisterMapSize("Teldrassil",			0, 5091.6665039, 3393.75)
DBM:RegisterMapSize("TempestKeep",			-- Tempest Keep (Raid-BC)
	1, 1575, 1050
)
DBM:RegisterMapSize("TerokkarForest",		0, 5399.99975586, 3600.000061035)
DBM:RegisterMapSize("TheArcatraz",			-- Tempest Keep: The Arcatraz (Party-BC)
	1, 689.68402099600007, 459.78935241700003,
	2, 546.048049927, 364.032012939,
	3, 636.684005737, 424.45602417
)
DBM:RegisterMapSize("TheArgentColiseum",	-- Trial of the Crusader (Raid-WotLK)
	1, 369.9861869814, 246.657989502,		-- The Argent Coliseum
	2, 739.996017456, 493.33001709			-- The Icy Depths
)
DBM:RegisterMapSize("TheBloodFurnace",		-- Hellfire Citadel: The Blood Furnace (Party-BC)
	1, 1003.519012451, 669.012687683
)
DBM:RegisterMapSize("TheBotanica",			-- Tempest Keep: The Botanica (Party-BC)
	1, 757.40248107899993, 504.934997558
)
DBM:RegisterMapSize("TheDeadmines",			-- Deadmines (Party-Classic)
	1, 559.2640075679999, 372.8425025944,
	2, 499.26300049099996, 332.84230041549995
)
DBM:RegisterMapSize("TheExodar",			0, 1056.7705078, 704.68774414000018)
DBM:RegisterMapSize("TheEyeofEternity",		-- The Eye of Eternity (Raid-WotLK)
	1, 430.07006836000005, 286.713012695
)
DBM:RegisterMapSize("TheForgeofSouls",		-- The Forge of Souls (Party-WotLK)
	1, 1448.0998535099998, 965.40039062000051
)
DBM:RegisterMapSize("TheMechanar",			-- Tempest Keep: The Mechanar (Party-BC)
	1, 676.23800659199992, 450.825401306,
	2, 676.23800659199992, 450.8253669737
)
DBM:RegisterMapSize("TheNexus",				1, 1101.280975342, 734.1874999997) -- The Nexus (Party-WotLK)
DBM:RegisterMapSize("TheObsidianSanctum",	0, 1162.4999179809, 775) -- The Obsidian Sanctum (Raid-WotLK)
DBM:RegisterMapSize("TheRubySanctum",		0, 752.083312988, 502.08325195999987) -- The Ruby Sanctum (Raid-WotLK)
DBM:RegisterMapSize("TheShatteredHalls",	1, 1063.747467041, 709.1649932866) -- Hellfire Citadel: The Shattered Hall (Party-BC)
DBM:RegisterMapSize("TheSlavePens",			1, 890.05812454269994, 593.372070312) -- Coilfang: The Slave Pens (Party-BC)
DBM:RegisterMapSize("TheSteamvault",		-- Coilfang: The Steamvault (Party-BC)
	1, 876.764007569, 584.509414673,
	2, 876.764007569, 584.509414673
)
DBM:RegisterMapSize("TheStockade",			1, 378.152999878, 252.10249519299998) -- Stormwind Stockade (Party-Classic)
DBM:RegisterMapSize("TheStormPeaks",		0, 7112.4996337899993, 4741.6660156)
DBM:RegisterMapSize("TheTempleOfAtalHakkar",	-- Sunken Temple (Party-Classic)
	1, 695.028991699, 463.35298156799996,
	2, 248.1767673494, 166.03546142599998,
	3, 556.16923522999991, 370.38801574700005
)
DBM:RegisterMapSize("TheUnderbog",			1, 894.919998169, 596.613357544) -- Coilfang: The Underbog (Party-BC)
DBM:RegisterMapSize("ThousandNeedles",		0, 4399.999694822, 2933.33300781)
DBM:RegisterMapSize("ThunderBluff",			0, 1043.749938965, 695.833312985)
DBM:RegisterMapSize("Tirisfal",				0, 4518.74987793, 3012.4998168949996)
DBM:RegisterMapSize("Uldaman",				-- Uldaman (Party-Classic)
	1, 893.668014527, 595.778991699,
	2, 492.57041931180004, 328.3804931642
)
DBM:RegisterMapSize("Ulduar",				-- Ulduar (Raid-WotLK). Has DungeonUsesTerrainMap()
	0, 3287.49987793, 2191.66662598,			-- DUNGEON_FLOOR_ULDUAR0 = "The Grand Approach"
	1, 669.45098877000009, 446.30004882999992,	-- DUNGEON_FLOOR_ULDUAR1 = "The Antechamber of Ulduar"
	2, 1328.4609985349998, 885.63989258000015,	-- DUNGEON_FLOOR_ULDUAR2 = "The Inner Sanctum of Ulduar"
	3, 910.5, 607,								-- DUNGEON_FLOOR_ULDUAR3 = "The Prison of Yogg-Saron"
	4, 1569.45996094, 1046.30004883,			-- DUNGEON_FLOOR_ULDUAR4 = "The Spark of Imagination"
	5, 619.46899414, 412.9799804700001			-- DUNGEON_FLOOR_ULDUAR5 = "The Mind's Eye"
)
DBM:RegisterMapSize("Ulduar77",				1, 920.19601440299994, 613.466064453) -- Halls of Stone (Party-WotLK)
DBM:RegisterMapSize("Undercity",			0, 959.37503051749991, 640.10412597999994)
DBM:RegisterMapSize("UngoroCrater",			0, 33699.999816898, 2466.6665039000009)
DBM:RegisterMapSize("UtgardeKeep",		-- Utgarde Keep (Party-WotLK)
	1, 734.580993652, 489.72150039639996,	-- Norndir Preperation
	2, 481.081008911, 320.72029304480003,	-- Dragonflayer Ascent
	3, 736.581008911, 491.05451202409995	-- Tyr's Terrace
)
DBM:RegisterMapSize("UtgardePinnacle",		-- Utgarde Pinnacle (Party-WotLK)
	1, 548.93601989699994, 365.95701599100005,	-- Lower Pinnacle
	2, 756.17994308428, 504.11900329599996		-- Upper Pinnacle
)
DBM:RegisterMapSize("VaultofArchavon",		1, 1398.2550048829999, 932.170013428) -- Vault of Archavon (Raid-WotLK)
DBM:RegisterMapSize("VioletHold",			1, 256.229003907, 170.82006836000005) -- The Violet Hold (Raid-WotLK)
DBM:RegisterMapSize("WailingCaverns",		1, 936.47500610299994, 624.315994263) -- Wailing Caverns (Party-Classic)
DBM:RegisterMapSize("WarsongGulch",			0, 1145.833312992, 764.583312985)
DBM:RegisterMapSize("WesternPlaguelands",	0, 4299.999908444, 2866.666534428)
DBM:RegisterMapSize("Westfall",				0, 3499.999816898, 2333.3330078)
DBM:RegisterMapSize("Wetlands",				0, 4135.416687012, 2756.25)
DBM:RegisterMapSize("Winterspring",			0, 7099.999847416, 4733.3332519500009)
DBM:RegisterMapSize("Zangarmarsh",			0, 5027.08349609, 3352.08325196)
DBM:RegisterMapSize("ZulAman",				0, 1268.749938962, 845.833312988) -- Zul'Aman (Raid-BC)
DBM:RegisterMapSize("ZulDrak",				0, 4993.75, 3329.16650391)
DBM:RegisterMapSize("ZulFarrak",			0, 1383.3332214359998, 922.91662597) -- Zul'Farrak (Party-Classic)
DBM:RegisterMapSize("ZulGurub",				0, 2120.83325195, 1414.5830078) -- Zul'Gurub (Raid-Classic)

local _, private = ...

---------------
--  Globals  --
---------------
DBM.RangeCheck = {}

--------------
--  Locals  --
--------------
local L = DBM_CORE_L
local rangeCheck = DBM.RangeCheck
local mainFrame = CreateFrame("Frame")
local textFrame, radarFrame, updateIcon, updateRangeFrame, initializeDropdown
local RAID_CLASS_COLORS = _G["CUSTOM_CLASS_COLORS"] or RAID_CLASS_COLORS -- For Phanx' Class Colors

---------------------------
--  Unit Position/Range  --
---------------------------
-- API
local GetPlayerMapPosition = GetPlayerMapPosition
local UnitInRaid, UnitInParty, UnitIsPlayer = UnitInRaid, UnitInParty, UnitIsPlayer
-- Nil variables
local rangeX, rangeY
-- Lib
local LibRangeCheck = LibStub("LibRangeCheck-2.0")

local HarmItems = { -- for BossMode, to avoid iterating thru pairs of lib harmRC
	[5] = {
		37727, -- Ruby Acorn
	},
	[8] = {
		34368, -- Attuned Crystal Cores
		33278, -- Burning Torch
	},
	[10] = {
		32321, -- Sparrowhawk Net
	},
	[15] = {
		33069, -- Sturdy Rope
	},
	[20] = {
		10645, -- Gnomish Death Ray
	},
	[25] = {
		24268, -- Netherweave Net
		41509, -- Frostweave Net
		31463, -- Zezzak's Shard
	},
	[30] = {
		835, -- Large Rope Net
		7734, -- Six Demon Bag
		34191, -- Handful of Snowflakes
	},
	[35] = {
		24269, -- Heavy Netherweave Net
		18904, -- Zorbin's Ultra-Shrinker
	},
	[40] = {
		28767, -- The Decapitator
	},
	[45] = {
		32698, -- Wrangling Rope
	},
	[60] = {
		32825, -- Soul Cannon
		37887, -- Seeds of Nature's Wrath
	},
	[80] = {
		35278, -- Reinforced Net
	},
}

local function getUnitRange(unit)
	local restrictionsActive = DBM:HasMapRestrictions()
	if not restrictionsActive and (UnitInRaid(unit) or UnitInParty(unit)) and UnitIsPlayer(unit) then
		local mapX, mapY = DBM:GetMapSize()

		local playerX, playerY = GetPlayerMapPosition("player")
		local unitX, unitY = GetPlayerMapPosition(unit)
		rangeX, rangeY = (unitX - playerX) * mapX, (unitY - playerY) * mapY
		local range = (rangeX * rangeX + rangeY * rangeY) ^ 0.5

		return range
	else
		return LibRangeCheck:GetRange(unit)
	end
end

---------------------
--  Dropdown Menu  --
---------------------
do
	local sounds = {
		"none",
		"Interface\\AddOns\\DBM-Core\\Sounds\\blip_8.ogg",
		"Interface\\AddOns\\DBM-Core\\Sounds\\alarmclockbeeps.ogg"
	}

	local function setSound(self, option, sound)
		DBM.Options[option] = sound
		if sound ~= "none" then
			DBM:PlaySoundFile(sound)
		end
	end

	local function setRange(self, range)
		rangeCheck:Hide(true)
		rangeCheck:Show(range, mainFrame.filter, true, mainFrame.redCircleNumPlayers or 1)
	end

	local function setThreshold(self, threshold)
		rangeCheck:Hide(true)
		rangeCheck:Show(mainFrame.range, mainFrame.filter, true, threshold)
	end

	local function setFrames(self, option)
		DBM.Options.RangeFrameFrames = option
		rangeCheck:Hide(true)
		rangeCheck:Show(mainFrame.range, mainFrame.filter, true, mainFrame.redCircleNumPlayers or 1)
	end

	-- local function setSpeed(self, option)
	--	DBM.Options.RangeFrameUpdates = option
	-- end

	local function toggleLocked()
		DBM.Options.RangeFrameLocked = not DBM.Options.RangeFrameLocked
	end

	function initializeDropdown(_, level, menu) -- dropdownFrame, level, menu
		local info

		if level == 1 then
			info = UIDropDownMenu_CreateInfo()
			info.text = L.RANGECHECK_SETRANGE
			info.notCheckable = true
			info.hasArrow = true
			info.keepShownOnClick = true
			info.menuList = "range"
			UIDropDownMenu_AddButton(info, 1)

			info = UIDropDownMenu_CreateInfo()
			info.text = L.RANGECHECK_SETTHRESHOLD
			info.notCheckable = true
			info.hasArrow = true
			info.keepShownOnClick = true
			info.menuList = "threshold"
			UIDropDownMenu_AddButton(info, 1)

			info = UIDropDownMenu_CreateInfo()
			info.text = L.RANGECHECK_SOUNDS
			info.notCheckable = true
			info.hasArrow = true
			info.keepShownOnClick = true
			info.menuList = "sounds"
			UIDropDownMenu_AddButton(info, 1)

			info = UIDropDownMenu_CreateInfo()
			info.text = L.RANGECHECK_OPTION_FRAMES
			info.notCheckable = true
			info.hasArrow = true
			info.keepShownOnClick = true
			info.menuList = "frames"
			UIDropDownMenu_AddButton(info, 1)

			-- info = UIDropDownMenu_CreateInfo()
			-- info.text = L.RANGECHECK_OPTION_SPEED
			-- info.notCheckable = true
			-- info.hasArrow = true
			-- info.keepShownOnClick = true
			-- info.menuList = "speed"
			-- UIDropDownMenu_AddButton(info, 1)

			info = UIDropDownMenu_CreateInfo()
			info.text = L.RANGECHECK_LOCK
			if DBM.Options.RangeFrameLocked then
				info.checked = true
			end
			info.func = toggleLocked
			UIDropDownMenu_AddButton(info, 1)

			info = UIDropDownMenu_CreateInfo()
			info.text = HIDE
			info.notCheckable = true
			info.func = function() rangeCheck:Hide(true) end
			info.arg1 = rangeCheck
			UIDropDownMenu_AddButton(info, 1)
		elseif level == 2 then
			if menu == "range" then
				local ranges = {5, 8, 10, 15, 20, 25, 30, 35, 40, 45, 60, 80}

				for _, r in pairs(ranges) do
					info = UIDropDownMenu_CreateInfo()
					info.text = L.RANGECHECK_SETRANGE_TO:format(r)
					info.func = setRange
					info.arg1 = r
					info.checked = (mainFrame.range == r)
					UIDropDownMenu_AddButton(info, 2)
				end
			elseif menu == "threshold" then
				local thresholds = {1, 2, 3, 4, 5, 6, 8}

				for _, t in pairs(thresholds) do
					info = UIDropDownMenu_CreateInfo()
					info.text = t
					info.func = setThreshold
					info.arg1 = t
					info.checked = (mainFrame.redCircleNumPlayers == t)
					UIDropDownMenu_AddButton(info, 2)
				end
			elseif menu == "sounds" then
				info = UIDropDownMenu_CreateInfo()
				info.text = L.RANGECHECK_SOUND_OPTION_1
				info.notCheckable = true
				info.hasArrow = true
				info.menuList = "RangeFrameSound1"
				UIDropDownMenu_AddButton(info, 2)

				info = UIDropDownMenu_CreateInfo()
				info.text = L.RANGECHECK_SOUND_OPTION_2
				info.notCheckable = true
				info.hasArrow = true
				info.menuList = "RangeFrameSound2"
				UIDropDownMenu_AddButton(info, 2)
			elseif menu == "frames" then
				info = UIDropDownMenu_CreateInfo()
				info.text = L.RANGECHECK_OPTION_TEXT
				info.func = setFrames
				info.arg1 = "text"
				info.checked = (DBM.Options.RangeFrameFrames == "text")
				UIDropDownMenu_AddButton(info, 2)

				info = UIDropDownMenu_CreateInfo()
				info.text = L.RANGECHECK_OPTION_RADAR
				info.func = setFrames
				info.arg1 = "radar"
				info.checked = (DBM.Options.RangeFrameFrames == "radar")
				UIDropDownMenu_AddButton(info, 2)

				info = UIDropDownMenu_CreateInfo()
				info.text = L.RANGECHECK_OPTION_BOTH
				info.func = setFrames
				info.arg1 = "both"
				info.checked = (DBM.Options.RangeFrameFrames == "both")
				UIDropDownMenu_AddButton(info, 2)
			-- elseif menu == "speed" then
			--	info = UIDropDownMenu_CreateInfo()
			--	info.text = L.RANGECHECK_OPTION_SLOW
			--	info.func = setSpeed
			--	info.arg1 = "Slow"
			--	info.checked = (DBM.Options.RangeFrameUpdates == "Slow")
			--	UIDropDownMenu_AddButton(info, 2)

			--	info = UIDropDownMenu_CreateInfo()
			--	info.text = L.RANGECHECK_OPTION_AVERAGE
			--	info.func = setSpeed
			--	info.arg1 = "Average"
			--	info.checked = (DBM.Options.RangeFrameUpdates == "Average")
			--	UIDropDownMenu_AddButton(info, 2)

			--	info = UIDropDownMenu_CreateInfo()
			--	info.text = L.RANGECHECK_OPTION_FAST
			--	info.func = setSpeed
			--	info.arg1 = "Fast"
			--	info.checked = (DBM.Options.RangeFrameUpdates == "Fast")
			--	UIDropDownMenu_AddButton(info, 2)
			end
		elseif level == 3 then
			local option = menu

			for k, s in ipairs(sounds) do
				info = UIDropDownMenu_CreateInfo()
				info.text = L["RANGECHECK_SOUND_"..tostring(k - 1)]
				info.func = setSound
				info.arg1 = option
				info.arg2 = s
				info.checked = (DBM.Options[option] == s)
				UIDropDownMenu_AddButton(info, 3)
			end

		end
	end
end

-----------------
-- Play Sounds --
-----------------
local updateSound
local soundUpdate = 0

do
	local UnitAffectingCombat = UnitAffectingCombat

	function updateSound(num)
		if not UnitAffectingCombat("player") or (GetTime() - soundUpdate) < 5 then
			return
		end
		soundUpdate = GetTime()
		if num == 1 then
			if DBM.Options.RangeFrameSound1 ~= "none" then
				DBM:PlaySoundFile(DBM.Options.RangeFrameSound1)
			end
		elseif num > 1 then
			if DBM.Options.RangeFrameSound2 ~= "none" then
				DBM:PlaySoundFile(DBM.Options.RangeFrameSound2)
			end
		end
	end
end

------------------------
--  Create the frame  --
------------------------
local function createTextFrame()
	textFrame = CreateFrame("Frame", "DBMRangeCheck", UIParent)
	textFrame:SetFrameStrata("DIALOG")
	textFrame.backdropInfo = {
		bgFile		= "Interface\\DialogFrame\\UI-DialogBox-Background",--131071
		tile		= true,
		tileSize	= 16
	}
	textFrame:SetBackdrop(textFrame.backdropInfo)
	textFrame:SetPoint(DBM.Options.RangeFramePoint, UIParent, DBM.Options.RangeFramePoint, DBM.Options.RangeFrameX, DBM.Options.RangeFrameY)
	textFrame:SetSize(128, 12)
	textFrame:SetClampedToScreen(true)
	textFrame:EnableMouse(true)
	textFrame:SetToplevel(true)
	textFrame:SetMovable(true)
	textFrame:RegisterForDrag("LeftButton")
	textFrame:SetScript("OnDragStart", function(self)
		if not DBM.Options.RangeFrameLocked then
			self:StartMoving()
		end
	end)
	textFrame:SetScript("OnDragStop", function(self)
		self:StopMovingOrSizing()
		local point, _, _, x, y = self:GetPoint(1)
		DBM.Options.RangeFrameX = x
		DBM.Options.RangeFrameY = y
		DBM.Options.RangeFramePoint = point
	end)
	textFrame:SetScript("OnMouseDown", function(_, button)
		if button == "RightButton" then
			local dropdownFrame = CreateFrame("Frame", "DBMRangeCheckDropdown", UIParent)
			UIDropDownMenu_Initialize(dropdownFrame, initializeDropdown)
			ToggleDropDownMenu(1, nil, dropdownFrame, "cursor", 5, -10)
		end
	end)

	local text = textFrame:CreateFontString(nil, "OVERLAY", "GameTooltipText")
	text:SetSize(128, 15)
	text:SetPoint("BOTTOMLEFT", textFrame, "TOPLEFT")
	text:SetTextColor(1, 1, 1, 1)
	text:Show()
	text.OldSetText = text.SetText
	text.SetText = function(self, text)
		self:OldSetText(text)
		self:SetWidth(0) -- Set the text width to 0, so the system can auto-calculate the size
	end
	textFrame.text = text

	local inRangeText = textFrame:CreateFontString(nil, "OVERLAY", "GameTooltipText")
	inRangeText:SetSize(128, 15)
	inRangeText:SetPoint("TOPLEFT", textFrame, "BOTTOMLEFT")
	inRangeText:SetTextColor(1, 1, 1, 1)
	inRangeText:Hide()
	textFrame.inRangeText = inRangeText

	textFrame.lines = {}
	for i = 1, 5 do
		local line = textFrame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
		line:SetSize(128, 12)
		line:SetJustifyH("LEFT")
		if i == 1 then
			line:SetPoint("TOPLEFT", textFrame, "TOPLEFT", 6, -6)
		else
			line:SetPoint("TOPLEFT", textFrame.lines[i - 1], "LEFT", 0, -6)
		end
		textFrame.lines[i] = line
	end

	textFrame:Hide()
end

local function createRadarFrame()
	radarFrame = CreateFrame("Frame", "DBMRangeCheckRadar", UIParent)
	radarFrame:SetFrameStrata("DIALOG")
	radarFrame:SetPoint(DBM.Options.RangeFrameRadarPoint, UIParent, DBM.Options.RangeFrameRadarPoint, DBM.Options.RangeFrameRadarX, DBM.Options.RangeFrameRadarY)
	radarFrame:SetSize(128, 128)
	radarFrame:SetClampedToScreen(true)
	radarFrame:EnableMouse(true)
	radarFrame:SetToplevel(true)
	radarFrame:SetMovable(true)
	radarFrame:RegisterForDrag("LeftButton")
	radarFrame:SetScript("OnDragStart", function(self)
		if not DBM.Options.RangeFrameLocked then
			self:StartMoving()
		end
	end)
	radarFrame:SetScript("OnDragStop", function(self)
		self:StopMovingOrSizing()
		local point, _, _, x, y = self:GetPoint(1)
		DBM.Options.RangeFrameRadarX = x
		DBM.Options.RangeFrameRadarY = y
		DBM.Options.RangeFrameRadarPoint = point
	end)
	radarFrame:SetScript("OnMouseDown", function(_, button)
		if button == "RightButton" then
			local dropdownFrame = CreateFrame("Frame", "DBMRangeCheckDropdown", UIParent--[[, "UIDropDownMenuTemplate"]])
			UIDropDownMenu_Initialize(dropdownFrame, initializeDropdown)
			ToggleDropDownMenu(1, nil, dropdownFrame, "cursor", 5, -10)
		end
	end)

	local bg = radarFrame:CreateTexture(nil, "BACKGROUND")
	bg:SetAllPoints(radarFrame)
	bg:SetBlendMode("BLEND")
	bg:SetTexture(0, 0, 0, 0.3)
	radarFrame.background = bg

	local circle = radarFrame:CreateTexture(nil, "ARTWORK")
	circle:SetSize(85, 85)
	circle:SetPoint("CENTER")
	circle:SetTexture("Interface\\AddOns\\DBM-Core\\textures\\radar_circle.blp")
	circle:SetVertexColor(0, 1, 0)
	circle:SetBlendMode("ADD")
	radarFrame.circle = circle

	local player = radarFrame:CreateTexture(nil, "OVERLAY")
	player:SetSize(32, 32)
	player:SetTexture("Interface\\Minimap\\MinimapArrow.blp")
	player:SetBlendMode("ADD")
	player:SetPoint("CENTER")

	local text = radarFrame:CreateFontString(nil, "OVERLAY", "GameTooltipText")
	text:SetSize(128, 15)
	text:SetPoint("BOTTOMLEFT", radarFrame, "TOPLEFT")
	text:SetTextColor(1, 1, 1, 1)
	text:Show()
	radarFrame.text = text

	local inRangeText = radarFrame:CreateFontString(nil, "OVERLAY", "GameTooltipText")
	inRangeText:SetSize(128, 15)
	inRangeText:SetPoint("TOPLEFT", radarFrame, "BOTTOMLEFT")
	inRangeText:SetTextColor(1, 1, 1, 1)
	inRangeText:Hide()
	radarFrame.inRangeText = inRangeText

	radarFrame.dots = {}
	for i = 1, 40 do
		local dot = radarFrame:CreateTexture(nil, "OVERLAY")
		dot:SetSize(24, 24)
		dot:SetTexture("Interface\\Minimap\\PartyRaidBlips") -- 249183
		dot:Hide()
		radarFrame.dots[i] = dot
	end

	radarFrame:Hide()
end

----------------
--  OnUpdate  --
----------------
do
	local UnitExists, UnitIsUnit, UnitIsDeadOrGhost, UnitIsConnected, GetPlayerFacing, UnitClass, IsInRaid, GetNumGroupMembers, GetRaidTargetIndex = UnitExists, UnitIsUnit, UnitIsDeadOrGhost, UnitIsConnected, GetPlayerFacing, UnitClass, private.IsInRaid, private.GetNumGroupMembers, GetRaidTargetIndex
	local max, min, sin, cos, pi2 = math.max, math.min, math.sin, math.cos, math.pi * 2
	local circleColor, rotation, pixelsperyard, activeDots, prevRange, prevThreshold, prevNumClosePlayer, prevclosestRange, prevColor, prevType = 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	local bossMode
	local unitList = {}
	local BLIP_TEX_COORDS = {
		["WARRIOR"]		 = { 0, 0.125, 0, 0.25 },
		["PALADIN"]		 = { 0.125, 0.25, 0, 0.25 },
		["HUNTER"]		 = { 0.25, 0.375, 0, 0.25 },
		["ROGUE"]		 = { 0.375, 0.5, 0, 0.25 },
		["PRIEST"]		 = { 0.5, 0.625, 0, 0.25 },
		["DEATHKNIGHT"]	 = { 0.625, 0.75, 0, 0.25 },
		["SHAMAN"]		 = { 0.75, 0.875, 0, 0.25 },
		["MAGE"]		 = { 0.875, 1, 0, 0.25 },
		["WARLOCK"]		 = { 0, 0.125, 0.25, 0.5 },
		["DRUID"]		 = { 0.25, 0.375, 0.25, 0.5 },
	}

	local function setDot(id, sinTheta, cosTheta)
		local dot = radarFrame.dots[id]
		if dot.range < (mainFrame.range * 1.5) then -- If person is closer than 1.5 * range, show the dot. Else hide it
			dot:ClearAllPoints()
			dot:SetPoint("CENTER", radarFrame, "CENTER", ((dot.x * cosTheta) - (-dot.y * sinTheta)) * pixelsperyard, ((dot.x * sinTheta) + (-dot.y * cosTheta)) * pixelsperyard)
			dot:Show()
		elseif dot:IsShown() then
			dot:Hide()
		end
	end

	function updateIcon()
		local numPlayers = GetNumGroupMembers()
		activeDots = max(numPlayers, activeDots)
		for i = 1, activeDots do
			local dot = radarFrame.dots[i]
			if i <= numPlayers then
				unitList[i] = IsInRaid() and "raid" .. i or "party" .. i
				local _, class = UnitClass(unitList[i])
				local icon = GetRaidTargetIndex(unitList[i])
				dot.class = class
				if icon and icon < 9 then
					dot.icon = icon
					dot:SetTexture("Interface\\TargetingFrame\\UI-RaidTargetingIcon_" .. icon) -- 13700 .. icon
					dot:SetTexCoord(0, 1, 0, 1)
					dot:SetSize(16, 16)
					dot:SetDrawLayer("OVERLAY", 1)
				else
					dot.icon = nil
					class = class or "PRIEST"
					dot:SetTexture("Interface\\Minimap\\PartyRaidBlips") -- 249183
					dot:SetTexCoord(BLIP_TEX_COORDS[class][1], BLIP_TEX_COORDS[class][2], BLIP_TEX_COORDS[class][3], BLIP_TEX_COORDS[class][4])
					dot:SetSize(24, 24)
					dot:SetDrawLayer("OVERLAY", 0)
				end
			elseif dot:IsShown() then
				dot:Hide()
			end
		end
	end

	function updateRangeFrame()
		if mainFrame.hideTime > 0 and GetTime() > mainFrame.hideTime then
			rangeCheck:Hide()
			return
		end
		local activeRange = mainFrame.range
--		local restricted = mainFrame.restrictions -- GetPlayerFacing() was only protected in 7.1.0
		local tEnabled = textFrame:IsShown()
		local rEnabled = radarFrame:IsShown()
		local reverse = mainFrame.reverse
		local warnThreshold = mainFrame.redCircleNumPlayers
		if tEnabled then
			for i = 1, 5 do
				textFrame.lines[i]:SetText("")
				textFrame.lines[i]:Hide()
			end
			if mainFrame.bossMode then
				textFrame.text:SetText(L.RANGERADAR_BOSS_HEADER:format(activeRange))
			else
				if reverse then
					if warnThreshold > 1 then
						textFrame.text:SetText(L.RANGECHECK_RHEADERT:format(activeRange, warnThreshold))
					else
						textFrame.text:SetText(L.RANGECHECK_RHEADER:format(activeRange))
					end
				else
					if warnThreshold > 1 then
						textFrame.text:SetText(L.RANGECHECK_HEADERT:format(activeRange, warnThreshold))
					else
						textFrame.text:SetText(L.RANGECHECK_HEADER:format(activeRange))
					end
				end
			end
		end
		if rEnabled and (prevRange ~= activeRange or prevThreshold ~= mainFrame.redCircleNumPlayers) then
			prevRange = activeRange
			pixelsperyard = min(radarFrame:GetWidth(), radarFrame:GetHeight()) / (activeRange * 3)
			radarFrame.circle:SetSize(activeRange * pixelsperyard * 2, activeRange * pixelsperyard * 2)
			if mainFrame.bossMode then
				if bossMode ~= mainFrame.bossMode then
					bossMode = mainFrame.bossMode
				end
				radarFrame.text:SetText(L.RANGERADAR_BOSS_HEADER:format(activeRange))
			else
				if reverse then
					radarFrame.text:SetText(L.RANGERADAR_RHEADER:format(activeRange, mainFrame.redCircleNumPlayers))
				else
					radarFrame.text:SetText(L.RANGERADAR_HEADER:format(activeRange, mainFrame.redCircleNumPlayers))
				end
			end
		end

		rotation = pi2 - (GetPlayerFacing() or 0)
		local sinTheta = sin(rotation)
		local cosTheta = cos(rotation)
		local closePlayer = 0
		local closestRange = nil -- declare as nil to prevent luacheck error
		local closetName
		local filter = mainFrame.filter
		local type = reverse and 2 or filter and 1 or 0
		local onlySummary = mainFrame.onlySummary

		if mainFrame.bossMode then
			local uId = mainFrame.bossUnit
			local range = getUnitRange(uId)
			if uId and range and range <= activeRange and (not filter or filter(uId)) then
				closePlayer = closePlayer + 1
				local color = NORMAL_FONT_COLOR
				closetName = UnitName(uId)
				if rEnabled then -- Only used by radar
					if not closestRange then
						closestRange = range
					elseif range < closestRange then
						closestRange = range
					end
				end

				if tEnabled and not onlySummary and closePlayer < 6 then -- Display up to 5 players in text range frame.
					textFrame.lines[closePlayer]:SetText(closetName, color.r, color.g, color.b)
					textFrame.lines[closePlayer]:SetTextColor(color.r, color.g, color.b)
					textFrame.lines[closePlayer]:Show()
					textFrame:SetHeight((closePlayer * 12) + 12)
				end
			end
		else
			for i = 1, GetNumGroupMembers() do
				local uId = unitList[i]
				local dot = radarFrame.dots[i]
				if UnitExists(uId) and not UnitIsUnit(uId, "player") and not UnitIsDeadOrGhost(uId) and UnitIsConnected(uId) and (not filter or filter(uId)) then
					local range = getUnitRange(uId)
					local inRange = false
					if range < activeRange + 0.5 then
						closePlayer = closePlayer + 1
						inRange = true
						if rEnabled then -- Only used by radar
							if not closestRange then
								closestRange = range
							elseif range < closestRange then
								closestRange = range
							end
						end
						if not closetName then
							closetName = DBM:GetUnitFullName(uId)
							closetName = DBM:GetShortServerName(closetName)
						end
					end
					if tEnabled and inRange and not onlySummary and closePlayer < 6 then -- Display up to 5 players in text range frame.
						local playerName = DBM:GetUnitFullName(uId)
						playerName = DBM:GetShortServerName(playerName)
						local color = RAID_CLASS_COLORS[dot.class] or NORMAL_FONT_COLOR
						textFrame.lines[closePlayer]:SetText(dot.icon and ("|TInterface\\TargetingFrame\\UI-RaidTargetingIcon_%d:0|t %s"):format(dot.icon, playerName) or playerName)
						textFrame.lines[closePlayer]:SetTextColor(color.r, color.g, color.b)
						textFrame.lines[closePlayer]:Show()
						textFrame:SetHeight((closePlayer * 12) + 12)
					end
					if rEnabled then
						local playerX, playerY = GetPlayerMapPosition("player")
						if playerX == 0 and playerY == 0 then
							rangeCheck:Hide(true)
							return
						end
						dot.x = rangeX
						dot.y = rangeY
						dot.range = range
						setDot(i, sinTheta, cosTheta)
					end
				elseif rEnabled and dot:IsShown() then
					dot:Hide()
				end
			end
		end

		if tEnabled then
			-- Green Text (Regular range frame and not near too many players, or reverse range frame and we ARE near enough)
			textFrame.inRangeText:SetText(L.RANGECHECK_IN_RANGE_TEXT:format(closePlayer, activeRange))
			textFrame.inRangeText:Show()
			if (reverse and closePlayer >= warnThreshold) or (not reverse and closePlayer < warnThreshold) then
				textFrame.inRangeText:SetTextColor(0, 1, 0)
			-- Red Text (Regular range frame and we are near too many players, or reverse range frame and we aren't near enough)
			else
				updateSound(closePlayer)
				textFrame.inRangeText:SetTextColor(1, 0, 0)
			end
			textFrame:Show()
		end
		if rEnabled then
			if prevNumClosePlayer ~= closePlayer or prevclosestRange ~= closestRange or prevType ~= type then
				if closePlayer >= warnThreshold then -- Only show the text if the circle is red
					circleColor = reverse and 1 or 2
					if closePlayer == 1 then
						radarFrame.inRangeText:SetText(L.RANGERADAR_IN_RANGE_TEXTONE:format(closetName, closestRange))
					else
						radarFrame.inRangeText:SetText(L.RANGERADAR_IN_RANGE_TEXT:format(closePlayer, closestRange))
					end
					radarFrame.inRangeText:Show()
				else
					circleColor = reverse and 2 or 1
					radarFrame.inRangeText:Hide()
				end
				prevNumClosePlayer = closePlayer
				prevclosestRange = closestRange
				prevType = type
			end

			if UnitIsDeadOrGhost("player") then
				circleColor = 3
			end

			if prevColor ~= circleColor then
				if circleColor == 1 then
					radarFrame.circle:SetVertexColor(0, 1, 0)
				elseif circleColor == 2 then
					radarFrame.circle:SetVertexColor(1, 0, 0)
				else
					radarFrame.circle:SetVertexColor(1, 1, 1)
				end
				prevColor = circleColor
			end
			if circleColor == 2 then -- Red
				updateSound(closePlayer)
			end
		end
	end
end

local updater = mainFrame:CreateAnimationGroup()
updater:SetLooping("REPEAT")
local anim = updater:CreateAnimation()
anim:SetDuration(0.05)

mainFrame:SetSize(0, 0)
mainFrame:SetScript("OnEvent", function(self, event)
	if event == "PARTY_MEMBERS_CHANGED" or event == "RAID_ROSTER_UPDATE" or event == "RAID_TARGET_UPDATE" then
		updateIcon()
	end
end)

-----------------------
--  Check functions  --
-----------------------
local getDistanceBetween, getDistanceBetweenAll

do
	local UnitExists, UnitIsUnit, UnitIsDeadOrGhost, UnitIsConnected = UnitExists, UnitIsUnit, UnitIsDeadOrGhost, UnitIsConnected

	function getDistanceBetweenAll(checkrange)
		local range
		for uId in DBM:GetGroupMembers() do
			if UnitExists(uId) and not UnitIsUnit(uId, "player") and not UnitIsDeadOrGhost(uId) and UnitIsConnected(uId) then
				range = getUnitRange(uId)
				if checkrange < (range + 0.5) then
					return true
				end
			end
		end
		return false
	end

	function getDistanceBetween(uId, x, y)
		local restrictionsActive = DBM:HasMapRestrictions()
		if restrictionsActive then
			if not x then -- If only one arg then 2nd arg is always assumed to be player
				return getUnitRange(uId)
			end
			if type(x) == "string" and UnitExists(x) then -- arguments: uId, uId2
				if UnitIsUnit("player", uId) then
					return getUnitRange(x)
				elseif UnitIsUnit("player", x) then
					return getUnitRange(uId)
				end
			end
		else -- Neither unit is player, no way to avoid GetPlayerMapPosition
			if not x then -- If only one arg then 2nd arg is always assumed to be player
				x, y = GetPlayerMapPosition("player")
			end
			if type(x) == "string" and UnitExists(x) then -- arguments: uId, uId2
				local uId2 = x
				x, y = GetPlayerMapPosition(uId2)
				if not x then
					print("getDistanceBetween failed for: " .. uId .. " (" .. tostring(UnitExists(uId)) .. ") and " .. uId2 .. " (" .. tostring(UnitExists(uId2)) .. ")")
					return
				end
			end
		end
		if restrictionsActive then -- Cannot check distance between player and a location (not another unit, again, fail quietly)
			return 1000
		end
		local mapX, mapY = DBM:GetMapSize()
		local startX, startY = GetPlayerMapPosition(uId)
		local dX = (startX - x) * mapX
		local dY = (startY - y) * mapY
		return (dX * dX + dY * dY) ^ 0.5
	end
end

---------------
--  Methods  --
---------------
local restoreRange, restoreFilter, restoreThreshold, restoreReverse

function rangeCheck:Show(range, filter, forceshow, redCircleNumPlayers, reverse, hideTime, onlySummary, bossUnit)
	DBM:Debug(("Range Frame called. #members: %d ; Options: %s + %s + %s ; forceshow: %s ; MapRestrictions: %s"):format(DBM:GetNumRealGroupMembers(), tostring(DBM.Options.DontShowRangeFrame), tostring(DBM.Options.SpamSpecInformationalOnly), DBM.Options.RangeFrameFrames or "nil", tostring(forceshow) or "nil", tostring(DBM:HasMapRestrictions())), 3)
	if (DBM:GetNumRealGroupMembers() < 2 or DBM.Options.DontShowRangeFrame or DBM.Options.SpamSpecInformationalOnly) and not forceshow then
		return
	end
	if type(range) == "function" then -- The first argument is optional
		return self:Show(nil, range)
	end
	range = range or 10
	redCircleNumPlayers = redCircleNumPlayers or 1
	if not textFrame then
		createTextFrame()
	end
	if not radarFrame then
		createRadarFrame()
	end
	mainFrame.previouslyShown = self:IsShown()
	local restrictionsActive = DBM:HasMapRestrictions()
	if (DBM.Options.RangeFrameFrames == "text" or DBM.Options.RangeFrameFrames == "both" or restrictionsActive) and not textFrame:IsShown() then
		DBM:Debug("Range TEXT frame shown", 3)
		textFrame:Show()
	end
	-- TODO, add check for restricted area here so we can prevent radar frame loading.
	if not restrictionsActive and (DBM.Options.RangeFrameFrames == "radar" or DBM.Options.RangeFrameFrames == "both") and not radarFrame:IsShown() then
		DBM:Debug("Range RADAR frame shown", 3)
		radarFrame:Show()
	end
	mainFrame.previousRange = mainFrame.range or range
	mainFrame.range = range
	mainFrame.filter = filter
	mainFrame.redCircleNumPlayers = redCircleNumPlayers
	mainFrame.reverse = reverse
	mainFrame.hideTime = hideTime and (GetTime() + hideTime) or 0
	mainFrame.restrictions = restrictionsActive
	mainFrame.onlySummary = onlySummary
	mainFrame.bossUnit = bossUnit
	mainFrame.bossMode = bossUnit ~= nil
	if not mainFrame.eventRegistered then
		mainFrame.eventRegistered = true
		updateIcon()
		mainFrame:RegisterEvent("PARTY_MEMBERS_CHANGED")
		mainFrame:RegisterEvent("RAID_ROSTER_UPDATE")
		mainFrame:RegisterEvent("RAID_TARGET_UPDATE")
	end
	updater:SetScript("OnLoop", updateRangeFrame)
	updater:Play()
	if forceshow and not DBM.Options.DontRestoreRange then -- Force means user activated range frame, store user value for restore function
		restoreRange, restoreFilter, restoreThreshold, restoreReverse = mainFrame.range, mainFrame.filter, mainFrame.redCircleNumPlayers, mainFrame.reverse
	end
end

function rangeCheck:SetBossRange(range, bossUnit)
	if DBM.Options.DontShowRangeFrame then return end
	if not HarmItems[range] then
		error(("Boss mode range \"%d yd\" is not supported."):format(range), 2)
	end
	self:Show(range, nil, true, nil, nil, nil, nil, bossUnit)
end

function rangeCheck:DisableBossMode()
	if mainFrame and mainFrame.bossMode then
		mainFrame.bossMode = false
		mainFrame.bossUnit = nil
		mainFrame.range = mainFrame.previousRange
		restoreRange = mainFrame.range
		if not mainFrame.previouslyShown then
			self:Hide(true)
		end
	end
end

function rangeCheck:Hide(force)
	if not DBM.Options.DontRestoreRange and restoreRange and not force then -- Restore range frame to way it was when boss mod is done with it
		rangeCheck:Show(restoreRange, restoreFilter, true, restoreThreshold, restoreReverse)
	else
		restoreRange, restoreFilter, restoreThreshold, restoreReverse = nil, nil, nil, nil
		updater:Stop()
		if mainFrame.eventRegistered then
			mainFrame.eventRegistered = nil
			mainFrame:UnregisterAllEvents()
		end
		if textFrame then
			textFrame:Hide()
		end
		if radarFrame then
			radarFrame:Hide()
		end
	end
end

function rangeCheck:IsShown()
	return textFrame and textFrame:IsShown() or radarFrame and radarFrame:IsShown()
end

function rangeCheck:IsRadarShown()
	return radarFrame and radarFrame:IsShown()
end

function rangeCheck:UpdateRestrictions(force)
	mainFrame.restrictions = force or DBM:HasMapRestrictions()
end

function rangeCheck:SetHideTime(hideTime)
	mainFrame.hideTime = hideTime and (GetTime() + hideTime) or 0
end

-- GetDistance(uId) -- distance between you and the given uId
-- GetDistance(uId, x, y) -- distance between uId and the coordinates
-- GetDistance(uId, uId2) -- distance between the two uIds
function rangeCheck:GetDistance(...)
	return getDistanceBetween(...)
end

function rangeCheck:GetDistanceAll(checkrange)
	return getDistanceBetweenAll(checkrange)
end

do
	local function UpdateRangeFrame(r, reverse)
		if rangeCheck:IsShown() then
			rangeCheck:Hide(true)
		else
			if DBM:HasMapRestrictions() then
				DBM:AddMsg(L.NO_RANGE)
			end
			rangeCheck:Show((r and r < 201) and r or 10, nil, true, nil, reverse)
		end
	end
	SLASH_DBMRANGE1 = "/range"
	SLASH_DBMRANGE2 = "/distance"
	SLASH_DBMRRANGE1 = "/rrange"
	SLASH_DBMRRANGE2 = "/rdistance"
	SLASH_DBMBOSSRANGE1 = "/bossrange"
	SlashCmdList["DBMRANGE"] = function(msg)
		UpdateRangeFrame(tonumber(msg), false)
	end
	SlashCmdList["DBMRRANGE"] = function(msg)
		UpdateRangeFrame(tonumber(msg), true)
	end
	SlashCmdList["DBMBOSSRANGE"] = function(msg)
		local r = tonumber(msg)
		if not r then
			DBM.RangeCheck:DisableBossMode()
		else
			DBM.RangeCheck:SetBossRange(r, "target")
		end
	end
end
