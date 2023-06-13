if GetLocale() ~= "deDE" then return end
local L

-----------
--  Alar --
-----------
L = DBM:GetModLocalization("Alar")

L:SetGeneralLocalization({
	name = "Al'ar"
})

L:SetTimerLocalization({
	NextPlatform	= "Max. Plattformdauer"
})

L:SetOptionLocalization({
	NextPlatform	= "Zeige Zeit bis Al'ar spätestens die Plattform wechselt<br/>(wechselt möglicherweise früher, aber fast nie später)"
})

------------------
--  Void Reaver --
------------------
L = DBM:GetModLocalization("VoidReaver")

L:SetGeneralLocalization({
	name = "Leerhäscher"
})

--------------------------------
--  High Astromancer Solarian --
--------------------------------
L = DBM:GetModLocalization("Solarian")

L:SetGeneralLocalization({
	name = "Hochastromantin Solarian"
})

L:SetWarningLocalization({
	WarnSplit		= "Verschwinden",
	WarnSplitSoon	= "Verschwinden in 5 Sekunden",
	WarnAgent		= "Agenten erscheinen",
	WarnPriest		= "Priester und Solarian erscheinen"

})

L:SetTimerLocalization({
	TimerSplit		= "Nächstes Verschwinden",
	TimerAgent		= "Agenten kommen",
	TimerPriest		= "Priester & Solarian kommen"
})

L:SetOptionLocalization({
	WarnSplit		= "Zeige Warnung für Verschwinden",
	WarnSplitSoon	= "Zeige Vorwarnung für Verschwinden",
	WarnAgent		= "Zeige Warnung, wenn Agenten erscheinen",
	WarnPriest		= "Zeige Warnung, wenn Priester und Solarian erscheinen",
	TimerSplit		= "Zeige Zeit bis Verschwinden",
	TimerAgent		= "Zeige Zeit bis Agenten erscheinen",
	TimerPriest		= "Zeige Zeit bis Priester und Solarian erscheinen"
})

L:SetMiscLocalization({
	YellSplit1		= "Ich werde Euch Euren Hochmut austreiben!",
	YellSplit2		= "Ihr seid eindeutig in der Unterzahl!",
	YellPhase2		= "Ich werde eins mit der Leere!"
})

---------------------------
--  Kael'thas Sunstrider --
---------------------------
L = DBM:GetModLocalization("KaelThas")

L:SetGeneralLocalization({
	name = "Kael'thas Sonnenwanderer"
})

L:SetWarningLocalization({
	WarnGaze		= "Blick auf >%s<",
	WarnMobDead		= "%s tot",
	WarnEgg			= "Phönixei erschienen",
	SpecWarnGaze	= "Blick auf DIR - Renn weg!",
	SpecWarnEgg		= "Phönixei erschienen - Wechsel Ziel!"
})

L:SetTimerLocalization({
	TimerPhase		= "Nächste Phase",
	TimerPhase1mob	= "%s",
	TimerNextGaze	= "Nächstes Blickziel",
	TimerRebirth	= "Phönix schlüpft"
})

L:SetOptionLocalization({
	WarnGaze		= "Zeige Warnung für Ziele von Thaladreds Blick",
	WarnMobDead		= "Zeige Warnung für getötete Waffen in Phase 2",
	WarnEgg			= "Zeige Warnung, wenn Phönixei erscheint",
	SpecWarnGaze	= "Spezialwarnung, wenn dich Thaladred anblickt",
	SpecWarnEgg		= "Spezialwarnung, wenn Phönixei erscheint",
	TimerPhase		= "Zeige Zeit bis nächste Phase",
	TimerPhase1mob	= "Zeige Zeit bis Berater in Phase 1 aktiv werden",
	TimerNextGaze	= "Zeige Zeit bis Thaladred ein neues Ziel anblickt",
	TimerRebirth	= "Zeige Zeit bis Phönix aus Phönixei schlüpft",
	GazeIcon		= "Zeichen auf Thaladreds Ziel setzen"
})

L:SetMiscLocalization({
	YellPhase2	= "Wie Ihr seht, habe ich viele Waffen in meinem Arsenal...",
	YellPhase3	= "Vielleicht habe ich Euch unterschätzt. Es wäre ungerecht, Euch gegen meine vier Berater gleichzeitig kämpfen zu lassen, aber... mein Volk wurde auch nie gerecht behandelt. Ich vergelte nur Gleiches mit Gleichem.",
	YellPhase4	= "Ach, manchmal muss man die Dinge selbst in die Hand nehmen. Balamore shanal!",
	YellPhase5	= "Ich bin nicht so weit gekommen, um jetzt noch aufgehalten zu werden! Die Zukunft, die ich geplant habe, wird nicht gefährdet werden. Jetzt bekommt Ihr wahre Macht zu spüren!",
	YellSang	= "Ihr habt gegen einige meiner besten Berater bestanden... aber niemand kommt gegen die Macht des Bluthammers an. Erzittert vor Lord Sanguinar!",
	YellCaper	= "Capernian wird dafür sorgen, dass Euer Aufenthalt hier nicht lange währt.",
	YellTelo	= "Gut gemacht. Ihr habt Euch würdig erwiesen, gegen meinen Meisteringenieur Telonicus anzutreten.",
	EmoteGaze	= "behält ([^%s]+) im Blickfeld!",
	Thaladred	= "Thaladred der Verfinsterer",
	Sanguinar	= "Lord Sanguinar",
	Capernian	= "Großastromantin Capernian",
	Telonicus	= "Meisteringenieur Telonicus",
	Bow			= "Netherbespannter Langbogen",
	Axe			= "Macht der Verwüstung",
	Mace		= "Kosmische Macht",
	Dagger		= "Klinge der Unendlichkeit",
	Sword		= "Warpschnitter",
	Shield		= "Phasenverschobenes Bollwerk",
	Staff		= "Stab der Auflösung",
	Egg			= "Phönixei"
})
