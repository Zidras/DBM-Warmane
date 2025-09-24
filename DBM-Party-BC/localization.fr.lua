if GetLocale() ~= "frFR" then return end

local L

-------------------------
--  Hellfire Ramparts  --
-----------------------------
--  Watchkeeper Gargolmar  --
-----------------------------
L = DBM:GetModLocalization(527)

L:SetGeneralLocalization({
	name		= "Gardien des guetteurs Gargolmar"
})

--------------------------
--  Omor the Unscarred  --
--------------------------
L = DBM:GetModLocalization(528)

L:SetGeneralLocalization({
	name		= "Omor l'Intouché"
})

------------------------
--  Nazan & Vazruden  --
------------------------
L = DBM:GetModLocalization(529)

L:SetGeneralLocalization({
	name		= "Nazan et Vazruden"
})

-------------------------
--  The Blood Furnace  --
-------------------------
--  The Maker  --
-----------------
L = DBM:GetModLocalization(555)

L:SetGeneralLocalization({
	name		= "Le Faiseur"
})

---------------
--  Broggok  --
---------------
L = DBM:GetModLocalization(556)

L:SetGeneralLocalization({
	name		= "Broggok"
})

----------------------------
--  Keli'dan the Breaker  --
----------------------------
L = DBM:GetModLocalization(557)

L:SetGeneralLocalization({
	name		= "Keli'dan le Briseur"
})

---------------------------
--  The Shattered Halls  --
--------------------------------
--  Grand Warlock Nethekurse  --
--------------------------------
L = DBM:GetModLocalization(566)

L:SetGeneralLocalization({
	name		= "Grand démoniste Néanathème"
})

--------------------------
--  Blood Guard Porung  --
--------------------------
L = DBM:GetModLocalization(728)

L:SetGeneralLocalization({
	name		= "Garde de sang Porung"
})

--------------------------
--  Warbringer O'mrogg  --
--------------------------
L = DBM:GetModLocalization(568)

L:SetGeneralLocalization({
	name		= "Porteguerre O'mrogg"
})

----------------------------------
--  Warchief Kargath Bladefist  --
----------------------------------
L = DBM:GetModLocalization(569)

L:SetGeneralLocalization({
	name		= "Chef de guerre Kargath Lamepoing"
})

L:SetWarningLocalization({
	warnHeathen			= "Garde païen",
	warnReaver			= "Garde saccageur",
	warnSharpShooter	= "Garde tireur de précision",
})

L:SetTimerLocalization({
	timerHeathen		= "Garde païen: %s",
	timerReaver			= "Garde saccageur: %s",
	timerSharpShooter	= "Garde tireur de précision: %s"
})

L:SetOptionLocalization({
	warnHeathen			= "Afficher une alerte pour le Garde païen",
	timerHeathen		= "Afficher un timer pour le Garde païen",
	warnReaver			= "Afficher une alerte pour le Garde saccageur",
	timerReaver			= "Afficher un timer pour le Garde saccageur",
	warnSharpShooter	= "Afficher une alerte pour le Garde tireur de précision",
	timerSharpShooter	= "Afficher un timer pour le Garde tireur de précision"
})

------------------
--  Slave Pens  --
--------------------------
--  Mennu the Betrayer  --
--------------------------
L = DBM:GetModLocalization(570)

L:SetGeneralLocalization({
	name		= "Mennu le Traître"
})

---------------------------
--  Rokmar the Crackler  --
---------------------------
L = DBM:GetModLocalization(571)

L:SetGeneralLocalization({
	name		= "Rokmar le Crépitant"
})

------------------
--  Quagmirran  --
------------------
L = DBM:GetModLocalization(572)

L:SetGeneralLocalization({
	name		= "Bourbierreux"
})

--------------------
--  The Underbog  --
--------------------
--  Hungarfen  --
-----------------
L = DBM:GetModLocalization(576)

L:SetGeneralLocalization({
	name		= "Hungarfen"
})

---------------
--  Ghaz'an  --
---------------
L = DBM:GetModLocalization(577)

L:SetGeneralLocalization({
	name		= "Ghaz'an"
})

