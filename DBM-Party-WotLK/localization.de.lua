if GetLocale() ~= "deDE" then return end

-- fehlende Übersetzungen:
--
-- PdC: Großchampions, Der Schwarze Ritter
-- HdR: Lichkönig-Event (Horde)

local L

local optionWarning		= "Zeige Warnung für %s"
local optionPreWarning	= "Zeige Vorwarnung für %s"

----------------------------------
--  Ahn'Kahet: The Old Kingdom  --
----------------------------------
--  Prince Taldaram  --
-----------------------
L = DBM:GetModLocalization("Taldaram")

L:SetGeneralLocalization({
	name = "Prinz Taldaram"
})

-------------------
--  Elder Nadox  --
-------------------
L = DBM:GetModLocalization("Nadox")

L:SetGeneralLocalization({
	name = "Urahne Nadox"
})

---------------------------
--  Jedoga Shadowseeker  --
---------------------------
L = DBM:GetModLocalization("JedogaShadowseeker")

L:SetGeneralLocalization({
	name = "Jedoga Schattensucher"
})

---------------------
--  Herald Volazj  --
---------------------
L = DBM:GetModLocalization("Volazj")

L:SetGeneralLocalization({
	name = "Herold Volazj"
})

----------------
--  Amanitar  --
----------------
L = DBM:GetModLocalization("Amanitar")

L:SetGeneralLocalization({
	name = "Amanitar"
})

-------------------
--  Azjol-Nerub  --
---------------------------------
--  Krik'thir the Gatewatcher  --
---------------------------------
L = DBM:GetModLocalization("Krikthir")

L:SetGeneralLocalization({
	name = "Krik'thir der Torwächter"
})

----------------
--  Hadronox  --
----------------
L = DBM:GetModLocalization("Hadronox")

L:SetGeneralLocalization({
	name = "Hadronox"
})

-------------------------
--  Anub'arak (Party)  --
-------------------------
L = DBM:GetModLocalization("Anubarak")

L:SetGeneralLocalization({
	name = "Anub'arak (Gruppe)"
})

---------------------------------------
--  Caverns of Time: Old Stratholme  --
---------------------------------------
--  Meathook  --
----------------
L = DBM:GetModLocalization("Meathook")

L:SetGeneralLocalization({
	name = "Fleischhaken"
})

--------------------------------
--  Salramm the Fleshcrafter  --
--------------------------------
L = DBM:GetModLocalization("SalrammTheFleshcrafter")

L:SetGeneralLocalization({
	name = "Salramm der Fleischformer"
})

-------------------------
--  Chrono-Lord Epoch  --
-------------------------
L = DBM:GetModLocalization("ChronoLordEpoch")

L:SetGeneralLocalization({
	name = "Chronolord Epoch"
})

-----------------
--  Mal'Ganis  --
-----------------
L = DBM:GetModLocalization("MalGanis")

L:SetGeneralLocalization({
	name = "Mal'Ganis"
})

L:SetMiscLocalization({
	Outro	= "Eure Reise hat erst begonnen, junger Prinz. Sammelt Eure Streitmacht und folgt mir in das arktische Land Nordend. Dort werden wir unsere Rechnung begleichen. Dort wird sich Euer wahres Schicksal offenbaren."
})

-------------------
--  Wave Timers  --
-------------------
L = DBM:GetModLocalization("StratWaves")

L:SetGeneralLocalization({
	name = "Stratholme-Wellen"
})

L:SetWarningLocalization({
	WarningWaveNow = "Welle %d: %s erschienen"
})

L:SetTimerLocalization({
	TimerWaveIn		= "Nächste Welle (6)",
	TimerRoleplay	= "Eröffnungsrollenspiel"
})

L:SetOptionLocalization({
	WarningWaveNow	= "Zeige Warnung für neue Welle",
	TimerWaveIn		= "Zeige Zeit bis die nächste Wellengruppe nach dem ersten Boss kommt",
	TimerRoleplay	= "Dauer des Eröffnungsrollenspiels anzeigen"
})

