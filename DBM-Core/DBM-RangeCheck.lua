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
DBM:RegisterMapSize("BlackTemple",			-- Black Temple (Raid-BC)
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
DBM:RegisterMapSize("CoTMountHyjal", 		0, 2499.99975586, 1666.6665039)
DBM:RegisterMapSize("CoTStratholme",		-- The Culling of Stratholme (Party-WotLK) ; API returns levels 1 and 2 - this is corrected with DungeonUsesTerrainMap()
	0, 1824.999938962, 1216.6665039099998,	-- DUNGEON_FLOOR_COTSTRATHOLME0 = "The Road to Stratholme"
	1, 1125.299987791, 750.19995117			-- DUNGEON_FLOOR_COTSTRATHOLME1 = "Stratholme City"
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
DBM:RegisterMapSize("DeeprunTram",			1, 312, 208)
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
DBM:RegisterMapSize("Expansion01",			0, 17464.078125, 11642.71875) -- Old client Zangarmarsh BC dungeons. HD client fixes mapInfo
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
DBM:RegisterMapSize("Mana-Tombs",		-- Mana-Tombs (Party-BC)
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
DBM:RegisterMapSize("PitofSaron", 			0, 1533.333312988, 1022.916671753) -- Pit of Saron (Party-WotLK)
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
DBM:RegisterMapSize("RuinsofAhnQiraj", 		0, 2512.499877933, 1675) -- Ahn'Qiraj 20 (Raid-Classic)

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
	0, 906.25, 604.166626,
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
	0, 3287.49987793, 2191.66662598,			-- DUNGEON_FLOOR_ULDUAR0 = "The Grand Approach "
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

---------------
--  Globals  --
---------------
DBM.RangeCheck = {}


--------------
--  Locals  --
--------------
local L = DBM_CORE_L
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
			info.text = L.RANGECHECK_SETRANGE
			info.notCheckable = true
			info.hasArrow = true
			info.menuList = "range"
			UIDropDownMenu_AddButton(info, 1)

			info = UIDropDownMenu_CreateInfo()
			info.text = L.RANGECHECK_SOUNDS
			info.notCheckable = true
			info.hasArrow = true
			info.menuList = "sounds"
			UIDropDownMenu_AddButton(info, 1)

			info = UIDropDownMenu_CreateInfo()
			info.text = L.RANGECHECK_OPTION_FRAMES
			info.notCheckable = true
			info.hasArrow = true
			info.menuList = "frames"
			UIDropDownMenu_AddButton(info, 1)

			info = UIDropDownMenu_CreateInfo()
			info.text = L.RANGECHECK_OPTION_SPEED
			info.notCheckable = true
			info.hasArrow = true
			info.menuList = "speed"
			UIDropDownMenu_AddButton(info, 1)

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
			info.func = rangeCheck.Hide
			info.arg1 = rangeCheck
			UIDropDownMenu_AddButton(info, 1)

		elseif level == 2 then
			if menu == "range" then

				if initRangeCheck() then
					info = UIDropDownMenu_CreateInfo()
					info.text = L.RANGECHECK_SETRANGE_TO:format(5)
					info.func = setRange
					info.arg1 = 5
					info.checked = (frame.range == 5)
					UIDropDownMenu_AddButton(info, 2)
				end

				if initRangeCheck() then
					info = UIDropDownMenu_CreateInfo()
					info.text = L.RANGECHECK_SETRANGE_TO:format(6)
					info.func = setRange
					info.arg1 = 6
					info.checked = (frame.range == 6)
					UIDropDownMenu_AddButton(info, 2)
				end

				if initRangeCheck() then
					info = UIDropDownMenu_CreateInfo()
					info.text = L.RANGECHECK_SETRANGE_TO:format(7)
					info.func = setRange
					info.arg1 = 7
					info.checked = (frame.range == 7)
					UIDropDownMenu_AddButton(info, 2)
				end

				if initRangeCheck() then
					info = UIDropDownMenu_CreateInfo()
					info.text = L.RANGECHECK_SETRANGE_TO:format(8)
					info.func = setRange
					info.arg1 = 8
					info.checked = (frame.range == 8)
					UIDropDownMenu_AddButton(info, 2)
				end

				if initRangeCheck() then
					info = UIDropDownMenu_CreateInfo()
					info.text = L.RANGECHECK_SETRANGE_TO:format(9)
					info.func = setRange
					info.arg1 = 9
					info.checked = (frame.range == 9)
					UIDropDownMenu_AddButton(info, 2)
				end

				if initRangeCheck() then
					info = UIDropDownMenu_CreateInfo()
					info.text = L.RANGECHECK_SETRANGE_TO:format(10)
					info.func = setRange
					info.arg1 = 10
					info.checked = (frame.range == 10)
					UIDropDownMenu_AddButton(info, 2)
				end

				if initRangeCheck() then
					info = UIDropDownMenu_CreateInfo()
					info.text = L.RANGECHECK_SETRANGE_TO:format(11)
					info.func = setRange
					info.arg1 = 11
					info.checked = (frame.range == 11)
					UIDropDownMenu_AddButton(info, 2)
				end

				if initRangeCheck() then
					info = UIDropDownMenu_CreateInfo()
					info.text = L.RANGECHECK_SETRANGE_TO:format(12)
					info.func = setRange
					info.arg1 = 12
					info.checked = (frame.range == 12)
					UIDropDownMenu_AddButton(info, 2)
				end

				if initRangeCheck() then
					info = UIDropDownMenu_CreateInfo()
					info.text = L.RANGECHECK_SETRANGE_TO:format(13)
					info.func = setRange
					info.arg1 = 13
					info.checked = (frame.range == 13)
					UIDropDownMenu_AddButton(info, 2)
				end

				if initRangeCheck() then
					info = UIDropDownMenu_CreateInfo()
					info.text = L.RANGECHECK_SETRANGE_TO:format(14)
					info.func = setRange
					info.arg1 = 14
					info.checked = (frame.range == 14)
					UIDropDownMenu_AddButton(info, 2)
				end

				if initRangeCheck() then
					info = UIDropDownMenu_CreateInfo()
					info.text = L.RANGECHECK_SETRANGE_TO:format(15)
					info.func = setRange
					info.arg1 = 15
					info.checked = (frame.range == 15)
					UIDropDownMenu_AddButton(info, 2)
				end

				if initRangeCheck() then
					info = UIDropDownMenu_CreateInfo()
					info.text = L.RANGECHECK_SETRANGE_TO:format(20)
					info.func = setRange
					info.arg1 = 20
					info.checked = (frame.range == 20)
					UIDropDownMenu_AddButton(info, 2)
				end

				if initRangeCheck() then
					info = UIDropDownMenu_CreateInfo()
					info.text = L.RANGECHECK_SETRANGE_TO:format(28)
					info.func = setRange
					info.arg1 = 28
					info.checked = (frame.range == 28)
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
			elseif menu == "speed" then
				info = UIDropDownMenu_CreateInfo()
				info.text = L.RANGECHECK_OPTION_SLOW
				info.func = setSpeed
				info.arg1 = "Slow"
				info.checked = (DBM.Options.RangeFrameUpdates == "Slow")
				UIDropDownMenu_AddButton(info, 2)

				info = UIDropDownMenu_CreateInfo()
				info.text = L.RANGECHECK_OPTION_AVERAGE
				info.func = setSpeed
				info.arg1 = "Average"
				info.checked = (DBM.Options.RangeFrameUpdates == "Average")
				UIDropDownMenu_AddButton(info, 2)

				info = UIDropDownMenu_CreateInfo()
				info.text = L.RANGECHECK_OPTION_FAST
				info.func = setSpeed
				info.arg1 = "Fast"
				info.checked = (DBM.Options.RangeFrameUpdates == "Fast")
				UIDropDownMenu_AddButton(info, 2)
			end
		elseif level == 3 then
			local option = menu
			info = UIDropDownMenu_CreateInfo()
			info.text = L.RANGECHECK_SOUND_0
			info.func = setSound
			info.arg1 = option
			info.arg2 = sound0
			info.checked = (DBM.Options[option] == sound0)
			UIDropDownMenu_AddButton(info, 3)

			info = UIDropDownMenu_CreateInfo()
			info.text = L.RANGECHECK_SOUND_1
			info.func = setSound
			info.arg1 = option
			info.arg2 = sound1
			info.checked = (DBM.Options[option] == sound1)
			UIDropDownMenu_AddButton(info, 3)

			info = UIDropDownMenu_CreateInfo()
			info.text = L.RANGECHECK_SOUND_2
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
	frame:SetSize(128, 12)
	frame:SetClampedToScreen(true)
	frame:EnableMouse(true)
	frame:SetToplevel(true)
	frame:SetMovable(true)
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
	self:SetText(L.RANGECHECK_HEADER:format(self.range), 1, 1, 1)
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
		self:AddLine(L.RANGE_CHECK_ZONE_UNSUPPORTED:format(self.range))
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
				radarFrame.text:SetText(L.RANGERADAR_HEADER:format(range))
			end

			local mapName = GetMapInfo()
			local level = GetCurrentMapDungeonLevel()
			local usesTerrainMap = DungeonUsesTerrainMap()
			level = usesTerrainMap and level - 1 or level
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
		local startX, startY = GetPlayerMapPosition(uId)
		local mapName = GetMapInfo()
		local level = GetCurrentMapDungeonLevel()
		local usesTerrainMap = DungeonUsesTerrainMap()
		level = usesTerrainMap and level - 1 or level
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
		local usesTerrainMap = DungeonUsesTerrainMap()
		level = usesTerrainMap and level - 1 or level
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
	local usesTerrainMap = DungeonUsesTerrainMap()
	level = usesTerrainMap and level - 1 or level
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

-- GetDistance(uId) -- distance between you and the given uId
-- GetDistance(uId, x, y) -- distance between uId and the coordinates
-- GetDistance(uId, uId2) -- distance between the two uIds
function rangeCheck:GetDistance(...)
	if initRangeCheck() then
		return getDistanceBetween(...)
	end
end
