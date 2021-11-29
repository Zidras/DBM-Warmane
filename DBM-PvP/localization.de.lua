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
	ShowRelativeGameTime= "Füllen Sie den Gewinn-Timer relativ zur Startzeit des Schlachtfelds (Wenn deaktiviert, sieht die Leiste einfach immer voll aus)",
	TimerCap			= "Zeige Eroberungstimer",
	TimerFlag			= "Zeige Timer für Flaggen-Respawn",
	TimerShadow			= "Zeige Timer für Schattensicht",
	TimerStart			= "Zeige Starttimer",
	TimerWin			= "Zeige Siegtimer"
})

L:SetMiscLocalization({
--	BgStart60			= "Die Schlacht beginnt in 1 Minute.",
--	BgStart30			= "Die Schlacht beginnt in 30 Sekunden. Macht Euch bereit!",
	ArenaInvite			= "Arena-Einladung",
--	Start60				= "Noch eine Minute bis der Arenakampf beginnt!",
--	Start30				= "Noch dreißig Sekunden bis der Arenakampf beginnt!",
--	Start15				= "Noch fünfzehn Sekunden bis der Arenakampf beginnt!",
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
	Vulnerable2			= "Eure Angriffe verursachen nun sehr schwere Verletzungen bei Flaggenträgern!"
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
	WarnSiegeEngineSoon	= "Zeige Warnung, wenn Belagerungsmaschine fast bereit ist",
	ShowGatesHealth		= "Zeige Erhaltungsgrad beschädigter Tore (kann nach dem Beitritt<br/>zu einem bereits laufenden Schlachtfeld falsche Werte liefern!)"
})

L:SetMiscLocalization({
	GatesHealthFrame		= "Beschädigte Tore",
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