L:SetMiscLocalization({
	Meathook	= "Fleischhaken",
	Salramm		= "Salramm der Fleischformer",
	Devouring	= "Verschlingender Ghul",
	Enraged		= "Aufgebrachter Ghul",
	Necro		= "Totenbeschwörer",
	Fiend		= "Gruftbestie",
	Stalker		= "Grabschleicher",
	Abom		= "Flickwerkkonstrukt",
	Acolyte		= "Akolyth",
	Wave1		= "%d %s",
	Wave2		= "%d %s und %d %s",
	Wave3		= "%d %s, %d %s und %d %s",
	Wave4		= "%d %s, %d %s, %d %s und %d %s",
	WaveBoss	= "%s",
	WaveCheck	= "Geißelwelle = (%d+)/10",
	Roleplay	= "Wie schön, dass Ihr es geschafft habt, Uther.",
	Roleplay2	= "Alle sind bereit. Vergesst nicht, diese Leute sind alle infiziert und werden bald sterben. Wir müssen Stratholme säubern, um den Rest Lordaerons vor der Geißel zu schützen. Los jetzt."
})

------------------------
--  Drak'Tharon Keep  --
------------------------
--  Trollgore  --
-----------------
L = DBM:GetModLocalization("Trollgore")

L:SetGeneralLocalization({
	name = "Trollgrind"
})

--------------------------
--  Novos the Summoner  --
--------------------------
L = DBM:GetModLocalization("NovosTheSummoner")

L:SetGeneralLocalization({
	name = "Novos der Beschwörer"
})

L:SetWarningLocalization({
	WarnCrystalHandler	= "neuer Kristallwirker (%d übrig)"
})

L:SetTimerLocalization({
	timerCrystalHandler	= "neuer Kristallwirker"
})

L:SetOptionLocalization({
	WarnCrystalHandler	= "Zeige Warnung wenn Kristallwirker erscheint",
	timerCrystalHandler	= "Zeige Timer für nächsten Kristallwirker"
})

L:SetMiscLocalization({
	YellPull		= "Was ihr spürt, ist euer Ende, das naht.",
	HandlerYell		= "Verstärkt meine Verteidigung! Schnell, verdammt!",
	Phase2			= "Sicher seht ihr, dass alles vergebens ist!",
	YellKill		= "Eure Mühen... sind umsonst."
})

-----------------
--  King Dred  --
-----------------
L = DBM:GetModLocalization("KingDred")

L:SetGeneralLocalization({
	name = "König Dred"
})

-----------------------------
--  The Prophet Tharon'ja  --
-----------------------------
L = DBM:GetModLocalization("ProphetTharonja")

L:SetGeneralLocalization({
	name = "Der Prophet Tharon'ja"
})

---------------
--  Gundrak  --
----------------
--  Slad'ran  --
----------------
L = DBM:GetModLocalization("Sladran")

L:SetGeneralLocalization({
	name = "Slad'ran"
})

---------------
--  Moorabi  --
---------------
L = DBM:GetModLocalization("Moorabi")

L:SetGeneralLocalization({
	name = "Moorabi"
})

-------------------------
--  Drakkari Colossus  --
-------------------------
L = DBM:GetModLocalization("BloodstoneAnnihilator")

L:SetGeneralLocalization({
	name = "Koloss der Drakkari"
})

L:SetWarningLocalization({
	WarningElemental	= "Phase 2: Der Elementar",
	WarningStone		= "Phase 1: Der Koloss"
})

L:SetOptionLocalization({
	WarningElemental	= "Zeige Warnung für Phase 2: Der Elementar",
	WarningStone		= "Zeige Warnung für Phase 1: Der Koloss"
})

-----------------
--  Gal'darah  --
-----------------
L = DBM:GetModLocalization("Galdarah")

L:SetGeneralLocalization({
	name = "Gal'darah"
})

L:SetWarningLocalization({
	TimerPhase2		= "Phase 2: Der Avatar von Akali",
	TimerPhase1		= "Phase 1: Hochprophet von Akali"
})

L:SetTimerLocalization({
	TimerPhase2		= "Phase 2: Der Avatar von Akali",
	TimerPhase1		= "Phase 1: Hochprophet von Akali"
})

L:SetOptionLocalization({
	TimerPhase2		= "Zeige Warnung für Phase 2: Der Avatar von Akali",
	TimerPhase1		= "Zeige Warnung für Phase 1: Hochprophet von Akali"
})

L:SetMiscLocalization({
	YellPhase2_1	= "Hiernach bleibt nichts mehr von euch übrig!",
	YellPhase2_2	= "Ihr wollt Macht sehen? Ich zeig' euch Macht!"
})

-------------------------
--  Eck the Ferocious  --
-------------------------
L = DBM:GetModLocalization("Eck")

L:SetGeneralLocalization({
	name = "Der wilde Eck"
})