--------------------------
--  Swamplord Musel'ek  --
--------------------------
L = DBM:GetModLocalization(578)

L:SetGeneralLocalization({
	name		= "Seigneur des marais Musel'ek"
})

-------------------------
--  The Black Stalker  --
-------------------------
L = DBM:GetModLocalization(579)

L:SetGeneralLocalization({
	name		= "La Traqueuse noire"
})

----------------------
--  The Steamvault  --
---------------------------
--  Hydromancer Thespia  --
---------------------------
L = DBM:GetModLocalization(573)

L:SetGeneralLocalization({
	name		= "Hydromancienne Thespia"
})

-----------------------------
--  Mekgineer Steamrigger  --
-----------------------------
L = DBM:GetModLocalization(574)

L:SetGeneralLocalization({
	name		= "Mekgénieur Montevapeur"
})

L:SetWarningLocalization({
	warnSummon	= "Mécaniciens Montevapeur - Changez de cible"
})

L:SetOptionLocalization({
	warnSummon	= "Afficher une alerte pour les mécaniciens Montevapeur"
})

L:SetMiscLocalization({
	Mechs	= "Faites-leur une vidange, les gars !"
})

--------------------------
--  Warlord Kalithresh  --
--------------------------
L = DBM:GetModLocalization(575)

L:SetGeneralLocalization({
	name		= "Seigneur de guerre Kalithresh"
})

-----------------------
--  Auchenai Crypts  --
--------------------------------
--  Shirrak the Dead Watcher  --
--------------------------------
L = DBM:GetModLocalization(523)

L:SetGeneralLocalization({
	name		= "Shirrak le Veillemort"
})

-----------------------
--  Exarch Maladaar  --
-----------------------
L = DBM:GetModLocalization(524)

L:SetGeneralLocalization({
	name		= "Exarque Maladaar"
})

------------------
--  Mana-Tombs  --
------------------
--    Trash     --
------------------
L = DBM:GetModLocalization("AuctTombsTrash")

L:SetGeneralLocalization({
	name		= "Trash"
})

-------------------
--  Pandemonius  --
-------------------
L = DBM:GetModLocalization(534)

L:SetGeneralLocalization({
	name		= "Pandemonius"
})

---------------
--  Tavarok  --
---------------
L = DBM:GetModLocalization(535)

L:SetGeneralLocalization({
	name		= "Tavarok"
})

----------------------------
--  Nexus-Prince Shaffar  --
----------------------------
L = DBM:GetModLocalization(537)

L:SetGeneralLocalization({
	name		= "Prince-nexus Shaffar"
})

-----------
--  Yor  --
-----------
L = DBM:GetModLocalization(536)

L:SetGeneralLocalization({
	name		= "Yor"
})

---------------------
--  Sethekk Halls  --
-----------------------
--  Darkweaver Syth  --
-----------------------
L = DBM:GetModLocalization(541)

L:SetGeneralLocalization({
	name		= "Tisseur d'ombre Syth"
})

L:SetWarningLocalization({
	warnSummon	= "Invocation d'élémentaires"
})

L:SetOptionLocalization({
	warnSummon	= "Afficher une alerte pour les élémentaires invoqués"
})

------------
--  Anzu  --
------------
L = DBM:GetModLocalization(542)

L:SetGeneralLocalization({
	name		= "Anzu"
})

L:SetWarningLocalization({
	warnBrood	= "Progéniture d'Anzu",
	warnStoned	= "%s returned to stone"
})

L:SetOptionLocalization({
	warnBrood	= "Afficher une alerte pour la progéniture d'Anzu",
	warnStoned	= "Afficher une alerte pour les esprits redevenus pierre"
})

L:SetMiscLocalization({
	BirdStone	= "%s returns to stone."
})

------------------------
--  Talon King Ikiss  --
------------------------
L = DBM:GetModLocalization(543)

L:SetGeneralLocalization({
	name		= "Roi-serre Ikiss"
})

------------------------
--  Shadow Labyrinth  --
--------------------------
--  Ambassador Hellmaw  --
--------------------------
L = DBM:GetModLocalization(544)

