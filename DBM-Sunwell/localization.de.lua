if GetLocale() ~= "deDE" then return end
local L

---------------
--  Kalecgos --
---------------
L = DBM:GetModLocalization("Kal")

L:SetGeneralLocalization({
	name = "Kalecgos"
})

L:SetWarningLocalization({
	WarnPortal			= "Portal #%d : >%s< (Gruppe %d)",
	SpecWarnWildMagic	= "Wilde Magie - %s!"
})

L:SetOptionLocalization({
	WarnPortal			= "Zeige Warnung für Ziel von $spell:46021",
	SpecWarnWildMagic	= "Spezialwarnung für Wilde Magie",
	ShowRespawn			= "Zeige Zeit bis zum Wiedererscheinen des Bosses nach einer Niederlage",
	ShowFrame			= "Zeige Spektralreichfenster",
	FrameClassColor		= "Benutze Klassenfarben in Spektralreichfenster",
	FrameUpwards		= "Erweitere Spektralreichfenster nach oben",
	FrameLocked			= "Setze Spektralreichfenster auf gesperrt (nicht verschiebbar)"
})

L:SetMiscLocalization({
	Demon				= "Sathrovarr der Verderber",
	Heal				= "Heilung +100%",
	Haste				= "Zauberzeit +100%",
	Hit					= "Trefferchance Nah-/Fernkampf -50%",
	Crit				= "Kritischer Schaden +100%",
	Aggro				= "BEDROHUNG +100%",
	Mana				= "Zauber-/Fähigkeitskosten -50%",
	FrameTitle			= "Spektralreich",
	FrameLock			= "Sperre Fenster",
	FrameClassColor		= "Benutze Klassenfarben",
	FrameOrientation	= "Erweitere nach oben",
	FrameHide			= "Verberge Fenster",
	FrameClose			= "Schließen",
	FrameGUIMoveMe		= "Positionieren"
})

----------------
--  Brutallus --
----------------
L = DBM:GetModLocalization("Brutallus")

L:SetGeneralLocalization({
	name = "Brutallus"
})

L:SetOptionLocalization({
	RangeFrameActivation= "Range-Frame-Aktivierung",
	AlwaysOn			= "Beim Start der Begegnung. Ignoriert den Filter",
	OnDebuff			= "Ein Debuff. Wendet Debuff-Filter an"
})

L:SetMiscLocalization({
	Pull			= "Ah, mehr Lämmer zum Schlachten!",
})

--------------
--  Felmyst --
--------------
L = DBM:GetModLocalization("Felmyst")

L:SetGeneralLocalization({
	name = "Teufelsruch"
})

L:SetWarningLocalization({
	WarnPhase		= "%sphase"
})

L:SetTimerLocalization({
	TimerPhase		= "Nächste %sphase"
})

L:SetOptionLocalization({
	WarnPhase		= "Zeige Warnung für nächste Phase",
	TimerPhase		= "Zeige Zeit bis nächste Phase"
})

L:SetMiscLocalization({
	Air				= "Luft",
	Ground			= "Boden",
	AirPhase		= "Ich bin stärker als je zuvor!",
	Breath			= "%s holt tief Luft."
})

-----------------------
--  The Eredar Twins --
-----------------------
L = DBM:GetModLocalization("Twins")

L:SetGeneralLocalization({
	name = "Eredarzwillinge"
})

L:SetMiscLocalization({
	Nova			= "Sacrolash zielt mit Schattennova auf (.+)%.",
	Conflag			= "Alythess zielt mit Großbrand auf (.+)%.",
	Sacrolash		= "Lady Sacrolash",
	Alythess		= "Großhexenmeisterin Alythess"
})

------------
--  M'uru --
------------
L = DBM:GetModLocalization("Muru")

L:SetGeneralLocalization({
	name = "M'uru"
})

L:SetWarningLocalization({
	WarnHuman		= "Humanoide (%d)",
	WarnVoid		= "Leerenschildwache (%d)",
	WarnFiend		= "Finstere Scheusale erschienen"
})

L:SetTimerLocalization({
	TimerHuman		= "Nächste Humanoide (%s)",
	TimerVoid		= "Nächste Leerenschildwache (%s)",
	TimerPhase		= "Entropius"
})

L:SetOptionLocalization({
	WarnHuman		= "Zeige Warnung für Humanoide",
	WarnVoid		= "Zeige Warnung für Leerenschildwache",
	WarnFiend		= "Zeige Warnung für Finstere Scheusale in Phase 2",
	TimerHuman		= "Zeige Zeit bis Humanoide erscheinen",
	TimerVoid		= "Zeige Zeit bis Leerenschildwache erscheint",
	TimerPhase		= "Dauer des Übergangs in Phase 2 anzeigen"
})

L:SetMiscLocalization({
	Entropius		= "Entropius"
})

----------------
--  Kil'jeden --
----------------
L = DBM:GetModLocalization("Kil")

L:SetGeneralLocalization({
	name = "Kil'jaeden"
})

L:SetWarningLocalization({
	WarnDarkOrb		= "Schildkugeln erschienen",
	WarnBlueOrb		= "Drachenkugel bereit",
	SpecWarnDarkOrb	= "Schildkugeln erschienen!",
	SpecWarnBlueOrb	= "Drachenkugel bereit!"
})

L:SetTimerLocalization({
	TimerBlueOrb	= "Drachenkugelaktivierung"
})

L:SetOptionLocalization({
	WarnDarkOrb		= "Zeige Warnung für Schildkugeln",
	WarnBlueOrb		= "Zeige Warnung für Drachenkugeln",
	SpecWarnDarkOrb	= "Spezialwarnung für Schildkugeln",
	SpecWarnBlueOrb	= "Spezialwarnung für Drachenkugeln",
	TimerBlueOrb	= "Zeige Zeit bis Drachenkugeln bereit sind"
})

L:SetMiscLocalization({
	YellPull		= "Die Entbehrlichen sind dahin - so sei es! Jetzt werde ich dort erfolgreich sein, wo Sargeras versagt hat! Ich werde diese jämmerliche Welt ausbluten lassen und meinen Platz als wahrer Meister der Brennenden Legion einnehmen! Das Ende ist gekommen! Lasst uns diese Welt dem Erdboden gleichmachen!",
	OrbYell1		= "Ich werde die Kugeln mit meiner Macht erfüllen! Seid bereit!",
	OrbYell2		= "Eine weitere Kugel ist von meiner Macht erfüllt! Benutzt sie, schnell!",
	OrbYell3		= "Eine weitere Kugel ist bereit! Sputet Euch!",
	OrbYell4		= "Ich habe getan, was ich konnte! Die Macht liegt in Euren Händen!"
})