--------------------------
--  Halls of Lightning  --
--------------------------
--  General Bjarngrim  --
-------------------------
L = DBM:GetModLocalization("Gjarngrin")

L:SetGeneralLocalization({
	name = "General Bjarngrim"
})

-------------
--  Ionar  --
-------------
L = DBM:GetModLocalization("Ionar")

L:SetGeneralLocalization({
	name = "Ionar"
})

---------------
--  Volkhan  --
---------------
L = DBM:GetModLocalization("Volkhan")

L:SetGeneralLocalization({
	name = "Volkhan"
})

-------------
--  Loken  --
-------------
L = DBM:GetModLocalization("Kronus")

L:SetGeneralLocalization({
	name = "Loken"
})

----------------------
--  Halls of Stone  --
-----------------------
--  Maiden of Grief  --
-----------------------
L = DBM:GetModLocalization("MaidenOfGrief")

L:SetGeneralLocalization({
	name = "Maid der Trauer"
})

------------------
--  Krystallus  --
------------------
L = DBM:GetModLocalization("Krystallus")

L:SetGeneralLocalization({
	name = "Krystallus"
})

------------------------------
--  Sjonnir the Ironshaper  --
------------------------------
L = DBM:GetModLocalization("SjonnirTheIronshaper")

L:SetGeneralLocalization({
	name = "Sjonnir der Eisenformer"
})

--------------------------------------
--  Brann Bronzebeard Escort Event  --
--------------------------------------
L = DBM:GetModLocalization("BrannBronzebeard")

L:SetGeneralLocalization({
	name = "Brann-Eskorte"
})

L:SetWarningLocalization({
	WarningPhase	= "Phase %d"
})

L:SetTimerLocalization({
	timerEvent	= "Zeit verbleibend"
})

L:SetOptionLocalization({
	WarningPhase	= "Zeige Warnung für Phasenwechsel",
	timerEvent		= "Dauer des Ereignisses anzeigen"
})

L:SetMiscLocalization({
	Pull	= "Haltet jetzt die Augen offen! Ich werde die Sache hier im Handumdrehen...",
	Phase1	= "Sicherheitsverletzung. Setze Analyse historischer Archive auf niedrige Priorität. Leite Gegenmaßnahmen ein.",
	Phase2	= "Bedrohungsindexgrenze überschritten. Himmelsarchiv abgebrochen. Alarmstufe erhöht.",
	Phase3	= "Kritischer Bedrohungsindex. Leerenanalyse umgeleitet. Initialisiere Säuberungsprotokoll.",
	Kill	= "Alarm: Sicherungssysteme deaktiviert. Beginne Speichersäuberung und..."
})

-----------------
--  The Nexus  --
-----------------
--  Anomalus  --
----------------
L = DBM:GetModLocalization("Anomalus")

L:SetGeneralLocalization({
	name = "Anomalus"
})

-------------------------------
--  Ormorok the Tree-Shaper  --
-------------------------------
L = DBM:GetModLocalization("OrmorokTheTreeShaper")

L:SetGeneralLocalization({
	name = "Ormorok der Baumformer"
})

----------------------------
--  Grand Magus Telestra  --
----------------------------
L = DBM:GetModLocalization("GrandMagusTelestra")

L:SetGeneralLocalization({
	name = "Großmagistrix Telestra"
})

L:SetWarningLocalization({
	WarningSplitSoon	= "Aufspaltung bald",
	WarningSplitNow		= "Aufspaltung",
	WarningMerge		= "Fusion"
})
L:SetOptionLocalization({
	WarningSplitSoon	= optionPreWarning:format("Aufspaltung"),
	WarningSplitNow		= optionWarning:format("Aufspaltung"),
	WarningMerge		= optionWarning:format("Fusion"),
})

L:SetMiscLocalization({
	SplitTrigger1		= "Es ist genug von mir für alle da.",
	SplitTrigger2		= "Ich teile mehr aus, als ihr verkraften könnt!",
	MergeTrigger		= "Nun bringen wir's zu Ende!"
})

-------------------
--  Keristrasza  --
-------------------
L = DBM:GetModLocalization("Keristrasza")

L:SetGeneralLocalization({
	name = "Keristrasza"
})

-----------------------------------
--  Commander Kolurg/Stoutbeard  --
-----------------------------------
L = DBM:GetModLocalization("Commander")

local commander = "Eingefrorener Kommandant"
if UnitFactionGroup("player") == "Alliance" then
	commander = "Kommandant Kolurg"