L:SetGeneralLocalization({
	name		= "Ambassadeur Gueule-d'Enfer"
})

------------------------------
--  Blackheart the Inciter  --
------------------------------
L = DBM:GetModLocalization(545)

L:SetGeneralLocalization({
	name		= "Cœur-Noir le Séditieux"
})

--------------------------
--  Grandmaster Vorpil  --
--------------------------
L = DBM:GetModLocalization(546)

L:SetGeneralLocalization({
	name		= "Grand maître Vorpil"
})

--------------
--  Murmur  --
--------------
L = DBM:GetModLocalization(547)

L:SetGeneralLocalization({
	name		= "Marmon"
})

-------------------------------
--  Old Hillsbrad Foothills  --
-------------------------------
--  Lieutenant Drake  --
------------------------
L = DBM:GetModLocalization(538)

L:SetGeneralLocalization({
	name		= "Lieutenant Drake"
})

-----------------------
--  Captain Skarloc  --
-----------------------
L = DBM:GetModLocalization(539)

L:SetGeneralLocalization({
	name		= "Capitaine Skarloc"
})

--------------------
--  Epoch Hunter  --
--------------------
L = DBM:GetModLocalization(540)

L:SetGeneralLocalization({
	name		= "Chasseur d'époques"
})

------------------------
--  The Black Morass  --
------------------------
--  Chrono Lord Deja  --
------------------------
L = DBM:GetModLocalization(552)

L:SetGeneralLocalization({
	name		= "Chronoseigneur Déjà"
})

----------------
--  Temporus  --
----------------
L = DBM:GetModLocalization(553)

L:SetGeneralLocalization({
	name		= "Temporus"
})

--------------
--  Aeonus  --
--------------
L = DBM:GetModLocalization(554)

L:SetGeneralLocalization({
	name		= "Aeonus"
})

---------------------
--  Portal Timers  --
---------------------
L = DBM:GetModLocalization("PT")

L:SetGeneralLocalization({
	name = "Timers des failles (CoT)"
})

L:SetWarningLocalization({
	WarnWavePortalSoon	= "Nouvelle faille bientôt",
	WarnWavePortal		= "Faille temporelle %d",
	WarnBossPortal		= "Boss incoming"
})

L:SetTimerLocalization({
	TimerNextPortal		= "Faille temporelle %d"
})

L:SetOptionLocalization({
	WarnWavePortalSoon	= "Montre une pré-alerte pour la nouvelle faille",
	WarnWavePortal		= "Montre une alerte pour la faille",
	WarnBossPortal		= "Montre une alerte pour le boss a venir",
	TimerNextPortal		= "Montre un timer pour les failles à venir (après Boss)",
	ShowAllPortalTimers	= "Montre un timer pour toute les failles (inexacte)"
})

L:SetMiscLocalization({
	Shielddown			= "Non ! Maudite soit cette enveloppe mortelle !"
})

--------------------
--  The Mechanar  --
-----------------------------
--  Gatewatcher Gyro-Kill  --
-----------------------------
L = DBM:GetModLocalization("Gyrokill")--Not in EJ

L:SetGeneralLocalization({
	name = "Gardien de porte Gyro-Meurtre"
})

-----------------------------
--  Gatewatcher Iron-Hand  --
-----------------------------
L = DBM:GetModLocalization("Ironhand")--Not in EJ

L:SetGeneralLocalization({
	name = "Gardien de porte Main-en-fer"
})

L:SetMiscLocalization({
	JackHammer	= "%s lève son marteau d'un air menaçant..."
})

------------------------------
--  Mechano-Lord Capacitus  --
------------------------------
L = DBM:GetModLocalization(563)

L:SetGeneralLocalization({
	name		= "Mécano-seigneur Capacitus"
})

------------------------------
--  Nethermancer Sepethrea  --
------------------------------
L = DBM:GetModLocalization(564)

L:SetGeneralLocalization({
	name		= "Néantomancienne Sepethrea"
})

--------------------------------
--  Pathaleon the Calculator  --
--------------------------------
L = DBM:GetModLocalization(565)

