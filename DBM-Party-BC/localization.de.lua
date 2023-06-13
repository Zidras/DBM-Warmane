if GetLocale() ~= "deDE" then return end
local L

-------------------------
--  Hellfire Ramparts  --
-----------------------------
--  Watchkeeper Gargolmar  --
-----------------------------
-- L = DBM:GetModLocalization(527)

--------------------------
--  Omor the Unscarred  --
--------------------------
-- L = DBM:GetModLocalization(528)

------------------------
--  Nazan & Vazruden  --
------------------------
-- L = DBM:GetModLocalization(529)

-------------------------
--  The Blood Furnace  --
-------------------------
--  The Maker  --
-----------------
-- L = DBM:GetModLocalization(555)

---------------
--  Broggok  --
---------------
-- L = DBM:GetModLocalization(556)

----------------------------
--  Keli'dan the Breaker  --
----------------------------
-- L = DBM:GetModLocalization(557)

---------------------------
--  The Shattered Halls  --
--------------------------------
--  Grand Warlock Nethekurse  --
--------------------------------
-- L = DBM:GetModLocalization(566)

--------------------------
--  Blood Guard Porung  --
--------------------------
-- L = DBM:GetModLocalization(728)

--------------------------
--  Warbringer O'mrogg  --
--------------------------
-- L = DBM:GetModLocalization(568)

----------------------------------
--  Warchief Kargath Bladefist  --
----------------------------------
-- L = DBM:GetModLocalization(569)

------------------
--  Slave Pens  --
--------------------------
--  Mennu the Betrayer  --
--------------------------
-- L = DBM:GetModLocalization(570)

---------------------------
--  Rokmar the Crackler  --
---------------------------
-- L = DBM:GetModLocalization(571)

------------------
--  Quagmirran  --
------------------
-- L = DBM:GetModLocalization(572)

--------------------
--  The Underbog  --
--------------------
--  Hungarfen  --
-----------------
-- L = DBM:GetModLocalization(576)

---------------
--  Ghaz'an  --
---------------
-- L = DBM:GetModLocalization(577)

--------------------------
--  Swamplord Musel'ek  --
--------------------------
-- L = DBM:GetModLocalization(578)

-------------------------
--  The Black Stalker  --
-------------------------
-- L = DBM:GetModLocalization(579)

----------------------
--  The Steamvault  --
---------------------------
--  Hydromancer Thespia  --
---------------------------
-- L = DBM:GetModLocalization(573)

-----------------------------
--  Mekgineer Steamrigger  --
-----------------------------
L = DBM:GetModLocalization(574)

L:SetMiscLocalization({
	Mechs	= "Legt sie tiefer, Jungs!"
})

--------------------------
--  Warlord Kalithresh  --
--------------------------
-- L = DBM:GetModLocalization(575)

-----------------------
--  Auchenai Crypts  --
--------------------------------
--  Shirrak the Dead Watcher  --
--------------------------------
-- L = DBM:GetModLocalization(523)

-----------------------
--  Exarch Maladaar  --
-----------------------
-- L = DBM:GetModLocalization(524)

------------------
--  Mana-Tombs  --
-------------------
--  Pandemonius  --
-------------------
-- L = DBM:GetModLocalization(534)

---------------
--  Tavarok  --
---------------
-- L = DBM:GetModLocalization(535)

----------------------------
--  Nexus-Prince Shaffar  --
----------------------------
-- L = DBM:GetModLocalization(537)

-----------
--  Yor  --
-----------
-- L = DBM:GetModLocalization(536)

---------------------
--  Sethekk Halls  --
-----------------------
--  Darkweaver Syth  --
-----------------------
-- L = DBM:GetModLocalization(541)

------------
--  Anzu  --
------------
L = DBM:GetModLocalization(542)

L:SetWarningLocalization({
	warnStoned	= "%s wird wieder zu Stein"
})

L:SetOptionLocalization({
	warnStoned	= "Zeige Warnung für Geister die wieder zu Stein werden"
})

L:SetMiscLocalization({
	BirdStone	= "%s wird wieder zu Stein."
})

------------------------
--  Talon King Ikiss  --
------------------------
-- L = DBM:GetModLocalization(543)

------------------------
--  Shadow Labyrinth  --
--------------------------
--  Ambassador Hellmaw  --
--------------------------
-- L = DBM:GetModLocalization(544)

------------------------------
--  Blackheart the Inciter  --
------------------------------
-- L = DBM:GetModLocalization(545)

--------------------------
--  Grandmaster Vorpil  --
--------------------------
-- L = DBM:GetModLocalization(546)

--------------
--  Murmur  --
--------------
-- L = DBM:GetModLocalization(547)

-------------------------------
--  Old Hillsbrad Foothills  --
-------------------------------
--  Lieutenant Drake  --
------------------------
-- L = DBM:GetModLocalization(538)