elseif UnitFactionGroup("player") == "Horde" then
	commander = "Kommandant Starkbart"
end

L:SetGeneralLocalization({
	name = commander
})

------------------
--  The Oculus  --
-------------------------------
--  Drakos the Interrogator  --
-------------------------------
L = DBM:GetModLocalization("DrakosTheInterrogator")

L:SetGeneralLocalization({
	name = "Drakos der Befrager"
})


L:SetOptionLocalization({
	MakeitCountTimer	= "Zeige Timer für Erfolg 'Jagt ihn!'"
})

L:SetMiscLocalization({
	MakeitCountTimer	= "Jagt ihn!"
})

----------------------
--  Mage-Lord Urom  --
----------------------
L = DBM:GetModLocalization("MageLordUrom")

L:SetGeneralLocalization({
	name = "Magierlord Urom"
})

L:SetMiscLocalization({
	CombatStart		= "Arme, blinde Narren!"
})

--------------------------
--  Varos Cloudstrider  --
--------------------------
L = DBM:GetModLocalization("VarosCloudstrider")

L:SetGeneralLocalization({
	name = "Varos Wolkenwanderer"
})

---------------------------
--  Ley-Guardian Eregos  --
---------------------------
L = DBM:GetModLocalization("LeyGuardianEregos")

L:SetGeneralLocalization({
	name = "Leywächter Eregos"
})

L:SetMiscLocalization({
	MakeitCountTimer	= "Jagt ihn!"
})

--------------------
--  Utgarde Keep  --
-----------------------
--  Prince Keleseth  --
-----------------------
L = DBM:GetModLocalization("Keleseth")

L:SetGeneralLocalization({
	name = "Prinz Keleseth"
})

--------------------------------
--  Skarvald the Constructor  --
--  & Dalronn the Controller  --
--------------------------------
L = DBM:GetModLocalization("ConstructorAndController")

L:SetGeneralLocalization({
	name = "Skarvald & Dalronn"
})

----------------------------
--  Ingvar the Plunderer  --
----------------------------
L = DBM:GetModLocalization("IngvarThePlunderer")

L:SetGeneralLocalization({
	name = "Ingvar der Brandschatzer"
})

L:SetMiscLocalization({
	YellIngvarPhase2	= "Ich kehre wieder! Ahhhh... Eine zweite Chance, Euren Schädel zu zerlegen!",
	YellCombatEnd		= "Nein! Ich bin... besser, Ich bin..."
})

------------------------
--  Utgarde Pinnacle  --
--------------------------
--  Skadi the Ruthless  --
--------------------------
L = DBM:GetModLocalization("SkadiTheRuthless")

L:SetGeneralLocalization({
	name = "Skadi der Skrupellose"
})

L:SetMiscLocalization({
	CombatStart		= "Welche Hunde wagen es, hier einzudringen? Auf sie, meine Brüder! Ein Fest für den, der mir ihre Köpfe bringt!",
	Phase2			= "Ihr räudigen Halunken! Eure Leichen werden feine Appetithappen für meinen neuen Drachen abgeben!"
})

-------------------
--  King Ymiron  --
-------------------
L = DBM:GetModLocalization("Ymiron")

L:SetGeneralLocalization({
	name = "König Ymiron"
})

-------------------------
--  Svala Sorrowgrave  --
-------------------------
L = DBM:GetModLocalization("SvalaSorrowgrave")

L:SetGeneralLocalization({
	name = "Svala Grabesleid"
})

L:SetTimerLocalization({
	timerRoleplay		= "Svala Grabesleid aktiv"
})

L:SetOptionLocalization({
	timerRoleplay		= "Zeige Dauer des Rollenspiels bevor Svala Grabesleid aktiv wird"
})

L:SetMiscLocalization({
	SvalaRoleplayStart	= "Mein Meister! Ich tat, was Ihr verlangtet, und ersuche Euch um Euren Segen!"
})

-----------------------
--  Gortok Palehoof  --
-----------------------
L = DBM:GetModLocalization("GortokPalehoof")

L:SetGeneralLocalization({
	name = "Gortok Bleichhuf"
})

-----------------------
--  The Violet Hold  --
-----------------------
--  Cyanigosa  --
-----------------
L = DBM:GetModLocalization("Cyanigosa")

L:SetGeneralLocalization({
	name = "Cyanigosa"
})

L:SetMiscLocalization({
	CyanArrived	= "Eine beherzte Verteidigung, aber diese Stadt muss dem Erdboden gleichgemacht werden. Ich werde Malygos' Befehle persönlich ausführen!"
})

