if GetLocale() ~= "deDE" then return end

local L

--------------------------
--  General BG Options  --
--------------------------
L = DBM:GetModLocalization("PvPGeneral")

L:SetGeneralLocalization({
	name	= "Allgemeine Einstellungen"
})

L:SetTimerLocalization({
	TimerFlag		= "Flaggenrespawn",
	TimerShadow		= "Schattensicht",
	TimerStart		= "Spiel startet in",
	TimerWin		= "Sieg in"
})

L:SetOptionLocalization({
	AutoSpirit			= "Automatisch Geist freilassen",
	ColorByClass		= "Einfärbung der Spielernamen nach Klasse in der Schlachtfeld-Punktetafel",
	HideBossEmoteFrame	= "Verberge das Fenster \"RaidBossEmoteFrame\" und Garnisons-/Gildenerfolgsmeldungen während Schlachtfeldern",
	ShowBasesToWin		= "Zeige benötigte Anzahl an Punkten zum Sieg",
	ShowEstimatedPoints	= "Zeige geschätzte Kampf-Endpunkte",
	ShowFlagCarrier		= "Zeige Flaggenträger",
	ShowGatesHealth		= "Zeige Erhaltungsgrad beschädigter Tore (kann nach dem Beitritt<br/>zu einem bereits laufenden Schlachtfeld falsche Werte liefern!)",
	ShowRelativeGameTime= "Füllen Sie den Gewinn-Timer relativ zur Startzeit des Schlachtfelds (Wenn deaktiviert, sieht die Leiste einfach immer voll aus)",
	TimerCap			= "Zeige Eroberungstimer",
	TimerFlag			= "Zeige Timer für Flaggen-Respawn",
	TimerShadow			= "Zeige Timer für Schattensicht",
	TimerStart			= "Zeige Starttimer",
	TimerWin			= "Zeige Siegtimer"
})

L:SetMiscLocalization({
	--BG 2 minutes
	BgStart120TC		= "Die Schlacht beginnt in 2 Minuten!",
	--BG 1 minute
	BgStart60TC			= "Die Schlacht beginnt in 1 Minute!",
	BgStart60AlteracTC	= "Der Kampf um das Alteractal beginnt in 1 Minute.",
	BgStart60SotA2TC	= "Runde 2 der Schlacht um den Strand der Uralten beginnt in 1 Minute.",
	BgStart60WarsongTC	= "Der Kampf um die Kriegshymnenschlucht beginnt in 1 Minute.",
	-- BG 30 seconds
	BgStart30TC			= "Die Schlacht beginnt in 30 Sekunden!",
	BgStart30AlteracTC	= "Der Kampf um das Alteractal beginnt in 30 Sekunden.",
	BgStart30SotA2TC	= "Runde 2 beginnt in 30 Sekunden. Macht Euch bereit!",
	BgStart30WarsongTC	= "Der Kampf um die Kriegshymnenschlucht beginnt in 30 Sekunden. Haltet Euch bereit!",
	--
	ArenaInvite			= "Arena-Einladung",
	Start60TC			= "Noch eine Minute bis der Arenakampf beginnt!",
	Start30TC			= "Noch dreißig Sekunden bis der Arenakampf beginnt!",
	Start15TC			= "Noch fünfzehn Sekunden bis der Arenakampf beginnt!",
	BasesToWin			= "Punkte nötig um zu gewinnen: %d",
	WinBarText			= "%s gewinnt",
	Flag				= "Flagge",
--	FlagReset			= "Die Flagge wurde zurückgesetzt.",
--	FlagTaken			= "(.+) hat die Flagge erobert%.",
--	FlagCaptured		= "Die %w+ hat die F%w+ erobert!",
--	FlagDropped			= "Die F%w+ wurde fallengelassen.",
--	ExprFlagPickUp		= "(.+) hat die Flagge der (%w+) aufgenommen!",
--	ExprFlagCaptured	= "(.+) hat die Flagge der (%w+) errungen!",
--	ExprFlagReturn		= "Die Flagge der (%w+) wurde von (.+) zu ihrem Stützpunkt zurückgebracht!",
	Vulnerable1			= "Eure Angriffe verursachen nun schwerere Verletzungen bei Flaggenträgern!",
	Vulnerable2			= "Eure Angriffe verursachen nun sehr schwere Verletzungen bei Flaggenträgern!",
	-- Gates
	GatesHealthFrame	= "Beschädigte Tore",
	HordeGate			= "Hordentor",
	AllianceGate		= "Allianztor",
	-- Gates Emotes
	GreenEmeraldAttacked			= "Das Tor des Smaragdhorizonts wird angegriffen!",
	GreenEmeraldDestroyed			= "Das Tor des Smaragdhorizonts ist zerstört worden!",
	BlueSapphireAttacked			= "Das Tor des Saphirhimmels wird angegriffen!",
	BlueSapphireDestroyed			= "Das Tor des Saphirhimmels ist zerstört worden!",
	PurpleAmethystAttacked			= "Das Tor des Amethyststerns wird angegriffen!",
	PurpleAmethystDestroyed			= "Das Tor des Amethyststerns ist zerstört worden!",
	RedSunAttacked					= "Das Tor der Rubinsonne wird angegriffen!",
	RedSunDestroyed					= "Das Tor der Rubinsonne ist zerstört worden!",
	YellowMoonAttacked				= "Das Tor des Goldmondes wird angegriffen!",
	YellowMoonDestroyed				= "Das Tor des Goldmondes ist zerstört worden!",
	ChamberAncientRelicsAttacked	= "Die Reliktkammer wird angegriffen!",
	ChamberAncientRelicsDestroyed	= "In die Kammer wurde eingebrochen! Der Titan ist in Gefahr!",
})

