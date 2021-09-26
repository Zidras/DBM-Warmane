if GetLocale() ~= "deDE" then return end
local L

-----------------
--  Najentus  --
-----------------
L = DBM:GetModLocalization("Najentus")

L:SetGeneralLocalization{
	name = "Oberster Kriegsfürst Naj'entus"
}

L:SetMiscLocalization{
	HealthInfo	= "Gesundheitsinfo"
}

----------------
-- Supremus --
----------------
L = DBM:GetModLocalization("Supremus")

L:SetGeneralLocalization{
	name = "Supremus"
}

L:SetWarningLocalization{
	WarnPhase		= "%sphase"
}

L:SetTimerLocalization{
	TimerPhase		= "Nächste %sphase"
}

L:SetOptionLocalization{
	WarnPhase		= "Zeige Warnung für nächste Phase",
	TimerPhase		= "Zeige Zeit bis nächste Phase",
	KiteIcon		= "Setze Zeichen auf das verfolgte Ziel"
}

L:SetMiscLocalization{
	PhaseTank		= "schlägt wütend auf den Boden!",
	PhaseKite		= "Der Boden beginnt aufzubrechen!",
	ChangeTarget	= "wählt ein neues Ziel!",
	Kite			= "Kite",
	Tank			= "Tank"
}

-------------------------
--  Shape of Akama  --
-------------------------
L = DBM:GetModLocalization("Akama")

L:SetGeneralLocalization{
	name = "Akamas Schemen"
}

-------------------------
--  Teron Gorefiend  --
-------------------------
L = DBM:GetModLocalization("TeronGorefiend")

L:SetGeneralLocalization{
	name = "Teron Blutschatten"
}

L:SetTimerLocalization{
	TimerVengefulSpirit		= "Geist : %s"
}

L:SetOptionLocalization{
	TimerVengefulSpirit		= "Dauer der Rachsüchtigen Geister anzeigen"
}

----------------------------
--  Gurtogg Bloodboil  --
----------------------------
L = DBM:GetModLocalization("Bloodboil")

L:SetGeneralLocalization{
	name = "Gurtogg Siedeblut"
}

--------------------------
--  Essence Of Souls  --
--------------------------
L = DBM:GetModLocalization("Souls")

L:SetGeneralLocalization{
	name = "Reliquiar der Seelen"
}

L:SetWarningLocalization{
	WarnMana		= "Null Mana in 30 Sek"
}

L:SetTimerLocalization{
	TimerMana		= "Null Mana"
}

L:SetOptionLocalization{
	WarnMana		= "Zeige Warnung für 0 Mana in Phase 2",
	TimerMana		= "Zeige Zeit bis 0 Mana in Phase 2"
}

L:SetMiscLocalization{
	Suffering		= "Essenz des Leidens",
	Desire			= "Essenz der Begierde",
	Anger			= "Essenz des Zorns",
	Phase1End		= "Ich will nicht zurück!",
	Phase2End		= "Ich bin immer in Eurer Nähe!"
}

-----------------------
--  Mother Shahraz --
-----------------------
L = DBM:GetModLocalization("Shahraz")

L:SetGeneralLocalization{
	name = "Mutter Shahraz"
}

L:SetTimerLocalization{
	timerAura	= "%s"
}

L:SetOptionLocalization{
	timerAura	= "Dauer der Prismatischen Auren anzeigen"
}

----------------------
--  Illidari Council  --
----------------------
L = DBM:GetModLocalization("Council")

L:SetGeneralLocalization{
	name = "Der Rat der Illidari"
}

L:SetWarningLocalization{
	Immune			= "Malande - %s für 15 Sek"
}

L:SetOptionLocalization{
	Immune			= "Spezialwarnung, wenn Malande gegen magische oder körperliche Angriffe immun wird"
}

L:SetMiscLocalization{
	Gathios			= "Gathios der Zerschmetterer",
	Malande			= "Lady Malande",
	Zerevor			= "Hochnethermant Zerevor",
	Veras			= "Veras Schwarzschatten",
	Melee			= "Körperliche Immunität",
	Spell			= "Magieimmunität"
}

-------------------------
--  Illidan Stormrage --
-------------------------
L = DBM:GetModLocalization("Illidan")

L:SetGeneralLocalization{
	name = "Illidan Sturmgrimm"
}

L:SetWarningLocalization{
	WarnHuman		= "Normalform",
	WarnDemon		= "Dämonenform"
}

L:SetTimerLocalization{
	TimerNextHuman		= "Normalform",
	TimerNextDemon		= "Dämonenform"
}

L:SetOptionLocalization{
	WarnHuman		= "Zeige Warnung für Normalform",
	WarnDemon		= "Zeige Warnung für Dämonenform",
	TimerNextHuman	= "Zeige Zeit bis nächste Normalform",
	TimerNextDemon	= "Zeige Zeit bis nächste Dämonenform",
	RangeFrame		= "Zeige Abstandsfenster (10m) in Phase 3 und 4"
}

L:SetMiscLocalization{
	Pull			= "Akama. Euer falsches Spiel überrascht mich nicht. Ich hätte Euch und Eure missgestalteten Brüder schon vor langer Zeit abschlachten sollen.",
	Eyebeam			= "Blickt in die Augen des Verräters!",
	Demon			= "Erzittert vor der Macht des Dämonen!",
	Phase4			= "War's das schon, Sterbliche? Ist das alles, was Ihr zu bieten habt?",
}
