if GetLocale() ~= "deDE" then return end
local L

---------------
-- Kurinnaxx --
---------------
L = DBM:GetModLocalization("Kurinnaxx")

L:SetGeneralLocalization{
	name 		= "Kurinnaxx"
}
------------
-- Rajaxx --
------------
L = DBM:GetModLocalization("Rajaxx")

L:SetGeneralLocalization{
	name 		= "General Rajaxx"
}
L:SetWarningLocalization{
	WarnWave	= "Welle %s"
}
L:SetOptionLocalization{
	WarnWave	= "Zeige Meldung für nächste Angriffswelle"
}
L:SetMiscLocalization{
	Wave12		= "Hier kommen sie. Bleibt am Leben, Welpen.",
	Wave12Alt	= "Erinnerst du dich daran, Rajaxx, wann ich dir das letzte Mal sagte, ich würde dich töten?",
	Wave3		= "Die Zeit der Vergeltung ist gekommen! Lasst uns die Herzen unserer Feinde mit Dunkelheit füllen!",
	Wave4		= "Wir werden nicht länger hinter verbarrikadierten Toren und Mauern aus Stein ausharren! Die Rache wird unser sein! Selbst die Drachen werden im Angesicht unseres Zornes erzittern!",
	Wave5		= "Wir kennen keine Furcht! Und wir werden unseren Feinden den Tod bringen!",
	Wave6		= "Staghelm wird winseln und um sein Leben betteln, genau wie sein räudiger Sohn! Eintausend Jahre der Ungerechtigkeit werden heute enden!",
	Wave7		= "Fandral! Deine Zeit ist gekommen! Geh und verstecke dich im Smaragdgrünen Traum, und bete, dass wir dich nie finden werden!",
	Wave8		= "Unverschämter Narr! Ich werde Euch höchstpersönlich töten!"
}

----------
-- Moam --
----------
L = DBM:GetModLocalization("Moam")

L:SetGeneralLocalization{
	name 		= "Moam"
}

----------
-- Buru --
----------
L = DBM:GetModLocalization("Buru")

L:SetGeneralLocalization{
	name 		= "Buru der Verschlinger"
}
L:SetWarningLocalization{
	WarnPursue		= "Verfolgung auf >%s<",
	SpecWarnPursue	= "Du wirst verfolgt",
	WarnDismember	= "%s auf >%s< (%s)"
}
L:SetOptionLocalization{
	WarnPursue		= "Verkünde Ziele von Verfolgung",
	SpecWarnPursue	= "Spezialwarnung, wenn du verfolgt wirst"
}
L:SetMiscLocalization{
	PursueEmote 	= "%s behält %s im Blickfeld!"--MIGHT NOT WORK
}

-------------
-- Ayamiss --
-------------
L = DBM:GetModLocalization("Ayamiss")

L:SetGeneralLocalization{
	name 		= "Ayamiss der Jäger"
}

--------------
-- Ossirian --
--------------
L = DBM:GetModLocalization("Ossirian")

L:SetGeneralLocalization{
	name 		= "Ossirian der Narbenlose"
}
L:SetWarningLocalization{
	WarnVulnerable	= "%s"
}
L:SetTimerLocalization{
	TimerVulnerable	= "%s"
}
L:SetOptionLocalization{
	WarnVulnerable	= "Verkünde Schwächen",
	TimerVulnerable	= "Dauer der Schwächen anzeigen"
}

----------------
-- AQ20 Trash --
----------------
L = DBM:GetModLocalization("AQ20Trash")

L:SetGeneralLocalization{
	name = "AQ20 Trash"
}