-----------------------
--  Captain Skarloc  --
-----------------------
-- L = DBM:GetModLocalization(539)

--------------------
--  Epoch Hunter  --
--------------------
-- L = DBM:GetModLocalization(540)

------------------------
--  The Black Morass  --
------------------------
--  Chrono Lord Deja  --
------------------------
-- L = DBM:GetModLocalization(552)

----------------
--  Temporus  --
----------------
-- L = DBM:GetModLocalization(553)

--------------
--  Aeonus  --
--------------
L = DBM:GetModLocalization(554)

L:SetMiscLocalization({
	AeonusFrenzy	= "%s gerät in Raserei!"
})

---------------------
--  Portal Timers  --
---------------------
L = DBM:GetModLocalization("PT")

L:SetGeneralLocalization({
	name = "Portaltimer (HdZ 2)"
})

L:SetWarningLocalization({
	WarnWavePortalSoon	= "Neues Portal bald",
	WarnWavePortal		= "Portal %d",
	WarnBossPortal		= "Boss kommt"
})

L:SetTimerLocalization({
	TimerNextPortal		= "Portal %d"
})

L:SetOptionLocalization({
	WarnWavePortalSoon	= "Zeige Vorwarnung für neues Portal",
	WarnWavePortal		= "Zeige Warnung für neues Portal",
	WarnBossPortal		= "Zeige Warnung für neuen Boss",
	TimerNextPortal		= "Zeige Timer für nächstes Portal (nach einem Boss)",
	ShowAllPortalTimers	= "Zeige Timer für alle Portale (ungenau)"
})

L:SetMiscLocalization({
	PortalCheck			= "Geöffnete Zeitrisse: (%d+)/18",
	Shielddown			= "Nein! Verdammt sei diese schwache, sterbliche Hülle!"
})

--------------------
--  The Mechanar  --
-----------------------------
--  Gatewatcher Gyro-Kill  --
-----------------------------
L = DBM:GetModLocalization("Gyrokill")

L:SetGeneralLocalization({
	name = "Torwächter Gyrotod"
})

-----------------------------
--  Gatewatcher Iron-Hand  --
-----------------------------
L = DBM:GetModLocalization("Ironhand")

L:SetGeneralLocalization({
	name = "Torwächter Eisenhand"
})

L:SetMiscLocalization({
	JackHammer	= "%s erhebt seinen Hammer bedrohlich..."
})

------------------------------
--  Mechano-Lord Capacitus  --
------------------------------
-- L = DBM:GetModLocalization(563)

------------------------------
--  Nethermancer Sepethrea  --
------------------------------
-- L = DBM:GetModLocalization(564)

--------------------------------
--  Pathaleon the Calculator  --
--------------------------------
-- L = DBM:GetModLocalization(565)

--------------------
--  The Botanica  --
--------------------------
--  Commander Sarannis  --
--------------------------
-- L = DBM:GetModLocalization(558)

------------------------------
--  High Botanist Freywinn  --
------------------------------
-- L = DBM:GetModLocalization(559)

-----------------------------
--  Thorngrin the Tender  --
-----------------------------
-- L = DBM:GetModLocalization(560)

-----------
--  Laj  --
-----------
-- L = DBM:GetModLocalization(561)

---------------------
--  Warp Splinter  --
---------------------
-- L = DBM:GetModLocalization(562)

--------------------
--  The Arcatraz  --
----------------------------
--  Zereketh the Unbound  --
----------------------------
-- L = DBM:GetModLocalization(548)

-----------------------------
--  Dalliah the Doomsayer  --
-----------------------------
-- L = DBM:GetModLocalization(549)

---------------------------------
--  Wrath-Scryer Soccothrates  --
---------------------------------
-- L = DBM:GetModLocalization(550)

-------------------------
--  Harbinger Skyriss  --
-------------------------
L = DBM:GetModLocalization(551)

L:SetMiscLocalization({
	Split	= "Das Universum ist unser Zuhause, wir sind zahllos wie die Sterne!"
})

--------------------------
--  Magisters' Terrace  --
--------------------------
--  Selin Fireheart  --
-----------------------
-- L = DBM:GetModLocalization(530)

----------------
--  Vexallus  --
----------------
-- L = DBM:GetModLocalization(531)

--------------------------
--  Priestess Delrissa  --
--------------------------
L = DBM:GetModLocalization(532)

L:SetMiscLocalization({
--	DelrissaPull	= "Vernichtet sie.",
	DelrissaEnd		= "Das war so nicht... geplant."
})

------------------------------------
--  Kael'thas Sunstrider (Party)  --
------------------------------------
L = DBM:GetModLocalization(533)

L:SetMiscLocalization({
	KaelP2	= "Ich werde Eure Welt... auf den Kopf stellen."
})
