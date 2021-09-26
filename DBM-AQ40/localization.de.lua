if GetLocale() ~= "deDE" then return end
local L

------------
-- Skeram --
------------
L = DBM:GetModLocalization("Skeram")

L:SetGeneralLocalization{
	name = "Der Prophet Skeram"
}

----------------
-- Three Bugs --
----------------
L = DBM:GetModLocalization("ThreeBugs")

L:SetGeneralLocalization{
	name = "Adel der Silithiden"
}
L:SetMiscLocalization{
	Yauj = "Prinzessin Yauj",
	Vem = "Vem",
	Kri = "Lord Kri"
}

-------------
-- Sartura --
-------------
L = DBM:GetModLocalization("Sartura")

L:SetGeneralLocalization{
	name = "Schlachtwache Sartura"
}

--------------
-- Fankriss --
--------------
L = DBM:GetModLocalization("Fankriss")

L:SetGeneralLocalization{
	name = "Fankriss der Unnachgiebige"
}

--------------
-- Viscidus --
--------------
L = DBM:GetModLocalization("Viscidus")

L:SetGeneralLocalization{
	name = "Viscidus"
}
L:SetWarningLocalization{
	WarnFreeze	= "Eingefroren: %d/3",
	WarnShatter	= "Zerspringen: %d/3"
}
L:SetOptionLocalization{
	WarnFreeze	= "Verkünde Eingefroren Status",
	WarnShatter	= "Verkünde Zerspringen Status"
}
L:SetMiscLocalization{
	Slow	= "wird langsamer!",
	Freezing= "friert ein!",
	Frozen	= "ist tiefgefroren!",
	Phase4 	= "geht die Puste aus!",
	Phase5 	= "ist kurz davor, zu zerspringen!",
	Phase6 	= "explodiert!",

	HitsRemain	= "Verbleibende Treffer",
	Frost		= "Frost",
	Physical	= "Körperlich"
}
-------------
-- Huhuran --
-------------
L = DBM:GetModLocalization("Huhuran")

L:SetGeneralLocalization{
	name = "Prinzessin Huhuran"
}
---------------
-- Twin Emps --
---------------
L = DBM:GetModLocalization("TwinEmpsAQ")

L:SetGeneralLocalization{
	name = "Zwillingsimperatoren"
}
L:SetMiscLocalization{
	Veklor = "Imperator Vek'lor",
	Veknil = "Imperator Vek'nilash"
}

------------
-- C'Thun --
------------
L = DBM:GetModLocalization("CThun")

L:SetGeneralLocalization{
	name = "C'Thun"
}
L:SetWarningLocalization{
	WarnEyeTentacle			= "Augententakel erscheinen",
	WarnClawTentacle2		= "Klauententakel erscheinen",
	WarnGiantEyeTentacle	= "Riesiges Augententakel erscheinen",
	WarnGiantClawTentacle	= "Riesiges Klauententakel erscheinen",
	SpecWarnWeakened		= "C'Thun ist geschwächt!"
}
L:SetTimerLocalization{
	TimerEyeTentacle		= "Nächstes Augententakel",
	TimerClawTentacle		= "Nächstes Klauententakel",
	TimerGiantEyeTentacle	= "Nächstes Riesiges Augententakel",
	TimerGiantClawTentacle	= "Nächstes Riesiges Klauententakel",
	TimerWeakened			= "Schwäche endet"
}
L:SetOptionLocalization{
	WarnEyeTentacle			= "Zeige Warnung, wenn Augententakel erscheinen",
	WarnClawTentacle2		= "Zeige Warnung, wenn Klauententakel erscheinen",
	WarnGiantEyeTentacle	= "Zeige Warnung, wenn Riesiges Augententakel erscheinen",
	WarnGiantClawTentacle	= "Zeige Warnung, wenn Riesiges Klauententakel erscheinen",
	SpecWarnWeakened		= "Spezialwarnung, wenn C'Thun geschwächt ist",
	TimerEyeTentacle		= "Zeige Zeit bis die nächsten Augententakel erscheinen",
	TimerClawTentacle		= "Zeige Zeit bis die nächsten Klauententakel erscheinen",
	TimerGiantEyeTentacle	= "Zeige Zeit bis die nächsten Riesiges Augententakel erscheinen",
	TimerGiantClawTentacle	= "Zeige Zeit bis die nächsten Riesiges Klauententakel erscheinen",
	TimerWeakened			= "Dauer der Schwäche von C'Thun anzeigen",
	RangeFrame				= "Zeige Abstandsfenster (10m)"
}
L:SetMiscLocalization{
	Stomach		= "Magen",
	Eye			= "Auge von C'Thun",
	FleshTent	= "Fleischtentakel",
	Weakened 	= "ist geschwächt!",
	NotValid	= "AQ40 teilweise gelöscht. % s optionale Bosse bleiben erhalten."
}
----------------
-- Ouro --
----------------
L = DBM:GetModLocalization("Ouro")

L:SetGeneralLocalization{
	name = "Ouro"
}
L:SetWarningLocalization{
	WarnSubmerge		= "Abtauchen",
	WarnEmerge			= "Auftauchen"
}
L:SetTimerLocalization{
	TimerSubmerge		= "Abtauchen",
	TimerEmerge			= "Auftauchen"
}
L:SetOptionLocalization{
	WarnSubmerge		= "Zeige Warnung für Abtauchen",
	TimerSubmerge		= "Zeige Zeit bis Abtauchen",
	WarnEmerge			= "Zeige Warnung für Auftauchen",
	TimerEmerge			= "Zeige Zeit bis Auftauchen"
}
