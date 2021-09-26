if GetLocale() ~= "deDE" then return end
local L

---------------------------
--  Hydross the Unstable --
---------------------------
L = DBM:GetModLocalization("Hydross")

L:SetGeneralLocalization{
	name = "Hydross der Unstete"
}

L:SetWarningLocalization{
	WarnMark 		= "%s : %s",
	WarnPhase		= "%sphase",
	SpecWarnMark	= "%s : %s"
}

L:SetTimerLocalization{
	TimerMark	= "Nächstes %s : %s"
}

L:SetOptionLocalization{
	WarnMark		= "Zeige Warnung für Male",
	WarnPhase		= "Zeige Warnung für nächste Phase",
	SpecWarnMark	= "Spezialwarnung, wenn Schaden durch Male Debuff um 100% oder mehr erhöht ist",
	TimerMark		= "Zeige Zeit bis nächste Male"
}

L:SetMiscLocalization{
	Frost	= "Frost",
	Nature	= "Natur"
}

-----------------------
--  The Lurker Below --
-----------------------
L = DBM:GetModLocalization("LurkerBelow")

L:SetGeneralLocalization{
	name = "Das Grauen aus der Tiefe"
}

L:SetWarningLocalization{
	WarnSubmerge		= "Abtauchen",
	WarnEmerge			= "Auftauchen"
}

L:SetTimerLocalization{
	TimerSubmerge		= "Abtauchen CD",
	TimerEmerge			= "Auftauchen CD"
}

L:SetOptionLocalization{
	WarnSubmerge		= "Zeige Warnung für Abtauchen",
	WarnEmerge			= "Zeige Warnung für Auftauchen",
	TimerSubmerge		= "Abklingzeit von Abtauchen anzeigen",
	TimerEmerge			= "Abklingzeit von Auftauchen anzeigen"
}

--------------------------
--  Leotheras the Blind --
--------------------------
L = DBM:GetModLocalization("Leotheras")

L:SetGeneralLocalization{
	name = "Leotheras der Blinde"
}

L:SetWarningLocalization{
	WarnPhase		= "%s Phase"
}

L:SetTimerLocalization{
	TimerPhase	= "Nächste %s Phase"
}

L:SetOptionLocalization{
	WarnPhase		= "Zeige Warnung für nächste Phase",
	TimerPhase		= "Zeige Zeit bis nächste Phase"
}

L:SetMiscLocalization{
	Human		= "Humanoide",
	Demon		= "Dämonen",
	YellDemon	= "Hinfort, unbedeutender Elf%.%s*Ich habe jetzt die Kontrolle!",
	YellPhase2	= "Nein... nein! Was habt Ihr getan? Ich bin der Meister! Hört Ihr? Ich! Ich... aaaaah! Ich kann ihn... nicht aufhalten..."
}

-----------------------------
--  Fathom-Lord Karathress --
-----------------------------
L = DBM:GetModLocalization("Fathomlord")

L:SetGeneralLocalization{
	name = "Tiefenlord Karathress"
}

L:SetWarningLocalization{
}

L:SetTimerLocalization{
}

L:SetOptionLocalization{
}

L:SetMiscLocalization{
	Caribdis	= "Tiefenwächterin Caribdis",
	Tidalvess	= "Tiefenwächter Flutvess",
	Sharkkis	= "Tiefenwächter Haikis"
}

--------------------------
--  Morogrim Tidewalker --
--------------------------
L = DBM:GetModLocalization("Tidewalker")

L:SetGeneralLocalization{
	name = "Morogrim Gezeitenwandler"
}

L:SetWarningLocalization{
	SpecWarnMurlocs	= "Murlocs kommen!"
}

L:SetTimerLocalization{
	TimerMurlocs	= "Murlocs"
}

L:SetOptionLocalization{
	SpecWarnMurlocs	= "Spezialwarnung, wenn Murlocs erscheinen",
	TimerMurlocs	= "Zeige Zeit bis Murlocs erscheinen"
}

L:SetMiscLocalization{
}

-----------------
--  Lady Vashj --
-----------------
L = DBM:GetModLocalization("Vashj")

L:SetGeneralLocalization{
	name = "Lady Vashj"
}

L:SetWarningLocalization{
	WarnElemental		= "Besudelter Elementar bald (%s)",
	WarnStrider			= "Schreiter bald (%s)",
	WarnNaga			= "Naga bald (%s)",
	WarnShield			= "Schildgenerator %d/4 zerstört",
	WarnLoot			= ">%s< hat den Besudelten Kern",
	SpecWarnElemental	= "Besudelter Elementar - Ziel wechseln!"
}

L:SetTimerLocalization{
	TimerElementalActive	= "Elementar aktiv",
	TimerElemental			= "Elementar CD (%d)",
	TimerStrider			= "Nächster Schreiter (%d)",
	TimerNaga				= "Nächster Naga (%d)"
}

L:SetOptionLocalization{
	WarnElemental		= "Zeige Vorwarnung für nächsten Besudelter Elementar",
	WarnStrider			= "Zeige Vorwarnung für nächsten Schreiter",
	WarnNaga			= "Zeige Vorwarnung für nächsten Naga",
	WarnShield			= "Zeige Warnung für zerstörte Schildgeneratoren in Phase 2",
	WarnLoot			= "Spieler mit Besudelten Kern ansagen",
	TimerElementalActive	= "Zeige Zeit bis Besudelter Elementar verschwindet",
	TimerElemental		= "Abklingzeit von Besudelter Elementar anzeigen",
	TimerStrider		= "Zeige Zeit bis nächster Schreiter",
	TimerNaga			= "Zeige Zeit bis nächster Naga",
	SpecWarnElemental	= "Spezialwarnung, wenn Besudelter Elementar kommt",
	AutoChangeLootToFFA	= "Plündermodus in Phase 2 automatisch auf 'Jeder gegen jeden' einstellen"
}

L:SetMiscLocalization{
	DBM_VASHJ_YELL_PHASE2	= "Die Zeit ist gekommen! Lasst keinen am Leben!",
	DBM_VASHJ_YELL_PHASE3	= "Geht besser in Deckung!",
	LootMsg					= "([^%s]+).*Hitem:(%d+)"
}