--------------
--  Erekem  --
--------------
L = DBM:GetModLocalization("Erekem")

L:SetGeneralLocalization({
	name = "Erekem"
})

---------------
--  Ichoron  --
---------------
L = DBM:GetModLocalization("Ichoron")

L:SetGeneralLocalization({
	name = "Ichoron"
})

-----------------
--  Lavanthor  --
-----------------
L = DBM:GetModLocalization("Lavanthor")

L:SetGeneralLocalization({
	name = "Lavanthor"
})

--------------
--  Moragg  --
--------------
L = DBM:GetModLocalization("Moragg")

L:SetGeneralLocalization({
	name = "Moragg"
})

--------------
--  Xevozz  --
--------------
L = DBM:GetModLocalization("Xevoss")

L:SetGeneralLocalization({
	name = "Xevozz"
})

-------------------------------
--  Zuramat the Obliterator  --
-------------------------------
L = DBM:GetModLocalization("Zuramat")

L:SetGeneralLocalization({
	name = "Zuramat der Vernichter"
})

---------------------
--  Portal Timers  --
---------------------
L = DBM:GetModLocalization("PortalTimers")

L:SetGeneralLocalization({
	name = "Portaltimer"
})

L:SetWarningLocalization({
	WarningPortalSoon	= "Neues Portal bald",
	WarningPortalNow	= "Portal %d",
	WarningBossNow		= "Boss kommt"
})

L:SetTimerLocalization({
	TimerPortalIn	= "Portal %d",
})

L:SetOptionLocalization({
	WarningPortalNow		= "Zeige Warnung für neues Portal",
	WarningPortalSoon		= "Zeige Vorwarnung für neues Portal",
	WarningBossNow			= "Zeige Warnung für neuen Boss",
	TimerPortalIn			= "Zeige Timer für nächstes Portal (nach einem Boss)",
	ShowAllPortalTimers		= "Zeige Timer für alle Portale (ungenau)"
})

L:SetMiscLocalization({
	Sealbroken	= "Wir haben das Gefängnistor durchbrochen! Der Weg nach Dalaran ist frei! Jetzt können wir den Nexuskrieg endlich beenden!",
	WavePortal	= "Geöffnete Portale: (%d+)/18"
})

-----------------------------
--  Trial of the Champion  --
-----------------------------
--  The Black Knight  --
------------------------
L = DBM:GetModLocalization("BlackKnight")

L:SetGeneralLocalization({
	name = "Der Schwarze Ritter"
})

L:SetOptionLocalization({
	AchievementCheck		= "Verkünde Fehlschlag des Erfolgs 'Ich hab' schon Schlimmeres gesehen' an Gruppe"
})

L:SetMiscLocalization({
	Pull				= "Gut gemacht. Ihr habt Euch heute bewiesen-",
	AchievementFailed	= ">> ERFOLG FEHLGESCHLAGEN: %s wurde von Ghulexplosion getroffen <<",
	YellCombatEnd		= "Meine Glückwünsche, Champions. In Prüfungen sowohl geplant als auch unerwartet habt Ihr triumphiert."	-- can also be "Nein! Ich darf nicht... wieder... versagen..."
})

-----------------------
--  Grand Champions  --
-----------------------
L = DBM:GetModLocalization("GrandChampions")

L:SetGeneralLocalization({
	name = "Großchampions"
})

L:SetMiscLocalization({
	YellCombatEnd	= "Gut gekämpft! Eure nächste Herausforderung kommt aus den eigenen Reihen des Kreuzzugs. Ihr werdet Euch gegen ihre eindrucksvolle Tapferkeit beweisen müssen."
})

----------------------------------
--  Argent Confessor Paletress  --
----------------------------------
L = DBM:GetModLocalization("Confessor")

L:SetGeneralLocalization({
	name = "Argentumbeichtpatin Blondlocke"
})

L:SetMiscLocalization({
	YellCombatEnd	= "Exzellente Arbeit!"
})

-----------------------
--  Eadric the Pure  --
-----------------------
L = DBM:GetModLocalization("EadricthePure")

L:SetGeneralLocalization({
	name = "Eadric der Reine"
})

L:SetMiscLocalization({
	YellCombatEnd	= "Ich ergebe mich! Exzellente Arbeit. Darf ich jetzt wegrennen?"
})

--------------------
--  Pit of Saron  --
---------------------
--  Ick and Krick  --
---------------------
L = DBM:GetModLocalization("Ick")