L:SetGeneralLocalization({
	name		= "Pathaleon le Calculateur"
})

--------------------
--  The Botanica  --
--------------------------
--  Commander Sarannis  --
--------------------------
L = DBM:GetModLocalization(558)

L:SetGeneralLocalization({
	name		= "Commandant Sarannis"
})

------------------------------
--  High Botanist Freywinn  --
------------------------------
L = DBM:GetModLocalization(559)

L:SetGeneralLocalization({
	name		= "Grand botaniste Freywinn"
})

-----------------------------
--  Thorngrin the Tender  --
-----------------------------
L = DBM:GetModLocalization(560)

L:SetGeneralLocalization({
	name		= "Rirépine le Tendre"
})

-----------
--  Laj  --
-----------
L = DBM:GetModLocalization(561)

L:SetGeneralLocalization({
	name		= "Laj"
})

---------------------
--  Warp Splinter  --
---------------------
L = DBM:GetModLocalization(562)

L:SetGeneralLocalization({
	name		= "Brise-dimension"
})

--------------------
--  The Arcatraz  --
----------------------------
--  Zereketh the Unbound  --
----------------------------
L = DBM:GetModLocalization(548)

L:SetGeneralLocalization({
	name		= "Zereketh le Délié"
})

-----------------------------
--  Dalliah the Doomsayer  --
-----------------------------
L = DBM:GetModLocalization(549)

L:SetGeneralLocalization({
	name		= "Dalliah l'Auspice-Funeste"
})

---------------------------------
--  Wrath-Scryer Soccothrates  --
---------------------------------
L = DBM:GetModLocalization(550)

L:SetGeneralLocalization({
	name		= "Scrute-courroux Soccothrates"
})

-------------------------
--  Harbinger Skyriss  --
-------------------------
L = DBM:GetModLocalization(551)

L:SetGeneralLocalization({
	name		= "Messager Cieuriss"
})

L:SetWarningLocalization({
	warnSplitSoon	= "Illusion du messager bientôt",
	warnSplit		= "Illusion du messager"
})

L:SetOptionLocalization({
	warnSplitSoon	= "Montre une pré-alerte pour Illusion du messager",
	warnSplit		= "Montre une alerte pour Illusion du messager"
})

L:SetMiscLocalization({
	Split	= "Nous nous étendons sur l'univers, aussi innombrables que les étoiles !"
})

--------------------------
--  Magisters' Terrace  --
--------------------------
--  Selin Fireheart  --
-----------------------
L = DBM:GetModLocalization(530)

L:SetGeneralLocalization({
	name		= "Selin Coeur-de-feu"
})

L:SetWarningLocalization({
	warningFelCrystal	= "Gangrecristal - changez de cible"
})

L:SetTimerLocalization({
	timerFelCrystal		= "~Gangrecristal"
})

L:SetOptionLocalization({
	warningFelCrystal	= "Montre une alerte spéciale pour changer de cible sur le Gangrecristal",
	timerFelCrystal		= "Montre un timer pour le Gangrecristal"
})

----------------
--  Vexallus  --
----------------
L = DBM:GetModLocalization(531)

L:SetGeneralLocalization({
	name		= "Vexallus"
})

L:SetWarningLocalization({
	warnEnergy	= "Energie pure - changez de cible"
})

L:SetOptionLocalization({
	warnEnergy	= "Montre une alerte pour Energie pure"
})

--------------------------
--  Priestess Delrissa  --
--------------------------
L = DBM:GetModLocalization(532)

L:SetGeneralLocalization({
	name		= "Prêtresse Delrissa"
})

L:SetMiscLocalization({
	DelrissaEnd		= "Ça n'était pas… prévu."
})

------------------------------------
--  Kael'thas Sunstrider (Party)  --
------------------------------------
L = DBM:GetModLocalization(533)

L:SetGeneralLocalization({
	name		= "Kael'thas Haut-Soleil (Donjon)"
})

L:SetMiscLocalization({
	KaelP2	= "Vous allez me trouver… renversant."
})