--------------
--  Arenas  --
--------------
L = DBM:GetModLocalization("Arenas")

L:SetGeneralLocalization({
	name = "Arenas"
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
	TimerStart	= "Zeige Starttimer",
})

L:SetMiscLocalization({
})

----------------------
--  Alterac Valley  --
----------------------
L = DBM:GetModLocalization("AlteracValley")

L:SetGeneralLocalization({
	name = "Alteractal"
})

L:SetOptionLocalization({
	AutoTurnIn = "Automatisches Abgeben der Quests im Alteractal"
})

--------------------
--  Arathi Basin  --
--------------------
L = DBM:GetModLocalization("ArathiBasin")

L:SetGeneralLocalization({
	name = "Arathibecken"
})

L:SetMiscLocalization({
})

L:SetTimerLocalization({
	TimerStart = "Spiel startet in",
	TimerCap = "%s",
})

L:SetOptionLocalization({
})

------------------------
--  Eye of the Storm  --
------------------------
L = DBM:GetModLocalization("EyeoftheStorm")

L:SetGeneralLocalization({
	name = "Auge des Sturms"
})

---------------------
--  Warsong Gulch  --
---------------------
L = DBM:GetModLocalization("WarsongGulch")

L:SetGeneralLocalization({
	name = "Kriegshymnenschlucht"
})

------------------------------
--  Strand of the Ancients  --
------------------------------
L = DBM:GetModLocalization("StrandoftheAncients")

L:SetGeneralLocalization({
	name = "Strand der Uralten"
})

------------------------
--  Isle of Conquest  --
------------------------
L = DBM:GetModLocalization("IsleofConquest")

L:SetGeneralLocalization({
	name = "Insel der Eroberung"
})

L:SetWarningLocalization({
	WarnSiegeEngine		= "Belagerungsmaschine bereit!",
	WarnSiegeEngineSoon	= "Belagerungsmaschine in ~10 Sekunden"
})

L:SetTimerLocalization({
	TimerSiegeEngine	= "Belagerungsmaschine"
})

L:SetOptionLocalization({
	TimerSiegeEngine	= "Zeige Zeit bis Belagerungsmaschine bereit ist",
	WarnSiegeEngine		= "Zeige Warnung, wenn Belagerungsmaschine bereit ist",
	WarnSiegeEngineSoon	= "Zeige Warnung, wenn Belagerungsmaschine fast bereit ist"
})

L:SetMiscLocalization({
	SiegeEngine				= "Belagerungsmaschine",
	GoblinStartAlliance		= "Seht Ihr diese Zephyriumbomben? Benutzt sie an den Toren, während ich die Belagerungsmaschine repariere!",
	GoblinStartHorde		= "Ich arbeite an der Belagerungsmaschine. Haltet mir einfach nur den Rücken frei. Benutzt diese Zephyriumbomben an den Toren, solltet Ihr sie brauchen!",
	GoblinHalfwayAlliance	= "Ich hab's gleich! Haltet die Horde von hier fern. Kämpfen stand in der Ingenieursschule nicht auf dem Lehrplan!",
	GoblinHalfwayHorde		= "Ich hab's gleich! Haltet mir die Allianz vom Leib. Kämpfen steht nicht in meinem Vertrag!",
	GoblinFinishedAlliance	= "Meine beste Arbeit bisher! Diese Belagerungsmaschine ist bereit, ein bisschen Aktion zu sehen!",
	GoblinFinishedHorde		= "Die Belagerungsmaschine ist bereit, loszurollen!",
	GoblinBrokenAlliance	= "Es ist schon kaputt?! Ach, keine Sorge, nichts, was ich nicht reparieren kann.",
	GoblinBrokenHorde		= "Schon wieder kaputt?! Ich werde es richten... Ihr solltet allerdings nicht davon ausgehen, dass das noch unter die Garantie fällt."
})