L:SetGeneralLocalization({
	name = "Ick und Krick"
})

----------------------------
--  Forgemaster Garfrost  --
----------------------------
L = DBM:GetModLocalization("ForgemasterGarfrost")

L:SetGeneralLocalization({
	name = "Schmiedemeister Garfrost"
})

L:SetOptionLocalization({
	AchievementCheck	= "Verkünde Warnungen für den Erfolg 'Elfer raus!' an Gruppe"
})

L:SetMiscLocalization({
	SaroniteRockThrow	= "%s schleudert Euch einen massiven Saronitstein entgegen!",
	AchievementWarning	= "Warnung: %s hat %d Stapel von Permafrost",
	AchievementFailed	= ">> ERFOLG FEHLGESCHLAGEN: %s hat %d Stapel von Permafrost <<"
})

----------------------------
--  Scourgelord Tyrannus  --
----------------------------
L = DBM:GetModLocalization("ScourgelordTyrannus")

L:SetGeneralLocalization({
	name = "Geißelfürst Tyrannus"
})

L:SetMiscLocalization({
	CombatStart		= "Ach, Ihr tapferen, tapferen Helden, Euer kleiner Aufstand endet hier. Hört Ihr das Geklapper von Stahl und Knochen aus dem Tunnel hinter Euch? Das ist das Geräusch Eures Todes.",
	HoarfrostTarget	= "Der Frostwyrm Raufang wendet sich (%S+) zu und bereitet einen eisigen Angriff vor!",
	YellCombatEnd	= "Unmöglich... Raufang... warne..."
})

----------------------
--  Forge of Souls  --
----------------------
--  Bronjahm  --
----------------
L = DBM:GetModLocalization("Bronjahm")

L:SetGeneralLocalization({
	name = "Bronjahm"
})

-------------------------
--  Devourer of Souls  --
-------------------------
L = DBM:GetModLocalization("DevourerofSouls")

L:SetGeneralLocalization({
	name = "Verschlinger der Seelen"
})

---------------------------
--  Halls of Reflection  --
---------------------------
--  Wave Timers  --
-------------------
L = DBM:GetModLocalization("HoRWaveTimer")

L:SetGeneralLocalization({
	name = "Wellentimer"
})

L:SetWarningLocalization({
	WarnNewWaveSoon	= "Neue Welle bald",
	WarnNewWave		= "%s kommt"
})

L:SetTimerLocalization({
	TimerNextWave	= "Nächste Welle"
})

L:SetOptionLocalization({
	WarnNewWave			= "Zeige Warnung für neuen Boss",
	WarnNewWaveSoon		= "Zeige Vorwarnung für neue Welle nach dem ersten Boss",
	ShowAllWaveWarnings	= "Zeige Warnungen für alle Wellen",
	TimerNextWave		= "Zeige Zeit bis die nächste Wellengruppe nach dem ersten Boss kommt",
	ShowAllWaveTimers	= "Zeige Vorwarnung und Timer für alle Wellen (ungenau)"
})

L:SetMiscLocalization({
	Falric		= "Falric",
	WaveCheck	= "Geisterwelle = (%d+)/10"
})

--------------
--  Falric  --
--------------
L = DBM:GetModLocalization("Falric")

L:SetGeneralLocalization({
	name = "Falric"
})

--------------
--  Marwyn  --
--------------
L = DBM:GetModLocalization("Marwyn")

L:SetGeneralLocalization({
	name = "Marwyn"
})

-----------------------
--  Lich King Event  --
-----------------------
L = DBM:GetModLocalization("LichKingEvent")

L:SetGeneralLocalization({
	name = "Lichkönig-Event"
})

L:SetTimerLocalization({
	achievementEscape	= "Zeit zur Flucht"
})

L:SetOptionLocalization({
	WarnWave	= "Zeige Warnung für Monsterwellen"
})

L:SetMiscLocalization({
	Ghoul			= "Tobender Ghul",				--creature id 36940. Not sure how to use these in function above to simplify locals though. :\
	Abom			= "Schwerfällige Monstrosität",	--creature id 37069
	WitchDoctor		= "Auferstandener Hexendoktor",	--creature id 36941
	Wave1			= "Es gibt kein Entkommen!",
	Wave2			= "Ergebt Euch der Grabeskälte!",
	Wave3			= "Eine weitere Sackgasse!",
	Wave4			= "Wie lange könnt Ihr Euch noch wehren?"
})
